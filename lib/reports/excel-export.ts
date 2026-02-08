// Client-side Excel Export for Reorder Reports
// Uses xlsx (SheetJS) library
// Generates 3 sheets: Detail, Manufacturer Summary, Priority Breakdown

import * as XLSX from 'xlsx'
import type { ReorderReport, ReorderItem } from './reorder-report'

interface CompanyInfo {
  name: string
}

// Group items by manufacturer (returns sorted array of tuples)
function groupByManufacturer(items: ReorderItem[]): Array<[string, ReorderItem[]]> {
  const grouped: Record<string, ReorderItem[]> = {}
  for (const item of items) {
    const mfg = item.manufacturer || item.supplierName || item.vendorCode || 'Other'
    if (!grouped[mfg]) grouped[mfg] = []
    grouped[mfg].push(item)
  }
  return Object.entries(grouped).sort((a, b) => a[0].localeCompare(b[0]))
}

export function generateReorderXLSX(
  report: ReorderReport,
  company: CompanyInfo,
  adjustments: Record<string, number> = {}
): Blob {
  const wb = XLSX.utils.book_new()
  const dateStr = new Date().toLocaleDateString('en-US', {
    year: 'numeric', month: 'long', day: 'numeric',
  })
  const poRef = `PO-${new Date().toISOString().split('T')[0].replace(/-/g, '')}-RPT`

  // ─── SHEET 1: PURCHASE ORDER DETAIL ───
  const detailHeaders = [
    'Priority', 'Manufacturer', 'Category', 'SKU', 'Item Name', 'Model',
    'Unit', 'On Hand', 'Reorder Pt', 'Par Level', 'Order Qty',
    'Unit Cost', 'Extended Cost', 'Lead Time', 'Days Stock',
  ]

  const detailData: any[][] = [
    [`Purchase Order Report - ${company.name}`],
    [`Report #: ${poRef} | Generated: ${dateStr}`],
    [], // blank row
    detailHeaders,
  ]

  // Sort: by manufacturer, then category, then priority
  const sortedItems = [...report.items].sort((a, b) => {
    const mfgA = a.manufacturer || a.supplierName || 'ZZZ'
    const mfgB = b.manufacturer || b.supplierName || 'ZZZ'
    if (mfgA !== mfgB) return mfgA.localeCompare(mfgB)
    if (a.category !== b.category) return a.category.localeCompare(b.category)
    const priOrder: Record<string, number> = { critical: 0, urgent: 1, normal: 2, optional: 3 }
    return (priOrder[a.priority] || 3) - (priOrder[b.priority] || 3)
  })

  for (const item of sortedItems) {
    const qty = adjustments[item.id] ?? item.suggestedOrderQty
    const ext = Math.round(qty * item.unitCost * 100) / 100
    detailData.push([
      item.priority.toUpperCase(),
      item.manufacturer || item.supplierName || item.vendorCode || '',
      item.category,
      item.sku,
      item.productName,
      '', // model placeholder - from product data
      item.unit,
      item.currentStock,
      item.reorderPoint,
      item.parLevel,
      qty,
      item.unitCost,
      ext,
      `${item.leadTimeDays}d`,
      `${item.daysOfStockRemaining}d`,
    ])
  }

  // Totals row
  const totalQty = sortedItems.reduce((s, i) => s + (adjustments[i.id] ?? i.suggestedOrderQty), 0)
  const totalCost = sortedItems.reduce((s, i) => {
    const q = adjustments[i.id] ?? i.suggestedOrderQty
    return s + Math.round(q * i.unitCost * 100) / 100
  }, 0)

  detailData.push([
    'GRAND TOTAL', '', '', '', '', '', '', '', '', '',
    totalQty, '', totalCost, '', '',
  ])

  const ws1 = XLSX.utils.aoa_to_sheet(detailData)

  // Set column widths
  ws1['!cols'] = [
    { wch: 11 }, // Priority
    { wch: 20 }, // Manufacturer
    { wch: 14 }, // Category
    { wch: 16 }, // SKU
    { wch: 34 }, // Item Name
    { wch: 14 }, // Model
    { wch: 10 }, // Unit
    { wch: 9 },  // On Hand
    { wch: 10 }, // Reorder Pt
    { wch: 10 }, // Par Level
    { wch: 10 }, // Order Qty
    { wch: 12 }, // Unit Cost
    { wch: 14 }, // Extended Cost
    { wch: 10 }, // Lead Time
    { wch: 10 }, // Days Stock
  ]

  // Format currency columns
  const dataStartRow = 4 // 0-indexed row 4 = row 5 in sheet
  for (let r = dataStartRow; r < detailData.length; r++) {
    const costCell = XLSX.utils.encode_cell({ r, c: 11 })
    const extCell = XLSX.utils.encode_cell({ r, c: 12 })
    if (ws1[costCell]) ws1[costCell].z = '$#,##0.00'
    if (ws1[extCell]) ws1[extCell].z = '$#,##0.00'
  }

  XLSX.utils.book_append_sheet(wb, ws1, 'Purchase Order Detail')

  // ─── SHEET 2: MANUFACTURER SUMMARY ───
  const grouped = groupByManufacturer(report.items)

  const summaryData: any[][] = [
    ['Order Summary by Manufacturer'],
    [],
    ['Manufacturer', 'Items', 'Categories', 'Est. Cost', '% of Total'],
  ]

  for (const [mfg, items] of grouped) {
    const mfgCost = items.reduce((s, i) => {
      const q = adjustments[i.id] ?? i.suggestedOrderQty
      return s + Math.round(q * i.unitCost * 100) / 100
    }, 0)
    const categories = new Set(items.map(i => i.category))
    const pct = totalCost > 0 ? mfgCost / totalCost : 0

    summaryData.push([mfg, items.length, categories.size, mfgCost, pct])
  }

  summaryData.push(['TOTAL', report.items.length, '', totalCost, 1])

  const ws2 = XLSX.utils.aoa_to_sheet(summaryData)
  ws2['!cols'] = [
    { wch: 26 }, { wch: 10 }, { wch: 12 }, { wch: 16 }, { wch: 12 },
  ]

  // Format currency and percentage
  for (let r = 3; r < summaryData.length; r++) {
    const costCell = XLSX.utils.encode_cell({ r, c: 3 })
    const pctCell = XLSX.utils.encode_cell({ r, c: 4 })
    if (ws2[costCell]) ws2[costCell].z = '$#,##0.00'
    if (ws2[pctCell]) ws2[pctCell].z = '0.0%'
  }

  XLSX.utils.book_append_sheet(wb, ws2, 'Manufacturer Summary')

  // ─── SHEET 3: PRIORITY BREAKDOWN ───
  const priorities = ['critical', 'urgent', 'normal', 'optional'] as const

  const priorityData: any[][] = [
    ['Items by Priority Level'],
    [],
    ['Priority', 'Item Count', 'Est. Cost', 'Avg Lead Time'],
  ]

  for (const pri of priorities) {
    const priItems = report.items.filter(i => i.priority === pri)
    if (priItems.length === 0) continue
    const priCost = priItems.reduce((s, i) => {
      const q = adjustments[i.id] ?? i.suggestedOrderQty
      return s + Math.round(q * i.unitCost * 100) / 100
    }, 0)
    const avgLead = priItems.reduce((s, i) => s + i.leadTimeDays, 0) / priItems.length

    priorityData.push([
      pri.toUpperCase(),
      priItems.length,
      priCost,
      `${avgLead.toFixed(1)} days`,
    ])
  }

  const ws3 = XLSX.utils.aoa_to_sheet(priorityData)
  ws3['!cols'] = [
    { wch: 14 }, { wch: 12 }, { wch: 16 }, { wch: 14 },
  ]

  for (let r = 3; r < priorityData.length; r++) {
    const costCell = XLSX.utils.encode_cell({ r, c: 2 })
    if (ws3[costCell]) ws3[costCell].z = '$#,##0.00'
  }

  XLSX.utils.book_append_sheet(wb, ws3, 'Priority Breakdown')

  // Generate blob
  const wbOut = XLSX.write(wb, { bookType: 'xlsx', type: 'array' })
  return new Blob([wbOut], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
}
