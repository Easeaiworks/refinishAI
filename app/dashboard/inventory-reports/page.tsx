'use client'

import { useState, useEffect, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  FileText,
  Download,
  Printer,
  Filter,
  Search,
  ChevronDown,
  ChevronUp,
  Package,
  DollarSign,
  AlertTriangle,
  CheckCircle,
  ArrowUpDown,
  BarChart3,
  ClipboardList,
  Users,
  X,
  TrendingUp,
  TrendingDown,
  Minus
} from 'lucide-react'
import { InventoryReportService, createInventoryReportService } from '@/lib/reports/inventory-report'
import type { InventoryReport } from '@/lib/reports/inventory-report'
import type { InventoryReportFilters, InventoryReportItem } from '@/lib/types'

type TabId = 'inventory' | 'yoy' | 'counts' | 'adjustments'
type SortField = 'sku' | 'name' | 'quantityOnHand' | 'totalValue' | 'status' | 'qtyChange' | 'pctChange'
type SortDir = 'asc' | 'desc'

export default function InventoryReportsPage() {
  const supabase = createClient()

  // Auth & company
  const [companyId, setCompanyId] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)
  const [reportLoading, setReportLoading] = useState(false)

  // Report data
  const [report, setReport] = useState<InventoryReport | null>(null)

  // Filter options (populated from DB)
  const [manufacturerOptions, setManufacturerOptions] = useState<string[]>([])
  const [groupOptions, setGroupOptions] = useState<string[]>([])
  const [lineOptions, setLineOptions] = useState<string[]>([])

  // Filter state
  const [showFilters, setShowFilters] = useState(true)
  const [filters, setFilters] = useState<InventoryReportFilters>({
    startDate: getDefaultStartDate(),
    endDate: new Date().toISOString().split('T')[0],
    itemSearch: '',
    manufacturer: '',
    productGroup: '',
    productLine: '',
    enableYoY: false
  })

  // UI state
  const [activeTab, setActiveTab] = useState<TabId>('inventory')
  const [sortField, setSortField] = useState<SortField>('name')
  const [sortDir, setSortDir] = useState<SortDir>('asc')
  const [expandedUsers, setExpandedUsers] = useState<Set<string>>(new Set())

  // Initialize
  useEffect(() => {
    loadInitialData()
  }, [])

  async function loadInitialData() {
    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id')
        .eq('id', user.id)
        .single()

      if (profile?.company_id) {
        setCompanyId(profile.company_id)
        // Load filter options
        const service = createInventoryReportService(supabase)
        const options = await service.getFilterOptions(profile.company_id)
        setManufacturerOptions(options.manufacturers)
        setGroupOptions(options.productGroups)
        setLineOptions(options.productLines)
        // Generate initial report
        await generateReport(profile.company_id, filters)
      }
    } catch (err) {
      console.error('Failed to load initial data:', err)
    } finally {
      setLoading(false)
    }
  }

  async function generateReport(cId: string, f: InventoryReportFilters) {
    setReportLoading(true)
    try {
      const service = createInventoryReportService(supabase)
      const data = await service.generateReport(cId, f)
      setReport(data)
    } catch (err) {
      console.error('Failed to generate report:', err)
    } finally {
      setReportLoading(false)
    }
  }

  function handleApplyFilters() {
    if (companyId) {
      generateReport(companyId, filters)
    }
  }

  function handleResetFilters() {
    const reset: InventoryReportFilters = {
      startDate: getDefaultStartDate(),
      endDate: new Date().toISOString().split('T')[0],
      itemSearch: '',
      manufacturer: '',
      productGroup: '',
      productLine: '',
      enableYoY: false
    }
    setFilters(reset)
    if (companyId) {
      generateReport(companyId, reset)
    }
  }

  // Sorting
  function handleSort(field: SortField) {
    if (sortField === field) {
      setSortDir(sortDir === 'asc' ? 'desc' : 'asc')
    } else {
      setSortField(field)
      setSortDir('asc')
    }
  }

  function getSortedItems(): InventoryReportItem[] {
    if (!report) return []
    const items = [...report.items]
    items.sort((a, b) => {
      let valA: any = a[sortField as keyof InventoryReportItem]
      let valB: any = b[sortField as keyof InventoryReportItem]
      if (typeof valA === 'string') valA = valA.toLowerCase()
      if (typeof valB === 'string') valB = valB.toLowerCase()
      if (valA == null) valA = ''
      if (valB == null) valB = ''
      if (valA < valB) return sortDir === 'asc' ? -1 : 1
      if (valA > valB) return sortDir === 'asc' ? 1 : -1
      return 0
    })
    return items
  }

  // Export
  function exportCSV() {
    if (!report) return
    const service = createInventoryReportService(supabase)
    const csv = service.generateCSV(report)
    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `inventory-report-${new Date().toISOString().split('T')[0]}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  function printReport() {
    if (!report) return
    const service = createInventoryReportService(supabase)
    const html = service.generatePrintableHTML(report)
    const printWindow = window.open('', '_blank')
    if (printWindow) {
      printWindow.document.write(html)
      printWindow.document.close()
    }
  }

  // Toggle user detail expansion
  function toggleUser(userId: string) {
    const next = new Set(expandedUsers)
    if (next.has(userId)) {
      next.delete(userId)
    } else {
      next.add(userId)
    }
    setExpandedUsers(next)
  }

  // Status badge
  function StatusBadge({ status }: { status: string }) {
    const config: Record<string, { bg: string; text: string; label: string }> = {
      critical: { bg: 'bg-red-100', text: 'text-red-700', label: 'Critical' },
      low: { bg: 'bg-amber-100', text: 'text-amber-700', label: 'Low' },
      adequate: { bg: 'bg-green-100', text: 'text-green-700', label: 'Adequate' },
      overstocked: { bg: 'bg-blue-100', text: 'text-blue-700', label: 'Overstocked' }
    }
    const c = config[status] || config.adequate
    return (
      <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${c.bg} ${c.text}`}>
        {c.label}
      </span>
    )
  }

  // Sort header
  function SortHeader({ field, label, align }: { field: SortField; label: string; align?: string }) {
    return (
      <th
        className={`py-3 px-3 text-xs font-semibold text-gray-600 cursor-pointer hover:text-gray-900 select-none ${align === 'right' ? 'text-right' : 'text-left'}`}
        onClick={() => handleSort(field)}
      >
        <span className="inline-flex items-center gap-1">
          {label}
          {sortField === field && (
            sortDir === 'asc' ? <ChevronUp className="w-3 h-3" /> : <ChevronDown className="w-3 h-3" />
          )}
        </span>
      </th>
    )
  }

  // ── Loading state ──
  if (loading) {
    return (
      <div className="flex items-center justify-center py-12">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    )
  }

  const sortedItems = getSortedItems()

  // ── Tabs config ──
  const tabs: { id: TabId; label: string; icon: any }[] = [
    { id: 'inventory', label: 'Inventory Detail', icon: Package },
    { id: 'yoy', label: 'Year-on-Year', icon: BarChart3 },
    { id: 'counts', label: 'Count History', icon: ClipboardList },
    { id: 'adjustments', label: 'Adjustments by User', icon: Users }
  ]

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
            <FileText className="w-7 h-7 text-blue-600" />
            Inventory Reports
          </h1>
          <p className="text-gray-600 mt-1">
            Filter and analyze inventory by item, group, manufacturer, or product line
          </p>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setShowFilters(!showFilters)}
            className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
              showFilters ? 'bg-blue-50 text-blue-700' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            <Filter className="w-4 h-4" />
            Filters
          </button>
          <button
            onClick={exportCSV}
            disabled={!report}
            className="flex items-center gap-2 px-4 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 disabled:opacity-50"
          >
            <Download className="w-4 h-4" />
            CSV
          </button>
          <button
            onClick={printReport}
            disabled={!report}
            className="flex items-center gap-2 px-4 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 disabled:opacity-50"
          >
            <Printer className="w-4 h-4" />
            Print
          </button>
        </div>
      </div>

      {/* Filter Panel */}
      {showFilters && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            {/* Date Range */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Start Date</label>
              <input
                type="date"
                value={filters.startDate}
                onChange={e => setFilters({ ...filters, startDate: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">End Date</label>
              <input
                type="date"
                value={filters.endDate}
                onChange={e => setFilters({ ...filters, endDate: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              />
            </div>
            {/* Item Search */}
            <div className="md:col-span-2">
              <label className="block text-xs font-medium text-gray-600 mb-1">Search Item</label>
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                <input
                  type="text"
                  placeholder="Search by SKU or product name..."
                  value={filters.itemSearch}
                  onChange={e => setFilters({ ...filters, itemSearch: e.target.value })}
                  className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                />
              </div>
            </div>
            {/* Manufacturer */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Manufacturer</label>
              <select
                value={filters.manufacturer}
                onChange={e => setFilters({ ...filters, manufacturer: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500"
              >
                <option value="">All Manufacturers</option>
                {manufacturerOptions.map(m => <option key={m} value={m}>{m}</option>)}
              </select>
            </div>
            {/* Product Group */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Product Group</label>
              <select
                value={filters.productGroup}
                onChange={e => setFilters({ ...filters, productGroup: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500"
              >
                <option value="">All Groups</option>
                {groupOptions.map(g => <option key={g} value={g}>{g}</option>)}
              </select>
            </div>
            {/* Product Line */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Product Line</label>
              <select
                value={filters.productLine}
                onChange={e => setFilters({ ...filters, productLine: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500"
              >
                <option value="">All Lines</option>
                {lineOptions.map(l => <option key={l} value={l}>{l}</option>)}
              </select>
            </div>
          </div>

          {/* YoY toggle + action buttons */}
          <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100">
            <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
              <input
                type="checkbox"
                checked={filters.enableYoY}
                onChange={e => setFilters({ ...filters, enableYoY: e.target.checked })}
                className="w-4 h-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
              />
              Enable Year-on-Year Comparison
            </label>
            <div className="flex items-center gap-2">
              <button
                onClick={handleResetFilters}
                className="px-4 py-2 text-sm font-medium text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded-lg transition-colors"
              >
                Reset
              </button>
              <button
                onClick={handleApplyFilters}
                disabled={reportLoading}
                className="px-6 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 disabled:opacity-50 transition-colors"
              >
                {reportLoading ? 'Generating...' : 'Apply Filters'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Summary Cards */}
      {report && (
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
            <div className="flex items-center gap-2 mb-1">
              <Package className="w-4 h-4 text-gray-400" />
              <p className="text-xs font-medium text-gray-500">Total SKUs</p>
            </div>
            <p className="text-2xl font-bold text-gray-900">{report.summary.totalSKUs}</p>
          </div>
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
            <div className="flex items-center gap-2 mb-1">
              <DollarSign className="w-4 h-4 text-green-500" />
              <p className="text-xs font-medium text-gray-500">Inventory Value</p>
            </div>
            <p className="text-2xl font-bold text-gray-900">${report.summary.totalInventoryValue.toLocaleString()}</p>
          </div>
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
            <div className="flex items-center gap-2 mb-1">
              <AlertTriangle className="w-4 h-4 text-red-500" />
              <p className="text-xs font-medium text-gray-500">Critical Items</p>
            </div>
            <p className="text-2xl font-bold text-red-600">{report.summary.criticalItems}</p>
          </div>
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
            <div className="flex items-center gap-2 mb-1">
              <AlertTriangle className="w-4 h-4 text-amber-500" />
              <p className="text-xs font-medium text-gray-500">Low Stock</p>
            </div>
            <p className="text-2xl font-bold text-amber-600">{report.summary.lowStockItems}</p>
          </div>
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
            <div className="flex items-center gap-2 mb-1">
              <ClipboardList className="w-4 h-4 text-blue-500" />
              <p className="text-xs font-medium text-gray-500">Counts Completed</p>
            </div>
            <p className="text-2xl font-bold text-gray-900">{report.summary.countsCompleted}</p>
          </div>
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
            <div className="flex items-center gap-2 mb-1">
              <ArrowUpDown className="w-4 h-4 text-purple-500" />
              <p className="text-xs font-medium text-gray-500">Net Adjustments</p>
            </div>
            <p className={`text-2xl font-bold ${report.summary.netAdjustmentValue >= 0 ? 'text-green-600' : 'text-red-600'}`}>
              ${Math.abs(report.summary.netAdjustmentValue).toLocaleString()}
            </p>
          </div>
        </div>
      )}

      {/* Tabs */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200">
        <div className="border-b border-gray-200">
          <div className="flex">
            {tabs.map(tab => {
              const Icon = tab.icon
              return (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`flex items-center gap-2 px-5 py-3 text-sm font-medium border-b-2 transition-colors ${
                    activeTab === tab.id
                      ? 'border-blue-600 text-blue-700 bg-blue-50'
                      : 'border-transparent text-gray-600 hover:text-gray-900 hover:bg-gray-50'
                  }`}
                >
                  <Icon className="w-4 h-4" />
                  {tab.label}
                </button>
              )
            })}
          </div>
        </div>

        <div className="p-0">
          {/* Inventory Detail Tab */}
          {activeTab === 'inventory' && (
            <div className="overflow-x-auto">
              {reportLoading ? (
                <div className="flex items-center justify-center py-12">
                  <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
                </div>
              ) : sortedItems.length === 0 ? (
                <div className="text-center py-12">
                  <Package className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                  <p className="text-gray-500">No inventory items match the current filters</p>
                </div>
              ) : (
                <table className="w-full">
                  <thead className="bg-gray-50 border-b border-gray-200">
                    <tr>
                      <SortHeader field="sku" label="SKU" />
                      <SortHeader field="name" label="Product Name" />
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Category</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Product Group</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Manufacturer</th>
                      <SortHeader field="quantityOnHand" label="On Hand" align="right" />
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Unit Cost</th>
                      <SortHeader field="totalValue" label="Total Value" align="right" />
                      <SortHeader field="status" label="Status" />
                    </tr>
                  </thead>
                  <tbody>
                    {sortedItems.map(item => (
                      <tr key={item.productId} className="border-b border-gray-100 hover:bg-gray-50">
                        <td className="py-3 px-3 text-sm font-mono text-gray-700">{item.sku}</td>
                        <td className="py-3 px-3 text-sm text-gray-900 font-medium">{item.name}</td>
                        <td className="py-3 px-3 text-sm text-gray-600">{item.category}</td>
                        <td className="py-3 px-3 text-sm text-gray-600">{item.productGroup || '—'}</td>
                        <td className="py-3 px-3 text-sm text-gray-600">{item.manufacturer || '—'}</td>
                        <td className="py-3 px-3 text-sm text-right font-medium text-gray-900">{item.quantityOnHand}</td>
                        <td className="py-3 px-3 text-sm text-right text-gray-600">${item.unitCost.toFixed(2)}</td>
                        <td className="py-3 px-3 text-sm text-right font-medium text-gray-900">${item.totalValue.toFixed(2)}</td>
                        <td className="py-3 px-3"><StatusBadge status={item.status} /></td>
                      </tr>
                    ))}
                  </tbody>
                  <tfoot className="bg-gray-50 border-t border-gray-200">
                    <tr>
                      <td colSpan={5} className="py-3 px-3 text-sm font-semibold text-gray-700">Totals</td>
                      <td className="py-3 px-3 text-sm text-right font-bold text-gray-900">
                        {report?.summary.totalQuantity.toLocaleString()}
                      </td>
                      <td className="py-3 px-3"></td>
                      <td className="py-3 px-3 text-sm text-right font-bold text-gray-900">
                        ${report?.summary.totalInventoryValue.toLocaleString()}
                      </td>
                      <td className="py-3 px-3"></td>
                    </tr>
                  </tfoot>
                </table>
              )}
            </div>
          )}

          {/* Year-on-Year Tab */}
          {activeTab === 'yoy' && (
            <div className="overflow-x-auto">
              {!filters.enableYoY ? (
                <div className="text-center py-12">
                  <BarChart3 className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                  <p className="text-gray-500 mb-2">Year-on-Year comparison is disabled</p>
                  <p className="text-sm text-gray-400">Enable it in the Filters panel above, then click Apply Filters</p>
                </div>
              ) : sortedItems.length === 0 ? (
                <div className="text-center py-12">
                  <BarChart3 className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                  <p className="text-gray-500">No data available for comparison</p>
                </div>
              ) : (
                <table className="w-full">
                  <thead className="bg-gray-50 border-b border-gray-200">
                    <tr>
                      <SortHeader field="sku" label="SKU" />
                      <SortHeader field="name" label="Product Name" />
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Current Qty</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Current Value</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Prior Yr Qty</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Prior Yr Value</th>
                      <SortHeader field="qtyChange" label="Qty Change" align="right" />
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Value Change</th>
                      <SortHeader field="pctChange" label="% Change" align="right" />
                    </tr>
                  </thead>
                  <tbody>
                    {sortedItems.map(item => {
                      const changeColor = (item.qtyChange || 0) > 0 ? 'text-green-600' : (item.qtyChange || 0) < 0 ? 'text-red-600' : 'text-gray-500'
                      const ChangeIcon = (item.qtyChange || 0) > 0 ? TrendingUp : (item.qtyChange || 0) < 0 ? TrendingDown : Minus
                      return (
                        <tr key={item.productId} className="border-b border-gray-100 hover:bg-gray-50">
                          <td className="py-3 px-3 text-sm font-mono text-gray-700">{item.sku}</td>
                          <td className="py-3 px-3 text-sm text-gray-900 font-medium">{item.name}</td>
                          <td className="py-3 px-3 text-sm text-right font-medium text-gray-900">{item.quantityOnHand}</td>
                          <td className="py-3 px-3 text-sm text-right text-gray-900">${item.totalValue.toFixed(2)}</td>
                          <td className="py-3 px-3 text-sm text-right text-gray-500">{item.priorYearQty ?? '—'}</td>
                          <td className="py-3 px-3 text-sm text-right text-gray-500">
                            {item.priorYearValue != null ? `$${item.priorYearValue.toFixed(2)}` : '—'}
                          </td>
                          <td className={`py-3 px-3 text-sm text-right font-medium ${changeColor}`}>
                            <span className="inline-flex items-center gap-1">
                              <ChangeIcon className="w-3 h-3" />
                              {item.qtyChange != null ? (item.qtyChange >= 0 ? '+' : '') + item.qtyChange : '—'}
                            </span>
                          </td>
                          <td className={`py-3 px-3 text-sm text-right font-medium ${changeColor}`}>
                            {item.valueChange != null ? (item.valueChange >= 0 ? '+$' : '-$') + Math.abs(item.valueChange).toFixed(2) : '—'}
                          </td>
                          <td className={`py-3 px-3 text-sm text-right font-medium ${changeColor}`}>
                            {item.pctChange != null ? (item.pctChange >= 0 ? '+' : '') + item.pctChange + '%' : '—'}
                          </td>
                        </tr>
                      )
                    })}
                  </tbody>
                </table>
              )}
            </div>
          )}

          {/* Count History Tab */}
          {activeTab === 'counts' && (
            <div className="overflow-x-auto">
              {!report?.countHistory?.length ? (
                <div className="text-center py-12">
                  <ClipboardList className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                  <p className="text-gray-500">No completed counts in this date range</p>
                </div>
              ) : (
                <table className="w-full">
                  <thead className="bg-gray-50 border-b border-gray-200">
                    <tr>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Date</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Type</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Status</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Items Counted</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Variances</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-right">Variance Value</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Counted By</th>
                      <th className="py-3 px-3 text-xs font-semibold text-gray-600 text-left">Verified By</th>
                    </tr>
                  </thead>
                  <tbody>
                    {report.countHistory.map(c => (
                      <tr key={c.id} className="border-b border-gray-100 hover:bg-gray-50">
                        <td className="py-3 px-3 text-sm text-gray-900 font-medium">
                          {new Date(c.countDate).toLocaleDateString()}
                        </td>
                        <td className="py-3 px-3 text-sm text-gray-600 capitalize">{c.countType.replace('_', ' ')}</td>
                        <td className="py-3 px-3">
                          <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${
                            c.status === 'completed' ? 'bg-green-100 text-green-700' : 'bg-blue-100 text-blue-700'
                          }`}>
                            <CheckCircle className="w-3 h-3 mr-1" />
                            {c.status}
                          </span>
                        </td>
                        <td className="py-3 px-3 text-sm text-right text-gray-900 font-medium">{c.itemsCounted}</td>
                        <td className="py-3 px-3 text-sm text-right text-gray-900">
                          {c.varianceCount > 0 ? (
                            <span className="text-amber-600 font-medium">{c.varianceCount}</span>
                          ) : (
                            <span className="text-green-600">0</span>
                          )}
                        </td>
                        <td className={`py-3 px-3 text-sm text-right font-medium ${
                          c.totalVarianceValue !== 0 ? 'text-amber-600' : 'text-green-600'
                        }`}>
                          ${Math.abs(c.totalVarianceValue).toFixed(2)}
                        </td>
                        <td className="py-3 px-3 text-sm text-gray-700">{c.countedByName}</td>
                        <td className="py-3 px-3 text-sm text-gray-500">{c.verifiedByName || '—'}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          )}

          {/* Adjustments by User Tab */}
          {activeTab === 'adjustments' && (
            <div>
              {!report?.userAdjustments?.length ? (
                <div className="text-center py-12">
                  <Users className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                  <p className="text-gray-500">No adjustments recorded in this date range</p>
                </div>
              ) : (
                <div className="divide-y divide-gray-200">
                  {report.userAdjustments.map(user => (
                    <div key={user.userId}>
                      {/* User Summary Row */}
                      <button
                        onClick={() => toggleUser(user.userId)}
                        className="w-full flex items-center justify-between px-5 py-4 hover:bg-gray-50 transition-colors"
                      >
                        <div className="flex items-center gap-3">
                          <div className="w-9 h-9 rounded-full bg-blue-100 flex items-center justify-center">
                            <span className="text-sm font-bold text-blue-700">
                              {user.userName.charAt(0).toUpperCase()}
                            </span>
                          </div>
                          <div className="text-left">
                            <p className="text-sm font-semibold text-gray-900">{user.userName}</p>
                            <p className="text-xs text-gray-500">{user.adjustmentCount} adjustment{user.adjustmentCount !== 1 ? 's' : ''}</p>
                          </div>
                        </div>
                        <div className="flex items-center gap-4">
                          <span className={`text-lg font-bold ${user.totalValue >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                            ${Math.abs(user.totalValue).toLocaleString()}
                          </span>
                          {expandedUsers.has(user.userId) ? (
                            <ChevronUp className="w-5 h-5 text-gray-400" />
                          ) : (
                            <ChevronDown className="w-5 h-5 text-gray-400" />
                          )}
                        </div>
                      </button>

                      {/* Expanded Detail */}
                      {expandedUsers.has(user.userId) && (
                        <div className="bg-gray-50 px-5 pb-4">
                          <table className="w-full">
                            <thead>
                              <tr className="border-b border-gray-200">
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-left">SKU</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-left">Product</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-left">Type</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-right">Previous</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-right">New</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-right">Change</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-right">Value</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-left">Reason</th>
                                <th className="py-2 px-2 text-xs font-semibold text-gray-500 text-left">Date</th>
                              </tr>
                            </thead>
                            <tbody>
                              {user.adjustments.map(a => (
                                <tr key={a.id} className="border-b border-gray-100">
                                  <td className="py-2 px-2 text-xs font-mono text-gray-600">{a.productSku}</td>
                                  <td className="py-2 px-2 text-xs text-gray-800">{a.productName}</td>
                                  <td className="py-2 px-2">
                                    <span className="text-xs px-1.5 py-0.5 rounded bg-gray-200 text-gray-600 capitalize">
                                      {a.adjustmentType.replace('_', ' ')}
                                    </span>
                                  </td>
                                  <td className="py-2 px-2 text-xs text-right text-gray-600">{a.previousQuantity}</td>
                                  <td className="py-2 px-2 text-xs text-right text-gray-900 font-medium">{a.newQuantity}</td>
                                  <td className={`py-2 px-2 text-xs text-right font-medium ${
                                    a.adjustmentQuantity >= 0 ? 'text-green-600' : 'text-red-600'
                                  }`}>
                                    {a.adjustmentQuantity >= 0 ? '+' : ''}{a.adjustmentQuantity}
                                  </td>
                                  <td className={`py-2 px-2 text-xs text-right font-medium ${
                                    a.adjustmentValue >= 0 ? 'text-green-600' : 'text-red-600'
                                  }`}>
                                    ${Math.abs(a.adjustmentValue).toFixed(2)}
                                  </td>
                                  <td className="py-2 px-2 text-xs text-gray-500 max-w-[150px] truncate">{a.reason || '—'}</td>
                                  <td className="py-2 px-2 text-xs text-gray-500">{new Date(a.createdAt).toLocaleDateString()}</td>
                                </tr>
                              ))}
                            </tbody>
                          </table>
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}
        </div>
      </div>

      {/* Report metadata */}
      {report && (
        <div className="text-center text-xs text-gray-400 py-2">
          Report generated {new Date(report.generatedAt).toLocaleString()} • {report.companyName}
        </div>
      )}
    </div>
  )
}

// Helper: default start date (90 days ago)
function getDefaultStartDate(): string {
  const d = new Date()
  d.setDate(d.getDate() - 90)
  return d.toISOString().split('T')[0]
}
