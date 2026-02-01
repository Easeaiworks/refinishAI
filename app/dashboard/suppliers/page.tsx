'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Building2, Package, DollarSign, RefreshCw, Search, Filter,
  Plus, Settings, ExternalLink, CheckCircle, XCircle, AlertCircle,
  ShoppingCart, TrendingDown, ArrowRight, Truck, Clock, Star
} from 'lucide-react'
import {
  SUPPLIERS,
  SUPPLIER_INFO,
  SupplierCode,
  PRODUCT_CATEGORIES,
  formatProductForDB
} from '@/lib/suppliers'
import {
  getSupplierAPI,
  comparePrices,
  getAllSupplierProducts
} from '@/lib/suppliers/supplier-service'
import type { SupplierProduct, SupplierConfig, PriceQuote } from '@/lib/suppliers'

export default function SuppliersPage() {
  const [supplierConfigs, setSupplierConfigs] = useState<SupplierConfig[]>([])
  const [products, setProducts] = useState<SupplierProduct[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [categoryFilter, setCategoryFilter] = useState('all')
  const [supplierFilter, setSupplierFilter] = useState('all')
  const [selectedProduct, setSelectedProduct] = useState<SupplierProduct | null>(null)
  const [priceQuotes, setPriceQuotes] = useState<PriceQuote[]>([])
  const [comparingPrices, setComparingPrices] = useState(false)
  const [showConfigModal, setShowConfigModal] = useState(false)
  const [importing, setImporting] = useState<string | null>(null)
  const supabase = createClient()

  useEffect(() => {
    initializeSuppliers()
  }, [])

  const initializeSuppliers = async () => {
    setLoading(true)

    // Load supplier configs from database or use defaults
    const { data: savedConfigs } = await supabase
      .from('supplier_configs')
      .select('*')

    const configs: SupplierConfig[] = (savedConfigs && savedConfigs.length > 0)
      ? savedConfigs as SupplierConfig[]
      : Object.entries(SUPPLIER_INFO).map(([code, info]) => ({
          id: code,
          code: code as SupplierCode,
          name: info.name,
          enabled: ['PPG', 'AXALTA', 'SHERWIN_WILLIAMS'].includes(code),
          logoUrl: `/logos/${code.toLowerCase()}.png`
        }))

    setSupplierConfigs(configs)

    // Load products from enabled suppliers
    const enabledConfigs = configs.filter(c => c.enabled)
    const allProducts = await getAllSupplierProducts(enabledConfigs)
    setProducts(allProducts)

    setLoading(false)
  }

  const toggleSupplier = async (supplierId: string) => {
    const updated = supplierConfigs.map(c =>
      c.id === supplierId ? { ...c, enabled: !c.enabled } : c
    )
    setSupplierConfigs(updated)

    // Reload products
    const enabledConfigs = updated.filter(c => c.enabled)
    const allProducts = await getAllSupplierProducts(enabledConfigs)
    setProducts(allProducts)
  }

  const handleComparePrice = async (product: SupplierProduct) => {
    setSelectedProduct(product)
    setComparingPrices(true)
    setPriceQuotes([])

    try {
      const quotes = await comparePrices(
        product.name.split(' ')[0], // Search by first word
        1,
        supplierConfigs.filter(c => c.enabled)
      )
      setPriceQuotes(quotes)
    } catch (error) {
      console.error('Error comparing prices:', error)
    } finally {
      setComparingPrices(false)
    }
  }

  const importToInventory = async (product: SupplierProduct) => {
    setImporting(product.supplierSku)

    try {
      const productData = formatProductForDB(product)

      const { error } = await supabase.from('products').insert([productData])

      if (error) {
        if (error.code === '23505') {
          alert('Product already exists in inventory')
        } else {
          throw error
        }
      } else {
        alert(`${product.name} added to inventory!`)
      }
    } catch (error) {
      console.error('Error importing product:', error)
      alert('Error importing product')
    } finally {
      setImporting(null)
    }
  }

  const filteredProducts = products.filter(product => {
    const matchesSearch = !searchTerm ||
      product.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      product.supplierSku.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesCategory = categoryFilter === 'all' || product.category === categoryFilter
    const matchesSupplier = supplierFilter === 'all' || product.supplierCode === supplierFilter

    return matchesSearch && matchesCategory && matchesSupplier
  })

  const enabledSupplierCount = supplierConfigs.filter(c => c.enabled).length

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Paint Suppliers</h1>
          <p className="text-gray-600 mt-2">Browse products and compare prices from major suppliers</p>
        </div>
        <button
          onClick={() => setShowConfigModal(true)}
          className="flex items-center gap-2 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
        >
          <Settings className="w-4 h-4" />
          Configure Suppliers
        </button>
      </div>

      {/* Supplier Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {supplierConfigs.slice(0, 6).map(config => {
          const info = SUPPLIER_INFO[config.code as SupplierCode]
          const productCount = products.filter(p => p.supplierCode === config.code).length

          return (
            <div
              key={config.id}
              className={`bg-white rounded-lg shadow-sm border-2 p-4 transition-all ${
                config.enabled
                  ? 'border-blue-500 bg-blue-50'
                  : 'border-gray-200 opacity-60'
              }`}
            >
              <div className="flex items-center justify-between mb-2">
                <Building2 className={`w-6 h-6 ${config.enabled ? 'text-blue-600' : 'text-gray-400'}`} />
                <button
                  onClick={() => toggleSupplier(config.id)}
                  className={`w-8 h-5 rounded-full transition-colors ${
                    config.enabled ? 'bg-blue-600' : 'bg-gray-300'
                  }`}
                >
                  <span className={`block w-4 h-4 bg-white rounded-full transform transition-transform ${
                    config.enabled ? 'translate-x-3' : 'translate-x-0.5'
                  }`} />
                </button>
              </div>
              <p className="font-semibold text-gray-900 text-sm">{config.name}</p>
              {config.enabled && (
                <p className="text-xs text-blue-600 mt-1">{productCount} products</p>
              )}
            </div>
          )
        })}
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Active Suppliers</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{enabledSupplierCount}</p>
            </div>
            <Building2 className="w-8 h-8 text-blue-500" />
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Total Products</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{products.length}</p>
            </div>
            <Package className="w-8 h-8 text-green-500" />
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Categories</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">
                {new Set(products.map(p => p.category)).size}
              </p>
            </div>
            <Filter className="w-8 h-8 text-purple-500" />
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Avg Lead Time</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">
                {Math.round(products.reduce((sum, p) => sum + (p.leadTimeDays || 0), 0) / products.length || 0)} days
              </p>
            </div>
            <Truck className="w-8 h-8 text-orange-500" />
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
        <div className="flex flex-col md:flex-row gap-4">
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Search products by name or SKU..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <select
            value={categoryFilter}
            onChange={(e) => setCategoryFilter(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg"
          >
            <option value="all">All Categories</option>
            {PRODUCT_CATEGORIES.map(cat => (
              <option key={cat} value={cat}>{cat}</option>
            ))}
          </select>
          <select
            value={supplierFilter}
            onChange={(e) => setSupplierFilter(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg"
          >
            <option value="all">All Suppliers</option>
            {supplierConfigs.filter(c => c.enabled).map(config => (
              <option key={config.id} value={config.code}>{config.name}</option>
            ))}
          </select>
        </div>
      </div>

      {/* Products Grid */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : filteredProducts.length === 0 ? (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
          <Package className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No products found</h3>
          <p className="text-gray-600">
            {enabledSupplierCount === 0
              ? 'Enable at least one supplier to see products'
              : 'Try adjusting your search or filters'
            }
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filteredProducts.map((product, index) => (
            <div
              key={`${product.supplierCode}-${product.supplierSku}-${index}`}
              className="bg-white rounded-lg shadow-sm border border-gray-200 p-4 hover:shadow-md transition-shadow"
            >
              <div className="flex items-start justify-between mb-3">
                <div>
                  <span className="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-blue-100 text-blue-700">
                    {SUPPLIER_INFO[product.supplierCode as SupplierCode]?.name || product.supplierCode}
                  </span>
                  <p className="font-mono text-xs text-gray-500 mt-1">{product.supplierSku}</p>
                </div>
                {product.inStock ? (
                  <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-700">
                    <CheckCircle className="w-3 h-3" />
                    In Stock
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-700">
                    <XCircle className="w-3 h-3" />
                    Out
                  </span>
                )}
              </div>

              <h3 className="font-semibold text-gray-900 mb-2">{product.name}</h3>

              <div className="flex items-center gap-2 text-sm text-gray-500 mb-3">
                <span className="px-2 py-0.5 bg-gray-100 rounded">{product.category}</span>
                <span>•</span>
                <span>{product.unitType}</span>
              </div>

              <div className="flex items-end justify-between mb-4">
                <div>
                  <p className="text-2xl font-bold text-gray-900">${product.unitCost.toFixed(2)}</p>
                  {product.msrp && product.msrp > product.unitCost && (
                    <p className="text-sm text-gray-500 line-through">${product.msrp.toFixed(2)} MSRP</p>
                  )}
                </div>
                <div className="text-right text-sm text-gray-500">
                  <div className="flex items-center gap-1">
                    <Clock className="w-3 h-3" />
                    {product.leadTimeDays} days
                  </div>
                </div>
              </div>

              <div className="flex gap-2">
                <button
                  onClick={() => handleComparePrice(product)}
                  className="flex-1 flex items-center justify-center gap-1 px-3 py-2 text-sm border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
                >
                  <TrendingDown className="w-4 h-4" />
                  Compare
                </button>
                <button
                  onClick={() => importToInventory(product)}
                  disabled={importing === product.supplierSku}
                  className="flex-1 flex items-center justify-center gap-1 px-3 py-2 text-sm bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400"
                >
                  {importing === product.supplierSku ? (
                    <RefreshCw className="w-4 h-4 animate-spin" />
                  ) : (
                    <Plus className="w-4 h-4" />
                  )}
                  Add
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Price Comparison Modal */}
      {selectedProduct && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-lg w-full p-6">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-bold text-gray-900">Price Comparison</h2>
              <button
                onClick={() => {
                  setSelectedProduct(null)
                  setPriceQuotes([])
                }}
                className="p-2 hover:bg-gray-100 rounded-lg"
              >
                <XCircle className="w-5 h-5" />
              </button>
            </div>

            <div className="bg-gray-50 rounded-lg p-4 mb-4">
              <p className="font-semibold text-gray-900">{selectedProduct.name}</p>
              <p className="text-sm text-gray-500">{selectedProduct.category}</p>
            </div>

            {comparingPrices ? (
              <div className="flex items-center justify-center py-8">
                <RefreshCw className="w-8 h-8 text-blue-500 animate-spin" />
                <span className="ml-2 text-gray-600">Comparing prices...</span>
              </div>
            ) : priceQuotes.length === 0 ? (
              <div className="text-center py-8 text-gray-500">
                No comparable products found at other suppliers
              </div>
            ) : (
              <div className="space-y-3">
                {priceQuotes.map((quote, index) => (
                  <div
                    key={quote.supplierId}
                    className={`p-4 rounded-lg border-2 ${
                      index === 0 ? 'border-green-500 bg-green-50' : 'border-gray-200'
                    }`}
                  >
                    <div className="flex items-center justify-between">
                      <div>
                        <div className="flex items-center gap-2">
                          <p className="font-semibold text-gray-900">
                            {SUPPLIER_INFO[quote.supplierId as SupplierCode]?.name || quote.supplierId}
                          </p>
                          {index === 0 && (
                            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-700">
                              <Star className="w-3 h-3" />
                              Best Price
                            </span>
                          )}
                        </div>
                        <p className="text-sm text-gray-500">SKU: {quote.productSku}</p>
                      </div>
                      <div className="text-right">
                        <p className="text-xl font-bold text-gray-900">${quote.unitPrice.toFixed(2)}</p>
                        {quote.discountApplied && quote.discountApplied > 0 && (
                          <p className="text-sm text-green-600">-{quote.discountApplied}% discount</p>
                        )}
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}

            <div className="mt-6 flex justify-end">
              <button
                onClick={() => {
                  setSelectedProduct(null)
                  setPriceQuotes([])
                }}
                className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Configure Suppliers Modal */}
      {showConfigModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full p-6 max-h-[80vh] overflow-y-auto">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-bold text-gray-900">Supplier Configuration</h2>
              <button
                onClick={() => setShowConfigModal(false)}
                className="p-2 hover:bg-gray-100 rounded-lg"
              >
                <XCircle className="w-5 h-5" />
              </button>
            </div>

            <p className="text-gray-600 mb-4">
              Enable suppliers to browse their product catalogs and compare prices.
              API credentials can be added for real-time pricing (contact suppliers for API access).
            </p>

            <div className="space-y-4">
              {Object.entries(SUPPLIER_INFO).map(([code, info]) => {
                const config = supplierConfigs.find(c => c.code === code)

                return (
                  <div
                    key={code}
                    className={`p-4 rounded-lg border-2 ${
                      config?.enabled ? 'border-blue-500 bg-blue-50' : 'border-gray-200'
                    }`}
                  >
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3">
                          <h3 className="font-semibold text-gray-900">{info.name}</h3>
                          <button
                            onClick={() => toggleSupplier(code)}
                            className={`px-3 py-1 rounded-full text-xs font-medium ${
                              config?.enabled
                                ? 'bg-blue-600 text-white'
                                : 'bg-gray-200 text-gray-600'
                            }`}
                          >
                            {config?.enabled ? 'Enabled' : 'Disabled'}
                          </button>
                        </div>
                        <p className="text-sm text-gray-500 mt-1">{info.description}</p>
                        {info.website && (
                          <a
                            href={info.website}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="inline-flex items-center gap-1 text-sm text-blue-600 hover:text-blue-700 mt-2"
                          >
                            <ExternalLink className="w-3 h-3" />
                            Visit Website
                          </a>
                        )}
                      </div>
                    </div>

                    {config?.enabled && code !== 'CUSTOM' && (
                      <div className="mt-4 pt-4 border-t border-gray-200">
                        <p className="text-xs text-gray-500 mb-2">API Configuration (Optional)</p>
                        <div className="grid grid-cols-2 gap-2">
                          <input
                            type="text"
                            placeholder="API Endpoint"
                            className="px-3 py-1.5 text-sm border border-gray-300 rounded"
                          />
                          <input
                            type="password"
                            placeholder="API Key"
                            className="px-3 py-1.5 text-sm border border-gray-300 rounded"
                          />
                        </div>
                      </div>
                    )}
                  </div>
                )
              })}
            </div>

            <div className="mt-6 pt-4 border-t border-gray-200 flex justify-end">
              <button
                onClick={() => setShowConfigModal(false)}
                className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
              >
                Done
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
