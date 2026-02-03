/**
 * RefinishAI Calculation Service
 *
 * All business calculations go through this service to ensure:
 * - Deterministic results
 * - Full audit trail
 * - Transparent formulas
 * - Defensible against audits
 */

import { FORMULAS, createAuditEntry, CalculationAuditEntry } from './audit-trail'

export interface ReorderCalculation {
  productId: string
  productName: string
  currentStock: number
  avgDailyUsage: number
  leadTimeDays: number
  safetyStock: number
  orderCycleDays: number
  orderMultiple: number
  // Calculated values
  reorderPoint: number
  parLevel: number
  suggestedOrderQty: number
  daysOfStockRemaining: number
  // Audit
  auditEntries: CalculationAuditEntry[]
}

export interface LaborCostCalculation {
  bodyHours: number
  refinishHours: number
  mechanicalHours: number
  structuralHours: number
  aluminumHours: number
  glassHours: number
  // Rates
  bodyRate: number
  refinishRate: number
  mechanicalRate: number
  structuralRate: number
  aluminumRate: number
  glassRate: number
  // Calculated values
  bodyCost: number
  refinishCost: number
  mechanicalCost: number
  structuralCost: number
  aluminumCost: number
  glassCost: number
  totalLaborCost: number
  // Audit
  auditEntries: CalculationAuditEntry[]
}

export class CalculationService {
  private auditLog: CalculationAuditEntry[] = []
  private userId?: string
  private companyId?: string

  constructor(userId?: string, companyId?: string) {
    this.userId = userId
    this.companyId = companyId
  }

  /**
   * Calculate reorder metrics for a product
   * All calculations are deterministic and auditable
   */
  calculateReorderMetrics(
    productId: string,
    productName: string,
    currentStock: number,
    avgDailyUsage: number,
    leadTimeDays: number,
    safetyStock: number = 0,
    orderCycleDays: number = 7,
    orderMultiple: number = 1
  ): ReorderCalculation {
    const auditEntries: CalculationAuditEntry[] = []

    // Calculate Reorder Point
    const reorderPoint = FORMULAS.REORDER_POINT.calculate(avgDailyUsage, leadTimeDays, safetyStock)
    auditEntries.push(createAuditEntry(
      'Reorder Point',
      'REORDER_POINT',
      { avgDailyUsage, leadTimeDays, safetyStock },
      reorderPoint,
      this.userId,
      this.companyId
    ))

    // Calculate Par Level
    const parLevel = FORMULAS.PAR_LEVEL.calculate(reorderPoint, avgDailyUsage, orderCycleDays)
    auditEntries.push(createAuditEntry(
      'Par Level',
      'PAR_LEVEL',
      { reorderPoint, avgDailyUsage, orderCycleDays },
      parLevel,
      this.userId,
      this.companyId
    ))

    // Calculate Suggested Order Quantity
    const suggestedOrderQty = FORMULAS.SUGGESTED_ORDER_QTY.calculate(parLevel, currentStock, orderMultiple)
    auditEntries.push(createAuditEntry(
      'Suggested Order Quantity',
      'SUGGESTED_ORDER_QTY',
      { parLevel, currentStock, orderMultiple },
      suggestedOrderQty,
      this.userId,
      this.companyId
    ))

    // Calculate Days of Stock Remaining
    const daysOfStockRemaining = FORMULAS.DAYS_OF_STOCK.calculate(currentStock, avgDailyUsage)
    auditEntries.push(createAuditEntry(
      'Days of Stock Remaining',
      'DAYS_OF_STOCK',
      { currentStock, avgDailyUsage },
      daysOfStockRemaining,
      this.userId,
      this.companyId
    ))

    // Add to main audit log
    this.auditLog.push(...auditEntries)

    return {
      productId,
      productName,
      currentStock,
      avgDailyUsage,
      leadTimeDays,
      safetyStock,
      orderCycleDays,
      orderMultiple,
      reorderPoint,
      parLevel,
      suggestedOrderQty,
      daysOfStockRemaining,
      auditEntries
    }
  }

  /**
   * Calculate labor costs for an estimate/invoice
   * All calculations are deterministic and auditable
   */
  calculateLaborCosts(
    hours: {
      body: number
      refinish: number
      mechanical: number
      structural: number
      aluminum: number
      glass: number
    },
    rates: {
      body: number
      refinish: number
      mechanical: number
      structural: number
      aluminum: number
      glass: number
    }
  ): LaborCostCalculation {
    const auditEntries: CalculationAuditEntry[] = []

    // Calculate each labor type cost
    const bodyCost = FORMULAS.LABOR_COST.calculate(hours.body, rates.body)
    auditEntries.push(createAuditEntry(
      'Body Labor Cost',
      'LABOR_COST',
      { hours: hours.body, rate: rates.body },
      bodyCost,
      this.userId,
      this.companyId
    ))

    const refinishCost = FORMULAS.LABOR_COST.calculate(hours.refinish, rates.refinish)
    auditEntries.push(createAuditEntry(
      'Refinish Labor Cost',
      'LABOR_COST',
      { hours: hours.refinish, rate: rates.refinish },
      refinishCost,
      this.userId,
      this.companyId
    ))

    const mechanicalCost = FORMULAS.LABOR_COST.calculate(hours.mechanical, rates.mechanical)
    auditEntries.push(createAuditEntry(
      'Mechanical Labor Cost',
      'LABOR_COST',
      { hours: hours.mechanical, rate: rates.mechanical },
      mechanicalCost,
      this.userId,
      this.companyId
    ))

    const structuralCost = FORMULAS.LABOR_COST.calculate(hours.structural, rates.structural)
    auditEntries.push(createAuditEntry(
      'Structural Labor Cost',
      'LABOR_COST',
      { hours: hours.structural, rate: rates.structural },
      structuralCost,
      this.userId,
      this.companyId
    ))

    const aluminumCost = FORMULAS.LABOR_COST.calculate(hours.aluminum, rates.aluminum)
    auditEntries.push(createAuditEntry(
      'Aluminum Labor Cost',
      'LABOR_COST',
      { hours: hours.aluminum, rate: rates.aluminum },
      aluminumCost,
      this.userId,
      this.companyId
    ))

    const glassCost = FORMULAS.LABOR_COST.calculate(hours.glass, rates.glass)
    auditEntries.push(createAuditEntry(
      'Glass Labor Cost',
      'LABOR_COST',
      { hours: hours.glass, rate: rates.glass },
      glassCost,
      this.userId,
      this.companyId
    ))

    // Calculate total
    const totalLaborCost = FORMULAS.TOTAL_LABOR_COST.calculate([
      { hours: hours.body, rate: rates.body },
      { hours: hours.refinish, rate: rates.refinish },
      { hours: hours.mechanical, rate: rates.mechanical },
      { hours: hours.structural, rate: rates.structural },
      { hours: hours.aluminum, rate: rates.aluminum },
      { hours: hours.glass, rate: rates.glass }
    ])
    auditEntries.push(createAuditEntry(
      'Total Labor Cost',
      'TOTAL_LABOR_COST',
      {
        bodyHours: hours.body, bodyRate: rates.body,
        refinishHours: hours.refinish, refinishRate: rates.refinish,
        mechanicalHours: hours.mechanical, mechanicalRate: rates.mechanical,
        structuralHours: hours.structural, structuralRate: rates.structural,
        aluminumHours: hours.aluminum, aluminumRate: rates.aluminum,
        glassHours: hours.glass, glassRate: rates.glass
      },
      totalLaborCost,
      this.userId,
      this.companyId
    ))

    this.auditLog.push(...auditEntries)

    return {
      bodyHours: hours.body,
      refinishHours: hours.refinish,
      mechanicalHours: hours.mechanical,
      structuralHours: hours.structural,
      aluminumHours: hours.aluminum,
      glassHours: hours.glass,
      bodyRate: rates.body,
      refinishRate: rates.refinish,
      mechanicalRate: rates.mechanical,
      structuralRate: rates.structural,
      aluminumRate: rates.aluminum,
      glassRate: rates.glass,
      bodyCost,
      refinishCost,
      mechanicalCost,
      structuralCost,
      aluminumCost,
      glassCost,
      totalLaborCost,
      auditEntries
    }
  }

  /**
   * Calculate inventory valuation
   */
  calculateInventoryValue(items: Array<{ productId: string; quantity: number; unitCost: number }>): {
    totalValue: number
    itemValues: Array<{ productId: string; value: number }>
    auditEntry: CalculationAuditEntry
  } {
    const itemValues = items.map(item => ({
      productId: item.productId,
      value: FORMULAS.INVENTORY_VALUE.calculate(item.quantity, item.unitCost)
    }))

    const totalValue = FORMULAS.TOTAL_INVENTORY_VALUE.calculate(items)

    const auditEntry = createAuditEntry(
      'Inventory Valuation',
      'TOTAL_INVENTORY_VALUE',
      { itemCount: items.length, items: items.map(i => `${i.quantity} @ $${i.unitCost}`) },
      totalValue,
      this.userId,
      this.companyId
    )

    this.auditLog.push(auditEntry)

    return { totalValue, itemValues, auditEntry }
  }

  /**
   * Calculate average daily usage from historical data
   */
  calculateAverageDailyUsage(totalUsed: number, periodDays: number): {
    avgDailyUsage: number
    auditEntry: CalculationAuditEntry
  } {
    const avgDailyUsage = FORMULAS.AVERAGE_DAILY_USAGE.calculate(totalUsed, periodDays)

    const auditEntry = createAuditEntry(
      'Average Daily Usage',
      'AVERAGE_DAILY_USAGE',
      { totalUsed, periodDays },
      avgDailyUsage,
      this.userId,
      this.companyId
    )

    this.auditLog.push(auditEntry)

    return { avgDailyUsage, auditEntry }
  }

  /**
   * Get the full audit log
   */
  getAuditLog(): CalculationAuditEntry[] {
    return [...this.auditLog]
  }

  /**
   * Clear the audit log (e.g., after exporting)
   */
  clearAuditLog(): void {
    this.auditLog = []
  }
}

// Export formulas for documentation
export { FORMULAS } from './audit-trail'
export {
  createAuditEntry,
  verifyCalculation,
  exportAuditTrailToCSV,
  generateCalculationDocumentation,
  runReliableForecast
} from './audit-trail'
export type { CalculationAuditEntry, AIForecastEntry } from './audit-trail'
