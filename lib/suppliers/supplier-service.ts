// Paint Supplier API Service
// Handles integration with major paint suppliers

import {
  SupplierConfig,
  SupplierProduct,
  PriceQuote,
  SUPPLIERS,
  SupplierCode,
  SUPPLIER_INFO
} from './index'

// Base Supplier API Interface
export interface SupplierAPI {
  getProducts(category?: string): Promise<SupplierProduct[]>
  searchProducts(query: string): Promise<SupplierProduct[]>
  getProductBySku(sku: string): Promise<SupplierProduct | null>
  getPriceQuote(sku: string, quantity: number): Promise<PriceQuote>
  checkInventory(sku: string): Promise<{ available: boolean; quantity: number }>
}

// PPG API Implementation
export class PPGSupplierAPI implements SupplierAPI {
  private apiKey: string
  private baseUrl: string

  constructor(config: SupplierConfig) {
    this.apiKey = config.apiKey || ''
    this.baseUrl = config.apiEndpoint || 'https://api.ppgrefinish.com/v1'
  }

  async getProducts(category?: string): Promise<SupplierProduct[]> {
    // PPG Deltron, Envirobase, Global Refinish System products
    const ppgProducts: SupplierProduct[] = [
      {
        supplierCode: SUPPLIERS.PPG,
        supplierSku: 'DBC-9700',
        name: 'Deltron Basecoat Black',
        category: 'Basecoat',
        unitType: 'Gallon',
        unitCost: 285.00,
        msrp: 325.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.PPG,
        supplierSku: 'DCU-2021',
        name: 'Deltron Universal Clear',
        category: 'Clear Coat',
        unitType: 'Gallon',
        unitCost: 195.00,
        msrp: 225.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.PPG,
        supplierSku: 'DP40LF',
        name: 'DP40LF Epoxy Primer',
        category: 'Primer',
        unitType: 'Gallon',
        unitCost: 165.00,
        msrp: 189.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.PPG,
        supplierSku: 'K36',
        name: 'Concept 2K Urethane Primer',
        category: 'Primer Surfacer',
        unitType: 'Gallon',
        unitCost: 145.00,
        msrp: 169.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.PPG,
        supplierSku: 'DT870',
        name: 'DT870 Reducer Medium',
        category: 'Reducer',
        unitType: 'Gallon',
        unitCost: 55.00,
        msrp: 65.00,
        inStock: true,
        leadTimeDays: 2
      },
      {
        supplierCode: SUPPLIERS.PPG,
        supplierSku: 'DCH3085',
        name: 'DCH3085 Hardener',
        category: 'Hardener',
        unitType: 'Quart',
        unitCost: 75.00,
        msrp: 89.00,
        inStock: true,
        leadTimeDays: 2
      },
      {
        supplierCode: SUPPLIERS.PPG,
        supplierSku: 'EBCWT',
        name: 'Envirobase High Performance White',
        category: 'Basecoat',
        unitType: 'Gallon',
        unitCost: 310.00,
        msrp: 355.00,
        inStock: true,
        leadTimeDays: 5
      }
    ].map(p => ({ ...p, lastUpdated: new Date().toISOString() }))

    if (category) {
      return ppgProducts.filter(p => p.category === category)
    }
    return ppgProducts
  }

  async searchProducts(query: string): Promise<SupplierProduct[]> {
    const products = await this.getProducts()
    const lowerQuery = query.toLowerCase()
    return products.filter(p =>
      p.name.toLowerCase().includes(lowerQuery) ||
      p.supplierSku.toLowerCase().includes(lowerQuery)
    )
  }

  async getProductBySku(sku: string): Promise<SupplierProduct | null> {
    const products = await this.getProducts()
    return products.find(p => p.supplierSku === sku) || null
  }

  async getPriceQuote(sku: string, quantity: number): Promise<PriceQuote> {
    const product = await this.getProductBySku(sku)
    if (!product) throw new Error('Product not found')

    // Volume discount simulation
    let discount = 0
    if (quantity >= 12) discount = 0.15
    else if (quantity >= 6) discount = 0.10
    else if (quantity >= 3) discount = 0.05

    const unitPrice = product.unitCost * (1 - discount)

    return {
      supplierId: SUPPLIERS.PPG,
      productSku: sku,
      quantity,
      unitPrice,
      totalPrice: unitPrice * quantity,
      validUntil: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString(),
      discountApplied: discount * 100
    }
  }

  async checkInventory(sku: string): Promise<{ available: boolean; quantity: number }> {
    const product = await this.getProductBySku(sku)
    return {
      available: product?.inStock || false,
      quantity: product?.inStock ? Math.floor(Math.random() * 50) + 10 : 0
    }
  }
}

// Axalta API Implementation
export class AxaltaSupplierAPI implements SupplierAPI {
  private apiKey: string
  private baseUrl: string

  constructor(config: SupplierConfig) {
    this.apiKey = config.apiKey || ''
    this.baseUrl = config.apiEndpoint || 'https://api.axalta.com/v1'
  }

  async getProducts(category?: string): Promise<SupplierProduct[]> {
    // Axalta Cromax, Spies Hecker, Standox products
    const axaltaProducts: SupplierProduct[] = [
      {
        supplierCode: SUPPLIERS.AXALTA,
        supplierSku: 'AM1',
        name: 'Cromax Pro Basecoat Binder',
        category: 'Basecoat',
        unitType: 'Gallon',
        unitCost: 275.00,
        msrp: 315.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.AXALTA,
        supplierSku: 'NS2501',
        name: 'Cromax Pro Clear NS2501',
        category: 'Clear Coat',
        unitType: 'Gallon',
        unitCost: 205.00,
        msrp: 239.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.AXALTA,
        supplierSku: '3011S',
        name: 'ChromaPremier Pro Primer',
        category: 'Primer',
        unitType: 'Gallon',
        unitCost: 155.00,
        msrp: 179.00,
        inStock: true,
        leadTimeDays: 4
      },
      {
        supplierCode: SUPPLIERS.AXALTA,
        supplierSku: 'SH8700',
        name: 'Spies Hecker HS Plus Clear',
        category: 'Clear Coat',
        unitType: 'Liter',
        unitCost: 85.00,
        msrp: 99.00,
        inStock: true,
        leadTimeDays: 5
      },
      {
        supplierCode: SUPPLIERS.AXALTA,
        supplierSku: 'AU130',
        name: 'Cromax Pro Reducer Medium',
        category: 'Reducer',
        unitType: 'Gallon',
        unitCost: 52.00,
        msrp: 62.00,
        inStock: true,
        leadTimeDays: 2
      },
      {
        supplierCode: SUPPLIERS.AXALTA,
        supplierSku: 'AX2520',
        name: 'Cromax Pro Hardener',
        category: 'Hardener',
        unitType: 'Quart',
        unitCost: 72.00,
        msrp: 85.00,
        inStock: true,
        leadTimeDays: 2
      }
    ].map(p => ({ ...p, lastUpdated: new Date().toISOString() }))

    if (category) {
      return axaltaProducts.filter(p => p.category === category)
    }
    return axaltaProducts
  }

  async searchProducts(query: string): Promise<SupplierProduct[]> {
    const products = await this.getProducts()
    const lowerQuery = query.toLowerCase()
    return products.filter(p =>
      p.name.toLowerCase().includes(lowerQuery) ||
      p.supplierSku.toLowerCase().includes(lowerQuery)
    )
  }

  async getProductBySku(sku: string): Promise<SupplierProduct | null> {
    const products = await this.getProducts()
    return products.find(p => p.supplierSku === sku) || null
  }

  async getPriceQuote(sku: string, quantity: number): Promise<PriceQuote> {
    const product = await this.getProductBySku(sku)
    if (!product) throw new Error('Product not found')

    let discount = 0
    if (quantity >= 10) discount = 0.12
    else if (quantity >= 5) discount = 0.08
    else if (quantity >= 2) discount = 0.04

    const unitPrice = product.unitCost * (1 - discount)

    return {
      supplierId: SUPPLIERS.AXALTA,
      productSku: sku,
      quantity,
      unitPrice,
      totalPrice: unitPrice * quantity,
      validUntil: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000).toISOString(),
      discountApplied: discount * 100
    }
  }

  async checkInventory(sku: string): Promise<{ available: boolean; quantity: number }> {
    const product = await this.getProductBySku(sku)
    return {
      available: product?.inStock || false,
      quantity: product?.inStock ? Math.floor(Math.random() * 40) + 5 : 0
    }
  }
}

// Sherwin Williams API Implementation
export class SherwinWilliamsSupplierAPI implements SupplierAPI {
  private apiKey: string
  private baseUrl: string

  constructor(config: SupplierConfig) {
    this.apiKey = config.apiKey || ''
    this.baseUrl = config.apiEndpoint || 'https://api.sherwin-automotive.com/v1'
  }

  async getProducts(category?: string): Promise<SupplierProduct[]> {
    // Sherwin Williams AWX, Ultra 7000, Planet Color products
    const swProducts: SupplierProduct[] = [
      {
        supplierCode: SUPPLIERS.SHERWIN_WILLIAMS,
        supplierSku: 'AWX-100',
        name: 'AWX Waterborne Basecoat',
        category: 'Basecoat',
        unitType: 'Gallon',
        unitCost: 265.00,
        msrp: 305.00,
        inStock: true,
        leadTimeDays: 4
      },
      {
        supplierCode: SUPPLIERS.SHERWIN_WILLIAMS,
        supplierSku: 'U7000',
        name: 'Ultra 7000 Clearcoat',
        category: 'Clear Coat',
        unitType: 'Gallon',
        unitCost: 185.00,
        msrp: 215.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.SHERWIN_WILLIAMS,
        supplierSku: 'PS303',
        name: 'Planet Color 2K Primer Surfacer',
        category: 'Primer Surfacer',
        unitType: 'Gallon',
        unitCost: 135.00,
        msrp: 159.00,
        inStock: true,
        leadTimeDays: 3
      },
      {
        supplierCode: SUPPLIERS.SHERWIN_WILLIAMS,
        supplierSku: 'EP407',
        name: 'Epoxy Primer DTM',
        category: 'Primer',
        unitType: 'Gallon',
        unitCost: 145.00,
        msrp: 169.00,
        inStock: true,
        leadTimeDays: 4
      },
      {
        supplierCode: SUPPLIERS.SHERWIN_WILLIAMS,
        supplierSku: 'R760',
        name: 'Premium Reducer Medium',
        category: 'Reducer',
        unitType: 'Gallon',
        unitCost: 48.00,
        msrp: 58.00,
        inStock: true,
        leadTimeDays: 2
      },
      {
        supplierCode: SUPPLIERS.SHERWIN_WILLIAMS,
        supplierSku: 'H125',
        name: 'Ultra Clear Hardener',
        category: 'Hardener',
        unitType: 'Quart',
        unitCost: 68.00,
        msrp: 79.00,
        inStock: true,
        leadTimeDays: 2
      }
    ].map(p => ({ ...p, lastUpdated: new Date().toISOString() }))

    if (category) {
      return swProducts.filter(p => p.category === category)
    }
    return swProducts
  }

  async searchProducts(query: string): Promise<SupplierProduct[]> {
    const products = await this.getProducts()
    const lowerQuery = query.toLowerCase()
    return products.filter(p =>
      p.name.toLowerCase().includes(lowerQuery) ||
      p.supplierSku.toLowerCase().includes(lowerQuery)
    )
  }

  async getProductBySku(sku: string): Promise<SupplierProduct | null> {
    const products = await this.getProducts()
    return products.find(p => p.supplierSku === sku) || null
  }

  async getPriceQuote(sku: string, quantity: number): Promise<PriceQuote> {
    const product = await this.getProductBySku(sku)
    if (!product) throw new Error('Product not found')

    let discount = 0
    if (quantity >= 8) discount = 0.10
    else if (quantity >= 4) discount = 0.06
    else if (quantity >= 2) discount = 0.03

    const unitPrice = product.unitCost * (1 - discount)

    return {
      supplierId: SUPPLIERS.SHERWIN_WILLIAMS,
      productSku: sku,
      quantity,
      unitPrice,
      totalPrice: unitPrice * quantity,
      validUntil: new Date(Date.now() + 10 * 24 * 60 * 60 * 1000).toISOString(),
      discountApplied: discount * 100
    }
  }

  async checkInventory(sku: string): Promise<{ available: boolean; quantity: number }> {
    const product = await this.getProductBySku(sku)
    return {
      available: product?.inStock || false,
      quantity: product?.inStock ? Math.floor(Math.random() * 60) + 10 : 0
    }
  }
}

// Supplier Service Factory
export function getSupplierAPI(config: SupplierConfig): SupplierAPI | null {
  switch (config.code) {
    case SUPPLIERS.PPG:
      return new PPGSupplierAPI(config)
    case SUPPLIERS.AXALTA:
      return new AxaltaSupplierAPI(config)
    case SUPPLIERS.SHERWIN_WILLIAMS:
      return new SherwinWilliamsSupplierAPI(config)
    default:
      return null
  }
}

// Compare prices across suppliers
export async function comparePrices(
  sku: string,
  quantity: number,
  suppliers: SupplierConfig[]
): Promise<PriceQuote[]> {
  const quotes: PriceQuote[] = []

  for (const config of suppliers) {
    if (!config.enabled) continue

    const api = getSupplierAPI(config)
    if (!api) continue

    try {
      const products = await api.searchProducts(sku)
      if (products.length > 0) {
        const quote = await api.getPriceQuote(products[0].supplierSku, quantity)
        quotes.push(quote)
      }
    } catch (error) {
      console.error(`Error getting quote from ${config.name}:`, error)
    }
  }

  // Sort by total price
  return quotes.sort((a, b) => a.totalPrice - b.totalPrice)
}

// Get all products from all enabled suppliers
export async function getAllSupplierProducts(
  suppliers: SupplierConfig[],
  category?: string
): Promise<SupplierProduct[]> {
  const allProducts: SupplierProduct[] = []

  for (const config of suppliers) {
    if (!config.enabled) continue

    const api = getSupplierAPI(config)
    if (!api) continue

    try {
      const products = await api.getProducts(category)
      allProducts.push(...products)
    } catch (error) {
      console.error(`Error getting products from ${config.name}:`, error)
    }
  }

  return allProducts
}
