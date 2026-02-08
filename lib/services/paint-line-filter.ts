// Paint Line Contract Filter
// Auto body shops contract with ONE paint manufacturer (PPG, Axalta, Sherwin-Williams, etc.)
// This filter ensures reorder reports only show the contracted paint line's products
// while allowing non-paint products (3M abrasives, consumables, etc.) from all vendors

import { SupabaseClient } from '@supabase/supabase-js'

// Paint-related product categories that are subject to contract filtering
const PAINT_CATEGORIES = [
  'paint',
  'primer',
  'clear coat',
  'basecoat',
  'base coat',
  'reducer',
  'hardener',
  'sealer',
  'toner',
  'activator',
]

export interface PaintLineInfo {
  vendorCode: string
  vendorName: string
  isPrimary: boolean
  discountPercent: number
  accountNumber: string | null
}

export interface PaintLineFilter {
  companyId: string
  primaryVendor: PaintLineInfo | null
  hasPaintLineContract: boolean
}

/**
 * Get the company's primary paint line vendor info
 */
export async function getPaintLineFilter(
  supabase: SupabaseClient,
  companyId: string
): Promise<PaintLineFilter> {
  // Query company_vendors for the primary vendor
  const { data: primaryVendors } = await supabase
    .from('company_vendors')
    .select('vendor_code, vendor_name, is_primary, discount_percent, account_number')
    .eq('company_id', companyId)
    .eq('is_primary', true)
    .eq('is_active', true)
    .limit(1)

  const primary = primaryVendors?.[0] || null

  return {
    companyId,
    primaryVendor: primary ? {
      vendorCode: primary.vendor_code,
      vendorName: primary.vendor_name,
      isPrimary: true,
      discountPercent: primary.discount_percent || 0,
      accountNumber: primary.account_number || null,
    } : null,
    hasPaintLineContract: !!primary,
  }
}

/**
 * Check if a product category is paint-related (subject to contract filtering)
 */
export function isPaintCategory(category: string): boolean {
  if (!category) return false
  return PAINT_CATEGORIES.includes(category.toLowerCase().trim())
}

/**
 * Determine if a product should be included based on paint line contract
 *
 * Rules:
 * - Paint-category products: only include if from the primary vendor
 * - Non-paint products (abrasives, consumables, safety, etc.): include from ALL vendors
 * - If no paint line contract is set: include everything (no filtering)
 */
export function shouldIncludeProduct(
  product: {
    category?: string
    vendor_code?: string | null
    manufacturer?: string | null
    supplier?: string | null
  },
  filter: PaintLineFilter
): boolean {
  // No paint line contract = no filtering
  if (!filter.hasPaintLineContract || !filter.primaryVendor) {
    return true
  }

  const category = product.category || ''

  // Non-paint products always pass through
  if (!isPaintCategory(category)) {
    return true
  }

  // Paint products: must match primary vendor
  const primaryCode = filter.primaryVendor.vendorCode.toLowerCase()
  const primaryName = filter.primaryVendor.vendorName.toLowerCase()

  // Check vendor_code field
  if (product.vendor_code && product.vendor_code.toLowerCase() === primaryCode) {
    return true
  }

  // Check manufacturer field
  if (product.manufacturer) {
    const mfg = product.manufacturer.toLowerCase()
    if (mfg === primaryCode || mfg === primaryName || mfg.includes(primaryName) || primaryName.includes(mfg)) {
      return true
    }
  }

  // Check legacy supplier field
  if (product.supplier) {
    const sup = product.supplier.toLowerCase()
    if (sup === primaryCode || sup === primaryName || sup.includes(primaryName) || primaryName.includes(sup)) {
      return true
    }
  }

  // Paint product from a non-primary vendor — exclude
  return false
}

/**
 * Get all paint manufacturers from vendor catalog
 * (for the company settings paint line selector)
 */
export async function getPaintManufacturers(
  supabase: SupabaseClient
): Promise<Array<{ code: string; name: string }>> {
  const { data: vendors } = await supabase
    .from('vendor_catalog')
    .select('code, name, product_categories')
    .eq('is_active', true)
    .order('name')

  if (!vendors) return []

  // Filter to vendors that carry paint products
  return vendors.filter(v => {
    const cats = v.product_categories || []
    return cats.some((c: string) =>
      ['Paint', 'Primer', 'Clear Coat', 'Basecoat'].includes(c)
    )
  }).map(v => ({ code: v.code, name: v.name }))
}
