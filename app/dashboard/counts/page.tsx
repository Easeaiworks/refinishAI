'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  ClipboardList, Plus, CheckCircle, Clock, AlertCircle, X,
  TrendingUp, TrendingDown, Search, Filter, ChevronRight,
  Shield, AlertTriangle, Check, XCircle, RotateCcw
} from 'lucide-react'

interface Product {
  id: string
  sku: string
  name: string
  category: string
  unit_cost: number
  unit_type: string
}

interface CountItem {
  id?: string
  product_id: string
  product?: Product
  expected_quantity: number
  counted_quantity: number | null
  variance_quantity?: number
  variance_pct?: number
  unit_cost: number
  is_counted: boolean
  requires_review: boolean
  notes: string
}

interface Count {
  id: string
  count_type: string
  count_date: string
  status: string
  items_counted: number
  variance_count: number
  positive_variance_count: number
  negative_variance_count: number
  total_expected_value: number
  total_counted_value: number
  total_variance_value: number
  requires_review: boolean
  is_verified: boolean
  notes: string
  created_at: string
  counted_by: string
  verified_by: string
  rejection_reason: string
}

interface CompanySettings {
  variance_tolerance_pct: number
  high_value_threshold: number
  require_manager_approval: boolean
}

export default function CountsPage() {
  const [counts, setCounts] = useState<Count[]>([])
  const [products, setProducts] = useState<Product[]>([])
  const [countItems, setCountItems] = useState<CountItem[]>([])
  const [loading, setLoading] = useState(true)
  const [showNewCount, setShowNewCount] = useState(false)
  const [showCountForm, setShowCountForm] = useState(false)
  const [activeCount, setActiveCount] = useState<Count | null>(null)
  const [settings, setSettings] = useState<CompanySettings>({
    variance_tolerance_pct: 5,
    high_value_threshold: 100,
    require_manager_approval: true
  })
  const [searchTerm, setSearchTerm] = useState('')
  const [categoryFilter, setCategoryFilter] = useState('all')
  const [userRole, setUserRole] = useState<string>('staff')
  const [companyId, setCompanyId] = useState<string | null>(null)

  const supabase = createClient()

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    setLoading(true)

    // Get current user and company
    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id, role')
        .eq('id', user.id)
        .single()

      if (profile) {
        setCompanyId(profile.company_id)
        setUserRole(profile.role || 'staff')

        // Load company settings
        const { data: settingsData } = await supabase
          .from('company_settings')
          .select('*')
          .eq('company_id', profile.company_id)
          .single()

        if (settingsData) {
          setSettings(settingsData)
        }
      }
    }

    // Load counts
    await loadCounts()

    // Load products
    const { data: productsData } = await supabase
      .from('products')
      .select('*')
      .order('category', { ascending: true })
      .order('name', { ascending: true })

    if (productsData) setProducts(productsData)

    setLoading(false)
  }

  const loadCounts = async () => {
    const { data } = await supabase
      .from('inventory_counts')
      .select('*')
      .order('created_at', { ascending: false })

    if (data) setCounts(data)
  }

  const loadCountItems = async (countId: string) => {
    const { data } = await supabase
      .from('inventory_count_items')
      .select(`
        *,
        product:products (id, sku, name, category, unit_cost, unit_type)
      `)
      .eq('count_id', countId)
      .order('product(category)', { ascending: true })

    if (data) {
      setCountItems(data.map(item => ({
        ...item,
        product: item.product
      })))
    }
  }

  const createNewCount = async (countType: string, notes: string) => {
    if (!companyId) return

    // Create count record
    const { data: newCount, error } = await supabase
      .from('inventory_counts')
      .insert({
        company_id: companyId,
        count_type: countType,
        notes: notes,
        status: 'draft'
      })
      .select()
      .single()

    if (error || !newCount) {
      console.error('Error creating count:', error)
      return
    }

    // Create count items for all products
    const countItemsToInsert = products.map(product => ({
      count_id: newCount.id,
      product_id: product.id,
      expected_quantity: 0, // Will be set based on current inventory
      unit_cost: product.unit_cost || 0,
      is_counted: false,
      requires_review: false,
      notes: ''
    }))

    await supabase.from('inventory_count_items').insert(countItemsToInsert)

    setShowNewCount(false)
    await loadCounts()

    // Open the count form
    setActiveCount(newCount)
    await loadCountItems(newCount.id)
    setShowCountForm(true)
  }

  const updateCountItem = async (itemId: string, countedQty: number | null, notes?: string) => {
    const item = countItems.find(i => i.id === itemId)
    if (!item) return

    const variance = countedQty !== null ? countedQty - item.expected_quantity : 0
    const variancePct = item.expected_quantity > 0
      ? (variance / item.expected_quantity) * 100
      : countedQty !== null && countedQty > 0 ? 100 : 0

    const requiresReview = Math.abs(variancePct) > settings.variance_tolerance_pct ||
      (item.unit_cost * Math.abs(variance)) > settings.high_value_threshold

    await supabase
      .from('inventory_count_items')
      .update({
        counted_quantity: countedQty,
        variance_pct: variancePct,
        is_counted: countedQty !== null,
        requires_review: requiresReview,
        notes: notes || '',
        updated_at: new Date().toISOString()
      })
      .eq('id', itemId)

    // Refresh items
    if (activeCount) {
      await loadCountItems(activeCount.id)
    }
  }

  const submitForReview = async () => {
    if (!activeCount) return

    const uncountedItems = countItems.filter(i => !i.is_counted)
    if (uncountedItems.length > 0) {
      alert(`Please count all items before submitting. ${uncountedItems.length} items remaining.`)
      return
    }

    const hasVariances = countItems.some(i => i.requires_review)

    await supabase
      .from('inventory_counts')
      .update({
        status: hasVariances && settings.require_manager_approval ? 'pending_review' : 'completed',
        requires_review: hasVariances,
        updated_at: new Date().toISOString()
      })
      .eq('id', activeCount.id)

    setShowCountForm(false)
    setActiveCount(null)
    await loadCounts()
  }

  const approveCount = async (countId: string) => {
    const { data: { user } } = await supabase.auth.getUser()

    await supabase
      .from('inventory_counts')
      .update({
        status: 'approved',
        is_verified: true,
        verified_by: user?.id,
        verified_at: new Date().toISOString()
      })
      .eq('id', countId)

    // Log verification
    await supabase.from('count_verifications').insert({
      count_id: countId,
      action: 'approved',
      verified_by: user?.id
    })

    await loadCounts()
  }

  const rejectCount = async (countId: string, reason: string) => {
    const { data: { user } } = await supabase.auth.getUser()

    await supabase
      .from('inventory_counts')
      .update({
        status: 'rejected',
        rejection_reason: reason
      })
      .eq('id', countId)

    await supabase.from('count_verifications').insert({
      count_id: countId,
      action: 'rejected',
      verified_by: user?.id,
      rejection_reason: reason
    })

    await loadCounts()
  }

  const completeCount = async (countId: string) => {
    await supabase
      .from('inventory_counts')
      .update({ status: 'completed' })
      .eq('id', countId)

    await loadCounts()
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'completed': return 'bg-green-100 text-green-800'
      case 'approved': return 'bg-blue-100 text-blue-800'
      case 'pending_review': return 'bg-yellow-100 text-yellow-800'
      case 'rejected': return 'bg-red-100 text-red-800'
      case 'draft': return 'bg-gray-100 text-gray-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'completed': return <CheckCircle className="w-4 h-4" />
      case 'approved': return <Shield className="w-4 h-4" />
      case 'pending_review': return <Clock className="w-4 h-4" />
      case 'rejected': return <XCircle className="w-4 h-4" />
      default: return <Clock className="w-4 h-4" />
    }
  }

  const filteredItems = countItems.filter(item => {
    const matchesSearch = !searchTerm ||
      item.product?.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.product?.sku.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesCategory = categoryFilter === 'all' || item.product?.category === categoryFilter

    return matchesSearch && matchesCategory
  })

  const categories = Array.from(new Set(products.map(p => p.category))).sort()

  const isManager = ['manager', 'admin', 'super_admin'].includes(userRole)

  // Summary stats
  const totalVarianceValue = countItems.reduce((sum, item) =>
    sum + (item.is_counted ? (item.counted_quantity || 0) - item.expected_quantity : 0) * item.unit_cost, 0
  )
  const positiveVariances = countItems.filter(i => i.is_counted && (i.counted_quantity || 0) > i.expected_quantity).length
  const negativeVariances = countItems.filter(i => i.is_counted && (i.counted_quantity || 0) < i.expected_quantity).length
  const itemsRequiringReview = countItems.filter(i => i.requires_review).length

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Physical Inventory Counts</h1>
          <p className="text-gray-600 mt-2">Reconcile actual stock with system records</p>
        </div>
        <button
          onClick={() => setShowNewCount(true)}
          className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        >
          <Plus className="w-5 h-5" />
          New Count
        </button>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Total Counts</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{counts.length}</p>
            </div>
            <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <ClipboardList className="w-6 h-6 text-blue-600" />
            </div>
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Pending Review</p>
              <p className="text-3xl font-bold text-yellow-600 mt-2">
                {counts.filter(c => c.status === 'pending_review').length}
              </p>
            </div>
            <div className="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
              <AlertTriangle className="w-6 h-6 text-yellow-600" />
            </div>
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">In Progress</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">
                {counts.filter(c => c.status === 'draft').length}
              </p>
            </div>
            <div className="w-12 h-12 bg-gray-100 rounded-lg flex items-center justify-center">
              <Clock className="w-6 h-6 text-gray-600" />
            </div>
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Completed</p>
              <p className="text-3xl font-bold text-green-600 mt-2">
                {counts.filter(c => c.status === 'completed').length}
              </p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <CheckCircle className="w-6 h-6 text-green-600" />
            </div>
          </div>
        </div>
      </div>

      {/* Counts List */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : counts.length === 0 ? (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
          <ClipboardList className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No counts yet</h3>
          <p className="text-gray-600 mb-4">Start your first physical inventory count</p>
          <button
            onClick={() => setShowNewCount(true)}
            className="inline-flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            <Plus className="w-5 h-5" />
            Create First Count
          </button>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Date</th>
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Type</th>
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Status</th>
                <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700">Items</th>
                <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700">
                  <span className="text-green-600">+</span> / <span className="text-red-600">-</span>
                </th>
                <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Variance $</th>
                <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>
              </tr>
            </thead>
            <tbody>
              {counts.map((count) => (
                <tr key={count.id} className="border-b border-gray-100 hover:bg-gray-50">
                  <td className="py-3 px-4 text-gray-900">
                    {new Date(count.created_at).toLocaleDateString()}
                  </td>
                  <td className="py-3 px-4 text-gray-600 capitalize">
                    {count.count_type?.replace('_', ' ') || 'Full'}
                  </td>
                  <td className="py-3 px-4">
                    <span className={`inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium ${getStatusColor(count.status)}`}>
                      {getStatusIcon(count.status)}
                      {count.status.replace('_', ' ')}
                    </span>
                  </td>
                  <td className="py-3 px-4 text-center text-gray-900">
                    {count.items_counted || 0}
                  </td>
                  <td className="py-3 px-4 text-center">
                    <span className="text-green-600 font-medium">{count.positive_variance_count || 0}</span>
                    {' / '}
                    <span className="text-red-600 font-medium">{count.negative_variance_count || 0}</span>
                  </td>
                  <td className={`py-3 px-4 text-right font-medium ${
                    (count.total_variance_value || 0) >= 0 ? 'text-green-600' : 'text-red-600'
                  }`}>
                    {(count.total_variance_value || 0) >= 0 ? '+' : ''}
                    ${(count.total_variance_value || 0).toFixed(2)}
                  </td>
                  <td className="py-3 px-4 text-right">
                    <div className="flex items-center justify-end gap-2">
                      {count.status === 'draft' && (
                        <button
                          onClick={async () => {
                            setActiveCount(count)
                            await loadCountItems(count.id)
                            setShowCountForm(true)
                          }}
                          className="text-blue-600 hover:text-blue-700 font-medium text-sm"
                        >
                          Continue
                        </button>
                      )}
                      {count.status === 'pending_review' && isManager && (
                        <>
                          <button
                            onClick={() => approveCount(count.id)}
                            className="text-green-600 hover:text-green-700 font-medium text-sm"
                          >
                            Approve
                          </button>
                          <button
                            onClick={() => {
                              const reason = prompt('Rejection reason:')
                              if (reason) rejectCount(count.id, reason)
                            }}
                            className="text-red-600 hover:text-red-700 font-medium text-sm"
                          >
                            Reject
                          </button>
                        </>
                      )}
                      {count.status === 'approved' && (
                        <button
                          onClick={() => completeCount(count.id)}
                          className="text-green-600 hover:text-green-700 font-medium text-sm"
                        >
                          Complete
                        </button>
                      )}
                      <button
                        onClick={async () => {
                          setActiveCount(count)
                          await loadCountItems(count.id)
                          setShowCountForm(true)
                        }}
                        className="text-gray-600 hover:text-gray-700"
                      >
                        <ChevronRight className="w-5 h-5" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* New Count Modal */}
      {showNewCount && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-md w-full p-6">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-bold text-gray-900">Start New Count</h2>
              <button onClick={() => setShowNewCount(false)} className="text-gray-400 hover:text-gray-600">
                <X className="w-6 h-6" />
              </button>
            </div>
            <form onSubmit={(e) => {
              e.preventDefault()
              const form = e.target as HTMLFormElement
              const countType = (form.elements.namedItem('countType') as HTMLSelectElement).value
              const notes = (form.elements.namedItem('notes') as HTMLTextAreaElement).value
              createNewCount(countType, notes)
            }}>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">Count Type</label>
                  <select name="countType" className="w-full px-3 py-2 border border-gray-300 rounded-lg">
                    <option value="full">Full Count</option>
                    <option value="spot_check">Spot Check</option>
                    <option value="cycle">Cycle Count</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">Notes (Optional)</label>
                  <textarea
                    name="notes"
                    rows={3}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg"
                    placeholder="Add any notes about this count..."
                  />
                </div>
                <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                  <p className="text-sm text-blue-800">
                    <strong>Note:</strong> This will create a count sheet with all {products.length} products.
                    Tolerance threshold is set to {settings.variance_tolerance_pct}%.
                  </p>
                </div>
                <div className="flex gap-3">
                  <button
                    type="button"
                    onClick={() => setShowNewCount(false)}
                    className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
                  >
                    Start Count
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Count Form Modal */}
      {showCountForm && activeCount && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-6xl w-full max-h-[90vh] overflow-hidden flex flex-col">
            {/* Header */}
            <div className="p-6 border-b border-gray-200">
              <div className="flex items-center justify-between">
                <div>
                  <h2 className="text-xl font-bold text-gray-900">
                    Physical Count - {new Date(activeCount.created_at).toLocaleDateString()}
                  </h2>
                  <p className="text-gray-600 mt-1 capitalize">
                    {activeCount.count_type?.replace('_', ' ')} • {activeCount.status.replace('_', ' ')}
                  </p>
                </div>
                <button onClick={() => setShowCountForm(false)} className="text-gray-400 hover:text-gray-600">
                  <X className="w-6 h-6" />
                </button>
              </div>

              {/* Summary Stats */}
              <div className="grid grid-cols-4 gap-4 mt-4">
                <div className="bg-gray-50 rounded-lg p-3">
                  <p className="text-xs text-gray-500">Counted</p>
                  <p className="text-xl font-bold text-gray-900">
                    {countItems.filter(i => i.is_counted).length} / {countItems.length}
                  </p>
                </div>
                <div className="bg-green-50 rounded-lg p-3">
                  <p className="text-xs text-green-600">Over (+)</p>
                  <p className="text-xl font-bold text-green-600 flex items-center gap-1">
                    <TrendingUp className="w-4 h-4" />
                    {positiveVariances}
                  </p>
                </div>
                <div className="bg-red-50 rounded-lg p-3">
                  <p className="text-xs text-red-600">Short (-)</p>
                  <p className="text-xl font-bold text-red-600 flex items-center gap-1">
                    <TrendingDown className="w-4 h-4" />
                    {negativeVariances}
                  </p>
                </div>
                <div className={`rounded-lg p-3 ${totalVarianceValue >= 0 ? 'bg-green-50' : 'bg-red-50'}`}>
                  <p className="text-xs text-gray-500">Total Variance</p>
                  <p className={`text-xl font-bold ${totalVarianceValue >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                    {totalVarianceValue >= 0 ? '+' : ''}${totalVarianceValue.toFixed(2)}
                  </p>
                </div>
              </div>

              {/* Filters */}
              <div className="flex gap-4 mt-4">
                <div className="flex-1 relative">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                  <input
                    type="text"
                    placeholder="Search products..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg"
                  />
                </div>
                <select
                  value={categoryFilter}
                  onChange={(e) => setCategoryFilter(e.target.value)}
                  className="px-4 py-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Categories</option>
                  {categories.map(cat => (
                    <option key={cat} value={cat}>{cat}</option>
                  ))}
                </select>
              </div>
            </div>

            {/* Count Items Table */}
            <div className="flex-1 overflow-auto">
              <table className="w-full">
                <thead className="bg-gray-50 sticky top-0">
                  <tr>
                    <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Product</th>
                    <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700 w-32">Expected</th>
                    <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700 w-32">Counted</th>
                    <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700 w-28">Variance</th>
                    <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700 w-24">Status</th>
                    <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700 w-48">Notes</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredItems.map((item) => {
                    const variance = item.is_counted
                      ? (item.counted_quantity || 0) - item.expected_quantity
                      : null

                    return (
                      <tr
                        key={item.id}
                        className={`border-b border-gray-100 ${
                          item.requires_review ? 'bg-yellow-50' : ''
                        }`}
                      >
                        <td className="py-3 px-4">
                          <div>
                            <p className="font-medium text-gray-900">{item.product?.name}</p>
                            <p className="text-sm text-gray-500">
                              {item.product?.sku} • {item.product?.category} • ${item.unit_cost.toFixed(2)}/{item.product?.unit_type}
                            </p>
                          </div>
                        </td>
                        <td className="py-3 px-4 text-center text-gray-900 font-medium">
                          {item.expected_quantity}
                        </td>
                        <td className="py-3 px-4 text-center">
                          <input
                            type="number"
                            min="0"
                            step="0.01"
                            value={item.counted_quantity ?? ''}
                            onChange={(e) => {
                              const value = e.target.value === '' ? null : parseFloat(e.target.value)
                              if (item.id) updateCountItem(item.id, value)
                            }}
                            disabled={activeCount.status !== 'draft'}
                            className="w-24 px-2 py-1 border border-gray-300 rounded text-center disabled:bg-gray-100"
                            placeholder="—"
                          />
                        </td>
                        <td className={`py-3 px-4 text-center font-medium ${
                          variance === null ? 'text-gray-400' :
                          variance > 0 ? 'text-green-600' :
                          variance < 0 ? 'text-red-600' : 'text-gray-900'
                        }`}>
                          {variance === null ? '—' : (
                            <>
                              {variance > 0 ? '+' : ''}{variance}
                              {item.variance_pct !== undefined && (
                                <span className="text-xs ml-1">
                                  ({item.variance_pct > 0 ? '+' : ''}{item.variance_pct.toFixed(1)}%)
                                </span>
                              )}
                            </>
                          )}
                        </td>
                        <td className="py-3 px-4 text-center">
                          {item.requires_review ? (
                            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                              <AlertTriangle className="w-3 h-3" />
                              Review
                            </span>
                          ) : item.is_counted ? (
                            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                              <Check className="w-3 h-3" />
                              Done
                            </span>
                          ) : (
                            <span className="text-gray-400 text-xs">Pending</span>
                          )}
                        </td>
                        <td className="py-3 px-4">
                          <input
                            type="text"
                            value={item.notes || ''}
                            onChange={(e) => {
                              if (item.id) updateCountItem(item.id, item.counted_quantity, e.target.value)
                            }}
                            disabled={activeCount.status !== 'draft'}
                            className="w-full px-2 py-1 border border-gray-300 rounded text-sm disabled:bg-gray-100"
                            placeholder="Add note..."
                          />
                        </td>
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>

            {/* Footer */}
            <div className="p-6 border-t border-gray-200 bg-gray-50">
              <div className="flex items-center justify-between">
                <div>
                  {itemsRequiringReview > 0 && (
                    <p className="text-yellow-600 flex items-center gap-2">
                      <AlertTriangle className="w-5 h-5" />
                      {itemsRequiringReview} items exceed {settings.variance_tolerance_pct}% tolerance - requires manager review
                    </p>
                  )}
                </div>
                <div className="flex gap-3">
                  <button
                    onClick={() => setShowCountForm(false)}
                    className="px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-100"
                  >
                    Close
                  </button>
                  {activeCount.status === 'draft' && (
                    <button
                      onClick={submitForReview}
                      className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 flex items-center gap-2"
                    >
                      <CheckCircle className="w-5 h-5" />
                      Submit Count
                    </button>
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
