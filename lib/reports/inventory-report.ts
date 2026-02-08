// Inventory Report Service
// Generates comprehensive inventory reports with filtering, YoY comparison,
// count history, and adjustment tracking by user.

import { SupabaseClient } from '@supabase/supabase-js'
import type {
  InventoryReportFilters,
  InventoryReportItem,
  InventoryReportSummary,
  CountHistoryEntry,
  AdjustmentEntry,
  UserAdjustmentSummary
} from '@/lib/types'

export interface InventoryReport {
  generatedAt: string
  companyId: string
  companyName: string
  filters: InventoryReportFilters
  items: InventoryReportItem[]
  summary: InventoryReportSummary
  countHistory: CountHistoryEntry[]
  userAdjustments: UserAdjustmentSummary[]
}

export class InventoryReportService {
  private supabase: SupabaseClient

  constructor(supabase: SupabaseClient) {
    this.supabase = supabase
  }

  async generateReport(
    companyId: string,
    filters: InventoryReportFilters
  ): Promise<InventoryReport> {
    // Get company info
    const { data: company } = await this.supabase
      .from('companies')
      .select('name')
      .eq('id', companyId)
      .single()

    // Run data fetches in parallel
    const [items, countHistory, userAdjustments] = await Promise.all([
      this.getInventoryItems(companyId, filters),
      this.getCountHistory(companyId, filters.startDate, filters.endDate),
      this.getAdjustmentsByUser(companyId, filters.startDate, filters.endDate)
    ])

    // Calculate summary
    const totalAdjValue = userAdjustments.reduce((sum, u) => sum + u.totalValue, 0)
    const summary: InventoryReportSummary = {
      totalSKUs: items.length,
      totalQuantity: items.reduce((sum, i) => sum + i.quantityOnHand, 0),
      totalInventoryValue: Number(items.reduce((sum, i) => sum + i.totalValue, 0).toFixed(2)),
      criticalItems: items.filter(i => i.status === 'critical').length,
      lowStockItems: items.filter(i => i.status === 'low').length,
      countsCompleted: countHistory.length,
      netAdjustmentValue: Number(totalAdjValue.toFixed(2))
    }

    return {
      generatedAt: new Date().toISOString(),
      companyId,
      companyName: company?.name || '',
      filters,
      items,
      summary,
      countHistory,
      userAdjustments
    }
  }

  private async getInventoryItems(
    companyId: string,
    filters: InventoryReportFilters
  ): Promise<InventoryReportItem[]> {
    // Fetch products with stock data
    let query = this.supabase
      .from('products')
      .select('*')
      .eq('company_id', companyId)
      .order('name')

    if (filters.category) query = query.eq('category', filters.category)
    if (filters.manufacturer) query = query.eq('manufacturer', filters.manufacturer)
    if (filters.productLine) query = query.eq('product_line', filters.productLine)
    if (filters.itemSearch) {
      query = query.or(`name.ilike.%${filters.itemSearch}%,sku.ilike.%${filters.itemSearch}%`)
    }

    // Try with is_active filter; fall back without if column doesn't exist
    let products: any[] | null = null
    const { data: activeData, error } = await query.eq('is_active', true)
    if (error) {
      const { data: allData } = await this.supabase
        .from('products')
        .select('*')
        .eq('company_id', companyId)
        .order('name')
      products = allData
    } else {
      products = activeData
    }

    // Fetch transactions for the period
    const { data: transactions } = await this.supabase
      .from('inventory_transactions')
      .select('product_id, quantity_change, transaction_date')
      .eq('shop_id', companyId)
      .gte('transaction_date', filters.startDate)
      .lte('transaction_date', filters.endDate)

    // Build transaction map: product_id -> { count, lastDate }
    const txnMap = new Map<string, { count: number; lastDate: string }>()
    for (const t of transactions || []) {
      const existing = txnMap.get(t.product_id)
      if (existing) {
        existing.count++
        if (t.transaction_date > existing.lastDate) {
          existing.lastDate = t.transaction_date
        }
      } else {
        txnMap.set(t.product_id, { count: 1, lastDate: t.transaction_date })
      }
    }

    // If YoY enabled, fetch prior year transactions for comparison
    let priorYearMap = new Map<string, { qty: number; value: number }>()
    if (filters.enableYoY) {
      const priorStart = this.shiftYear(filters.startDate, -1)
      const priorEnd = this.shiftYear(filters.endDate, -1)

      // Get transactions from prior year period to reconstruct stock levels
      const { data: priorTxns } = await this.supabase
        .from('inventory_transactions')
        .select('product_id, quantity_after, cost_per_unit, transaction_date')
        .eq('shop_id', companyId)
        .gte('transaction_date', priorStart)
        .lte('transaction_date', priorEnd)
        .order('transaction_date', { ascending: false })

      // Take the most recent transaction_date per product as the snapshot
      for (const t of priorTxns || []) {
        if (!priorYearMap.has(t.product_id)) {
          const qty = t.quantity_after || 0
          const cost = t.cost_per_unit || 0
          priorYearMap.set(t.product_id, { qty, value: Number((qty * cost).toFixed(2)) })
        }
      }
    }

    // Build report items
    const items: InventoryReportItem[] = []
    for (const p of products || []) {
      const qty = p.quantity_on_hand || 0
      const cost = p.unit_cost || 0
      const totalValue = Number((qty * cost).toFixed(2))
      const reorderPoint = p.reorder_point || p.min_quantity || 0
      const txnInfo = txnMap.get(p.id)

      // Determine status
      let status: 'critical' | 'low' | 'adequate' | 'overstocked'
      if (qty <= 0) {
        status = 'critical'
      } else if (qty <= reorderPoint) {
        status = 'low'
      } else if (reorderPoint > 0 && qty > reorderPoint * 3) {
        status = 'overstocked'
      } else {
        status = 'adequate'
      }

      const item: InventoryReportItem = {
        productId: p.id,
        sku: p.sku || '',
        name: p.name,
        category: p.category || 'Uncategorized',
        manufacturer: p.manufacturer || undefined,
        // product_group removed — category is used instead
        productLine: p.product_line || undefined,
        quantityOnHand: qty,
        unitCost: cost,
        totalValue,
        reorderPoint,
        status,
        transactionCount: txnInfo?.count || 0,
        lastTransactionDate: txnInfo?.lastDate || undefined
      }

      // YoY comparison
      if (filters.enableYoY) {
        const prior = priorYearMap.get(p.id)
        if (prior) {
          item.priorYearQty = prior.qty
          item.priorYearValue = prior.value
          item.qtyChange = qty - prior.qty
          item.valueChange = Number((totalValue - prior.value).toFixed(2))
          item.pctChange = prior.qty > 0
            ? Number((((qty - prior.qty) / prior.qty) * 100).toFixed(1))
            : qty > 0 ? 100 : 0
        } else {
          item.priorYearQty = 0
          item.priorYearValue = 0
          item.qtyChange = qty
          item.valueChange = totalValue
          item.pctChange = qty > 0 ? 100 : 0
        }
      }

      items.push(item)
    }

    return items
  }

  async getCountHistory(
    companyId: string,
    startDate: string,
    endDate: string
  ): Promise<CountHistoryEntry[]> {
    const { data: counts } = await this.supabase
      .from('inventory_counts')
      .select('*')
      .eq('company_id', companyId)
      .in('status', ['approved', 'completed'])
      .gte('count_date', startDate)
      .lte('count_date', endDate)
      .order('count_date', { ascending: false })

    if (!counts || counts.length === 0) return []

    // Resolve user names
    const userIds = new Set<string>()
    counts.forEach(c => {
      if (c.counted_by) userIds.add(c.counted_by)
      if (c.verified_by) userIds.add(c.verified_by)
    })

    const userNameMap = await this.resolveUserNames(Array.from(userIds))

    return counts.map(c => ({
      id: c.id,
      countDate: c.count_date,
      countType: c.count_type || 'full',
      status: c.status,
      itemsCounted: c.items_counted || 0,
      varianceCount: c.variance_count || 0,
      totalVarianceValue: c.total_variance_value || 0,
      countedBy: c.counted_by || '',
      countedByName: userNameMap.get(c.counted_by) || 'Unknown',
      verifiedBy: c.verified_by || undefined,
      verifiedByName: c.verified_by ? (userNameMap.get(c.verified_by) || 'Unknown') : undefined
    }))
  }

  async getAdjustmentsByUser(
    companyId: string,
    startDate: string,
    endDate: string
  ): Promise<UserAdjustmentSummary[]> {
    const { data: adjustments } = await this.supabase
      .from('inventory_adjustments')
      .select(`
        *,
        product:products(id, name, sku)
      `)
      .eq('company_id', companyId)
      .gte('created_at', startDate)
      .lte('created_at', endDate)
      .order('created_at', { ascending: false })

    if (!adjustments || adjustments.length === 0) return []

    // Resolve user names
    const userIds = new Set<string>()
    adjustments.forEach(a => {
      if (a.adjusted_by) userIds.add(a.adjusted_by)
    })
    const userNameMap = await this.resolveUserNames(Array.from(userIds))

    // Group by user
    const byUser = new Map<string, AdjustmentEntry[]>()
    for (const a of adjustments) {
      const userId = a.adjusted_by || 'unknown'
      const product = a.product as any
      const entry: AdjustmentEntry = {
        id: a.id,
        countId: a.count_id || undefined,
        productId: a.product_id,
        productName: product?.name || 'Unknown',
        productSku: product?.sku || '',
        adjustmentType: a.adjustment_type || 'manual',
        previousQuantity: a.previous_quantity || 0,
        newQuantity: a.new_quantity || 0,
        adjustmentQuantity: a.adjustment_quantity || 0,
        unitCost: a.unit_cost || 0,
        adjustmentValue: a.adjustment_value || 0,
        adjustedBy: userId,
        adjustedByName: userNameMap.get(userId) || 'Unknown',
        reason: a.reason || undefined,
        createdAt: a.created_at
      }

      if (!byUser.has(userId)) {
        byUser.set(userId, [])
      }
      byUser.get(userId)!.push(entry)
    }

    // Build summaries
    const summaries: UserAdjustmentSummary[] = []
    byUser.forEach((entries, userId) => {
      summaries.push({
        userId,
        userName: userNameMap.get(userId) || 'Unknown',
        adjustmentCount: entries.length,
        totalValue: Number(entries.reduce((sum, e) => sum + e.adjustmentValue, 0).toFixed(2)),
        adjustments: entries
      })
    })

    // Sort by adjustment count descending
    summaries.sort((a, b) => b.adjustmentCount - a.adjustmentCount)
    return summaries
  }

  // Fetch distinct filter options for dropdowns
  async getFilterOptions(companyId: string): Promise<{
    categories: string[]
    manufacturers: string[]
    productLines: string[]
  }> {
    // Try with is_active filter first, fall back without it if column doesn't exist
    let products: any[] | null = null
    const { data: activeProducts, error } = await this.supabase
      .from('products')
      .select('category, manufacturer, product_line')
      .eq('company_id', companyId)
      .eq('is_active', true)

    if (error) {
      // is_active column may not exist — query without it
      const { data: allProducts } = await this.supabase
        .from('products')
        .select('category, manufacturer, product_line')
        .eq('company_id', companyId)
      products = allProducts
    } else {
      products = activeProducts
    }

    const categories = new Set<string>()
    const manufacturers = new Set<string>()
    const productLines = new Set<string>()

    for (const p of products || []) {
      if (p.category) categories.add(p.category)
      if (p.manufacturer) manufacturers.add(p.manufacturer)
      if (p.product_line) productLines.add(p.product_line)
    }

    return {
      categories: Array.from(categories).sort(),
      manufacturers: Array.from(manufacturers).sort(),
      productLines: Array.from(productLines).sort()
    }
  }

  // CSV export
  generateCSV(report: InventoryReport): string {
    const hasYoY = report.filters.enableYoY
    const headers = [
      'SKU',
      'Product Name',
      'Category',
      'Manufacturer',
      'Product Line',
      'On Hand',
      'Unit Cost',
      'Total Value',
      'Reorder Point',
      'Status',
      'Transactions',
      'Last Transaction',
      ...(hasYoY ? ['Prior Year Qty', 'Prior Year Value', 'Qty Change', 'Value Change', '% Change'] : [])
    ]

    const rows = report.items.map(item => {
      const base = [
        item.sku,
        `"${item.name.replace(/"/g, '""')}"`,
        item.category,
        item.manufacturer || '',
        item.productLine || '',
        item.quantityOnHand,
        item.unitCost.toFixed(2),
        item.totalValue.toFixed(2),
        item.reorderPoint,
        item.status.toUpperCase(),
        item.transactionCount,
        item.lastTransactionDate ? new Date(item.lastTransactionDate).toLocaleDateString() : ''
      ]
      if (hasYoY) {
        base.push(
          String(item.priorYearQty ?? ''),
          String(item.priorYearValue != null ? item.priorYearValue.toFixed(2) : ''),
          String(item.qtyChange ?? ''),
          String(item.valueChange != null ? item.valueChange.toFixed(2) : ''),
          String(item.pctChange != null ? `${item.pctChange}%` : '')
        )
      }
      return base
    })

    return [headers.join(','), ...rows.map(r => r.join(','))].join('\n')
  }

  // Print-ready HTML
  generatePrintableHTML(report: InventoryReport): string {
    const hasYoY = report.filters.enableYoY

    const statusColor: Record<string, string> = {
      critical: '#dc2626',
      low: '#f59e0b',
      adequate: '#16a34a',
      overstocked: '#3b82f6'
    }

    const itemRows = report.items.map(item => `
      <tr>
        <td>${item.sku}</td>
        <td>${item.name}</td>
        <td>${item.category}</td>
        <td>${item.manufacturer || '—'}</td>
        <td style="text-align: right;">${item.quantityOnHand}</td>
        <td style="text-align: right;">$${item.unitCost.toFixed(2)}</td>
        <td style="text-align: right;"><strong>$${item.totalValue.toFixed(2)}</strong></td>
        <td>
          <span style="background: ${statusColor[item.status]}; color: white; padding: 2px 6px; border-radius: 4px; font-size: 10px;">
            ${item.status.toUpperCase()}
          </span>
        </td>
        ${hasYoY ? `
          <td style="text-align: right;">${item.priorYearQty ?? '—'}</td>
          <td style="text-align: right;">$${item.priorYearValue != null ? item.priorYearValue.toFixed(2) : '—'}</td>
          <td style="text-align: right; color: ${(item.qtyChange || 0) >= 0 ? '#16a34a' : '#dc2626'};">
            ${item.qtyChange != null ? (item.qtyChange >= 0 ? '+' : '') + item.qtyChange : '—'}
          </td>
          <td style="text-align: right; color: ${(item.pctChange || 0) >= 0 ? '#16a34a' : '#dc2626'};">
            ${item.pctChange != null ? (item.pctChange >= 0 ? '+' : '') + item.pctChange + '%' : '—'}
          </td>
        ` : ''}
      </tr>
    `).join('')

    const countRows = report.countHistory.map(c => `
      <tr>
        <td>${new Date(c.countDate).toLocaleDateString()}</td>
        <td>${c.countType}</td>
        <td style="text-align: right;">${c.itemsCounted}</td>
        <td style="text-align: right;">${c.varianceCount}</td>
        <td style="text-align: right;">$${c.totalVarianceValue.toFixed(2)}</td>
        <td>${c.countedByName}</td>
        <td>${c.verifiedByName || '—'}</td>
      </tr>
    `).join('')

    const adjustmentRows = report.userAdjustments.map(u => `
      <tr style="background: #f3f4f6; font-weight: bold;">
        <td colspan="4">${u.userName}</td>
        <td style="text-align: right;">${u.adjustmentCount} adjustments</td>
        <td style="text-align: right;">$${u.totalValue.toFixed(2)}</td>
      </tr>
      ${u.adjustments.slice(0, 10).map(a => `
        <tr>
          <td style="padding-left: 20px;">${a.productSku}</td>
          <td>${a.productName}</td>
          <td>${a.adjustmentType}</td>
          <td style="text-align: right;">${a.previousQuantity} → ${a.newQuantity}</td>
          <td style="text-align: right; color: ${a.adjustmentQuantity >= 0 ? '#16a34a' : '#dc2626'};">
            ${a.adjustmentQuantity >= 0 ? '+' : ''}${a.adjustmentQuantity}
          </td>
          <td style="text-align: right;">$${a.adjustmentValue.toFixed(2)}</td>
        </tr>
      `).join('')}
    `).join('')

    return `
<!DOCTYPE html>
<html>
<head>
  <title>Inventory Report - ${report.companyName}</title>
  <style>
    body { font-family: Arial, sans-serif; font-size: 12px; margin: 20px; }
    h1 { font-size: 18px; margin-bottom: 5px; }
    h2 { font-size: 15px; margin-top: 30px; border-bottom: 2px solid #1f2937; padding-bottom: 5px; }
    .subtitle { color: #666; font-size: 11px; margin-bottom: 20px; }
    .summary { display: flex; gap: 20px; margin-bottom: 20px; background: #f9fafb; padding: 15px; border-radius: 8px; flex-wrap: wrap; }
    .summary-item { text-align: center; min-width: 100px; }
    .summary-value { font-size: 24px; font-weight: bold; }
    .summary-label { font-size: 10px; color: #666; text-transform: uppercase; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
    th { background: #1f2937; color: white; padding: 8px 4px; text-align: left; font-size: 10px; }
    td { padding: 6px 4px; border-bottom: 1px solid #e5e7eb; vertical-align: middle; font-size: 11px; }
    @media print {
      body { margin: 10px; }
      .no-print { display: none; }
    }
  </style>
</head>
<body>
  <div class="no-print" style="margin-bottom: 20px;">
    <button onclick="window.print()" style="padding: 10px 20px; background: #2563eb; color: white; border: none; border-radius: 6px; cursor: pointer;">
      Print Report
    </button>
  </div>

  <h1>Inventory Report</h1>
  <div class="subtitle">
    ${report.companyName} | ${new Date(report.filters.startDate).toLocaleDateString()} – ${new Date(report.filters.endDate).toLocaleDateString()} | Generated: ${new Date(report.generatedAt).toLocaleString()}
  </div>

  <div class="summary">
    <div class="summary-item">
      <div class="summary-value">${report.summary.totalSKUs}</div>
      <div class="summary-label">Total SKUs</div>
    </div>
    <div class="summary-item">
      <div class="summary-value" style="color: #059669;">$${report.summary.totalInventoryValue.toLocaleString()}</div>
      <div class="summary-label">Inventory Value</div>
    </div>
    <div class="summary-item">
      <div class="summary-value" style="color: #dc2626;">${report.summary.criticalItems}</div>
      <div class="summary-label">Critical</div>
    </div>
    <div class="summary-item">
      <div class="summary-value" style="color: #f59e0b;">${report.summary.lowStockItems}</div>
      <div class="summary-label">Low Stock</div>
    </div>
    <div class="summary-item">
      <div class="summary-value">${report.summary.countsCompleted}</div>
      <div class="summary-label">Counts Completed</div>
    </div>
    <div class="summary-item">
      <div class="summary-value">$${Math.abs(report.summary.netAdjustmentValue).toLocaleString()}</div>
      <div class="summary-label">Net Adjustments</div>
    </div>
  </div>

  <h2>Inventory Detail</h2>
  <table>
    <thead>
      <tr>
        <th>SKU</th>
        <th>Product Name</th>
        <th>Category</th>
        <th>Manufacturer</th>
        <th style="text-align: right;">On Hand</th>
        <th style="text-align: right;">Unit Cost</th>
        <th style="text-align: right;">Total Value</th>
        <th>Status</th>
        ${hasYoY ? '<th style="text-align: right;">Prior Yr Qty</th><th style="text-align: right;">Prior Yr Value</th><th style="text-align: right;">Qty Change</th><th style="text-align: right;">% Change</th>' : ''}
      </tr>
    </thead>
    <tbody>${itemRows}</tbody>
    <tfoot>
      <tr style="background: #f3f4f6; font-weight: bold;">
        <td colspan="4">Totals</td>
        <td style="text-align: right;">${report.summary.totalQuantity}</td>
        <td></td>
        <td style="text-align: right;">$${report.summary.totalInventoryValue.toLocaleString()}</td>
        <td></td>
        ${hasYoY ? '<td colspan="4"></td>' : ''}
      </tr>
    </tfoot>
  </table>

  <h2>Count History</h2>
  <table>
    <thead>
      <tr>
        <th>Date</th>
        <th>Type</th>
        <th style="text-align: right;">Items Counted</th>
        <th style="text-align: right;">Variances</th>
        <th style="text-align: right;">Variance Value</th>
        <th>Counted By</th>
        <th>Verified By</th>
      </tr>
    </thead>
    <tbody>${countRows || '<tr><td colspan="7" style="text-align:center; color:#999;">No counts in this period</td></tr>'}</tbody>
  </table>

  <h2>Adjustments by User</h2>
  <table>
    <thead>
      <tr>
        <th>SKU / User</th>
        <th>Product</th>
        <th>Type</th>
        <th style="text-align: right;">Qty Change</th>
        <th style="text-align: right;">Count</th>
        <th style="text-align: right;">Value</th>
      </tr>
    </thead>
    <tbody>${adjustmentRows || '<tr><td colspan="6" style="text-align:center; color:#999;">No adjustments in this period</td></tr>'}</tbody>
  </table>

  <div style="margin-top: 30px; font-size: 10px; color: #666;">
    <strong>Reviewed by:</strong> _________________________
    <strong style="margin-left: 40px;">Date:</strong> _____________
    <strong style="margin-left: 40px;">Signature:</strong> _________________________
  </div>
</body>
</html>
    `
  }

  // Helper: shift a date string by N years
  private shiftYear(dateStr: string, years: number): string {
    const d = new Date(dateStr)
    d.setFullYear(d.getFullYear() + years)
    return d.toISOString().split('T')[0]
  }

  // Helper: resolve user IDs to display names
  private async resolveUserNames(userIds: string[]): Promise<Map<string, string>> {
    const nameMap = new Map<string, string>()
    if (userIds.length === 0) return nameMap

    const { data: profiles } = await this.supabase
      .from('user_profiles')
      .select('id, full_name, email')
      .in('id', userIds)

    for (const p of profiles || []) {
      nameMap.set(p.id, p.full_name || p.email || 'Unknown')
    }
    return nameMap
  }
}

// Factory function
export function createInventoryReportService(supabase: SupabaseClient): InventoryReportService {
  return new InventoryReportService(supabase)
}

export default InventoryReportService
