// Insurance Company Labor Rate System
// Manages labor rates per insurance company for accurate cost calculations

import { SupabaseClient } from '@supabase/supabase-js'

// Types
export interface InsuranceCompany {
  id: string
  name: string
  code: string | null
  phone: string | null
  email: string | null
  website: string | null
  claims_portal_url: string | null
  notes: string | null
  is_active: boolean
  created_at: string
  updated_at: string
}

export interface LaborRateType {
  id: string
  code: string
  name: string
  description: string | null
  sort_order: number
  is_active: boolean
}

export interface CompanyInsuranceRate {
  id: string
  company_id: string
  insurance_company_id: string
  is_drp: boolean
  drp_code: string | null
  account_number: string | null
  contact_name: string | null
  contact_phone: string | null
  contact_email: string | null
  notes: string | null
  is_active: boolean
  created_at: string
  updated_at: string
  // Joined fields
  insurance_company?: InsuranceCompany
  rates?: InsuranceLaborRate[]
}

export interface InsuranceLaborRate {
  id: string
  company_insurance_id: string
  labor_rate_type_id: string
  hourly_rate: number
  effective_date: string
  expiration_date: string | null
  notes: string | null
  created_at: string
  updated_at: string
  // Joined fields
  labor_rate_type?: LaborRateType
}

export interface LaborCostCalculation {
  total_labor_cost: number
  body_cost: number
  refinish_cost: number
  mechanical_cost: number
  structural_cost: number
  aluminum_cost: number
  glass_cost: number
}

export interface LaborHours {
  body_labor_hours?: number
  refinish_labor_hours?: number
  mechanical_labor_hours?: number
  structural_labor_hours?: number
  aluminum_labor_hours?: number
  glass_labor_hours?: number
}

// Labor Rate Service Class
export class LaborRateService {
  private supabase: SupabaseClient

  constructor(supabase: SupabaseClient) {
    this.supabase = supabase
  }

  // === Insurance Companies ===

  async getInsuranceCompanies(activeOnly: boolean = true): Promise<InsuranceCompany[]> {
    let query = this.supabase
      .from('insurance_companies')
      .select('*')
      .order('name')

    if (activeOnly) {
      query = query.eq('is_active', true)
    }

    const { data, error } = await query
    if (error) throw error
    return data || []
  }

  async getInsuranceCompany(id: string): Promise<InsuranceCompany | null> {
    const { data, error } = await this.supabase
      .from('insurance_companies')
      .select('*')
      .eq('id', id)
      .single()

    if (error) throw error
    return data
  }

  async createInsuranceCompany(company: Partial<InsuranceCompany>): Promise<InsuranceCompany> {
    const { data, error } = await this.supabase
      .from('insurance_companies')
      .insert(company)
      .select()
      .single()

    if (error) throw error
    return data
  }

  async updateInsuranceCompany(id: string, updates: Partial<InsuranceCompany>): Promise<InsuranceCompany> {
    const { data, error } = await this.supabase
      .from('insurance_companies')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()

    if (error) throw error
    return data
  }

  // === Labor Rate Types ===

  async getLaborRateTypes(): Promise<LaborRateType[]> {
    const { data, error } = await this.supabase
      .from('labor_rate_types')
      .select('*')
      .eq('is_active', true)
      .order('sort_order')

    if (error) throw error
    return data || []
  }

  // === Company-Insurance Relationships ===

  async getCompanyInsuranceRates(companyId: string): Promise<CompanyInsuranceRate[]> {
    const { data, error } = await this.supabase
      .from('company_insurance_rates')
      .select(`
        *,
        insurance_company:insurance_companies(*),
        rates:insurance_labor_rates(
          *,
          labor_rate_type:labor_rate_types(*)
        )
      `)
      .eq('company_id', companyId)
      .order('created_at', { ascending: false })

    if (error) throw error
    return data || []
  }

  async getCompanyInsuranceRate(id: string): Promise<CompanyInsuranceRate | null> {
    const { data, error } = await this.supabase
      .from('company_insurance_rates')
      .select(`
        *,
        insurance_company:insurance_companies(*),
        rates:insurance_labor_rates(
          *,
          labor_rate_type:labor_rate_types(*)
        )
      `)
      .eq('id', id)
      .single()

    if (error) throw error
    return data
  }

  async createCompanyInsuranceRate(
    companyId: string,
    insuranceCompanyId: string,
    details: Partial<CompanyInsuranceRate>
  ): Promise<CompanyInsuranceRate> {
    const { data, error } = await this.supabase
      .from('company_insurance_rates')
      .insert({
        company_id: companyId,
        insurance_company_id: insuranceCompanyId,
        ...details
      })
      .select(`
        *,
        insurance_company:insurance_companies(*)
      `)
      .single()

    if (error) throw error
    return data
  }

  async updateCompanyInsuranceRate(
    id: string,
    updates: Partial<CompanyInsuranceRate>
  ): Promise<CompanyInsuranceRate> {
    const { data, error } = await this.supabase
      .from('company_insurance_rates')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select(`
        *,
        insurance_company:insurance_companies(*)
      `)
      .single()

    if (error) throw error
    return data
  }

  async deleteCompanyInsuranceRate(id: string): Promise<void> {
    const { error } = await this.supabase
      .from('company_insurance_rates')
      .delete()
      .eq('id', id)

    if (error) throw error
  }

  // === Labor Rates ===

  async setLaborRate(
    companyInsuranceId: string,
    laborRateTypeId: string,
    hourlyRate: number,
    effectiveDate?: string,
    notes?: string
  ): Promise<InsuranceLaborRate> {
    const { data, error } = await this.supabase
      .from('insurance_labor_rates')
      .upsert({
        company_insurance_id: companyInsuranceId,
        labor_rate_type_id: laborRateTypeId,
        hourly_rate: hourlyRate,
        effective_date: effectiveDate || new Date().toISOString().split('T')[0],
        notes
      }, {
        onConflict: 'company_insurance_id,labor_rate_type_id,effective_date'
      })
      .select(`
        *,
        labor_rate_type:labor_rate_types(*)
      `)
      .single()

    if (error) throw error
    return data
  }

  async setMultipleLaborRates(
    companyInsuranceId: string,
    rates: { laborRateTypeId: string; hourlyRate: number }[]
  ): Promise<InsuranceLaborRate[]> {
    const effectiveDate = new Date().toISOString().split('T')[0]

    const { data, error } = await this.supabase
      .from('insurance_labor_rates')
      .upsert(
        rates.map(r => ({
          company_insurance_id: companyInsuranceId,
          labor_rate_type_id: r.laborRateTypeId,
          hourly_rate: r.hourlyRate,
          effective_date: effectiveDate
        })),
        { onConflict: 'company_insurance_id,labor_rate_type_id,effective_date' }
      )
      .select(`
        *,
        labor_rate_type:labor_rate_types(*)
      `)

    if (error) throw error
    return data || []
  }

  async getLaborRatesForInsurance(
    companyId: string,
    insuranceCompanyId: string
  ): Promise<Map<string, number>> {
    const rates = new Map<string, number>()

    // Get the company-insurance relationship
    const { data: relationship } = await this.supabase
      .from('company_insurance_rates')
      .select('id')
      .eq('company_id', companyId)
      .eq('insurance_company_id', insuranceCompanyId)
      .eq('is_active', true)
      .single()

    if (!relationship) {
      // Return default rates
      rates.set('BODY', 50)
      rates.set('REFINISH', 50)
      rates.set('MECHANICAL', 75)
      rates.set('STRUCTURAL', 60)
      rates.set('ALUMINUM', 70)
      rates.set('GLASS', 50)
      rates.set('DETAIL', 45)
      rates.set('DIAGNOSTIC', 100)
      return rates
    }

    // Get configured rates
    const { data: configuredRates } = await this.supabase
      .from('insurance_labor_rates')
      .select(`
        hourly_rate,
        labor_rate_type:labor_rate_types(code)
      `)
      .eq('company_insurance_id', relationship.id)
      .or(`expiration_date.is.null,expiration_date.gte.${new Date().toISOString().split('T')[0]}`)
      .order('effective_date', { ascending: false })

    if (configuredRates) {
      for (const rate of configuredRates) {
        const code = (rate.labor_rate_type as any)?.code
        if (code && !rates.has(code)) {
          rates.set(code, rate.hourly_rate)
        }
      }
    }

    // Fill in defaults for missing types
    if (!rates.has('BODY')) rates.set('BODY', 50)
    if (!rates.has('REFINISH')) rates.set('REFINISH', 50)
    if (!rates.has('MECHANICAL')) rates.set('MECHANICAL', 75)
    if (!rates.has('STRUCTURAL')) rates.set('STRUCTURAL', 60)
    if (!rates.has('ALUMINUM')) rates.set('ALUMINUM', 70)
    if (!rates.has('GLASS')) rates.set('GLASS', 50)
    if (!rates.has('DETAIL')) rates.set('DETAIL', 45)
    if (!rates.has('DIAGNOSTIC')) rates.set('DIAGNOSTIC', 100)

    return rates
  }

  // === Cost Calculations ===

  async calculateLaborCost(
    companyId: string,
    insuranceCompanyId: string,
    hours: LaborHours
  ): Promise<LaborCostCalculation> {
    const rates = await this.getLaborRatesForInsurance(companyId, insuranceCompanyId)

    const bodyHours = hours.body_labor_hours || 0
    const refinishHours = hours.refinish_labor_hours || 0
    const mechanicalHours = hours.mechanical_labor_hours || 0
    const structuralHours = hours.structural_labor_hours || 0
    const aluminumHours = hours.aluminum_labor_hours || 0
    const glassHours = hours.glass_labor_hours || 0

    const bodyCost = bodyHours * (rates.get('BODY') || 50)
    const refinishCost = refinishHours * (rates.get('REFINISH') || 50)
    const mechanicalCost = mechanicalHours * (rates.get('MECHANICAL') || 75)
    const structuralCost = structuralHours * (rates.get('STRUCTURAL') || 60)
    const aluminumCost = aluminumHours * (rates.get('ALUMINUM') || 70)
    const glassCost = glassHours * (rates.get('GLASS') || 50)

    return {
      total_labor_cost: Math.round((bodyCost + refinishCost + mechanicalCost + structuralCost + aluminumCost + glassCost) * 100) / 100,
      body_cost: Math.round(bodyCost * 100) / 100,
      refinish_cost: Math.round(refinishCost * 100) / 100,
      mechanical_cost: Math.round(mechanicalCost * 100) / 100,
      structural_cost: Math.round(structuralCost * 100) / 100,
      aluminum_cost: Math.round(aluminumCost * 100) / 100,
      glass_cost: Math.round(glassCost * 100) / 100
    }
  }

  // === Quick Setup Helper ===

  async setupDefaultRatesForCompany(
    companyId: string,
    defaultRates?: Record<string, number>
  ): Promise<void> {
    // Get all insurance companies
    const insurers = await this.getInsuranceCompanies()
    const rateTypes = await this.getLaborRateTypes()

    const defaults = defaultRates || {
      'BODY': 52,
      'REFINISH': 52,
      'MECHANICAL': 85,
      'STRUCTURAL': 65,
      'ALUMINUM': 75,
      'GLASS': 52,
      'DETAIL': 45,
      'DIAGNOSTIC': 110
    }

    for (const insurer of insurers) {
      // Create relationship if doesn't exist
      const { data: existing } = await this.supabase
        .from('company_insurance_rates')
        .select('id')
        .eq('company_id', companyId)
        .eq('insurance_company_id', insurer.id)
        .single()

      let relationshipId: string

      if (existing) {
        relationshipId = existing.id
      } else {
        const relationship = await this.createCompanyInsuranceRate(
          companyId,
          insurer.id,
          { is_drp: false }
        )
        relationshipId = relationship.id
      }

      // Set default rates
      const rateData = rateTypes.map(rt => ({
        laborRateTypeId: rt.id,
        hourlyRate: defaults[rt.code] || 50
      }))

      await this.setMultipleLaborRates(relationshipId, rateData)
    }
  }
}

// Factory function
export function createLaborRateService(supabase: SupabaseClient): LaborRateService {
  return new LaborRateService(supabase)
}

// Default export
export default LaborRateService
