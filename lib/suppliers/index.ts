// Paint Supplier Integration Types and Utilities

export interface SupplierConfig {
  id: string
  name: string
  code: string
  apiEndpoint?: string
  apiKey?: string
  enabled: boolean
  isAllowed?: boolean  // Whether company has access to this vendor
  isPrimary?: boolean  // Whether this is the company's primary vendor
  discount?: number    // Company-specific discount percentage
  lastSync?: string
  logoUrl?: string
}

export interface SupplierProduct {
  supplierCode: string
  supplierSku: string
  name: string
  category: string
  unitType: string
  unitCost: number
  msrp?: number
  inStock?: boolean
  leadTimeDays?: number
  colorCode?: string
  lastUpdated: string
}

export interface PriceQuote {
  supplierId: string
  productSku: string
  quantity: number
  unitPrice: number
  totalPrice: number
  validUntil?: string
  discountApplied?: number
}

export interface SupplierOrder {
  supplierId: string
  items: {
    sku: string
    quantity: number
    unitPrice: number
  }[]
  orderTotal: number
  estimatedDelivery?: string
}

// Supplier Codes
export const SUPPLIERS = {
  PPG: 'PPG',
  AXALTA: 'AXALTA',
  SHERWIN_WILLIAMS: 'SHERWIN_WILLIAMS',
  BASF: 'BASF',
  DUPONT: 'DUPONT',
  '3M': '3M',
  NORTON: 'NORTON',
  SATA: 'SATA',
  DEVILBISS: 'DEVILBISS',
  GENERIC: 'GENERIC',
  CUSTOM: 'CUSTOM'
} as const

export type SupplierCode = typeof SUPPLIERS[keyof typeof SUPPLIERS]

// Supplier Info
export const SUPPLIER_INFO: Record<SupplierCode, { name: string; website: string; description: string }> = {
  PPG: {
    name: 'PPG Industries',
    website: 'https://www.ppgrefinish.com',
    description: 'Global supplier of paints, coatings, and specialty materials'
  },
  AXALTA: {
    name: 'Axalta Coating Systems',
    website: 'https://www.axalta.com',
    description: 'Leading global coatings company for light and commercial vehicles'
  },
  SHERWIN_WILLIAMS: {
    name: 'Sherwin Williams Automotive',
    website: 'https://www.sherwin-williams.com/automotive',
    description: 'Premier automotive refinish coatings and color tools'
  },
  BASF: {
    name: 'BASF Refinish',
    website: 'https://www.basf-coatings.com',
    description: 'Innovative automotive refinish solutions'
  },
  DUPONT: {
    name: 'DuPont Performance Coatings',
    website: 'https://www.dupont.com',
    description: 'High-performance refinish products'
  },
  '3M': {
    name: '3M Automotive',
    website: 'https://www.3m.com/automotive',
    description: 'Abrasives, tapes, and specialty automotive products'
  },
  NORTON: {
    name: 'Norton Abrasives',
    website: 'https://www.nortonabrasives.com',
    description: 'Professional grade abrasives and finishing products'
  },
  SATA: {
    name: 'SATA GmbH',
    website: 'https://www.sata.com',
    description: 'Premium spray guns and finishing equipment'
  },
  DEVILBISS: {
    name: 'DeVilbiss',
    website: 'https://www.devilbissautomotive.com',
    description: 'Spray finishing equipment and accessories'
  },
  GENERIC: {
    name: 'Generic/Other',
    website: '',
    description: 'Generic or unbranded products'
  },
  CUSTOM: {
    name: 'Custom/Other',
    website: '',
    description: 'Custom or local paint supplier'
  }
}

// Product Categories
export const PRODUCT_CATEGORIES = [
  'Basecoat',
  'Clear Coat',
  'Primer',
  'Primer Surfacer',
  'Sealer',
  'Reducer',
  'Hardener',
  'Activator',
  'Adhesion Promoter',
  'Flex Agent',
  'Toner',
  'Blender',
  'Body Filler',
  'Putty',
  'Masking Materials',
  'Abrasives',
  'Polish/Compound',
  'Prep Solvent',
  'Wax & Grease Remover'
] as const

// Unit Types
export const UNIT_TYPES = [
  'Gallon',
  'Quart',
  'Pint',
  'Liter',
  'Milliliter',
  'Ounce',
  'Each',
  'Box',
  'Case',
  'Roll'
] as const

// Helper to format supplier product for database
export function formatProductForDB(product: SupplierProduct, companyId?: string) {
  return {
    sku: `${product.supplierCode}-${product.supplierSku}`,
    name: product.name,
    category: product.category,
    unit_type: product.unitType,
    unit_cost: product.unitCost,
    supplier: SUPPLIER_INFO[product.supplierCode as SupplierCode]?.name || product.supplierCode,
    lead_time_days: product.leadTimeDays || 7,
    coverage_sqft_per_unit: getCoverageEstimate(product.category, product.unitType),
    waste_factor: 0.15,
    company_id: companyId
  }
}

// Estimate coverage based on product type
function getCoverageEstimate(category: string, unitType: string): number {
  const baseGallon = {
    'Basecoat': 400,
    'Clear Coat': 500,
    'Primer': 350,
    'Primer Surfacer': 300,
    'Sealer': 400,
    'Reducer': 0,
    'Hardener': 0,
    'Activator': 0
  }[category] || 100

  // Adjust for unit type
  const multipliers: Record<string, number> = {
    'Gallon': 1,
    'Quart': 0.25,
    'Pint': 0.125,
    'Liter': 0.264,
    'Each': 0
  }

  return Math.round(baseGallon * (multipliers[unitType] || 1))
}
