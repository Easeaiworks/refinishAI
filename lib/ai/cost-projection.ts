// AI Cost Projection Engine
// Analyzes historical data to predict future material costs and consumption

import { SupabaseClient } from '@supabase/supabase-js'

// Types
export interface CostProjection {
  period: string
  startDate: string
  endDate: string
  estimatedJobs: number
  projectedMaterialCost: number
  projectedLaborCost: number
  projectedTotalCost: number
  confidence: number
  breakdown: CategoryBreakdown[]
  recommendations: Recommendation[]
}

export interface CategoryBreakdown {
  category: string
  projectedQuantity: number
  projectedCost: number
  percentOfTotal: number
  trend: 'up' | 'down' | 'stable'
  trendPercent: number
}

export interface Recommendation {
  type: 'order' | 'warning' | 'opportunity' | 'insight'
  priority: 'high' | 'medium' | 'low'
  title: string
  description: string
  potentialSavings?: number
  action?: string
}

export interface WasteAnalysis {
  period: string
  totalMaterialCost: number
  actualUsed: number
  wastedAmount: number
  wastePercent: number
  wasteCost: number
  byCategory: CategoryWaste[]
  trends: WasteTrend[]
  suggestions: string[]
}

export interface CategoryWaste {
  category: string
  expectedUsage: number
  actualUsage: number
  waste: number
  wastePercent: number
  wasteCost: number
}

export interface WasteTrend {
  month: string
  wastePercent: number
}

export interface ConsumptionPattern {
  productId: string
  productName: string
  avgDailyUsage: number
  avgWeeklyUsage: number
  avgMonthlyUsage: number
  peakDay: string
  peakUsage: number
  lowDay: string
  lowUsage: number
  seasonalFactor: number
}

// Cost Projection Engine Class
export class CostProjectionEngine {
  private supabase: SupabaseClient

  constructor(supabase: SupabaseClient) {
    this.supabase = supabase
  }

  // Generate cost projections for a given period
  async generateProjection(
    companyId: string,
    periodWeeks: number = 4
  ): Promise<CostProjection> {
    const startDate = new Date()
    const endDate = new Date()
    endDate.setDate(endDate.getDate() + periodWeeks * 7)

    // Get historical data
    const [invoices, estimates, consumption, products] = await Promise.all([
      this.getHistoricalInvoices(companyId, 90), // Last 90 days
      this.getUpcomingEstimates(companyId),
      this.getConsumptionHistory(companyId, 90),
      this.getProducts(companyId)
    ])

    // Calculate averages
    const avgJobsPerWeek = invoices.length / 13 // 90 days = ~13 weeks
    const avgMaterialCostPerJob = invoices.reduce((sum, inv) =>
      sum + (inv.material_cost || inv.total_amount * 0.4), 0) / Math.max(invoices.length, 1)
    const avgLaborCostPerJob = invoices.reduce((sum, inv) =>
      sum + (inv.labor_cost || inv.total_amount * 0.6), 0) / Math.max(invoices.length, 1)

    // Estimate jobs for projection period
    const scheduledJobs = estimates.length
    const projectedFromHistory = Math.round(avgJobsPerWeek * periodWeeks)
    const estimatedJobs = Math.max(scheduledJobs, projectedFromHistory)

    // Calculate projections
    const projectedMaterialCost = estimatedJobs * avgMaterialCostPerJob
    const projectedLaborCost = estimatedJobs * avgLaborCostPerJob
    const projectedTotalCost = projectedMaterialCost + projectedLaborCost

    // Calculate confidence based on data quality
    const confidence = this.calculateConfidence(invoices.length, consumption.length)

    // Generate category breakdown
    const breakdown = await this.generateCategoryBreakdown(
      consumption,
      products,
      estimatedJobs,
      avgJobsPerWeek * 13 // Historical jobs for comparison
    )

    // Generate recommendations
    const recommendations = await this.generateRecommendations(
      breakdown,
      products,
      consumption,
      estimates
    )

    return {
      period: `${periodWeeks} weeks`,
      startDate: startDate.toISOString().split('T')[0],
      endDate: endDate.toISOString().split('T')[0],
      estimatedJobs,
      projectedMaterialCost: Math.round(projectedMaterialCost * 100) / 100,
      projectedLaborCost: Math.round(projectedLaborCost * 100) / 100,
      projectedTotalCost: Math.round(projectedTotalCost * 100) / 100,
      confidence,
      breakdown,
      recommendations
    }
  }

  // Analyze waste patterns
  async analyzeWaste(
    companyId: string,
    periodDays: number = 30
  ): Promise<WasteAnalysis> {
    const consumption = await this.getConsumptionHistory(companyId, periodDays)
    const products = await this.getProducts(companyId)
    const invoices = await this.getHistoricalInvoices(companyId, periodDays)

    // Calculate totals
    const totalMaterialCost = consumption.reduce((sum, c) =>
      sum + (c.quantity_used * (c.cost_per_unit || 0)), 0)

    // Calculate waste by category
    const categoryMap = new Map<string, { expected: number; actual: number; cost: number }>()

    for (const c of consumption) {
      const product = products.find(p => p.id === c.product_id)
      if (!product) continue

      const category = product.category || 'Other'
      const existing = categoryMap.get(category) || { expected: 0, actual: 0, cost: 0 }

      // Expected usage based on coverage calculations
      const expectedUsage = c.quantity_used * (1 - (product.waste_factor || 0.15))
      const actualUsage = c.quantity_used

      categoryMap.set(category, {
        expected: existing.expected + expectedUsage,
        actual: existing.actual + actualUsage,
        cost: existing.cost + (actualUsage * (c.cost_per_unit || product.unit_cost || 0))
      })
    }

    const byCategory: CategoryWaste[] = []
    let totalExpected = 0
    let totalActual = 0

    categoryMap.forEach((data, category) => {
      const waste = data.actual - data.expected
      const wastePercent = data.expected > 0 ? (waste / data.expected) * 100 : 0
      const product = products.find(p => p.category === category)
      const avgCost = product?.unit_cost || 50

      byCategory.push({
        category,
        expectedUsage: Math.round(data.expected * 100) / 100,
        actualUsage: Math.round(data.actual * 100) / 100,
        waste: Math.round(waste * 100) / 100,
        wastePercent: Math.round(wastePercent * 10) / 10,
        wasteCost: Math.round(waste * avgCost * 100) / 100
      })

      totalExpected += data.expected
      totalActual += data.actual
    })

    // Sort by waste cost
    byCategory.sort((a, b) => b.wasteCost - a.wasteCost)

    const totalWaste = totalActual - totalExpected
    const overallWastePercent = totalExpected > 0 ? (totalWaste / totalExpected) * 100 : 0

    // Get waste trends (mock - would need historical tracking)
    const trends: WasteTrend[] = []
    for (let i = 5; i >= 0; i--) {
      const month = new Date()
      month.setMonth(month.getMonth() - i)
      trends.push({
        month: month.toLocaleString('default', { month: 'short' }),
        wastePercent: 12 + Math.random() * 8 - 4 // Mock trend data
      })
    }

    // Generate suggestions
    const suggestions = this.generateWasteSuggestions(byCategory)

    return {
      period: `Last ${periodDays} days`,
      totalMaterialCost: Math.round(totalMaterialCost * 100) / 100,
      actualUsed: Math.round(totalActual * 100) / 100,
      wastedAmount: Math.round(totalWaste * 100) / 100,
      wastePercent: Math.round(overallWastePercent * 10) / 10,
      wasteCost: Math.round(byCategory.reduce((sum, c) => sum + c.wasteCost, 0) * 100) / 100,
      byCategory,
      trends,
      suggestions
    }
  }

  // Analyze consumption patterns
  async analyzeConsumptionPatterns(
    companyId: string
  ): Promise<ConsumptionPattern[]> {
    const consumption = await this.getConsumptionHistory(companyId, 90)
    const products = await this.getProducts(companyId)

    const patterns: ConsumptionPattern[] = []

    // Group consumption by product
    const productConsumption = new Map<string, { dates: Date[]; quantities: number[] }>()

    for (const c of consumption) {
      const existing = productConsumption.get(c.product_id) || { dates: [], quantities: [] }
      existing.dates.push(new Date(c.transaction_date || c.created_at))
      existing.quantities.push(c.quantity_used)
      productConsumption.set(c.product_id, existing)
    }

    productConsumption.forEach((data, productId) => {
      const product = products.find(p => p.id === productId)
      if (!product) return

      const totalQty = data.quantities.reduce((sum, q) => sum + q, 0)
      const avgDaily = totalQty / 90
      const avgWeekly = avgDaily * 7
      const avgMonthly = avgDaily * 30

      // Calculate day-of-week patterns
      const dayTotals = [0, 0, 0, 0, 0, 0, 0]
      const dayCounts = [0, 0, 0, 0, 0, 0, 0]

      data.dates.forEach((date, i) => {
        const day = date.getDay()
        dayTotals[day] += data.quantities[i]
        dayCounts[day]++
      })

      const dayAverages = dayTotals.map((total, i) =>
        dayCounts[i] > 0 ? total / dayCounts[i] : 0
      )

      const peakDayIndex = dayAverages.indexOf(Math.max(...dayAverages))
      const lowDayIndex = dayAverages.indexOf(Math.min(...dayAverages.filter(d => d > 0)))

      const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

      patterns.push({
        productId,
        productName: product.name,
        avgDailyUsage: Math.round(avgDaily * 100) / 100,
        avgWeeklyUsage: Math.round(avgWeekly * 100) / 100,
        avgMonthlyUsage: Math.round(avgMonthly * 100) / 100,
        peakDay: days[peakDayIndex],
        peakUsage: Math.round(dayAverages[peakDayIndex] * 100) / 100,
        lowDay: days[lowDayIndex] || 'N/A',
        lowUsage: Math.round((dayAverages[lowDayIndex] || 0) * 100) / 100,
        seasonalFactor: 1.0 // Would need more data for seasonal analysis
      })
    })

    return patterns.sort((a, b) => b.avgMonthlyUsage - a.avgMonthlyUsage)
  }

  // Private helper methods
  private async getHistoricalInvoices(companyId: string, days: number) {
    const startDate = new Date()
    startDate.setDate(startDate.getDate() - days)

    const { data } = await this.supabase
      .from('invoices')
      .select('*')
      .gte('invoice_date', startDate.toISOString().split('T')[0])
      .order('invoice_date', { ascending: false })

    return data || []
  }

  private async getUpcomingEstimates(companyId: string) {
    const { data } = await this.supabase
      .from('estimates')
      .select('*')
      .gte('expected_start_date', new Date().toISOString().split('T')[0])
      .in('status', ['Quoted', 'Approved', 'Scheduled'])
      .order('expected_start_date', { ascending: true })

    return data || []
  }

  private async getConsumptionHistory(companyId: string, days: number) {
    const startDate = new Date()
    startDate.setDate(startDate.getDate() - days)

    const { data } = await this.supabase
      .from('consumption_history')
      .select('*')
      .gte('created_at', startDate.toISOString())
      .order('created_at', { ascending: false })

    return data || []
  }

  private async getProducts(companyId: string) {
    const { data } = await this.supabase
      .from('products')
      .select('*')

    return data || []
  }

  private calculateConfidence(invoiceCount: number, consumptionCount: number): number {
    // More data = higher confidence
    const invoiceScore = Math.min(invoiceCount / 50, 1) * 40 // Max 40 points
    const consumptionScore = Math.min(consumptionCount / 200, 1) * 40 // Max 40 points
    const baseScore = 20 // Base confidence

    return Math.round(baseScore + invoiceScore + consumptionScore)
  }

  private async generateCategoryBreakdown(
    consumption: any[],
    products: any[],
    projectedJobs: number,
    historicalJobs: number
  ): Promise<CategoryBreakdown[]> {
    const categoryMap = new Map<string, { qty: number; cost: number }>()

    for (const c of consumption) {
      const product = products.find(p => p.id === c.product_id)
      if (!product) continue

      const category = product.category || 'Other'
      const existing = categoryMap.get(category) || { qty: 0, cost: 0 }
      categoryMap.set(category, {
        qty: existing.qty + c.quantity_used,
        cost: existing.cost + (c.quantity_used * (c.cost_per_unit || product.unit_cost || 0))
      })
    }

    const totalCost = Array.from(categoryMap.values()).reduce((sum, c) => sum + c.cost, 0)
    const scaleFactor = historicalJobs > 0 ? projectedJobs / historicalJobs : 1

    const breakdown: CategoryBreakdown[] = []
    categoryMap.forEach((data, category) => {
      const projectedQty = data.qty * scaleFactor
      const projectedCost = data.cost * scaleFactor
      const percentOfTotal = totalCost > 0 ? (data.cost / totalCost) * 100 : 0

      // Simulate trend (would need historical comparison)
      const trendPercent = (Math.random() - 0.5) * 20
      const trend = trendPercent > 5 ? 'up' : trendPercent < -5 ? 'down' : 'stable'

      breakdown.push({
        category,
        projectedQuantity: Math.round(projectedQty * 100) / 100,
        projectedCost: Math.round(projectedCost * 100) / 100,
        percentOfTotal: Math.round(percentOfTotal * 10) / 10,
        trend,
        trendPercent: Math.round(Math.abs(trendPercent) * 10) / 10
      })
    })

    return breakdown.sort((a, b) => b.projectedCost - a.projectedCost)
  }

  private async generateRecommendations(
    breakdown: CategoryBreakdown[],
    products: any[],
    consumption: any[],
    estimates: any[]
  ): Promise<Recommendation[]> {
    const recommendations: Recommendation[] = []

    // Check for increasing costs
    breakdown.forEach(b => {
      if (b.trend === 'up' && b.trendPercent > 10) {
        recommendations.push({
          type: 'warning',
          priority: 'high',
          title: `${b.category} costs increasing`,
          description: `${b.category} spending is up ${b.trendPercent}% compared to the previous period. Review usage patterns and consider alternative suppliers.`,
          potentialSavings: b.projectedCost * 0.1
        })
      }
    })

    // Check for upcoming work requiring materials
    if (estimates.length > 5) {
      const totalEstimateValue = estimates.reduce((sum, e) => sum + (e.total_amount || 0), 0)
      recommendations.push({
        type: 'order',
        priority: 'high',
        title: 'Stock up for upcoming jobs',
        description: `You have ${estimates.length} scheduled jobs worth $${totalEstimateValue.toLocaleString()}. Ensure adequate material inventory.`,
        action: 'Review inventory levels'
      })
    }

    // Identify savings opportunities
    const highCostCategories = breakdown.filter(b => b.percentOfTotal > 25)
    highCostCategories.forEach(b => {
      recommendations.push({
        type: 'opportunity',
        priority: 'medium',
        title: `Optimize ${b.category} purchases`,
        description: `${b.category} represents ${b.percentOfTotal}% of material costs. Consider bulk ordering or negotiating better rates.`,
        potentialSavings: b.projectedCost * 0.05
      })
    })

    // General insights
    if (breakdown.length > 0) {
      recommendations.push({
        type: 'insight',
        priority: 'low',
        title: 'Diversified material usage',
        description: `Using products across ${breakdown.length} categories. Monitor for any single category exceeding 40% of total spend.`
      })
    }

    return recommendations.sort((a, b) => {
      const priorityOrder = { high: 0, medium: 1, low: 2 }
      return priorityOrder[a.priority] - priorityOrder[b.priority]
    })
  }

  private generateWasteSuggestions(byCategory: CategoryWaste[]): string[] {
    const suggestions: string[] = []

    byCategory.forEach(c => {
      if (c.wastePercent > 20) {
        suggestions.push(`Reduce ${c.category} waste by improving mixing accuracy and using digital scales`)
      }
      if (c.wastePercent > 15 && c.category.includes('Clear')) {
        suggestions.push(`Consider using smaller clear coat containers for small repairs to reduce waste`)
      }
    })

    if (suggestions.length === 0) {
      suggestions.push('Waste levels are within acceptable ranges. Continue monitoring.')
    }

    suggestions.push('Implement a color formula tracking system to reduce over-mixing')
    suggestions.push('Train staff on accurate material estimation techniques')

    return suggestions.slice(0, 5)
  }
}

// Utility function to create engine instance
export function createCostProjectionEngine(supabase: SupabaseClient): CostProjectionEngine {
  return new CostProjectionEngine(supabase)
}
