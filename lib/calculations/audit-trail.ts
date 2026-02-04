/**
 * RefinishAI Calculation Audit Trail System
 *
 * This module ensures all calculations are:
 * 1. Deterministic - same inputs always produce same outputs
 * 2. Auditable - every calculation is logged with inputs, formula, and result
 * 3. Transparent - formulas are documented and verifiable
 * 4. Defensible - audit trail can be exported for review
 */

export interface CalculationAuditEntry {
  id: string
  timestamp: string
  calculationType: string
  formulaName: string
  formulaDescription: string
  inputs: Record<string, number | string>
  formula: string // Human-readable formula
  result: number | Record<string, number>
  userId?: string
  companyId?: string
}

export interface AIForecastEntry {
  id: string
  timestamp: string
  forecastType: string
  confidenceScore: number // 0-100
  iterations: number
  consistencyRate: number // Percentage of iterations that produced same result
  isReliable: boolean // true if consistencyRate >= 97.8%
  result: any
  disclaimer: string
}

// Standard formulas used throughout the system
export const FORMULAS = {
  // Inventory Calculations
  REORDER_POINT: {
    name: 'Reorder Point',
    formula: '(Average Daily Usage × Lead Time Days) + Safety Stock',
    calculate: (avgDailyUsage: number, leadTimeDays: number, safetyStock: number): number => {
      return Math.ceil((avgDailyUsage * leadTimeDays) + safetyStock)
    }
  },

  PAR_LEVEL: {
    name: 'Par Level',
    formula: 'Reorder Point + (Average Daily Usage × Order Cycle Days)',
    calculate: (reorderPoint: number, avgDailyUsage: number, orderCycleDays: number): number => {
      return Math.ceil(reorderPoint + (avgDailyUsage * orderCycleDays))
    }
  },

  SUGGESTED_ORDER_QTY: {
    name: 'Suggested Order Quantity',
    formula: 'CEILING((Par Level - Current Stock) / Order Multiple) × Order Multiple',
    calculate: (parLevel: number, currentStock: number, orderMultiple: number = 1): number => {
      const needed = Math.max(0, parLevel - currentStock)
      return Math.ceil(needed / orderMultiple) * orderMultiple
    }
  },

  DAYS_OF_STOCK: {
    name: 'Days of Stock Remaining',
    formula: 'Current Stock / Average Daily Usage',
    calculate: (currentStock: number, avgDailyUsage: number): number => {
      if (avgDailyUsage <= 0) return 999 // Infinite if no usage
      return Math.floor(currentStock / avgDailyUsage)
    }
  },

  AVERAGE_DAILY_USAGE: {
    name: 'Average Daily Usage',
    formula: 'Total Units Used in Period / Number of Days in Period',
    calculate: (totalUsed: number, periodDays: number): number => {
      if (periodDays <= 0) return 0
      return Number((totalUsed / periodDays).toFixed(4))
    }
  },

  // Labor Calculations
  LABOR_COST: {
    name: 'Labor Cost',
    formula: 'Labor Hours × Hourly Rate',
    calculate: (hours: number, hourlyRate: number): number => {
      return Number((hours * hourlyRate).toFixed(2))
    }
  },

  TOTAL_LABOR_COST: {
    name: 'Total Labor Cost',
    formula: 'Σ(Labor Hours by Type × Hourly Rate by Type)',
    calculate: (laborByType: Array<{ hours: number; rate: number }>): number => {
      return Number(laborByType.reduce((sum, item) => sum + (item.hours * item.rate), 0).toFixed(2))
    }
  },

  // Material/Inventory Valuation
  INVENTORY_VALUE: {
    name: 'Inventory Value',
    formula: 'Quantity On Hand × Unit Cost',
    calculate: (quantity: number, unitCost: number): number => {
      return Number((quantity * unitCost).toFixed(2))
    }
  },

  TOTAL_INVENTORY_VALUE: {
    name: 'Total Inventory Value',
    formula: 'Σ(Quantity × Unit Cost) for all items',
    calculate: (items: Array<{ quantity: number; unitCost: number }>): number => {
      return Number(items.reduce((sum, item) => sum + (item.quantity * item.unitCost), 0).toFixed(2))
    }
  },

  // Order Cost Calculations
  ORDER_LINE_TOTAL: {
    name: 'Order Line Total',
    formula: 'Order Quantity × Unit Cost × (1 - Discount %)',
    calculate: (quantity: number, unitCost: number, discountPercent: number = 0): number => {
      return Number((quantity * unitCost * (1 - discountPercent / 100)).toFixed(2))
    }
  },

  // Estimate Calculations
  ESTIMATE_TOTAL: {
    name: 'Estimate Total',
    formula: 'Total Labor + Total Parts + Total Materials + Total Sublet - Deductible',
    calculate: (labor: number, parts: number, materials: number, sublet: number, deductible: number): number => {
      return Number((labor + parts + materials + sublet - deductible).toFixed(2))
    }
  }
}

/**
 * Create an audit entry for a calculation
 */
export function createAuditEntry(
  calculationType: string,
  formulaKey: keyof typeof FORMULAS,
  inputs: Record<string, number | string>,
  result: number | Record<string, number>,
  userId?: string,
  companyId?: string
): CalculationAuditEntry {
  const formula = FORMULAS[formulaKey]
  return {
    id: crypto.randomUUID(),
    timestamp: new Date().toISOString(),
    calculationType,
    formulaName: formula.name,
    formulaDescription: formula.formula,
    inputs,
    formula: formula.formula,
    result,
    userId,
    companyId
  }
}

/**
 * AI Forecast Reliability Check
 * Runs calculation multiple times and checks consistency
 * Only returns result if consistency >= 97.8%
 */
export async function runReliableForecast<T>(
  forecastFn: () => Promise<T>,
  iterations: number = 100,
  requiredConsistency: number = 97.8
): Promise<AIForecastEntry & { result: T | null }> {
  const results: T[] = []

  for (let i = 0; i < iterations; i++) {
    try {
      const result = await forecastFn()
      results.push(result)
    } catch (e) {
      // Count errors as inconsistent results
    }
  }

  // Calculate consistency (how many results match the most common result)
  const resultCounts = new Map<string, number>()
  results.forEach(r => {
    const key = JSON.stringify(r)
    resultCounts.set(key, (resultCounts.get(key) || 0) + 1)
  })

  let maxCount = 0
  let mostCommonResult: T | null = null
  resultCounts.forEach((count, key) => {
    if (count > maxCount) {
      maxCount = count
      mostCommonResult = JSON.parse(key)
    }
  })

  const consistencyRate = (maxCount / iterations) * 100
  const isReliable = consistencyRate >= requiredConsistency

  return {
    id: crypto.randomUUID(),
    timestamp: new Date().toISOString(),
    forecastType: 'AI Forecast',
    confidenceScore: consistencyRate,
    iterations,
    consistencyRate,
    isReliable,
    result: isReliable ? mostCommonResult : null,
    disclaimer: isReliable
      ? `AI forecast achieved ${consistencyRate.toFixed(1)}% consistency across ${iterations} iterations.`
      : `AI forecast did not meet reliability threshold (${consistencyRate.toFixed(1)}% < ${requiredConsistency}%). Showing deterministic calculation instead.`
  }
}

/**
 * Verify a calculation by re-running it
 * Used for audit purposes
 */
export function verifyCalculation(
  formulaKey: keyof typeof FORMULAS,
  inputs: any[],
  expectedResult: number
): { verified: boolean; calculatedResult: number; difference: number } {
  const formula = FORMULAS[formulaKey]
  // Use Function.prototype.apply to spread the inputs array
  const calculatedResult = (formula.calculate as Function).apply(null, inputs)
  const difference = Math.abs(calculatedResult - expectedResult)

  return {
    verified: difference < 0.01, // Allow for rounding differences
    calculatedResult,
    difference
  }
}

/**
 * Export audit trail to CSV for external review
 */
export function exportAuditTrailToCSV(entries: CalculationAuditEntry[]): string {
  const headers = [
    'ID',
    'Timestamp',
    'Calculation Type',
    'Formula Name',
    'Formula',
    'Inputs',
    'Result',
    'User ID',
    'Company ID'
  ]

  const rows = entries.map(entry => [
    entry.id,
    entry.timestamp,
    entry.calculationType,
    entry.formulaName,
    `"${entry.formula}"`,
    `"${JSON.stringify(entry.inputs)}"`,
    typeof entry.result === 'number' ? entry.result.toString() : JSON.stringify(entry.result),
    entry.userId || '',
    entry.companyId || ''
  ])

  return [headers.join(','), ...rows.map(r => r.join(','))].join('\n')
}

/**
 * Generate calculation documentation for audit purposes
 */
export function generateCalculationDocumentation(): string {
  let doc = '# RefinishAI Calculation Documentation\n\n'
  doc += '## Overview\n'
  doc += 'All calculations in RefinishAI use deterministic formulas that produce consistent, auditable results.\n\n'
  doc += '## Formulas\n\n'

  Object.entries(FORMULAS).forEach(([key, formula]) => {
    doc += `### ${formula.name}\n`
    doc += `**Formula:** \`${formula.formula}\`\n\n`
  })

  doc += '## AI Forecasting\n'
  doc += 'AI-powered forecasts are only displayed when they achieve ≥97.8% consistency across 100 iterations.\n'
  doc += 'When AI forecasts do not meet this threshold, the system falls back to deterministic calculations.\n'

  return doc
}
