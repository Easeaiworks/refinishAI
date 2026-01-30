'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  TrendingUp, TrendingDown, DollarSign, Package, AlertTriangle,
  CheckCircle, RefreshCw, Calendar, Target, Lightbulb, BarChart3,
  PieChart, Activity, Zap, ArrowUp, ArrowDown, Minus
} from 'lucide-react'
import { createCostProjectionEngine } from '@/lib/ai/cost-projection'
import type { CostProjection, WasteAnalysis, ConsumptionPattern } from '@/lib/ai/cost-projection'

export default function AnalyticsPage() {
  const [loading, setLoading] = useState(true)
  const [projectionPeriod, setProjectionPeriod] = useState(4)
  const [projection, setProjection] = useState<CostProjection | null>(null)
  const [wasteAnalysis, setWasteAnalysis] = useState<WasteAnalysis | null>(null)
  const [patterns, setPatterns] = useState<ConsumptionPattern[]>([])
  const [refreshing, setRefreshing] = useState(false)
  const supabase = createClient()

  useEffect(() => {
    loadAnalytics()
  }, [projectionPeriod])

  const loadAnalytics = async () => {
    setLoading(true)

    try {
      const engine = createCostProjectionEngine(supabase)

      // Get user's company ID
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id')
        .eq('id', user.id)
        .single()

      const companyId = profile?.company_id || ''

      // Load all analytics data
      const [proj, waste, consumptionPatterns] = await Promise.all([
        engine.generateProjection(companyId, projectionPeriod),
        engine.analyzeWaste(companyId, 30),
        engine.analyzeConsumptionPatterns(companyId)
      ])

      setProjection(proj)
      setWasteAnalysis(waste)
      setPatterns(consumptionPatterns.slice(0, 10))
    } catch (error) {
      console.error('Error loading analytics:', error)
    } finally {
      setLoading(false)
    }
  }

  const refreshData = async () => {
    setRefreshing(true)
    await loadAnalytics()
    setRefreshing(false)
  }

  const getTrendIcon = (trend: 'up' | 'down' | 'stable') => {
    switch (trend) {
      case 'up': return <ArrowUp className="w-4 h-4 text-red-500" />
      case 'down': return <ArrowDown className="w-4 h-4 text-green-500" />
      default: return <Minus className="w-4 h-4 text-gray-400" />
    }
  }

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'high': return 'bg-red-100 text-red-700 border-red-200'
      case 'medium': return 'bg-yellow-100 text-yellow-700 border-yellow-200'
      default: return 'bg-blue-100 text-blue-700 border-blue-200'
    }
  }

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'order': return <Package className="w-5 h-5" />
      case 'warning': return <AlertTriangle className="w-5 h-5" />
      case 'opportunity': return <Lightbulb className="w-5 h-5" />
      default: return <CheckCircle className="w-5 h-5" />
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center py-24">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Analyzing your data...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Analytics & Projections</h1>
          <p className="text-gray-600 mt-2">AI-powered cost forecasting and waste analysis</p>
        </div>
        <div className="flex items-center gap-4">
          <select
            value={projectionPeriod}
            onChange={(e) => setProjectionPeriod(parseInt(e.target.value))}
            className="px-4 py-2 border border-gray-300 rounded-lg"
          >
            <option value={2}>2 Week Forecast</option>
            <option value={4}>4 Week Forecast</option>
            <option value={8}>8 Week Forecast</option>
            <option value={12}>12 Week Forecast</option>
          </select>
          <button
            onClick={refreshData}
            disabled={refreshing}
            className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400"
          >
            <RefreshCw className={`w-4 h-4 ${refreshing ? 'animate-spin' : ''}`} />
            Refresh
          </button>
        </div>
      </div>

      {/* Confidence Score */}
      {projection && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Zap className="w-5 h-5 text-blue-600" />
              <span className="font-medium text-gray-900">AI Confidence Score</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-32 h-2 bg-gray-200 rounded-full overflow-hidden">
                <div
                  className={`h-full rounded-full ${
                    projection.confidence >= 70 ? 'bg-green-500' :
                    projection.confidence >= 40 ? 'bg-yellow-500' : 'bg-red-500'
                  }`}
                  style={{ width: `${projection.confidence}%` }}
                />
              </div>
              <span className="font-bold text-gray-900">{projection.confidence}%</span>
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-2">
            {projection.confidence >= 70
              ? 'High confidence based on sufficient historical data'
              : projection.confidence >= 40
              ? 'Moderate confidence - more data will improve accuracy'
              : 'Low confidence - add more historical invoices and consumption records'
            }
          </p>
        </div>
      )}

      {/* Key Metrics */}
      {projection && (
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">Projected Jobs</p>
                <p className="text-3xl font-bold text-gray-900 mt-1">{projection.estimatedJobs}</p>
              </div>
              <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                <Calendar className="w-6 h-6 text-blue-600" />
              </div>
            </div>
            <p className="text-sm text-gray-500 mt-3">Next {projectionPeriod} weeks</p>
          </div>

          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">Material Cost</p>
                <p className="text-3xl font-bold text-gray-900 mt-1">
                  ${projection.projectedMaterialCost.toLocaleString()}
                </p>
              </div>
              <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                <Package className="w-6 h-6 text-green-600" />
              </div>
            </div>
            <p className="text-sm text-gray-500 mt-3">Estimated spend</p>
          </div>

          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">Labor Cost</p>
                <p className="text-3xl font-bold text-gray-900 mt-1">
                  ${projection.projectedLaborCost.toLocaleString()}
                </p>
              </div>
              <div className="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
                <Activity className="w-6 h-6 text-purple-600" />
              </div>
            </div>
            <p className="text-sm text-gray-500 mt-3">Estimated spend</p>
          </div>

          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">Total Projected</p>
                <p className="text-3xl font-bold text-blue-600 mt-1">
                  ${projection.projectedTotalCost.toLocaleString()}
                </p>
              </div>
              <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                <DollarSign className="w-6 h-6 text-blue-600" />
              </div>
            </div>
            <p className="text-sm text-gray-500 mt-3">Combined costs</p>
          </div>
        </div>
      )}

      {/* Main Content Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Category Breakdown */}
        {projection && projection.breakdown.length > 0 && (
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <h2 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
              <PieChart className="w-5 h-5 text-blue-600" />
              Cost Breakdown by Category
            </h2>
            <div className="space-y-4">
              {projection.breakdown.map((item, index) => (
                <div key={item.category} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <span className="font-medium text-gray-900">{item.category}</span>
                      {getTrendIcon(item.trend)}
                      <span className={`text-xs ${
                        item.trend === 'up' ? 'text-red-600' :
                        item.trend === 'down' ? 'text-green-600' : 'text-gray-500'
                      }`}>
                        {item.trendPercent}%
                      </span>
                    </div>
                    <span className="font-semibold text-gray-900">
                      ${item.projectedCost.toLocaleString()}
                    </span>
                  </div>
                  <div className="w-full h-2 bg-gray-100 rounded-full overflow-hidden">
                    <div
                      className="h-full rounded-full"
                      style={{
                        width: `${item.percentOfTotal}%`,
                        backgroundColor: `hsl(${220 - index * 30}, 70%, 50%)`
                      }}
                    />
                  </div>
                  <div className="flex justify-between text-xs text-gray-500">
                    <span>{item.projectedQuantity} units</span>
                    <span>{item.percentOfTotal}% of total</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Waste Analysis */}
        {wasteAnalysis && (
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <h2 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
              <Target className="w-5 h-5 text-orange-600" />
              Waste Analysis
            </h2>

            {/* Waste Summary */}
            <div className="grid grid-cols-2 gap-4 mb-6">
              <div className="bg-orange-50 rounded-lg p-4">
                <p className="text-sm text-orange-700">Waste Rate</p>
                <p className="text-2xl font-bold text-orange-600">{wasteAnalysis.wastePercent}%</p>
              </div>
              <div className="bg-red-50 rounded-lg p-4">
                <p className="text-sm text-red-700">Waste Cost</p>
                <p className="text-2xl font-bold text-red-600">${wasteAnalysis.wasteCost.toLocaleString()}</p>
              </div>
            </div>

            {/* Waste by Category */}
            <div className="space-y-3 mb-6">
              {wasteAnalysis.byCategory.slice(0, 5).map((item) => (
                <div key={item.category} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div>
                    <p className="font-medium text-gray-900">{item.category}</p>
                    <p className="text-sm text-gray-500">
                      {item.waste.toFixed(1)} units wasted
                    </p>
                  </div>
                  <div className="text-right">
                    <p className={`font-semibold ${item.wastePercent > 20 ? 'text-red-600' : 'text-orange-600'}`}>
                      {item.wastePercent}%
                    </p>
                    <p className="text-sm text-gray-500">${item.wasteCost.toFixed(2)}</p>
                  </div>
                </div>
              ))}
            </div>

            {/* Waste Trend Chart */}
            <div className="border-t border-gray-200 pt-4">
              <p className="text-sm font-medium text-gray-700 mb-3">6-Month Waste Trend</p>
              <div className="flex items-end justify-between h-24 gap-2">
                {wasteAnalysis.trends.map((trend, index) => (
                  <div key={trend.month} className="flex-1 flex flex-col items-center">
                    <div
                      className="w-full bg-orange-200 rounded-t"
                      style={{ height: `${trend.wastePercent * 4}px` }}
                    />
                    <p className="text-xs text-gray-500 mt-1">{trend.month}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}
      </div>

      {/* AI Recommendations */}
      {projection && projection.recommendations.length > 0 && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <h2 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
            <Lightbulb className="w-5 h-5 text-yellow-500" />
            AI Recommendations
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {projection.recommendations.map((rec, index) => (
              <div
                key={index}
                className={`p-4 rounded-lg border ${getPriorityColor(rec.priority)}`}
              >
                <div className="flex items-start gap-3">
                  {getTypeIcon(rec.type)}
                  <div className="flex-1">
                    <div className="flex items-center justify-between">
                      <h3 className="font-semibold">{rec.title}</h3>
                      <span className="text-xs px-2 py-0.5 rounded-full bg-white/50 capitalize">
                        {rec.priority}
                      </span>
                    </div>
                    <p className="text-sm mt-1 opacity-80">{rec.description}</p>
                    {rec.potentialSavings && (
                      <p className="text-sm font-medium mt-2">
                        Potential Savings: ${rec.potentialSavings.toLocaleString()}
                      </p>
                    )}
                    {rec.action && (
                      <button className="text-sm font-medium mt-2 underline">
                        {rec.action} →
                      </button>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Top Consumption Patterns */}
      {patterns.length > 0 && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <h2 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
            <BarChart3 className="w-5 h-5 text-purple-600" />
            Top Products by Consumption
          </h2>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50">
                <tr>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Product</th>
                  <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Daily Avg</th>
                  <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Weekly Avg</th>
                  <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Monthly Avg</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Peak Day</th>
                </tr>
              </thead>
              <tbody>
                {patterns.map((pattern) => (
                  <tr key={pattern.productId} className="border-b border-gray-100">
                    <td className="py-3 px-4 font-medium text-gray-900">{pattern.productName}</td>
                    <td className="py-3 px-4 text-right text-gray-600">{pattern.avgDailyUsage}</td>
                    <td className="py-3 px-4 text-right text-gray-600">{pattern.avgWeeklyUsage}</td>
                    <td className="py-3 px-4 text-right font-semibold text-gray-900">{pattern.avgMonthlyUsage}</td>
                    <td className="py-3 px-4 text-gray-600">
                      {pattern.peakDay} ({pattern.peakUsage})
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Waste Reduction Suggestions */}
      {wasteAnalysis && wasteAnalysis.suggestions.length > 0 && (
        <div className="bg-gradient-to-r from-green-50 to-blue-50 rounded-lg border border-green-200 p-6">
          <h2 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
            <CheckCircle className="w-5 h-5 text-green-600" />
            Waste Reduction Tips
          </h2>
          <ul className="space-y-3">
            {wasteAnalysis.suggestions.map((suggestion, index) => (
              <li key={index} className="flex items-start gap-3">
                <span className="w-6 h-6 bg-green-600 text-white rounded-full flex items-center justify-center text-sm flex-shrink-0">
                  {index + 1}
                </span>
                <span className="text-gray-700">{suggestion}</span>
              </li>
            ))}
          </ul>
        </div>
      )}

      {/* No Data State */}
      {!projection && !loading && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
          <BarChart3 className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No Analytics Data Yet</h3>
          <p className="text-gray-600 mb-4">
            Upload invoices and track material consumption to generate cost projections and insights.
          </p>
          <a
            href="/dashboard/upload"
            className="inline-flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            Upload Data
          </a>
        </div>
      )}
    </div>
  )
}
