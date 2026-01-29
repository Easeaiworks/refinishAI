'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { TrendingUp, Package, AlertTriangle, Calendar, DollarSign } from 'lucide-react'

interface Prediction {
  id: string
  prediction_date: string
  forecast_start_date: string
  forecast_end_date: string
  status: string
  confidence_score: number
}

interface PredictionItem {
  id: string
  product_id: string
  predicted_quantity: number
  current_stock: number
  reasoning: string
  order_by_date: string
  product: {
    name: string
    sku: string
    unit_cost: number
    supplier: string
  }
}

export default function PredictionsPage() {
  const [predictions, setPredictions] = useState<Prediction[]>([])
  const [selectedPrediction, setSelectedPrediction] = useState<Prediction | null>(null)
  const [predictionItems, setPredictionItems] = useState<PredictionItem[]>([])
  const [loading, setLoading] = useState(true)
  const supabase = createClient()

  useEffect(() => {
    loadPredictions()
  }, [])

  const loadPredictions = async () => {
    setLoading(true)
    const { data } = await supabase
      .from('predictions')
      .select('*')
      .order('prediction_date', { ascending: false })
      .limit(10)
    
    if (data && data.length > 0) {
      setPredictions(data)
      setSelectedPrediction(data[0])
      loadPredictionItems(data[0].id)
    }
    setLoading(false)
  }

  const loadPredictionItems = async (predictionId: string) => {
    const { data } = await supabase
      .from('prediction_items')
      .select(`
        *,
        product:products(name, sku, unit_cost, supplier)
      `)
      .eq('prediction_id', predictionId)
      .order('predicted_quantity', { ascending: false })
    
    if (data) setPredictionItems(data as any)
  }

  const totalOrderValue = predictionItems.reduce((sum, item) => 
    sum + (item.predicted_quantity * item.product.unit_cost), 0
  )

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Inventory Predictions</h1>
        <p className="text-gray-600 mt-2">AI-powered forecasting for optimal stock levels</p>
      </div>

      {/* Coming Soon Notice */}
      <div className="bg-gradient-to-r from-blue-50 to-purple-50 border border-blue-200 rounded-lg p-6">
        <div className="flex items-start gap-4">
          <div className="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center flex-shrink-0">
            <TrendingUp className="w-6 h-6 text-white" />
          </div>
          <div>
            <h3 className="text-lg font-bold text-gray-900 mb-2">AI Forecasting - Phase 2</h3>
            <p className="text-gray-700 mb-4">
              Advanced predictive analytics are currently in development. This feature will analyze your historical
              estimates and invoices to automatically forecast inventory needs, suggest optimal reorder points,
              and generate purchase orders.
            </p>
            <div className="flex flex-wrap gap-4">
              <div className="flex items-center gap-2 text-sm text-gray-700">
                <Package className="w-4 h-4 text-blue-600" />
                <span>Demand Forecasting</span>
              </div>
              <div className="flex items-center gap-2 text-sm text-gray-700">
                <Calendar className="w-4 h-4 text-blue-600" />
                <span>Seasonal Trends</span>
              </div>
              <div className="flex items-center gap-2 text-sm text-gray-700">
                <DollarSign className="w-4 h-4 text-blue-600" />
                <span>Cost Optimization</span>
              </div>
              <div className="flex items-center gap-2 text-sm text-gray-700">
                <AlertTriangle className="w-4 h-4 text-blue-600" />
                <span>Smart Reorder Alerts</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Demo Preview */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Products to Reorder</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">0</p>
            </div>
            <div className="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
              <Package className="w-6 h-6 text-orange-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">Based on historical usage</p>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Forecast Confidence</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">--</p>
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
              <p className="text-3xl font-bold text-gray-900 mt-2">$0</p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <DollarSign className="w-6 h-6 text-green-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">Recommended purchase</p>
        </div>
      </div>

      {/* How It Works */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <h2 className="text-lg font-bold text-gray-900 mb-4">How AI Forecasting Works</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <div className="p-4 bg-blue-50 rounded-lg">
            <div className="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              1
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Data Collection</h3>
            <p className="text-sm text-gray-600">
              Analyzes your historical estimates, invoices, and actual product consumption patterns
            </p>
          </div>

          <div className="p-4 bg-purple-50 rounded-lg">
            <div className="w-10 h-10 bg-purple-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              2
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Pattern Recognition</h3>
            <p className="text-sm text-gray-600">
              Identifies seasonal trends, product usage rates, and job type correlations
            </p>
          </div>

          <div className="p-4 bg-green-50 rounded-lg">
            <div className="w-10 h-10 bg-green-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              3
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Predictive Modeling</h3>
            <p className="text-sm text-gray-600">
              Forecasts future demand based on pipeline estimates and historical velocity
            </p>
          </div>

          <div className="p-4 bg-orange-50 rounded-lg">
            <div className="w-10 h-10 bg-orange-600 rounded-lg flex items-center justify-center text-white font-bold mb-3">
              4
            </div>
            <h3 className="font-semibold text-gray-900 mb-2">Smart Recommendations</h3>
            <p className="text-sm text-gray-600">
              Generates optimal reorder quantities with lead time consideration
            </p>
          </div>
        </div>
      </div>

      {/* Data Requirements */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <h2 className="text-lg font-bold text-gray-900 mb-4">Get Started with AI Predictions</h2>
        <p className="text-gray-600 mb-4">
          To enable AI forecasting, you need to upload historical data:
        </p>
        <div className="space-y-3">
          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <div className="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center text-gray-600 font-semibold">
              1
            </div>
            <div>
              <p className="font-medium text-gray-900">Upload Past Estimates</p>
              <p className="text-sm text-gray-600">Minimum 50 estimates for accurate forecasting</p>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <div className="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center text-gray-600 font-semibold">
              2
            </div>
            <div>
              <p className="font-medium text-gray-900">Upload Completed Invoices</p>
              <p className="text-sm text-gray-600">Minimum 100 invoices to establish patterns</p>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <div className="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center text-gray-600 font-semibold">
              3
            </div>
            <div>
              <p className="font-medium text-gray-900">Wait for Analysis</p>
              <p className="text-sm text-gray-600">AI model trains overnight (24-48 hours)</p>
            </div>
          </div>
        </div>

        <a
          href="/dashboard/upload"
          className="mt-6 inline-flex items-center gap-2 px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        >
          <Package className="w-5 h-5" />
          Upload Historical Data
        </a>
      </div>
    </div>
  )
}
