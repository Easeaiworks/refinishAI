// Purchase Order Service
// Manages saving, retrieving, and updating purchase orders

import { SupabaseClient } from '@supabase/supabase-js'
import type { PurchaseOrder, PurchaseOrderItem, PurchaseOrderFilters } from '@/lib/types'
import type { ReorderItem } from '@/lib/reports/reorder-report'

export class PurchaseOrderService {
  private supabase: SupabaseClient

  constructor(supabase: SupabaseClient) {
    this.supabase = supabase
  }

  /**
   * Generate a sequential PO number for a company
   * Format: PO-YYYYMM-XXXX
   */
  async getNextPONumber(companyId: string): Promise<string> {
    const now = new Date()
    const yearMonth = `${now.getFullYear()}${String(now.getMonth() + 1).padStart(2, '0')}`
    const prefix = `PO-${yearMonth}-`

    // Get the highest PO number for this company/month
    const { data } = await this.supabase
      .from('purchase_orders')
      .select('po_number')
      .eq('company_id', companyId)
      .like('po_number', `${prefix}%`)
      .order('po_number', { ascending: false })
      .limit(1)

    let seq = 1
    if (data && data.length > 0) {
      const lastNum = data[0].po_number
      const lastSeq = parseInt(lastNum.split('-').pop() || '0', 10)
      seq = lastSeq + 1
    }

    return `${prefix}${String(seq).padStart(4, '0')}`
  }

  /**
   * Save a new purchase order from reorder items
   */
  async savePurchaseOrder(
    companyId: string,
    items: ReorderItem[],
    adjustments: Record<string, number>,
    notes?: string,
    vendorCode?: string,
    vendorName?: string
  ): Promise<{ success: boolean; poNumber?: string; error?: string }> {
    try {
      const poNumber = await this.getNextPONumber(companyId)

      // Get current user
      const { data: { user } } = await this.supabase.auth.getUser()

      // Calculate totals using adjusted quantities
      const orderItems = items.map(item => {
        const qty = adjustments[item.id] ?? item.suggestedOrderQty
        return {
          ...item,
          finalQty: qty,
          finalCost: Math.round(qty * item.unitCost * 100) / 100,
        }
      }).filter(item => item.finalQty > 0)

      const totalItems = orderItems.length
      const totalCost = Math.round(orderItems.reduce((sum, i) => sum + i.finalCost, 0) * 100) / 100

      // Insert purchase order
      const { data: po, error: poError } = await this.supabase
        .from('purchase_orders')
        .insert({
          company_id: companyId,
          po_number: poNumber,
          status: 'draft',
          vendor_code: vendorCode || null,
          vendor_name: vendorName || null,
          created_by: user?.id || null,
          total_items: totalItems,
          total_cost: totalCost,
          notes: notes || null,
        })
        .select()
        .single()

      if (poError) throw poError

      // Insert line items
      const lineItems = orderItems.map(item => ({
        purchase_order_id: po.id,
        product_id: item.productId,
        sku: item.sku,
        product_name: item.productName,
        category: item.category,
        manufacturer: item.supplierName || item.vendorCode || '',
        unit: item.unit,
        quantity_ordered: item.finalQty,
        unit_cost: item.unitCost,
        extended_cost: item.finalCost,
        priority: item.priority,
      }))

      const { error: itemsError } = await this.supabase
        .from('purchase_order_items')
        .insert(lineItems)

      if (itemsError) throw itemsError

      return { success: true, poNumber }
    } catch (err: any) {
      return { success: false, error: err.message || 'Failed to save purchase order' }
    }
  }

  /**
   * Get purchase orders for a company with optional filters
   */
  async getPurchaseOrders(
    companyId: string,
    filters: PurchaseOrderFilters = {}
  ): Promise<PurchaseOrder[]> {
    let query = this.supabase
      .from('purchase_orders')
      .select('*')
      .eq('company_id', companyId)
      .order('created_at', { ascending: false })

    if (filters.status && filters.status !== 'all') {
      query = query.eq('status', filters.status)
    }
    if (filters.startDate) {
      query = query.gte('created_at', filters.startDate)
    }
    if (filters.endDate) {
      query = query.lte('created_at', filters.endDate + 'T23:59:59')
    }

    const { data, error } = await query

    if (error) throw error

    let orders = (data || []) as PurchaseOrder[]

    // If searching, also need to filter by items
    if (filters.search) {
      const searchLower = filters.search.toLowerCase()
      // Get all PO IDs, then filter by items
      const poIds = orders.map(o => o.id)
      if (poIds.length > 0) {
        const { data: matchingItems } = await this.supabase
          .from('purchase_order_items')
          .select('purchase_order_id, product_name, sku, category, manufacturer')
          .in('purchase_order_id', poIds)

        const matchingPoIds = new Set<string>()
        for (const item of matchingItems || []) {
          if (
            item.product_name?.toLowerCase().includes(searchLower) ||
            item.sku?.toLowerCase().includes(searchLower) ||
            item.category?.toLowerCase().includes(searchLower) ||
            item.manufacturer?.toLowerCase().includes(searchLower)
          ) {
            matchingPoIds.add(item.purchase_order_id)
          }
        }

        // Also match PO number and vendor name
        orders = orders.filter(o =>
          matchingPoIds.has(o.id) ||
          o.po_number.toLowerCase().includes(searchLower) ||
          o.vendor_name?.toLowerCase().includes(searchLower)
        )
      }
    }

    return orders
  }

  /**
   * Get line items for a purchase order
   */
  async getPurchaseOrderItems(poId: string): Promise<PurchaseOrderItem[]> {
    const { data, error } = await this.supabase
      .from('purchase_order_items')
      .select('*')
      .eq('purchase_order_id', poId)
      .order('category', { ascending: true })

    if (error) throw error
    return (data || []) as PurchaseOrderItem[]
  }

  /**
   * Update purchase order status
   */
  async updateStatus(
    poId: string,
    newStatus: PurchaseOrder['status']
  ): Promise<{ success: boolean; error?: string }> {
    try {
      const updateData: any = { status: newStatus }

      if (newStatus === 'submitted') {
        updateData.submitted_date = new Date().toISOString()
      } else if (newStatus === 'received') {
        updateData.received_date = new Date().toISOString()
      }

      const { error } = await this.supabase
        .from('purchase_orders')
        .update(updateData)
        .eq('id', poId)

      if (error) throw error
      return { success: true }
    } catch (err: any) {
      return { success: false, error: err.message }
    }
  }
}

export function createPurchaseOrderService(supabase: SupabaseClient): PurchaseOrderService {
  return new PurchaseOrderService(supabase)
}
