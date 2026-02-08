'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { PRODUCT_CATEGORIES } from '@/lib/constants'
import {
  Package,
  Plus,
  Search,
  AlertCircle,
  Edit2,
  Trash2,
  X,
  Filter,
  ArrowUp,
  ArrowDown,
  RotateCcw,
  AlertTriangle,
  CheckCircle,
  TrendingDown
} from 'lucide-react'
import { Product } from '@/lib/types'

interface InventoryStock {
  id: string
  product_id: string
  quantity_on_hand: number
  reorder_point: number
  reorder_quantity: number
  last_updated: string
}

interface ProductWithStock extends Product {
  stock?: InventoryStock
}

export default function InventoryPage() {
  const [products, setProducts] = useState<ProductWithStock[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [categoryFilter, setCategoryFilter] = useState('all')
  const [stockFilter, setStockFilter] = useState<'all' | 'low' | 'out' | 'ok'>('all')
  const [showAddModal, setShowAddModal] = useState(false)
  const [showStockModal, setShowStockModal] = useState(false)
  const [editingProduct, setEditingProduct] = useState<ProductWithStock | null>(null)
  const [adjustingProduct, setAdjustingProduct] = useState<ProductWithStock | null>(null)
  const [companyId, setCompanyId] = useState<string | null>(null)
  const supabase = createClient()

  const categories = ['all', ...PRODUCT_CATEGORIES]

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    // Get user's company
    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id')
        .eq('id', user.id)
        .single()

      if (profile?.company_id) {
        setCompanyId(profile.company_id)
        await loadProducts(profile.company_id)
        return
      }
    }
    setLoading(false)
  }

  const loadProducts = async (compId?: string) => {
    const company = compId || companyId
    if (!company) return

    setLoading(true)

    // Load products filtered by company
    const { data: productsData, error: productsError } = await supabase
      .from('products')
      .select('*')
      .eq('company_id', company)
      .order('name')

    // Load stock levels
    const { data: stockData, error: stockError } = await supabase
      .from('inventory_stock')
      .select('*')

    if (productsData) {
      // Merge stock data with products
      const productsWithStock = productsData.map(product => {
        const stock = stockData?.find(s => s.product_id === product.id)
        return { ...product, stock }
      })
      setProducts(productsWithStock)
    }

    setLoading(false)
  }

  const getStockStatus = (product: ProductWithStock) => {
    if (!product.stock) return 'unknown'
    const qty = product.stock.quantity_on_hand
    const reorderPoint = product.stock.reorder_point

    if (qty <= 0) return 'out'
    if (qty <= reorderPoint) return 'low'
    return 'ok'
  }

  const filteredProducts = products.filter(product => {
    const matchesSearch = product.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         product.sku.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesCategory = categoryFilter === 'all' || product.category === categoryFilter
    const status = getStockStatus(product)
    const matchesStock = stockFilter === 'all' || status === stockFilter
    return matchesSearch && matchesCategory && matchesStock
  })

  const deleteProduct = async (id: string) => {
    if (!confirm('Are you sure you want to delete this product?')) return

    const { error } = await supabase.from('products').delete().eq('id', id)
    if (!error) loadProducts()
  }

  // Calculate stats
  const lowStockCount = products.filter(p => getStockStatus(p) === 'low').length
  const outOfStockCount = products.filter(p => getStockStatus(p) === 'out').length
  const totalValue = products.reduce((sum, p) => {
    return sum + (p.stock?.quantity_on_hand || 0) * p.unit_cost
  }, 0)

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-5">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold text-white">Inventory Management</h1>
              <p className="text-slate-300 mt-1 text-sm">Manage your refinish products and stock levels</p>
            </div>
            <button
              onClick={() => setShowAddModal(true)}
              className="flex items-center gap-2 px-4 py-2 bg-blue-500 hover:bg-blue-400 text-white rounded-lg transition-colors"
            >
              <Plus className="w-5 h-5" />
              Add Product
            </button>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="p-4">
            <p className="text-sm text-gray-600">Total Products</p>
            <p className="text-2xl font-bold text-gray-900 mt-1">{products.length}</p>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">Active items</p>
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="p-4">
            <p className="text-sm text-gray-600">Total Inventory Value</p>
            <p className="text-2xl font-bold text-gray-900 mt-1">${totalValue.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">Stock valuation</p>
          </div>
        </div>
        <div
          className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden cursor-pointer hover:bg-orange-50 transition-colors"
          onClick={() => setStockFilter(stockFilter === 'low' ? 'all' : 'low')}
        >
          <div className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">Low Stock</p>
                <p className="text-2xl font-bold text-orange-600 mt-1">{lowStockCount}</p>
              </div>
              <AlertTriangle className="w-6 h-6 text-orange-500" />
            </div>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">Needs reorder</p>
          </div>
        </div>
        <div
          className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden cursor-pointer hover:bg-red-50 transition-colors"
          onClick={() => setStockFilter(stockFilter === 'out' ? 'all' : 'out')}
        >
          <div className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">Out of Stock</p>
                <p className="text-2xl font-bold text-red-600 mt-1">{outOfStockCount}</p>
              </div>
              <TrendingDown className="w-6 h-6 text-red-500" />
            </div>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">Critical stock</p>
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="p-4">
            <p className="text-sm text-gray-600">Categories</p>
            <p className="text-2xl font-bold text-gray-900 mt-1">
              {new Set(products.map(p => p.category)).size}
            </p>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">Total types</p>
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-gray-50 px-5 py-3 border-b border-gray-200">
          <h3 className="text-xs font-semibold text-gray-600 uppercase tracking-wider">Filters</h3>
        </div>
        <div className="p-4">
          <div className="flex flex-col sm:flex-row gap-4">
          {/* Search */}
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Search by product name or SKU..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>

          {/* Category Filter */}
          <div className="relative">
            <Filter className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <select
              value={categoryFilter}
              onChange={(e) => setCategoryFilter(e.target.value)}
              className="pl-10 pr-8 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white"
            >
              {categories.map(cat => (
                <option key={cat} value={cat}>
                  {cat === 'all' ? 'All Categories' : cat}
                </option>
              ))}
            </select>
          </div>

          {/* Stock Status Filter */}
          <div className="flex gap-2">
            {(['all', 'ok', 'low', 'out'] as const).map(status => (
              <button
                key={status}
                onClick={() => setStockFilter(status)}
                className={`px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                  stockFilter === status
                    ? status === 'ok' ? 'bg-green-100 text-green-700 border border-green-300'
                      : status === 'low' ? 'bg-orange-100 text-orange-700 border border-orange-300'
                      : status === 'out' ? 'bg-red-100 text-red-700 border border-red-300'
                      : 'bg-blue-100 text-blue-700 border border-blue-300'
                    : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                }`}
              >
                {status === 'all' ? 'All' : status === 'ok' ? 'In Stock' : status === 'low' ? 'Low' : 'Out'}
              </button>
            ))}
          </div>
        </div>
        </div>
      </div>

      {/* Products Table */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : filteredProducts.length === 0 ? (
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-12 text-center overflow-hidden">
          <Package className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No products found</h3>
          <p className="text-gray-600">
            {searchTerm || categoryFilter !== 'all' || stockFilter !== 'all'
              ? 'Try adjusting your filters'
              : 'Get started by adding your first product'
            }
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-slate-100 border-b border-gray-200">
                <tr>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">SKU</th>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Product Name</th>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Category</th>
                  <th className="text-center py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Stock Status</th>
                  <th className="text-right py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">On Hand</th>
                  <th className="text-right py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Reorder Point</th>
                  <th className="text-right py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Cost</th>
                  <th className="text-right py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Value</th>
                  <th className="text-right py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                </tr>
              </thead>
              <tbody>
                {filteredProducts.map((product) => {
                  const status = getStockStatus(product)
                  const qty = product.stock?.quantity_on_hand || 0
                  const value = qty * product.unit_cost

                  return (
                    <tr key={product.id} className="border-b border-gray-100 hover:bg-gray-50">
                      <td className="py-3 px-4 font-mono text-sm text-gray-900">{product.sku}</td>
                      <td className="py-3 px-4">
                        <p className="font-medium text-gray-900">{product.name}</p>
                        <p className="text-xs text-gray-500">{product.supplier}</p>
                      </td>
                      <td className="py-3 px-4">
                        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                          {product.category}
                        </span>
                      </td>
                      <td className="py-3 px-4 text-center">
                        {status === 'ok' && (
                          <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-green-100 text-green-700">
                            <CheckCircle className="w-3 h-3" />
                            In Stock
                          </span>
                        )}
                        {status === 'low' && (
                          <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-orange-100 text-orange-700">
                            <AlertTriangle className="w-3 h-3" />
                            Low Stock
                          </span>
                        )}
                        {status === 'out' && (
                          <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-red-100 text-red-700">
                            <AlertCircle className="w-3 h-3" />
                            Out of Stock
                          </span>
                        )}
                        {status === 'unknown' && (
                          <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-600">
                            No Data
                          </span>
                        )}
                      </td>
                      <td className="py-3 px-4 text-right font-medium text-gray-900">
                        {qty.toFixed(1)} {product.unit_type}
                      </td>
                      <td className="py-3 px-4 text-right text-gray-600">
                        {product.stock?.reorder_point?.toFixed(1) || '-'}
                      </td>
                      <td className="py-3 px-4 text-right text-gray-900">
                        ${product.unit_cost.toFixed(2)}
                      </td>
                      <td className="py-3 px-4 text-right text-gray-900 font-medium">
                        ${value.toFixed(2)}
                      </td>
                      <td className="py-3 px-4 text-right">
                        <div className="flex items-center justify-end gap-1">
                          <button
                            onClick={() => {
                              setAdjustingProduct(product)
                              setShowStockModal(true)
                            }}
                            className="p-1.5 text-green-600 hover:bg-green-50 rounded"
                            title="Adjust Stock"
                          >
                            <RotateCcw className="w-4 h-4" />
                          </button>
                          <button
                            onClick={() => {
                              setEditingProduct(product)
                              setShowAddModal(true)
                            }}
                            className="p-1.5 text-blue-600 hover:bg-blue-50 rounded"
                            title="Edit"
                          >
                            <Edit2 className="w-4 h-4" />
                          </button>
                          <button
                            onClick={() => deleteProduct(product.id)}
                            className="p-1.5 text-red-600 hover:bg-red-50 rounded"
                            title="Delete"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Add/Edit Product Modal */}
      {showAddModal && (
        <ProductModal
          product={editingProduct}
          companyId={companyId}
          onClose={() => {
            setShowAddModal(false)
            setEditingProduct(null)
          }}
          onSave={() => {
            loadProducts()
            setShowAddModal(false)
            setEditingProduct(null)
          }}
        />
      )}

      {/* Adjust Stock Modal */}
      {showStockModal && adjustingProduct && (
        <StockAdjustmentModal
          product={adjustingProduct}
          onClose={() => {
            setShowStockModal(false)
            setAdjustingProduct(null)
          }}
          onSave={() => {
            loadProducts()
            setShowStockModal(false)
            setAdjustingProduct(null)
          }}
        />
      )}
    </div>
  )
}

// Product Modal Component
function ProductModal({
  product,
  companyId,
  onClose,
  onSave
}: {
  product: ProductWithStock | null
  companyId: string | null
  onClose: () => void
  onSave: () => void
}) {
  const [formData, setFormData] = useState({
    sku: product?.sku || '',
    name: product?.name || '',
    category: product?.category || 'Paint',
    unit_type: product?.unit_type || 'Gallon',
    coverage_sqft_per_unit: product?.coverage_sqft_per_unit || 100,
    waste_factor: product?.waste_factor || 0.15,
    unit_cost: product?.unit_cost || 0,
    supplier: product?.supplier || '',
    lead_time_days: product?.lead_time_days || 7,
  })
  const [saving, setSaving] = useState(false)
  const supabase = createClient()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setSaving(true)

    try {
      if (product) {
        await supabase.from('products').update(formData).eq('id', product.id)
      } else {
        // Include company_id for new products
        const insertData = companyId ? { ...formData, company_id: companyId } : formData
        const { data: newProduct } = await supabase.from('products').insert([insertData]).select().single()

        // Create initial stock record for new product
        if (newProduct) {
          await supabase.from('inventory_stock').insert({
            product_id: newProduct.id,
            quantity_on_hand: 0,
            reorder_point: 5,
            reorder_quantity: 10
          })
        }
      }
      onSave()
    } catch (error) {
      alert('Error saving product')
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        <div className="flex items-center justify-between p-6 border-b border-gray-200">
          <h2 className="text-xl font-bold text-gray-900">
            {product ? 'Edit Product' : 'Add New Product'}
          </h2>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg">
            <X className="w-5 h-5" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">SKU</label>
              <input
                type="text"
                required
                value={formData.sku}
                onChange={(e) => setFormData({ ...formData, sku: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Product Name</label>
              <input
                type="text"
                required
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Category</label>
              <select
                value={formData.category}
                onChange={(e) => setFormData({ ...formData, category: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              >
                {PRODUCT_CATEGORIES.map(cat => (
                  <option key={cat} value={cat}>{cat}</option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Unit Type</label>
              <select
                value={formData.unit_type}
                onChange={(e) => setFormData({ ...formData, unit_type: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              >
                <option>Gallon</option>
                <option>Quart</option>
                <option>Liter</option>
                <option>Pint</option>
                <option>Each</option>
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Coverage (sq ft/unit)</label>
              <input
                type="number"
                step="0.1"
                required
                value={formData.coverage_sqft_per_unit}
                onChange={(e) => setFormData({ ...formData, coverage_sqft_per_unit: parseFloat(e.target.value) })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Waste Factor</label>
              <input
                type="number"
                step="0.01"
                required
                value={formData.waste_factor}
                onChange={(e) => setFormData({ ...formData, waste_factor: parseFloat(e.target.value) })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                placeholder="0.15 = 15%"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Unit Cost ($)</label>
              <input
                type="number"
                step="0.01"
                required
                value={formData.unit_cost}
                onChange={(e) => setFormData({ ...formData, unit_cost: parseFloat(e.target.value) })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Supplier</label>
              <input
                type="text"
                required
                value={formData.supplier}
                onChange={(e) => setFormData({ ...formData, supplier: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Lead Time (days)</label>
              <input
                type="number"
                required
                value={formData.lead_time_days}
                onChange={(e) => setFormData({ ...formData, lead_time_days: parseInt(e.target.value) })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>

          <div className="flex gap-3 pt-4">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={saving}
              className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400"
            >
              {saving ? 'Saving...' : 'Save Product'}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

// Stock Adjustment Modal
function StockAdjustmentModal({
  product,
  onClose,
  onSave
}: {
  product: ProductWithStock
  onClose: () => void
  onSave: () => void
}) {
  const [adjustmentType, setAdjustmentType] = useState<'add' | 'remove' | 'set'>('add')
  const [quantity, setQuantity] = useState(0)
  const [reason, setReason] = useState('')
  const [reorderPoint, setReorderPoint] = useState(product.stock?.reorder_point || 5)
  const [reorderQuantity, setReorderQuantity] = useState(product.stock?.reorder_quantity || 10)
  const [saving, setSaving] = useState(false)
  const supabase = createClient()

  const currentStock = product.stock?.quantity_on_hand || 0

  const getNewQuantity = () => {
    switch (adjustmentType) {
      case 'add': return currentStock + quantity
      case 'remove': return Math.max(0, currentStock - quantity)
      case 'set': return quantity
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setSaving(true)

    try {
      const newQty = getNewQuantity()
      const qtyChange = newQty - currentStock

      // Create transaction record
      await supabase.from('inventory_transactions').insert({
        product_id: product.id,
        transaction_type: adjustmentType === 'add' ? 'purchase' : adjustmentType === 'remove' ? 'consumption' : 'adjustment',
        quantity_change: qtyChange,
        quantity_after: newQty,
        reference_type: 'manual',
        cost_per_unit: product.unit_cost,
        notes: reason || `Manual ${adjustmentType} adjustment`
      })

      // Update or insert stock record
      const { data: existingStock } = await supabase
        .from('inventory_stock')
        .select('id')
        .eq('product_id', product.id)
        .single()

      if (existingStock) {
        await supabase.from('inventory_stock').update({
          quantity_on_hand: newQty,
          reorder_point: reorderPoint,
          reorder_quantity: reorderQuantity,
          last_updated: new Date().toISOString()
        }).eq('product_id', product.id)
      } else {
        await supabase.from('inventory_stock').insert({
          product_id: product.id,
          quantity_on_hand: newQty,
          reorder_point: reorderPoint,
          reorder_quantity: reorderQuantity
        })
      }

      onSave()
    } catch (error) {
      console.error('Error adjusting stock:', error)
      alert('Error adjusting stock')
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-lg w-full">
        <div className="flex items-center justify-between p-6 border-b border-gray-200">
          <div>
            <h2 className="text-xl font-bold text-gray-900">Adjust Stock</h2>
            <p className="text-sm text-gray-600 mt-1">{product.name}</p>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg">
            <X className="w-5 h-5" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          {/* Current Stock Display */}
          <div className="bg-gray-50 rounded-lg p-4">
            <div className="flex justify-between items-center">
              <span className="text-gray-600">Current Stock:</span>
              <span className="text-xl font-bold text-gray-900">{currentStock.toFixed(1)} {product.unit_type}</span>
            </div>
          </div>

          {/* Adjustment Type */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Adjustment Type</label>
            <div className="grid grid-cols-3 gap-2">
              <button
                type="button"
                onClick={() => setAdjustmentType('add')}
                className={`flex items-center justify-center gap-2 p-3 rounded-lg border-2 transition-colors ${
                  adjustmentType === 'add'
                    ? 'border-green-500 bg-green-50 text-green-700'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                <ArrowUp className="w-4 h-4" />
                Add
              </button>
              <button
                type="button"
                onClick={() => setAdjustmentType('remove')}
                className={`flex items-center justify-center gap-2 p-3 rounded-lg border-2 transition-colors ${
                  adjustmentType === 'remove'
                    ? 'border-red-500 bg-red-50 text-red-700'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                <ArrowDown className="w-4 h-4" />
                Remove
              </button>
              <button
                type="button"
                onClick={() => setAdjustmentType('set')}
                className={`flex items-center justify-center gap-2 p-3 rounded-lg border-2 transition-colors ${
                  adjustmentType === 'set'
                    ? 'border-blue-500 bg-blue-50 text-blue-700'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                <RotateCcw className="w-4 h-4" />
                Set
              </button>
            </div>
          </div>

          {/* Quantity */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              {adjustmentType === 'set' ? 'New Quantity' : 'Quantity to ' + (adjustmentType === 'add' ? 'Add' : 'Remove')}
            </label>
            <input
              type="number"
              step="0.1"
              min="0"
              required
              value={quantity}
              onChange={(e) => setQuantity(parseFloat(e.target.value) || 0)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
            <p className="text-sm text-gray-500 mt-1">
              New stock will be: <span className="font-semibold">{getNewQuantity().toFixed(1)} {product.unit_type}</span>
            </p>
          </div>

          {/* Reason */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Reason (Optional)</label>
            <input
              type="text"
              value={reason}
              onChange={(e) => setReason(e.target.value)}
              placeholder="e.g., Received shipment, Physical count, Waste..."
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Reorder Settings */}
          <div className="pt-4 border-t border-gray-200">
            <h3 className="text-sm font-medium text-gray-700 mb-3">Reorder Settings</h3>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-xs text-gray-500 mb-1">Reorder Point</label>
                <input
                  type="number"
                  step="0.1"
                  min="0"
                  value={reorderPoint}
                  onChange={(e) => setReorderPoint(parseFloat(e.target.value) || 0)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 text-sm"
                />
              </div>
              <div>
                <label className="block text-xs text-gray-500 mb-1">Reorder Quantity</label>
                <input
                  type="number"
                  step="0.1"
                  min="0"
                  value={reorderQuantity}
                  onChange={(e) => setReorderQuantity(parseFloat(e.target.value) || 0)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 text-sm"
                />
              </div>
            </div>
          </div>

          <div className="flex gap-3 pt-4">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={saving}
              className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400"
            >
              {saving ? 'Saving...' : 'Save Adjustment'}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
