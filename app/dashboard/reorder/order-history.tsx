'use client'

import { useState, useEffect, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Search, Filter, ChevronDown, ChevronUp, Calendar,
  Package, Clock, CheckCircle, XCircle, AlertCircle,
  Send, Eye, Truck
} from 'lucide-react'
import { createPurchaseOrderService } from '@/lib/services/purchase-order-service'
import type { PurchaseOrder, PurchaseOrderItem, PurchaseOrderFilters } from '@/lib/types'

interface OrderHistoryProps {
  companyId: string
}

const STATUS_CONFIG: Record<string, { label: string; color: string; bg: string; icon: any }> = {
  draft: { label: 'Draft', color: 'text-gray-700', bg: 'bg-gray-100', icon: Clock },
  submitted: { label: 'Submitted', color: 'text-blue-700', bg: 'bg-blue-100', icon: Send },
  received: { label: 'Received', color: 'text-green-700', bg: 'bg-green-100', icon: CheckCircle },
  partial: { label: 'Partial', color: 'text-amber-700', bg: 'bg-amber-100', icon: AlertCircle },
  cancelled: { label: 'Cancelled', color: 'text-red-700', bg: 'bg-red-100', icon: XCircle },
}

export default function OrderHistory({ companyId }: OrderHistoryProps) {
  const supabase = createClient()
  const poService = createPurchaseOrderService(supabase)

  const [orders, setOrders] = useState<PurchaseOrder[]>([])
  const [loading, setLoading] = useState(true)
  const [expandedOrder, setExpandedOrder] = useState<string | null>(null)
  const [orderItems, setOrderItems] = useState<Record<string, PurchaseOrderItem[]>>({})
  const [loadingItems, setLoadingItems] = useState<string | null>(null)

  // Filters
  const [search, setSearch] = useState('')
  const [statusFilter, setStatusFilter] = useState('all')
  const [dateFrom, setDateFrom] = useState('')
  const [dateTo, setDateTo] = useState('')

  const loadOrders = useCallback(async () => {
    setLoading(true)
    try {
      const filters: PurchaseOrderFilters = {}
      if (search) filters.search = search
      if (statusFilter !== 'all') filters.status = statusFilter
      if (dateFrom) filters.startDate = dateFrom
      if (dateTo) filters.endDate = dateTo

      const data = await poService.getPurchaseOrders(companyId, filters)
      setOrders(data)
    } catch (err) {
      console.error('Failed to load orders:', err)
    } finally {
      setLoading(false)
    }
  }, [companyId, search, statusFilter, dateFrom, dateTo])

  useEffect(() => {
    if (companyId) loadOrders()
  }, [companyId, loadOrders])

  const toggleExpand = async (orderId: string) => {
    if (expandedOrder === orderId) {
      setExpandedOrder(null)
      return
    }

    setExpandedOrder(orderId)

    // Load items if not cached
    if (!orderItems[orderId]) {
      setLoadingItems(orderId)
      try {
        const items = await poService.getPurchaseOrderItems(orderId)
        setOrderItems(prev => ({ ...prev, [orderId]: items }))
      } catch (err) {
        console.error('Failed to load PO items:', err)
      } finally {
        setLoadingItems(null)
      }
    }
  }

  const handleStatusUpdate = async (orderId: string, newStatus: PurchaseOrder['status']) => {
    const result = await poService.updateStatus(orderId, newStatus)
    if (result.success) {
      loadOrders()
    }
  }

  // Group items by manufacturer for expanded view
  const groupItemsByMfg = (items: PurchaseOrderItem[]): Array<[string, PurchaseOrderItem[]]> => {
    const grouped: Record<string, PurchaseOrderItem[]> = {}
    for (const item of items) {
      const mfg = item.manufacturer || 'Other'
      if (!grouped[mfg]) grouped[mfg] = []
      grouped[mfg].push(item)
    }
    return Object.entries(grouped)
  }

  return (
    <div className="space-y-6">
      {/* Filter Bar */}
      <div className="bg-white rounded-xl border border-gray-200 p-4">
        <div className="flex flex-wrap items-center gap-3">
          {/* Search */}
          <div className="relative flex-1 min-w-[200px]">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search by PO#, manufacturer, category, or item..."
              value={search}
              onChange={e => setSearch(e.target.value)}
              onKeyDown={e => e.key === 'Enter' && loadOrders()}
              className="w-full pl-10 pr-4 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>

          {/* Status Filter */}
          <select
            value={statusFilter}
            onChange={e => setStatusFilter(e.target.value)}
            className="px-3 py-2 border rounded-lg text-sm bg-white"
          >
            <option value="all">All Statuses</option>
            <option value="draft">Draft</option>
            <option value="submitted">Submitted</option>
            <option value="received">Received</option>
            <option value="partial">Partial</option>
            <option value="cancelled">Cancelled</option>
          </select>

          {/* Date Range */}
          <div className="flex items-center gap-2">
            <Calendar className="w-4 h-4 text-gray-400" />
            <input
              type="date"
              value={dateFrom}
              onChange={e => setDateFrom(e.target.value)}
              className="px-2 py-2 border rounded-lg text-sm"
            />
            <span className="text-gray-400">to</span>
            <input
              type="date"
              value={dateTo}
              onChange={e => setDateTo(e.target.value)}
              className="px-2 py-2 border rounded-lg text-sm"
            />
          </div>

          <button
            onClick={loadOrders}
            className="px-4 py-2 bg-blue-600 text-white rounded-lg text-sm font-medium hover:bg-blue-700"
          >
            <Filter className="w-4 h-4 inline mr-1" /> Apply
          </button>
        </div>
      </div>

      {/* Orders List */}
      {loading ? (
        <div className="text-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-3" />
          <p className="text-gray-500 text-sm">Loading order history...</p>
        </div>
      ) : orders.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-xl border border-gray-200">
          <Package className="w-12 h-12 text-gray-300 mx-auto mb-3" />
          <h3 className="text-lg font-medium text-gray-900 mb-1">No Purchase Orders</h3>
          <p className="text-gray-500 text-sm">
            {search || statusFilter !== 'all' || dateFrom || dateTo
              ? 'No orders match your filters. Try adjusting your search.'
              : 'Create your first purchase order from the Current Reorder tab.'}
          </p>
        </div>
      ) : (
        <div className="space-y-3">
          {orders.map(order => {
            const statusCfg = STATUS_CONFIG[order.status] || STATUS_CONFIG.draft
            const StatusIcon = statusCfg.icon
            const isExpanded = expandedOrder === order.id
            const items = orderItems[order.id] || []

            return (
              <div
                key={order.id}
                className="bg-white rounded-xl border border-gray-200 overflow-hidden"
              >
                {/* Order Header Row */}
                <div
                  className="flex items-center justify-between p-4 cursor-pointer hover:bg-gray-50 transition-colors"
                  onClick={() => toggleExpand(order.id)}
                >
                  <div className="flex items-center gap-4 flex-1">
                    <button className="text-gray-400">
                      {isExpanded ? <ChevronUp className="w-5 h-5" /> : <ChevronDown className="w-5 h-5" />}
                    </button>

                    <div>
                      <span className="font-mono font-bold text-gray-900">{order.po_number}</span>
                      <span className="text-sm text-gray-500 ml-3">
                        {new Date(order.created_at).toLocaleDateString('en-US', {
                          month: 'short', day: 'numeric', year: 'numeric',
                        })}
                      </span>
                    </div>

                    {order.vendor_name && (
                      <span className="text-sm text-gray-600 bg-gray-100 px-2 py-0.5 rounded">
                        {order.vendor_name}
                      </span>
                    )}
                  </div>

                  <div className="flex items-center gap-6">
                    <span className="text-sm text-gray-600">
                      {order.total_items} items
                    </span>
                    <span className="font-bold text-gray-900">
                      ${order.total_cost.toLocaleString('en-US', { minimumFractionDigits: 2 })}
                    </span>
                    <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium ${statusCfg.bg} ${statusCfg.color}`}>
                      <StatusIcon className="w-3.5 h-3.5" />
                      {statusCfg.label}
                    </span>

                    {/* Action buttons */}
                    <div className="flex gap-1" onClick={e => e.stopPropagation()}>
                      {order.status === 'draft' && (
                        <button
                          onClick={() => handleStatusUpdate(order.id, 'submitted')}
                          className="px-2.5 py-1 text-xs bg-blue-50 text-blue-700 rounded hover:bg-blue-100"
                          title="Mark as Submitted"
                        >
                          <Send className="w-3.5 h-3.5" />
                        </button>
                      )}
                      {order.status === 'submitted' && (
                        <button
                          onClick={() => handleStatusUpdate(order.id, 'received')}
                          className="px-2.5 py-1 text-xs bg-green-50 text-green-700 rounded hover:bg-green-100"
                          title="Mark as Received"
                        >
                          <Truck className="w-3.5 h-3.5" />
                        </button>
                      )}
                      {(order.status === 'draft' || order.status === 'submitted') && (
                        <button
                          onClick={() => handleStatusUpdate(order.id, 'cancelled')}
                          className="px-2.5 py-1 text-xs bg-red-50 text-red-700 rounded hover:bg-red-100"
                          title="Cancel Order"
                        >
                          <XCircle className="w-3.5 h-3.5" />
                        </button>
                      )}
                    </div>
                  </div>
                </div>

                {/* Expanded Detail */}
                {isExpanded && (
                  <div className="border-t border-gray-200 bg-gray-50 p-4">
                    {loadingItems === order.id ? (
                      <div className="text-center py-6">
                        <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-blue-600 mx-auto mb-2" />
                        <p className="text-gray-500 text-xs">Loading items...</p>
                      </div>
                    ) : items.length === 0 ? (
                      <p className="text-gray-500 text-sm text-center py-4">No items found for this order.</p>
                    ) : (
                      <div className="space-y-4">
                        {groupItemsByMfg(items).map(([mfg, mfgItems]) => (
                          <div key={mfg}>
                            <h4 className="text-sm font-bold text-blue-700 mb-2">
                              {mfg}
                              <span className="text-gray-400 font-normal ml-2">
                                ({mfgItems.length} items | $
                                {mfgItems.reduce((s, i) => s + i.extended_cost, 0).toLocaleString('en-US', { minimumFractionDigits: 2 })})
                              </span>
                            </h4>
                            <table className="w-full text-sm">
                              <thead>
                                <tr className="text-xs text-gray-500 uppercase border-b">
                                  <th className="text-left py-1 px-2">Priority</th>
                                  <th className="text-left py-1 px-2">SKU</th>
                                  <th className="text-left py-1 px-2">Item Name</th>
                                  <th className="text-left py-1 px-2">Category</th>
                                  <th className="text-center py-1 px-2">Unit</th>
                                  <th className="text-center py-1 px-2">Qty Ordered</th>
                                  <th className="text-right py-1 px-2">Unit Cost</th>
                                  <th className="text-right py-1 px-2">Extended</th>
                                </tr>
                              </thead>
                              <tbody>
                                {mfgItems.map(item => (
                                  <tr key={item.id} className="border-b border-gray-100">
                                    <td className="py-1.5 px-2">
                                      {item.priority && (
                                        <span className={`text-xs font-medium px-1.5 py-0.5 rounded ${
                                          item.priority === 'critical' ? 'bg-red-100 text-red-700' :
                                          item.priority === 'urgent' ? 'bg-amber-100 text-amber-700' :
                                          'bg-green-100 text-green-700'
                                        }`}>
                                          {item.priority.toUpperCase()}
                                        </span>
                                      )}
                                    </td>
                                    <td className="py-1.5 px-2 font-mono text-xs">{item.sku}</td>
                                    <td className="py-1.5 px-2">{item.product_name}</td>
                                    <td className="py-1.5 px-2 text-gray-500">{item.category}</td>
                                    <td className="py-1.5 px-2 text-center">{item.unit || '—'}</td>
                                    <td className="py-1.5 px-2 text-center font-bold">{item.quantity_ordered}</td>
                                    <td className="py-1.5 px-2 text-right">${item.unit_cost.toFixed(2)}</td>
                                    <td className="py-1.5 px-2 text-right font-bold">${item.extended_cost.toFixed(2)}</td>
                                  </tr>
                                ))}
                              </tbody>
                            </table>
                          </div>
                        ))}

                        {order.notes && (
                          <div className="mt-3 p-3 bg-yellow-50 border border-yellow-200 rounded-lg text-sm text-yellow-800">
                            <strong>Notes:</strong> {order.notes}
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                )}
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
