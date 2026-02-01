// Count Sheet Generator
// Creates printable count sheets that can be filled in and scanned back

export interface CountSheetProduct {
  id: string
  sku: string
  name: string
  category: string
  location?: string
  unit_type: string
  expected_quantity: number
  barcode?: string
}

export interface CountSheetOptions {
  title: string
  countId: string
  countDate: string
  countType: 'full' | 'spot_check' | 'cycle' | 'category' | 'custom'
  companyName?: string
  countedBy?: string
  includeExpected: boolean // Whether to show expected quantities
  groupByCategory: boolean
  includeBarcode: boolean
  products: CountSheetProduct[]
}

export interface CountSheetData {
  html: string
  productCount: number
  categories: string[]
}

// Generate a printable count sheet HTML
export function generateCountSheetHTML(options: CountSheetOptions): CountSheetData {
  const {
    title,
    countId,
    countDate,
    countType,
    companyName,
    countedBy,
    includeExpected,
    groupByCategory,
    includeBarcode,
    products
  } = options

  // Group products by category if needed
  const groupedProducts = groupByCategory
    ? groupProductsByCategory(products)
    : { 'All Items': products }

  const categories = Object.keys(groupedProducts)

  // Generate the HTML
  const html = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title}</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: Arial, sans-serif;
      font-size: 11px;
      line-height: 1.4;
      color: #000;
      background: #fff;
    }

    .page {
      width: 8.5in;
      min-height: 11in;
      padding: 0.5in;
      margin: 0 auto;
      page-break-after: always;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      border-bottom: 2px solid #333;
      padding-bottom: 10px;
      margin-bottom: 15px;
    }

    .header-left h1 {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .header-left p {
      font-size: 11px;
      color: #666;
    }

    .header-right {
      text-align: right;
    }

    .count-id {
      font-size: 14px;
      font-weight: bold;
      font-family: monospace;
      background: #f0f0f0;
      padding: 5px 10px;
      border: 1px solid #ccc;
      margin-bottom: 5px;
    }

    .meta-box {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 15px;
      margin-bottom: 15px;
      padding: 10px;
      background: #f9f9f9;
      border: 1px solid #ddd;
    }

    .meta-field label {
      display: block;
      font-size: 9px;
      text-transform: uppercase;
      color: #666;
      margin-bottom: 3px;
    }

    .meta-field .value {
      font-size: 12px;
      font-weight: bold;
    }

    .meta-field .input-line {
      border-bottom: 1px solid #333;
      height: 20px;
      min-width: 100px;
    }

    .category-header {
      background: #333;
      color: #fff;
      padding: 8px 12px;
      font-size: 13px;
      font-weight: bold;
      margin-top: 15px;
      margin-bottom: 0;
    }

    .count-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 15px;
    }

    .count-table th {
      background: #e0e0e0;
      padding: 8px 6px;
      text-align: left;
      font-size: 10px;
      text-transform: uppercase;
      border: 1px solid #ccc;
    }

    .count-table td {
      padding: 6px;
      border: 1px solid #ccc;
      vertical-align: middle;
    }

    .count-table tr:nth-child(even) {
      background: #f9f9f9;
    }

    .sku-cell {
      font-family: monospace;
      font-size: 10px;
      white-space: nowrap;
    }

    .name-cell {
      font-weight: 500;
    }

    .expected-cell {
      text-align: center;
      font-weight: bold;
      background: #e8f4e8 !important;
      width: 70px;
    }

    .count-cell {
      text-align: center;
      width: 80px;
      background: #fff9e6 !important;
    }

    .count-input {
      width: 100%;
      height: 28px;
      border: 2px solid #999;
      background: #fffef0;
      text-align: center;
      font-size: 14px;
      font-weight: bold;
    }

    .variance-cell {
      text-align: center;
      width: 70px;
    }

    .notes-cell {
      width: 120px;
    }

    .notes-input {
      width: 100%;
      height: 28px;
      border: 1px solid #ccc;
    }

    .barcode-cell {
      font-family: 'Libre Barcode 39', monospace;
      font-size: 24px;
      text-align: center;
    }

    .footer {
      margin-top: 20px;
      padding-top: 15px;
      border-top: 1px solid #ccc;
    }

    .signature-section {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 30px;
      margin-top: 20px;
    }

    .signature-box {
      padding: 10px;
      border: 1px solid #ddd;
    }

    .signature-box label {
      display: block;
      font-size: 9px;
      text-transform: uppercase;
      color: #666;
      margin-bottom: 5px;
    }

    .signature-line {
      border-bottom: 1px solid #333;
      height: 30px;
      margin-bottom: 5px;
    }

    .instructions {
      background: #f0f7ff;
      border: 1px solid #b0d4ff;
      padding: 10px;
      margin-bottom: 15px;
      font-size: 10px;
    }

    .instructions h3 {
      font-size: 11px;
      margin-bottom: 5px;
    }

    .instructions ul {
      margin-left: 15px;
    }

    .scan-marker {
      position: absolute;
      width: 20px;
      height: 20px;
      border: 3px solid #000;
    }

    .scan-marker.top-left { top: 0.3in; left: 0.3in; border-right: none; border-bottom: none; }
    .scan-marker.top-right { top: 0.3in; right: 0.3in; border-left: none; border-bottom: none; }
    .scan-marker.bottom-left { bottom: 0.3in; left: 0.3in; border-right: none; border-top: none; }
    .scan-marker.bottom-right { bottom: 0.3in; right: 0.3in; border-left: none; border-top: none; }

    .page-number {
      text-align: center;
      font-size: 10px;
      color: #666;
      margin-top: 10px;
    }

    @media print {
      body { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
      .page { page-break-after: always; }
      .no-print { display: none; }
    }
  </style>
</head>
<body>
  <div class="page" style="position: relative;">
    <!-- Scan alignment markers -->
    <div class="scan-marker top-left"></div>
    <div class="scan-marker top-right"></div>
    <div class="scan-marker bottom-left"></div>
    <div class="scan-marker bottom-right"></div>

    <!-- Header -->
    <div class="header">
      <div class="header-left">
        <h1>📋 Physical Inventory Count Sheet</h1>
        <p>${companyName || 'RefinishAI'} • ${countType.replace('_', ' ').toUpperCase()}</p>
      </div>
      <div class="header-right">
        <div class="count-id">ID: ${countId.substring(0, 8).toUpperCase()}</div>
        <p style="font-size: 10px; color: #666;">Scan this code to import</p>
      </div>
    </div>

    <!-- Instructions -->
    <div class="instructions">
      <h3>📝 Instructions</h3>
      <ul>
        <li>Write the counted quantity clearly in the yellow "COUNT" column</li>
        <li>Use BLOCK numbers (0-9) for best scan accuracy</li>
        <li>Add notes for any discrepancies or damaged items</li>
        <li>When complete, scan this sheet to import counts automatically</li>
      </ul>
    </div>

    <!-- Meta Information -->
    <div class="meta-box">
      <div class="meta-field">
        <label>Count Date</label>
        <div class="value">${countDate}</div>
      </div>
      <div class="meta-field">
        <label>Counted By</label>
        <div class="input-line">${countedBy || ''}</div>
      </div>
      <div class="meta-field">
        <label>Total Items</label>
        <div class="value">${products.length}</div>
      </div>
    </div>

    <!-- Products by Category -->
    ${Object.entries(groupedProducts).map(([category, categoryProducts]) => `
      ${groupByCategory ? `<div class="category-header">📦 ${category} (${categoryProducts.length} items)</div>` : ''}
      <table class="count-table">
        <thead>
          <tr>
            <th style="width: 80px;">SKU</th>
            <th>Product Name</th>
            <th style="width: 70px;">Location</th>
            <th style="width: 50px;">Unit</th>
            ${includeExpected ? '<th style="width: 70px;">Expected</th>' : ''}
            <th style="width: 80px;">COUNT</th>
            <th style="width: 70px;">Variance</th>
            <th style="width: 120px;">Notes</th>
          </tr>
        </thead>
        <tbody>
          ${categoryProducts.map((product, idx) => `
            <tr data-product-id="${product.id}" data-row="${idx}">
              <td class="sku-cell">${product.sku}</td>
              <td class="name-cell">${product.name}</td>
              <td>${product.location || '—'}</td>
              <td>${product.unit_type}</td>
              ${includeExpected ? `<td class="expected-cell">${product.expected_quantity}</td>` : ''}
              <td class="count-cell">
                <div class="count-input" data-field="count" data-sku="${product.sku}"></div>
              </td>
              <td class="variance-cell"></td>
              <td class="notes-cell">
                <div class="notes-input" data-field="notes" data-sku="${product.sku}"></div>
              </td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    `).join('')}

    <!-- Signature Section -->
    <div class="footer">
      <div class="signature-section">
        <div class="signature-box">
          <label>Counted By (Signature)</label>
          <div class="signature-line"></div>
          <p style="font-size: 9px; color: #666;">Print Name: _______________________</p>
        </div>
        <div class="signature-box">
          <label>Verified By (Manager)</label>
          <div class="signature-line"></div>
          <p style="font-size: 9px; color: #666;">Print Name: _______________________</p>
        </div>
      </div>
    </div>

    <div class="page-number">
      Page 1 of 1 • Count ID: ${countId.substring(0, 8).toUpperCase()} • Generated: ${new Date().toLocaleString()}
    </div>
  </div>

  <script>
    // Print automatically when opened
    // window.print();
  </script>
</body>
</html>
`

  return {
    html,
    productCount: products.length,
    categories
  }
}

// Helper to group products by category
function groupProductsByCategory(products: CountSheetProduct[]): Record<string, CountSheetProduct[]> {
  return products.reduce((acc, product) => {
    const category = product.category || 'Uncategorized'
    if (!acc[category]) acc[category] = []
    acc[category].push(product)
    return acc
  }, {} as Record<string, CountSheetProduct[]>)
}

// Generate a simplified count sheet for specific items
export function generateQuickCountSheet(
  products: CountSheetProduct[],
  countId: string,
  title: string = 'Quick Count'
): CountSheetData {
  return generateCountSheetHTML({
    title,
    countId,
    countDate: new Date().toLocaleDateString(),
    countType: 'custom',
    includeExpected: true,
    groupByCategory: true,
    includeBarcode: false,
    products
  })
}
