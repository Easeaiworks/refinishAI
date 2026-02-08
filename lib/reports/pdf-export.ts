// Client-side PDF Export for Reorder Reports
// Uses jspdf + jspdf-autotable
// Layout: Manufacturer > Category > Items with priority colors

import jsPDF from 'jspdf'
import autoTable from 'jspdf-autotable'
import type { ReorderReport, ReorderItem } from './reorder-report'

interface CompanyInfo {
  name: string
  address?: string
  city?: string
  state?: string
  zip?: string
  phone?: string
}

// Group items by manufacturer > category (returns sorted arrays to avoid Map iteration issues)
type GroupedItems = Array<[string, Array<[string, ReorderItem[]]>]>

function groupItems(items: ReorderItem[]): GroupedItems {
  const grouped: Record<string, Record<string, ReorderItem[]>> = {}

  for (const item of items) {
    const mfg = item.manufacturer || item.supplierName || item.vendorCode || 'Other'
    if (!grouped[mfg]) grouped[mfg] = {}
    const cat = item.category || 'Uncategorized'
    if (!grouped[mfg][cat]) grouped[mfg][cat] = []
    grouped[mfg][cat].push(item)
  }

  return Object.entries(grouped)
    .sort((a, b) => a[0].localeCompare(b[0]))
    .map(([mfg, cats]) => [mfg, Object.entries(cats).sort((a, b) => a[0].localeCompare(b[0]))] as [string, Array<[string, ReorderItem[]]>])
}

const PRIORITY_COLORS: Record<string, { bg: number[]; text: number[] }> = {
  critical: { bg: [254, 226, 226], text: [153, 27, 27] },
  urgent: { bg: [254, 243, 199], text: [146, 64, 14] },
  normal: { bg: [209, 250, 229], text: [6, 95, 70] },
  optional: { bg: [243, 244, 246], text: [107, 114, 128] },
}

const BRAND_BLUE: [number, number, number] = [30, 64, 175]

export function generateReorderPDF(
  report: ReorderReport,
  company: CompanyInfo,
  adjustments: Record<string, number> = {}
): Blob {
  const doc = new jsPDF({ orientation: 'landscape', unit: 'pt', format: 'letter' })
  const pageWidth = doc.internal.pageSize.getWidth()
  const pageHeight = doc.internal.pageSize.getHeight()
  const margin = 36
  let y = margin

  const dateStr = new Date().toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
  const poRef = `PO-${new Date().toISOString().split('T')[0].replace(/-/g, '')}-RPT`

  // ─── HEADER ───
  doc.setFontSize(18)
  doc.setTextColor(...BRAND_BLUE)
  doc.setFont('helvetica', 'bold')
  doc.text(company.name, margin, y + 16)

  doc.setFontSize(14)
  doc.setTextColor(31, 41, 55)
  doc.text('Purchase Order Report', pageWidth - margin, y + 10, { align: 'right' })
  doc.setFontSize(8)
  doc.setTextColor(107, 114, 128)
  doc.text(`Report #: ${poRef}`, pageWidth - margin, y + 22, { align: 'right' })
  doc.text(`Generated: ${dateStr}`, pageWidth - margin, y + 32, { align: 'right' })

  y += 24
  doc.setFontSize(8)
  doc.setTextColor(107, 114, 128)
  const addr = [company.address, company.city, company.state, company.zip, company.phone].filter(Boolean).join(' | ')
  doc.text(addr, margin, y + 12)

  y += 20
  doc.setDrawColor(...BRAND_BLUE)
  doc.setLineWidth(1.5)
  doc.line(margin, y, pageWidth - margin, y)
  y += 12

  // ─── SUMMARY CARDS ───
  const cardLabels = ['TOTAL ITEMS', 'CRITICAL', 'URGENT', 'NORMAL', 'MANUFACTURERS', 'EST. TOTAL COST']
  const grouped = groupItems(report.items)
  const cardValues = [
    String(report.summary.totalItems),
    String(report.summary.criticalItems),
    String(report.summary.urgentItems),
    String(report.summary.normalItems),
    String(grouped.length),
    `$${report.summary.totalEstimatedCost.toLocaleString('en-US', { minimumFractionDigits: 2 })}`,
  ]
  const cardColors: Array<[number, number, number]> = [
    [31, 41, 55],
    [153, 27, 27],
    [146, 64, 14],
    [6, 95, 70],
    [31, 41, 55],
    [31, 41, 55],
  ]

  const cardWidth = (pageWidth - 2 * margin) / 6
  const cardHeight = 40

  doc.setFillColor(243, 244, 246)
  doc.roundedRect(margin, y, pageWidth - 2 * margin, cardHeight, 3, 3, 'F')

  for (let i = 0; i < 6; i++) {
    const cx = margin + cardWidth * i + cardWidth / 2

    doc.setFontSize(7)
    doc.setTextColor(107, 114, 128)
    doc.text(cardLabels[i], cx, y + 13, { align: 'center' })

    doc.setFontSize(14)
    doc.setFont('helvetica', 'bold')
    doc.setTextColor(...cardColors[i])
    doc.text(cardValues[i], cx, y + 30, { align: 'center' })
  }

  y += cardHeight + 16
  doc.setFont('helvetica', 'normal')

  // ─── DETAIL TABLES ───
  const columns = [
    { header: 'Priority', dataKey: 'priority' },
    { header: 'SKU', dataKey: 'sku' },
    { header: 'Item Name / Model', dataKey: 'name' },
    { header: 'Unit', dataKey: 'unit' },
    { header: 'On\nHand', dataKey: 'onHand' },
    { header: 'Reorder\nPt', dataKey: 'reorderPt' },
    { header: 'Par\nLevel', dataKey: 'parLevel' },
    { header: 'Order\nQty', dataKey: 'orderQty' },
    { header: 'Unit\nCost', dataKey: 'unitCost' },
    { header: 'Extended\nCost', dataKey: 'extCost' },
    { header: 'Lead\nTime', dataKey: 'leadTime' },
    { header: 'Days\nStock', dataKey: 'daysStock' },
  ]

  for (const [mfgName, categories] of grouped) {
    const mfgItems = categories.flatMap(([, items]) => items)
    const mfgTotal = mfgItems.reduce((s, i) => {
      const qty = adjustments[i.id] ?? i.suggestedOrderQty
      return s + qty * i.unitCost
    }, 0)

    // Check if we need a new page
    if (y > pageHeight - 120) {
      doc.addPage()
      y = margin
    }

    // Manufacturer header
    doc.setFontSize(12)
    doc.setFont('helvetica', 'bold')
    doc.setTextColor(...BRAND_BLUE)
    doc.text(mfgName, margin, y + 10)
    doc.setFontSize(8)
    doc.setTextColor(107, 114, 128)
    doc.text(
      `(${mfgItems.length} items | $${mfgTotal.toLocaleString('en-US', { minimumFractionDigits: 2 })})`,
      margin + doc.getTextWidth(mfgName + '  ') * 1.5,
      y + 10,
    )
    y += 18

    for (const [catName, items] of categories) {
      const catTotal = items.reduce((s, i) => {
        const qty = adjustments[i.id] ?? i.suggestedOrderQty
        return s + qty * i.unitCost
      }, 0)

      if (y > pageHeight - 100) {
        doc.addPage()
        y = margin
      }

      // Category header
      doc.setFontSize(9)
      doc.setFont('helvetica', 'bold')
      doc.setTextColor(31, 41, 55)
      doc.text(`  ${catName}`, margin, y + 8)
      doc.setFontSize(7)
      doc.setTextColor(156, 163, 175)
      doc.text(
        `(${items.length} items | $${catTotal.toLocaleString('en-US', { minimumFractionDigits: 2 })})`,
        margin + 10 + doc.getTextWidth(catName + '   '),
        y + 8,
      )
      y += 12

      // Prepare data rows
      const sortedItems = [...items].sort(
        (a, b) => ({ critical: 0, urgent: 1, normal: 2, optional: 3 }[a.priority] || 3) -
                   ({ critical: 0, urgent: 1, normal: 2, optional: 3 }[b.priority] || 3)
      )

      const bodyData = sortedItems.map(item => {
        const qty = adjustments[item.id] ?? item.suggestedOrderQty
        const ext = Math.round(qty * item.unitCost * 100) / 100
        return {
          priority: item.priority.toUpperCase(),
          sku: item.sku,
          name: item.productName,
          unit: item.unit,
          onHand: String(item.currentStock),
          reorderPt: String(item.reorderPoint),
          parLevel: String(item.parLevel),
          orderQty: String(qty),
          unitCost: `$${item.unitCost.toFixed(2)}`,
          extCost: `$${ext.toFixed(2)}`,
          leadTime: `${item.leadTimeDays}d`,
          daysStock: `${item.daysOfStockRemaining}d`,
          _priority: item.priority,
        }
      })

      autoTable(doc, {
        startY: y,
        columns,
        body: bodyData,
        margin: { left: margin + 8, right: margin },
        styles: {
          fontSize: 7,
          cellPadding: 3,
          lineColor: [209, 213, 219],
          lineWidth: 0.5,
          textColor: [31, 41, 55],
          valign: 'middle',
        },
        headStyles: {
          fillColor: BRAND_BLUE,
          textColor: [255, 255, 255],
          fontStyle: 'bold',
          fontSize: 6.5,
          halign: 'center',
        },
        columnStyles: {
          priority: { cellWidth: 46, halign: 'center', fontStyle: 'bold' },
          sku: { cellWidth: 58 },
          name: { cellWidth: 180 },
          unit: { cellWidth: 42, halign: 'center' },
          onHand: { cellWidth: 35, halign: 'center' },
          reorderPt: { cellWidth: 40, halign: 'center' },
          parLevel: { cellWidth: 35, halign: 'center' },
          orderQty: { cellWidth: 40, halign: 'center', fontStyle: 'bold' },
          unitCost: { cellWidth: 52, halign: 'right' },
          extCost: { cellWidth: 60, halign: 'right', fontStyle: 'bold' },
          leadTime: { cellWidth: 38, halign: 'center' },
          daysStock: { cellWidth: 38, halign: 'center' },
        },
        didParseCell: function (data: any) {
          if (data.section === 'body' && data.column.dataKey === 'priority') {
            const pri = data.row.raw._priority as string
            const colors = PRIORITY_COLORS[pri]
            if (colors) {
              data.cell.styles.fillColor = colors.bg
              data.cell.styles.textColor = colors.text
            }
          }
        },
        alternateRowStyles: {
          fillColor: [249, 250, 251],
        },
      })

      y = (doc as any).lastAutoTable.finalY + 8
    }

    y += 6
  }

  // ─── GRAND TOTAL BAR ───
  if (y > pageHeight - 80) {
    doc.addPage()
    y = margin
  }
  y += 4
  doc.setFillColor(...BRAND_BLUE)
  doc.roundedRect(margin, y, pageWidth - 2 * margin, 30, 3, 3, 'F')

  doc.setFontSize(10)
  doc.setFont('helvetica', 'bold')
  doc.setTextColor(255, 255, 255)
  doc.text(
    `GRAND TOTAL: ${report.summary.totalItems} Items from ${grouped.length} Manufacturers`,
    margin + 12,
    y + 19,
  )
  doc.setFontSize(13)
  doc.text(
    `$${report.summary.totalEstimatedCost.toLocaleString('en-US', { minimumFractionDigits: 2 })}`,
    pageWidth - margin - 12,
    y + 19,
    { align: 'right' },
  )

  y += 46

  // ─── SIGNATURE LINES ───
  if (y > pageHeight - 60) {
    doc.addPage()
    y = margin
  }
  doc.setFontSize(8)
  doc.setFont('helvetica', 'bold')
  doc.setTextColor(31, 41, 55)

  doc.text('Prepared By:', margin, y + 10)
  doc.line(margin + 65, y + 10, margin + 220, y + 10)
  doc.text('Date:', margin + 240, y + 10)
  doc.line(margin + 270, y + 10, margin + 380, y + 10)

  doc.text('Approved By:', margin, y + 30)
  doc.line(margin + 65, y + 30, margin + 220, y + 30)
  doc.text('Date:', margin + 240, y + 30)
  doc.line(margin + 270, y + 30, margin + 380, y + 30)

  // ─── FOOTER ON ALL PAGES ───
  const totalPages = doc.getNumberOfPages()
  for (let i = 1; i <= totalPages; i++) {
    doc.setPage(i)
    doc.setFontSize(7)
    doc.setFont('helvetica', 'normal')
    doc.setTextColor(107, 114, 128)
    doc.setDrawColor(209, 213, 219)
    doc.line(margin, pageHeight - 28, pageWidth - margin, pageHeight - 28)
    doc.text(`RefinishAI | ${company.name} | ${dateStr}`, margin, pageHeight - 18)
    doc.text(`Page ${i} of ${totalPages}`, pageWidth - margin, pageHeight - 18, { align: 'right' })
  }

  return doc.output('blob')
}
