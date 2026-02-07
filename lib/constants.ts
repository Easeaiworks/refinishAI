// Shared product categories used across the application
export const PRODUCT_CATEGORIES = [
  'Paint',
  'Primer',
  'Clear Coat',
  'Reducer',
  'Hardener',
  'Basecoat',
  'Base Coat',
  'Supplies',
  'Abrasives',
  'Consumables',
  'Safety',
] as const

export type ProductCategory = typeof PRODUCT_CATEGORIES[number]
