'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Building2, Package, DollarSign, RefreshCw, Search, Filter,
  Plus, Settings, ExternalLink, CheckCircle, XCircle, AlertCircle,
  ShoppingCart, TrendingDown, ArrowRight, Truck, Clock, Star, Lock
} from 'lucide-react'
import {
  SUPPLIERS,
  SUPPLIER_INFO,
  SupplierCode,
  SUPPLIER_PRODUCT_CATEGORIES,
  formatProductForDB
} from '@/lib/suppliers'
import {
  getSupplierAPI,
  comparePrices,
  getAllSupplierProducts
} from '@/lib/suppliers/supplier-service'
import type { SupplierProduct, SupplierConfig, PriceQuote } from '@/lib/suppliers'

interface CompanyVendor {
  id: string
  vendor_code: string
  vendor_name: string
  is_active: boolean
  is_primary: boolean
  discount_percent: number
}

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
  const [companyVendors, setCompanyVendors] = useState<CompanyVendor[]>([])
  const [companyId, setCompanyId] = useState<string | null>(null)
  const [userRole, setUserRole] = useState<string>('')
  const supabase = createClient()

  useEffect(() => {
    initializeSuppliers()
  }, [])

  const initializeSuppliers = async () => {
    setLoading(true)

    // Get user's company and role
    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id, role')
        .eq('id', user.id)
        .single()

      if (profile) {
        setCompanyId(profile.company_id)
        setUserRole(profile.role)

        // Load company's allowed vendors
        const { data: vendors } = await supabase
          .from('company_vendors')
          .select('*')
          .eq('company_id', profile.company_id)
          .eq('is_active', true)

        if (vendors) {
          setCompanyVendors(vendors)

          // Map vendor_code to SupplierCode
          const vendorCodeMapping: Record<string, SupplierCode> = {
            'ppg': 'PPG',
            'axalta': 'AXALTA',
            'sherwin_williams': 'SHERWIN_WILLIAMS',
            'basf': 'BASF',
            'dupont': 'DUPONT',
            '3m': '3M',
            'norton': 'NORTON',
            'sata': 'SATA',
            'devilbiss': 'DEVILBISS',
            'generic': 'GENERIC'
          }

          // Build supplier configs based on allowed vendors only
          const configs: SupplierConfig[] = Object.entries(SUPPLIER_INFO).map(([code, info]) => {
            const vendorCode = code.toLowerCase()
            const companyVendor = vendors.find(v => v.vendor_code === vendorCode)
            const isAllowed = !!companyVendor

            return {
              id: code,
              code: code as SupplierCode,
              name: info.name,
              enabled: isAllowed, // Only enable if company has access
              isAllowed: isAllowed, // Track if allowed at all
              discount: companyVendor?.discount_percent || 0,
              isPrimary: companyVendor?.is_primary || false,
              logoUrl: `/logos/${code.toLowerCase()}.png`
            }
          })

          setSupplierConfigs(configs)

          // Load products only from allowed suppliers
          const enabledConfigs = configs.filter(c => c.enabled && c.isAllowed)
          const allProducts = await getAllSupplierProducts(enabledConfigs)
          setProducts(allProducts)
        } else {
          // No vendors assigned - show message
          setSupplierConfigs(
            Object.entries(SUPPLIER_INFO).map(([code, info]) => ({
              id: code,
              code: code as SupplierCode,
              name: info.name,
              enabled: false,
              isAllowed: false,
              logoUrl: `/logos/${code.toLowerCase()}.png`
            }))
          )
        }
      }
    }

    setLoading(false)
  }

  const toggleSupplier = async (supplierId: string) => {
    const config = supplierConfigs.find(c => c.id === supplierId)
    if (!config?.isAllowed) {
      // Can't enable a supplier the company doesn't have access to
      return
    }

    const updated = supplierConfigs.map(c =>
      c.id === supplierId ? { ...c, enabled: !c.enabled } : c
    )
    setSupplierConfigs(updated)

    // Reload products
    const enabledConfigs = updated.filter(c => c.enabled && c.isAllowed)
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
        supplierConfigs.filter(c => c.enabled && c.isAllowed)
      )
      setPriceQuotes(quotes)
    } catch (error) {
      console.error('Error comparing prices:', error)
    } finally {
      setComparingPrices(false)
    }
  }

  const importToInventory = async (product: SupplierProduct) => {
    if (!companyId) return

    setImporting(product.supplierSku)

    try {
      const productData = {
        ...formatProductForDB(product),
        company_id: companyId,
        vendor_code: product.supplierCode.toLowerCase()
      }

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

  const enabledSupplierCount = supplierConfigs.filter(c => c.enabled && c.isAllowed).length
  const allowedSupplierCount = supplierConfigs.filter(c => c.isAllowed).length

  const getSupplierBgColor = (code: string) => {
    const colors: Record<string, string> = {
      PPG: 'bg-blue-500',
      AXALTA: 'bg-red-500',
      SHERWIN_WILLIAMS: 'bg-yellow-500',
      BASF: 'bg-purple-500',
      DUPONT: 'bg-orange-500',
      '3M': 'bg-red-600',
    }
    return colors[code] || 'bg-gray-400'
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Paint Suppliers</h1>
          <p className="text-gray-600 mt-2">Browse products and compare prices from your authorized suppliers</p>
        </div>
        {allowedSupplierCount === 0 && (
          <div className="flex items-center gap-2 px-4 py-2 bg-yellow-100 border border-yellow-300 text-yellow-800 rounded-lg">
            <AlertCircle className="w-5 h-5" />
            <span className="text-sm font-medium">No vendors assigned. Contact admin to enable suppliers.</span>
          </div>
        )}
      </div>

      {/* Vendor Access Notice */}
      {allowedSupplierCount > 0 && allowedSupplierCount < Object.keys(SUPPLIER_INFO).length && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 flex items-start gap-3">
          <Lock className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
          <div>
            <p className="font-medium text-blue-900">Vendor Access Restricted</p>
            <p className="text-sm text-blue-700 mt-1">
              Your company has access to {allowedSupplierCount} vendor(s). Locked vendors require admin approval.
              Contact your admin or super admin to request access to additional vendors.
            </p>
          </div>
        </div>
      )}

      {/* Supplier Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {supplierConfigs.slice(0, 6).map(config => {
          const info = SUPPLIER_INFO[config.code as SupplierCode]
          const productCount = products.filter(p => p.supplierCode === config.code).length
          const isLocked = !config.isAllowed

          return (
            <div
              key={config.id}
              className={`bg-white rounded-lg shadow-sm border-2 p-4 transition-all relative ${
                isLocked
                  ? 'border-gray-200 opacity-50 cursor-not-allowed'
                  : config.enabled
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-gray-200'
              }`}
            >
              {isLocked && (
                <div className="absolute top-2 right-2">
                  <Lock className="w-4 h-4 text-gray-400" />
                </div>
              )}

              <div className="flex items-center justify-between mb-2">
                <div className={`w-8 h-8 rounded-lg ${getSupplierBgColor(config.code)} flex items-center justify-center text-white text-xs font-bold`}>
                  {config.code.slice(0, 2)}
                </div>
                {!isLocked && (
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
                )}
              </div>
              <p className="font-semibold text-gray-900 text-sm">{config.name}</p>
              {isLocked ? (
                <p className="text-xs text-gray-400 mt-1">Locked</p>
              ) : config.enabled ? (
                <div className="flex items-center gap-1 mt-1">
                  <p className="text-xs text-blue-600">{productCount} products</p>
                  {config.isPrimary && (
                    <Star className="w-3 h-3 text-yellow-500 fill-yellow-500" />
                  )}
                </div>
              ) : (
                <p className="text-xs text-gray-400 mt-1">Disabled</p>
              )}
              {config.discount && config.discount > 0 && (
                <p className="text-xs text-green-600 mt-1">{config.discount}% discount</p>
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
              <p className="text-sm text-gray-600">Authorized Vendors</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{allowedSupplierCount}</p>
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
            {SUPPLIER_PRODUCT_CATEGORIES.map(cat => (
              <option key={cat} value={cat}>{cat}</option>
            ))}
          </select>
          <select
            value={supplierFilter}
            onChange={(e) => setSupplierFilter(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg"
          >
            <option value="all">All Suppliers</option>
            {supplierConfigs.filter(c => c.enabled && c.isAllowed).map(config => (
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
      ) : allowedSupplierCount === 0 ? (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
          <Lock className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No Vendor Access</h3>
          <p className="text-gray-600 mb-4">
            Your company doesn't have any authorized vendors configured.
            Contact your administrator to request vendor access.
          </p>
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
          {filteredProducts.map((product, index) => {
            const supplierConfig = supplierConfigs.find(c => c.code === product.supplierCode)
            const discount = supplierConfig?.discount || 0
            const discountedPrice = product.unitCost * (1 - discount / 100)

            return (
              <div
                key={`${product.supplierCode}-${product.supplierSku}-${index}`}
                className="bg-white rounded-lg shadow-sm border border-gray-200 p-4 hover:shadow-md transition-shadow"
              >
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <span className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium text-white ${getSupplierBgColor(product.supplierCode)}`}>
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
                    {discount > 0 ? (
                      <>
                        <p className="text-2xl font-bold text-green-600">${discountedPrice.toFixed(2)}</p>
                        <p className="text-sm text-gray-400 line-through">${product.unitCost.toFixed(2)}</p>
                        <p className="text-xs text-green-600">{discount}% company discount</p>
                      </>
                    ) : (
                      <p className="text-2xl font-bold text-gray-900">${product.unitCost.toFixed(2)}</p>
                    )}
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
                    Import
                  </button>
                </div>
              </div>
            )
          })}
        </div>
      )}

      {/* Price Comparison Modal */}
      {selectedProduct && priceQuotes.length > 0 && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-lg w-full p-6">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-bold text-gray-900">Price Comparison</h2>
              <button
                onClick={() => {
                  setSelectedProduct(null)
                  setPriceQuotes([])
                }}
                className="text-gray-400 hover:text-gray-600"
              >
                ×
              </button>
            </div>

            <p className="text-gray-600 mb-4">{selectedProduct.name}</p>

            <div className="space-y-3">
              {priceQuotes
                .sort((a, b) => a.unitPrice - b.unitPrice)
                .map((quote, idx) => (
                  <div
                    key={quote.supplierId}
                    className={`p-3 rounded-lg border ${
                      idx === 0 ? 'border-green-500 bg-green-50' : 'border-gray-200'
                    }`}
                  >
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="font-medium">{SUPPLIER_INFO[quote.supplierId as SupplierCode]?.name || quote.supplierId}</p>
                        <p className="text-xs text-gray-500">{quote.productSku}</p>
                      </div>
                      <div className="text-right">
                        <p className="font-bold text-lg">${quote.unitPrice.toFixed(2)}</p>
                        {idx === 0 && (
                          <span className="text-xs text-green-600 font-medium">Best Price</span>
                        )}
                      </div>
                    </div>
                  </div>
                ))}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
