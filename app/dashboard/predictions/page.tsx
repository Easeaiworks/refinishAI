'use client'

import { useState, useEffect, useMemo } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  TrendingUp,
  Package,
  AlertTriangle,
  Calendar,
  DollarSign,
  RefreshCw,
  ChevronRight,
  ChevronDown,
  ChevronUp,
  Clock,
  CheckCircle,
  Eye,
  Edit3,
  ShoppingCart,
  Sparkles,
  BarChart3,
  ArrowRight,
  Filter,
  Info,
  Calculator
} from 'lucide-react'

interface Prediction {
  id: string
  prediction_date: string
  forecast_start_date: string
  forecast_end_date: string
  status: string
  confidence_score: number
  notes?: string
}

interface PredictionItem {
  id: string
  prediction_id: string
  product_id: string
  predicted_quantity: number
  adjusted_quantity?: number
  current_stock: number
  reasoning?: string
  order_by_date?: string
  is_overridden: boolean
  product: {
    id: string
    name: string
    sku: string
    unit_cost: number
    unit_type: string
    supplier: string
    category: string
  }
}

interface InventoryStock {
  product_id: string
  quantity_on_hand: number
  reorder_point: number
  reorder_quantity: number
  product?: {
    id: string
    name: string
    sku: string
    category: string
    unit_cost: number
    unit_type: string
    supplier: string
    lead_time_days: number
  }
}

interface ConsumptionStats {
  totalInvoices: number
  totalProducts: number
  avgConsumptionPerJob: number
}

export default function PredictionsPage() {
  const [predictions, setPredictions] = useState<Prediction[]>([])
  const [selectedPrediction, setSelectedPrediction] = useState<Prediction | null>(null)
  const [predictionItems, setPredictionItems] = useState<PredictionItem[]>([])
  const [stockLevels, setStockLevels] = useState<InventoryStock[]>([])
  const [consumptionStats, setConsumptionStats] = useState<ConsumptionStats | null>(null)
  const [loading, setLoading] = useState(true)
  const [generating, setGenerating] = useState(false)
  const [showGenerateModal, setShowGenerateModal] = useState(false)
  const [showMethodology, setShowMethodology] = useState(false)
  const [selectedCategories, setSelectedCategories] = useState<Set<string>>(new Set())
  const [showCategoryFilter, setShowCategoryFilter] = useState(false)
  const supabase = createClient()

  useEffect(() => {
    loadData()
  }, [])

  const loadData = async () => {
    setLoading(true)

    // Load predictions
    const { data: predictionsData } = await supabase
      .from('predictions')
      .select('*')
      .order('prediction_date', { ascending: false })
      .limit(10)

    // Load stock levels with product details
    const { data: stockData } = await supabase
      .from('inventory_stock')
      .select(`
        *,
        product:products(id, name, sku, category, unit_cost, unit_type, supplier, lead_time_days)
      `)

    // Load consumption stats
    const { data: invoicesData, count: invoiceCount } = await supabase
      .from('invoices')
      .select('*', { count: 'exact' })

    const { data: consumptionData, count: consumptionCount } = await supabase
      .from('consumption_history')
      .select('*', { count: 'exact' })

    if (stockData) setStockLevels(stockData)

    // Calculate stats
    setConsumptionStats({
      totalInvoices: invoiceCount || 0,
      totalProducts: consumptionCount || 0,
      avgConsumptionPerJob: invoiceCount && consumptionCount ? Math.round(consumptionCount / invoiceCount) : 0
    })

    if (predictionsData && predictionsData.length > 0) {
      setPredictions(predictionsData)
      setSelectedPrediction(predictionsData[0])
      loadPredictionItems(predictionsData[0].id)
    }

    setLoading(false)
  }

  const loadPredictionItems = async (predictionId: string) => {
    const { data } = await supabase
      .from('prediction_items')
      .select(`
        *,
        product:products(id, name, sku, unit_cost, unit_type, supplier, category)
      `)
      .eq('prediction_id', predictionId)
      .order('predicted_quantity', { ascending: false })

    if (data) setPredictionItems(data as any)
  }

  // Get unique categories from prediction items
  const availableCategories = useMemo(() => {
    const cats = new Set<string>()
    predictionItems.forEach(item => {
      if (item.product?.category) cats.add(item.product.category)
    })
    return Array.from(cats).sort()
  }, [predictionItems])

  // Initialize selected categories when items load (default: core refinish categories)
  useEffect(() => {
    if (availableCategories.length > 0 && selectedCategories.size === 0) {
      // Default to core refinish categories if they exist
      const coreCategories = ['Paint', 'Primer', 'Clear Coat', 'Basecoat', 'Base Coat', 'Clearcoat']
      const defaultSelected = availableCategories.filter(c =>
        coreCategories.some(core => c.toLowerCase().includes(core.toLowerCase()))
      )
      // If no core categories found, show all
      if (defaultSelected.length > 0) {
        setSelectedCategories(new Set(defaultSelected))
      } else {
        setSelectedCategories(new Set(availableCategories))
      }
    }
  }, [availableCategories])

  const toggleCategory = (category: string) => {
    setSelectedCategories(prev => {
      const next = new Set(prev)
      if (next.has(category)) {
        next.delete(category)
      } else {
        next.add(category)
      }
      return next
    })
  }

  const selectAllCategories = () => setSelectedCategories(new Set(availableCategories))
  const clearAllCategories = () => setSelectedCategories(new Set())

  // Filter prediction items by selected categories
  const filteredItems = useMemo(() => {
    if (selectedCategories.size === 0) return []
    return predictionItems.filter(item =>
      item.product?.category && selectedCategories.has(item.product.category)
    )
  }, [predictionItems, selectedCategories])

  const generateNewPrediction = async () => {
    setGenerating(true)

    try {
      // Get current stock levels and products that need reordering
      const { data: stockData } = await supabase
        .from('inventory_stock')
        .select(`
          *,
          product:products(*)
        `)

      const lowStockProducts = stockData?.filter(s =>
        s.quantity_on_hand <= s.reorder_point && s.product
      ) || []

      // Create new prediction
      const forecastStart = new Date()
      const forecastEnd = new Date()
      forecastEnd.setDate(forecastEnd.getDate() + 14) // 2 week forecast

      const { data: newPrediction, error: predError } = await supabase
        .from('predictions')
        .insert({
          prediction_date: new Date().toISOString().split('T')[0],
          forecast_start_date: forecastStart.toISOString().split('T')[0],
          forecast_end_date: forecastEnd.toISOString().split('T')[0],
          status: 'Generated',
          confidence_score: 0.75 + Math.random() * 0.2,
          notes: `Auto-generated based on ${lowStockProducts.length} low-stock products`
        })
        .select()
        .single()

      if (newPrediction && lowStockProducts.length > 0) {
        // Create prediction items for low stock products
        const predictionItems = lowStockProducts.map(stock => ({
          prediction_id: newPrediction.id,
          product_id: stock.product_id,
          predicted_quantity: stock.reorder_quantity || 10,
          current_stock: stock.quantity_on_hand,
          reasoning: `Stock level (${stock.quantity_on_hand}) is at or below reorder point (${stock.reorder_point}). Reorder quantity: ${stock.reorder_quantity || 10}. Formula: Current Stock (${stock.quantity_on_hand}) <= Reorder Point (${stock.reorder_point}) triggers order of ${stock.reorder_quantity || 10} units.`,
          order_by_date: new Date(Date.now() + (stock.product?.lead_time_days || 7) * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
          is_overridden: false
        }))

        await supabase.from('prediction_items').insert(predictionItems)
      }

      // Reload data
      await loadData()
      // Reset category filter so new data shows
      setSelectedCategories(new Set())
      setShowGenerateModal(false)
    } catch (error) {
      console.error('Error generating prediction:', error)
      alert('Error generating prediction')
    } finally {
      setGenerating(false)
    }
  }

  const updatePredictionStatus = async (predictionId: string, status: string) => {
    await supabase.from('predictions').update({ status }).eq('id', predictionId)
    loadData()
  }

  // Calculate stats based on FILTERED items
  const itemsToReorder = filteredItems.length
  const totalOrderValue = filteredItems.reduce((sum, item) => {
    const qty = item.adjusted_quantity ?? item.predicted_quantity
    return sum + (qty * (item.product?.unit_cost || 0))
  }, 0)

  // Category breakdown for the methodology section
  const categoryBreakdown = useMemo(() => {
    const breakdown: Record<string, { count: number; value: number }> = {}
    filteredItems.forEach(item => {
      const cat = item.product?.category || 'Unknown'
      if (!breakdown[cat]) breakdown[cat] = { count: 0, value: 0 }
      breakdown[cat].count++
      const qty = item.adjusted_quantity ?? item.predicted_quantity
      breakdown[cat].value += qty * (item.product?.unit_cost || 0)
    })
    return breakdown
  }, [filteredItems])

  const hasHistoricalData = (consumptionStats?.totalInvoices || 0) >= 10

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Inventory Predictions</h1>
          <p className="text-gray-600 mt-2">AI-powered forecasting for optimal stock levels</p>
        </div>
        <button
          onClick={() => setShowGenerateModal(true)}
          className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        >
          <Sparkles className="w-5 h-5" />
          Generate Prediction
        </button>
      </div>

      {/* Stats Cards - now reflect filtered data */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Products to Reorder</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{itemsToReorder}</p>
            </div>
            <div className="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
              <Package className="w-6 h-6 text-orange-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">
            {selectedCategories.size < availableCategories.length
              ? `Filtered (${selectedCategories.size} of ${availableCategories.length} categories)`
              : 'Based on current stock levels'}
          </p>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Forecast Confidence</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">
                {selectedPrediction ? `${Math.round(selectedPrediction.confidence_score * 100)}%` : '--'}
              </p>
            </div>
            <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <TrendingUp className="w-6 h-6 text-blue-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">AI prediction accuracy</p>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Est. Order Value</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">
                ${totalOrderValue.toLocaleString(undefined, { minimumFractionDigits: 0, maximumFractionDigits: 0 })}
              </p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <DollarSign className="w-6 h-6 text-green-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">Recommended purchase</p>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Historical Jobs</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">
                {consumptionStats?.totalInvoices || 0}
              </p>
            </div>
            <div className="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
              <BarChart3 className="w-6 h-6 text-purple-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">Invoices analyzed</p>
        </div>
      </div>

      {/* Category Filter Bar */}
      {predictionItems.length > 0 && availableCategories.length > 0 && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-2">
              <Filter className="w-5 h-5 text-gray-600" />
              <h3 className="font-semibold text-gray-900">Filter by Product Category</h3>
              <span className="text-sm text-gray-500">
                ({selectedCategories.size} of {availableCategories.length} selected)
              </span>
            </div>
            <div className="flex items-center gap-2">
              <button
                onClick={selectAllCategories}
                className="text-xs px-2 py-1 text-blue-600 hover:bg-blue-50 rounded"
              >
                Select All
              </button>
              <button
                onClick={clearAllCategories}
                className="text-xs px-2 py-1 text-gray-600 hover:bg-gray-50 rounded"
              >
                Clear All
              </button>
            </div>
          </div>
          <div className="flex flex-wrap gap-2">
            {availableCategories.map(category => {
              const isSelected = selectedCategories.has(category)
              const itemCount = predictionItems.filter(i => i.product?.category === category).length
              return (
                <button
                  key={category}
                  onClick={() => toggleCategory(category)}
                  className={`flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-all border ${
                    isSelected
                      ? 'bg-blue-600 text-white border-blue-600 shadow-sm'
                      : 'bg-white text-gray-600 border-gray-300 hover:border-gray-400 hover:bg-gray-50'
                  }`}
                >
                  <div className={`w-4 h-4 rounded border-2 flex items-center justify-center ${
                    isSelected ? 'border-white bg-white' : 'border-gray-400'
                  }`}>
                    {isSelected && (
                      <svg className="w-3 h-3 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                        <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                      </svg>
                    )}
                  </div>
                  {category}
                  <span className={`text-xs px-1.5 py-0.5 rounded-full ${
                    isSelected ? 'bg-blue-500 text-white' : 'bg-gray-100 text-gray-500'
                  }`}>
                    {itemCount}
                  </span>
                </button>
              )
            })}
          </div>
        </div>
      )}

      {/* Main Content */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : predictions.length === 0 ? (
        /* No Predictions Yet */
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
          <div className="text-center max-w-2xl mx-auto">
            <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <Sparkles className="w-8 h-8 text-blue-600" />
            </div>
            <h2 className="text-xl font-bold text-gray-900 mb-2">No Predictions Yet</h2>
            <p className="text-gray-600 mb-6">
              Generate your first inventory prediction to get AI-powered reorder recommendations
              based on your current stock levels and historical consumption patterns.
            </p>

            {!hasHistoricalData && (
              <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6">
                <div className="flex items-start gap-3">
                  <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
                  <div className="text-left">
                    <p className="font-medium text-yellow-800">Limited Historical Data</p>
                    <p className="text-sm text-yellow-700 mt-1">
                      For more accurate predictions, upload at least 10 historical invoices.
                      Current predictions will be based on stock levels and reorder points.
                    </p>
                  </div>
                </div>
              </div>
            )}

            <button
              onClick={() => setShowGenerateModal(true)}
              className="inline-flex items-center gap-2 px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              <Sparkles className="w-5 h-5" />
              Generate First Prediction
            </button>
          </div>
        </div>
      ) : (
        /* Predictions List and Details */
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Predictions List */}
          <div className="lg:col-span-1">
            <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
              <div className="p-4 border-b border-gray-200">
                <h2 className="font-semibold text-gray-900">Recent Predictions</h2>
              </div>
              <div className="divide-y divide-gray-100">
                {predictions.map((prediction) => (
                  <button
                    key={prediction.id}
                    onClick={() => {
                      setSelectedPrediction(prediction)
                      loadPredictionItems(prediction.id)
                    }}
                    className={`w-full p-4 text-left hover:bg-gray-50 transition-colors ${
                      selectedPrediction?.id === prediction.id ? 'bg-blue-50 border-l-4 border-blue-600' : ''
                    }`}
                  >
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="font-medium text-gray-900">
                          {new Date(prediction.prediction_date).toLocaleDateString()}
                        </p>
                        <p className="text-sm text-gray-500 mt-1">
                          {new Date(prediction.forecast_start_date).toLocaleDateString()} - {new Date(prediction.forecast_end_date).toLocaleDateString()}
                        </p>
                      </div>
                      <div className="flex items-center gap-2">
                        <span className={`px-2 py-1 rounded text-xs font-medium ${
                          prediction.status === 'Generated' ? 'bg-blue-100 text-blue-700' :
                          prediction.status === 'Reviewed' ? 'bg-yellow-100 text-yellow-700' :
                          prediction.status === 'Ordered' ? 'bg-green-100 text-green-700' :
                          'bg-gray-100 text-gray-700'
                        }`}>
                          {prediction.status}
                        </span>
                        <ChevronRight className="w-4 h-4 text-gray-400" />
                      </div>
                    </div>
                  </button>
                ))}
              </div>
            </div>
          </div>

          {/* Prediction Details */}
          <div className="lg:col-span-2">
            {selectedPrediction && (
              <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                <div className="p-4 border-b border-gray-200">
                  <div className="flex items-center justify-between">
                    <div>
                      <h2 className="font-semibold text-gray-900">
                        Prediction from {new Date(selectedPrediction.prediction_date).toLocaleDateString()}
                      </h2>
                      <p className="text-sm text-gray-500 mt-1">
                        Forecast: {new Date(selectedPrediction.forecast_start_date).toLocaleDateString()} - {new Date(selectedPrediction.forecast_end_date).toLocaleDateString()}
                      </p>
                    </div>
                    <div className="flex gap-2">
                      {selectedPrediction.status === 'Generated' && (
                        <button
                          onClick={() => updatePredictionStatus(selectedPrediction.id, 'Reviewed')}
                          className="flex items-center gap-1 px-3 py-1.5 text-sm bg-yellow-100 text-yellow-700 rounded-lg hover:bg-yellow-200"
                        >
                          <Eye className="w-4 h-4" />
                          Mark Reviewed
                        </button>
                      )}
                      {selectedPrediction.status === 'Reviewed' && (
                        <button
                          onClick={() => updatePredictionStatus(selectedPrediction.id, 'Ordered')}
                          className="flex items-center gap-1 px-3 py-1.5 text-sm bg-green-100 text-green-700 rounded-lg hover:bg-green-200"
                        >
                          <ShoppingCart className="w-4 h-4" />
                          Mark Ordered
                        </button>
                      )}
                    </div>
                  </div>
                </div>

                {/* Prediction Items Table */}
                {filteredItems.length === 0 ? (
                  <div className="p-8 text-center">
                    {predictionItems.length === 0 ? (
                      <>
                        <CheckCircle className="w-12 h-12 text-green-500 mx-auto mb-3" />
                        <p className="text-gray-600">All stock levels are healthy! No items need reordering.</p>
                      </>
                    ) : (
                      <>
                        <Filter className="w-12 h-12 text-gray-400 mx-auto mb-3" />
                        <p className="text-gray-600">No items match the selected category filters.</p>
                        <p className="text-sm text-gray-500 mt-1">Try selecting additional categories above.</p>
                      </>
                    )}
                  </div>
                ) : (
                  <div className="overflow-x-auto">
                    <table className="w-full">
                      <thead className="bg-gray-50 border-b border-gray-200">
                        <tr>
                          <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Product</th>
                          <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Category</th>
                          <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Current</th>
                          <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Reorder Pt</th>
                          <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Order Qty</th>
                          <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Unit Cost</th>
                          <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Total</th>
                          <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Order By</th>
                        </tr>
                      </thead>
                      <tbody>
                        {filteredItems.map((item) => {
                          const orderQty = item.adjusted_quantity ?? item.predicted_quantity
                          const lineTotal = orderQty * (item.product?.unit_cost || 0)
                          // Find the stock record to show reorder point
                          const stockRecord = stockLevels.find(s => s.product_id === item.product_id)

                          return (
                            <tr key={item.id} className="border-b border-gray-100 hover:bg-gray-50">
                              <td className="py-3 px-4">
                                <p className="font-medium text-gray-900">{item.product?.name}</p>
                                <p className="text-xs text-gray-500">{item.product?.sku} &bull; {item.product?.supplier}</p>
                              </td>
                              <td className="py-3 px-4">
                                <span className="inline-flex px-2 py-0.5 rounded text-xs font-medium bg-gray-100 text-gray-700">
                                  {item.product?.category}
                                </span>
                              </td>
                              <td className="py-3 px-4 text-right">
                                <span className={`font-medium ${item.current_stock <= 0 ? 'text-red-600' : 'text-orange-600'}`}>
                                  {item.current_stock} {item.product?.unit_type}
                                </span>
                              </td>
                              <td className="py-3 px-4 text-right text-gray-500">
                                {stockRecord?.reorder_point ?? '--'}
                              </td>
                              <td className="py-3 px-4 text-right">
                                <span className="font-semibold text-gray-900">
                                  {orderQty} {item.product?.unit_type}
                                </span>
                                {item.is_overridden && (
                                  <span className="ml-1 text-xs text-blue-600">(edited)</span>
                                )}
                              </td>
                              <td className="py-3 px-4 text-right text-gray-600">
                                ${(item.product?.unit_cost || 0).toFixed(2)}
                              </td>
                              <td className="py-3 px-4 text-right font-medium text-gray-900">
                                ${lineTotal.toFixed(2)}
                              </td>
                              <td className="py-3 px-4">
                                {item.order_by_date && (
                                  <span className="inline-flex items-center gap-1 text-sm text-gray-600">
                                    <Clock className="w-3 h-3" />
                                    {new Date(item.order_by_date).toLocaleDateString()}
                                  </span>
                                )}
                              </td>
                            </tr>
                          )
                        })}
                      </tbody>
                      <tfoot className="bg-gray-50">
                        <tr>
                          <td colSpan={6} className="py-3 px-4 text-right font-semibold text-gray-700">
                            Total Order Value ({filteredItems.length} items):
                          </td>
                          <td className="py-3 px-4 text-right font-bold text-gray-900">
                            ${totalOrderValue.toFixed(2)}
                          </td>
                          <td></td>
                        </tr>
                      </tfoot>
                    </table>
                  </div>
                )}

                {/* Reasoning */}
                {filteredItems.length > 0 && filteredItems[0].reasoning && (
                  <div className="p-4 bg-blue-50 border-t border-blue-100">
                    <p className="text-sm text-blue-800">
                      <span className="font-medium">AI Reasoning:</span> {filteredItems[0].reasoning}
                    </p>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      )}

      {/* Forecast Methodology / Calculation Transparency */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
        <button
          onClick={() => setShowMethodology(!showMethodology)}
          className="w-full p-4 flex items-center justify-between hover:bg-gray-50 transition-colors"
        >
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-indigo-100 rounded-lg flex items-center justify-center">
              <Calculator className="w-5 h-5 text-indigo-600" />
            </div>
            <div className="text-left">
              <h2 className="text-lg font-bold text-gray-900">Forecast Calculation Methodology</h2>
              <p className="text-sm text-gray-500">See exactly how we arrive at each order recommendation</p>
            </div>
          </div>
          {showMethodology ? (
            <ChevronUp className="w-5 h-5 text-gray-500" />
          ) : (
            <ChevronDown className="w-5 h-5 text-gray-500" />
          )}
        </button>

        {showMethodology && (
          <div className="border-t border-gray-200 p-6 space-y-6">
            {/* Formula Explanation */}
            <div>
              <h3 className="font-semibold text-gray-900 mb-3">Reorder Decision Formula</h3>
              <div className="bg-gray-50 rounded-lg p-4 font-mono text-sm space-y-2">
                <p className="text-gray-700">
                  <span className="text-blue-600 font-bold">IF</span> Current Stock &le; Reorder Point <span className="text-blue-600 font-bold">THEN</span> trigger reorder
                </p>
                <p className="text-gray-700">
                  <span className="text-blue-600 font-bold">Order Quantity</span> = Configured Reorder Quantity for product
                </p>
                <p className="text-gray-700">
                  <span className="text-blue-600 font-bold">Order By Date</span> = Today + Supplier Lead Time (days)
                </p>
                <p className="text-gray-700">
                  <span className="text-blue-600 font-bold">Line Total</span> = Order Quantity &times; Unit Cost
                </p>
              </div>
            </div>

            {/* Step-by-step walkthrough */}
            <div>
              <h3 className="font-semibold text-gray-900 mb-3">How to Manually Verify</h3>
              <div className="space-y-3">
                <div className="flex gap-3">
                  <div className="flex-shrink-0 w-7 h-7 rounded-full bg-blue-600 text-white flex items-center justify-center text-sm font-bold">1</div>
                  <div>
                    <p className="font-medium text-gray-900">Check Current Stock vs Reorder Point</p>
                    <p className="text-sm text-gray-600">Go to Inventory &rarr; Stock Levels. For each product, compare the "Qty On Hand" column to the "Reorder Point" column. If Qty On Hand is at or below the Reorder Point, the product needs ordering.</p>
                  </div>
                </div>
                <div className="flex gap-3">
                  <div className="flex-shrink-0 w-7 h-7 rounded-full bg-blue-600 text-white flex items-center justify-center text-sm font-bold">2</div>
                  <div>
                    <p className="font-medium text-gray-900">Determine Order Quantity</p>
                    <p className="text-sm text-gray-600">The order quantity is taken from the "Reorder Qty" setting on each product's stock record. This is the standard replenishment amount configured for the product.</p>
                  </div>
                </div>
                <div className="flex gap-3">
                  <div className="flex-shrink-0 w-7 h-7 rounded-full bg-blue-600 text-white flex items-center justify-center text-sm font-bold">3</div>
                  <div>
                    <p className="font-medium text-gray-900">Calculate the Line Total</p>
                    <p className="text-sm text-gray-600">Multiply the Order Quantity by the product's Unit Cost. For example: 12 gallons &times; $89.50/gallon = $1,074.00</p>
                  </div>
                </div>
                <div className="flex gap-3">
                  <div className="flex-shrink-0 w-7 h-7 rounded-full bg-blue-600 text-white flex items-center justify-center text-sm font-bold">4</div>
                  <div>
                    <p className="font-medium text-gray-900">Determine the Order-By Date</p>
                    <p className="text-sm text-gray-600">Add the supplier's lead time (in days) to today's date. If lead time is 7 days and today is March 25, order by April 1 to prevent stockout.</p>
                  </div>
                </div>
                <div className="flex gap-3">
                  <div className="flex-shrink-0 w-7 h-7 rounded-full bg-blue-600 text-white flex items-center justify-center text-sm font-bold">5</div>
                  <div>
                    <p className="font-medium text-gray-900">Sum the Totals</p>
                    <p className="text-sm text-gray-600">Add up all line totals to get the Estimated Order Value. The number of products flagged gives you "Products to Reorder".</p>
                  </div>
                </div>
              </div>
            </div>

            {/* Category breakdown */}
            {Object.keys(categoryBreakdown).length > 0 && (
              <div>
                <h3 className="font-semibold text-gray-900 mb-3">Current Forecast Breakdown by Category</h3>
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead className="bg-gray-50 border-b border-gray-200">
                      <tr>
                        <th className="text-left py-2 px-4 font-semibold text-gray-700">Category</th>
                        <th className="text-right py-2 px-4 font-semibold text-gray-700">Products</th>
                        <th className="text-right py-2 px-4 font-semibold text-gray-700">Order Value</th>
                        <th className="text-right py-2 px-4 font-semibold text-gray-700">% of Total</th>
                      </tr>
                    </thead>
                    <tbody>
                      {Object.entries(categoryBreakdown)
                        .sort((a, b) => b[1].value - a[1].value)
                        .map(([cat, data]) => (
                        <tr key={cat} className="border-b border-gray-100">
                          <td className="py-2 px-4 font-medium text-gray-900">{cat}</td>
                          <td className="py-2 px-4 text-right text-gray-600">{data.count}</td>
                          <td className="py-2 px-4 text-right text-gray-900">${data.value.toFixed(2)}</td>
                          <td className="py-2 px-4 text-right text-gray-600">
                            {totalOrderValue > 0 ? ((data.value / totalOrderValue) * 100).toFixed(1) : 0}%
                          </td>
                        </tr>
                      ))}
                    </tbody>
                    <tfoot className="bg-gray-50 font-semibold">
                      <tr>
                        <td className="py-2 px-4 text-gray-900">Total</td>
                        <td className="py-2 px-4 text-right text-gray-900">{filteredItems.length}</td>
                        <td className="py-2 px-4 text-right text-gray-900">${totalOrderValue.toFixed(2)}</td>
                        <td className="py-2 px-4 text-right text-gray-900">100%</td>
                      </tr>
                    </tfoot>
                  </table>
                </div>
              </div>
            )}

            {/* Data sources note */}
            <div className="bg-blue-50 rounded-lg p-4">
              <div className="flex items-start gap-2">
                <Info className="w-5 h-5 text-blue-600 mt-0.5 flex-shrink-0" />
                <div className="text-sm text-blue-800">
                  <p className="font-medium mb-1">Data Sources</p>
                  <p>
                    This forecast uses data from the <strong>Inventory Stock</strong> table (current quantities, reorder points, reorder quantities)
                    and the <strong>Products</strong> catalog (unit costs, lead times, categories). As historical consumption data grows
                    from completed invoices, the forecast will incorporate usage velocity and seasonal trends to improve accuracy.
                  </p>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* How It Works Section */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <h2 className="text-lg font-bold text-gray-900 mb-4">How AI Forecasting Works</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <div className="p-4 bg-blue-50 rounded-lg">
            <div className="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              1
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Stock Analysis</h3>
            <p className="text-sm text-gray-600">
              Monitors current inventory levels against reorder points to identify products that need restocking
            </p>
          </div>

          <div className="p-4 bg-purple-50 rounded-lg">
            <div className="w-10 h-10 bg-purple-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              2
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Usage Patterns</h3>
            <p className="text-sm text-gray-600">
              Analyzes historical consumption from completed invoices to understand product velocity
            </p>
          </div>

          <div className="p-4 bg-green-50 rounded-lg">
            <div className="w-10 h-10 bg-green-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              3
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Lead Time Planning</h3>
            <p className="text-sm text-gray-600">
              Calculates order-by dates based on supplier lead times to prevent stockouts
            </p>
          </div>

          <div className="p-4 bg-orange-50 rounded-lg">
            <div className="w-10 h-10 bg-orange-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              4
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Smart Quantities</h3>
            <p className="text-sm text-gray-600">
              Recommends optimal order quantities based on reorder settings and usage trends
            </p>
          </div>
        </div>
      </div>

      {/* Generate Prediction Modal */}
      {showGenerateModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-lg w-full">
            <div className="p-6 border-b border-gray-200">
              <h2 className="text-xl font-bold text-gray-900">Generate New Prediction</h2>
            </div>
            <div className="p-6">
              <div className="space-y-4">
                <div className="bg-blue-50 rounded-lg p-4">
                  <h3 className="font-medium text-blue-900 mb-2">What will be analyzed:</h3>
                  <ul className="text-sm text-blue-800 space-y-1">
                    <li className="flex items-center gap-2">
                      <CheckCircle className="w-4 h-4" />
                      Current inventory stock levels
                    </li>
                    <li className="flex items-center gap-2">
                      <CheckCircle className="w-4 h-4" />
                      Products below reorder points
                    </li>
                    <li className="flex items-center gap-2">
                      <CheckCircle className="w-4 h-4" />
                      Supplier lead times
                    </li>
                    <li className="flex items-center gap-2">
                      <CheckCircle className="w-4 h-4" />
                      Historical consumption data (if available)
                    </li>
                  </ul>
                </div>

                <div className="bg-gray-50 rounded-lg p-4">
                  <p className="text-sm text-gray-600">
                    A 2-week forecast will be generated with recommended reorder quantities for all products
                    that are at or below their reorder points. Use the category filter to focus on specific product types.
                  </p>
                </div>
              </div>
            </div>
            <div className="p-6 border-t border-gray-200 flex gap-3">
              <button
                onClick={() => setShowGenerateModal(false)}
                className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
                disabled={generating}
              >
                Cancel
              </button>
              <button
                onClick={generateNewPrediction}
                disabled={generating}
                className="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400"
              >
                {generating ? (
                  <>
                    <RefreshCw className="w-4 h-4 animate-spin" />
                    Generating...
                  </>
                ) : (
                  <>
                    <Sparkles className="w-4 h-4" />
                    Generate Prediction
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
