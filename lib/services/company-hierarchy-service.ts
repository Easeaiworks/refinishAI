// Company Hierarchy Service
// Manages parent/child company relationships, corporate settings,
// and cascading policies for multi-location groups

import type {
  CompanyWithHierarchy,
  CorporateSettingRow,
  NewCompanyData,
  NewLocationData,
} from '@/lib/types'

// ── COMPANY QUERIES ─────────────────────────────────────────

/** Fetch a company with its child locations (if corporate) */
export async function getCompanyWithChildren(
  supabase: any,
  companyId: string
): Promise<CompanyWithHierarchy | null> {
  const { data: company, error } = await supabase
    .from('companies')
    .select('*')
    .eq('id', companyId)
    .single()

  if (error || !company) return null

  let childLocations: CompanyWithHierarchy[] = []
  if (company.company_type === 'corporate') {
    const { data: children } = await supabase
      .from('companies')
      .select('*')
      .eq('parent_company_id', companyId)
      .order('location_code', { ascending: true })

    if (children) {
      // Get user counts per child
      const childIds = children.map((c: any) => c.id)
      const { data: userCounts } = await supabase
        .from('user_profiles')
        .select('company_id')
        .in('company_id', childIds)
        .eq('is_active', true)

      const countMap: Record<string, number> = {}
      for (const u of userCounts || []) {
        countMap[u.company_id] = (countMap[u.company_id] || 0) + 1
      }

      childLocations = children.map((c: any) => ({
        ...c,
        userCount: countMap[c.id] || 0,
      }))
    }
  }

  // Get parent user count
  const { count: userCount } = await supabase
    .from('user_profiles')
    .select('id', { count: 'exact', head: true })
    .eq('company_id', companyId)
    .eq('is_active', true)

  return {
    ...company,
    childLocations,
    userCount: userCount || 0,
  }
}

/** Get all companies organized as a hierarchy for admin view */
export async function getAllCompaniesHierarchy(
  supabase: any
): Promise<CompanyWithHierarchy[]> {
  // Load all companies
  const { data: allCompanies } = await supabase
    .from('companies')
    .select('*')
    .order('name')

  if (!allCompanies) return []

  // Load all user counts in one query
  const { data: allUsers } = await supabase
    .from('user_profiles')
    .select('company_id')
    .eq('is_active', true)

  const userCountMap: Record<string, number> = {}
  for (const u of allUsers || []) {
    userCountMap[u.company_id] = (userCountMap[u.company_id] || 0) + 1
  }

  // Build hierarchy
  const parentMap: Record<string, CompanyWithHierarchy[]> = {}
  const topLevel: CompanyWithHierarchy[] = []

  for (const c of allCompanies) {
    const enriched: CompanyWithHierarchy = {
      ...c,
      userCount: userCountMap[c.id] || 0,
      childLocations: [],
    }

    if (c.parent_company_id) {
      if (!parentMap[c.parent_company_id]) parentMap[c.parent_company_id] = []
      parentMap[c.parent_company_id].push(enriched)
    } else {
      topLevel.push(enriched)
    }
  }

  // Attach children to parents
  for (const company of topLevel) {
    company.childLocations = parentMap[company.id] || []
  }

  return topLevel
}

/** Get IDs of all companies a user can access */
export async function getAccessibleCompanyIds(
  supabase: any,
  userId: string
): Promise<string[]> {
  const { data: profile } = await supabase
    .from('user_profiles')
    .select('company_id, role, is_corporate_user')
    .eq('id', userId)
    .single()

  if (!profile) return []

  // Super admin: all companies
  if (profile.role === 'super_admin') {
    const { data: allCompanies } = await supabase
      .from('companies')
      .select('id')
    return (allCompanies || []).map((c: any) => c.id)
  }

  // Corporate user at parent: parent + all children
  if (profile.is_corporate_user) {
    const { data: company } = await supabase
      .from('companies')
      .select('company_type')
      .eq('id', profile.company_id)
      .single()

    if (company?.company_type === 'corporate') {
      const { data: children } = await supabase
        .from('companies')
        .select('id')
        .eq('parent_company_id', profile.company_id)

      const ids = [profile.company_id]
      for (const child of children || []) {
        ids.push(child.id)
      }
      return ids
    }
  }

  // Regular user: just their company
  return [profile.company_id]
}

// ── COMPANY CREATION ────────────────────────────────────────

/** Create a single-location company */
export async function createSingleCompany(
  supabase: any,
  data: NewCompanyData
): Promise<{ id: string } | null> {
  const { data: company, error } = await supabase
    .from('companies')
    .insert({
      name: data.name,
      email: data.email,
      phone: data.phone || null,
      address: data.address || null,
      city: data.city || null,
      state: data.state || null,
      zip: data.zip || null,
      website: data.website || null,
      company_type: 'single',
      subscription_status: 'trial',
    })
    .select('id')
    .single()

  if (error) throw error
  return company
}

/** Create a corporate group with initial child locations */
export async function createCorporateGroup(
  supabase: any,
  parentData: NewCompanyData,
  locations: NewLocationData[]
): Promise<{ parentId: string; locationIds: string[] }> {
  // Create parent
  const { data: parent, error: parentError } = await supabase
    .from('companies')
    .insert({
      name: parentData.name,
      email: parentData.email,
      phone: parentData.phone || null,
      address: parentData.address || null,
      city: parentData.city || null,
      state: parentData.state || null,
      zip: parentData.zip || null,
      website: parentData.website || null,
      company_type: 'corporate',
      subscription_status: 'trial',
    })
    .select('id')
    .single()

  if (parentError) throw parentError

  // Create child locations
  const locationIds: string[] = []
  for (const loc of locations) {
    const { data: child, error: childError } = await supabase
      .from('companies')
      .insert({
        name: loc.name,
        email: loc.email || parentData.email,
        phone: loc.phone || null,
        address: loc.address || null,
        city: loc.city || null,
        state: loc.state || null,
        zip: loc.zip || null,
        parent_company_id: parent.id,
        company_type: 'location',
        location_code: loc.location_code,
        is_headquarters: loc.is_headquarters || false,
        subscription_status: 'active',
      })
      .select('id')
      .single()

    if (childError) throw childError
    locationIds.push(child.id)
  }

  return { parentId: parent.id, locationIds }
}

/** Add a child location to an existing corporate parent */
export async function addChildLocation(
  supabase: any,
  parentId: string,
  data: NewLocationData
): Promise<{ id: string }> {
  // Verify parent is corporate type
  const { data: parent } = await supabase
    .from('companies')
    .select('id, company_type, email')
    .eq('id', parentId)
    .single()

  if (!parent || parent.company_type !== 'corporate') {
    throw new Error('Parent company is not a corporate entity')
  }

  const { data: child, error } = await supabase
    .from('companies')
    .insert({
      name: data.name,
      email: data.email || parent.email,
      phone: data.phone || null,
      address: data.address || null,
      city: data.city || null,
      state: data.state || null,
      zip: data.zip || null,
      parent_company_id: parentId,
      company_type: 'location',
      location_code: data.location_code,
      is_headquarters: data.is_headquarters || false,
      subscription_status: 'active',
    })
    .select('id')
    .single()

  if (error) throw error
  return child
}

/** Remove a child location (checks for active users first) */
export async function removeChildLocation(
  supabase: any,
  childId: string
): Promise<void> {
  // Check for active users
  const { count } = await supabase
    .from('user_profiles')
    .select('id', { count: 'exact', head: true })
    .eq('company_id', childId)
    .eq('is_active', true)

  if (count && count > 0) {
    throw new Error(`Cannot remove location — ${count} active user(s) still assigned. Reassign or deactivate them first.`)
  }

  const { error } = await supabase
    .from('companies')
    .delete()
    .eq('id', childId)
    .eq('company_type', 'location')

  if (error) throw error
}

// ── CORPORATE SETTINGS ──────────────────────────────────────

/** Get all corporate settings for a parent company */
export async function getCorporateSettings(
  supabase: any,
  parentId: string
): Promise<CorporateSettingRow[]> {
  const { data, error } = await supabase
    .from('corporate_settings')
    .select('*')
    .eq('parent_company_id', parentId)

  if (error) throw error
  return data || []
}

/** Get a specific corporate setting */
export async function getCorporateSetting(
  supabase: any,
  parentId: string,
  key: string
): Promise<CorporateSettingRow | null> {
  const { data } = await supabase
    .from('corporate_settings')
    .select('*')
    .eq('parent_company_id', parentId)
    .eq('setting_key', key)
    .single()

  return data || null
}

/** Upsert a corporate setting */
export async function saveCorporateSetting(
  supabase: any,
  parentId: string,
  key: string,
  value: Record<string, any>,
  enforceLock: boolean = false
): Promise<void> {
  const { error } = await supabase
    .from('corporate_settings')
    .upsert({
      parent_company_id: parentId,
      setting_key: key,
      setting_value: value,
      enforce_lock: enforceLock,
    }, {
      onConflict: 'parent_company_id,setting_key',
    })

  if (error) throw error
}

// ── CASCADING SETTINGS ──────────────────────────────────────

/** Get the effective paint line for a company (own setting → parent cascade) */
export async function getEffectivePaintLine(
  supabase: any,
  companyId: string
): Promise<{ vendorCode: string; vendorName: string } | null> {
  // First check this company's own primary vendor
  const { data: ownVendor } = await supabase
    .from('company_vendors')
    .select('vendor_code, vendor_name')
    .eq('company_id', companyId)
    .eq('is_primary', true)
    .eq('is_active', true)
    .limit(1)

  if (ownVendor && ownVendor.length > 0) {
    return {
      vendorCode: ownVendor[0].vendor_code,
      vendorName: ownVendor[0].vendor_name,
    }
  }

  // If this is a child location, check parent's corporate settings
  const { data: company } = await supabase
    .from('companies')
    .select('parent_company_id, company_type')
    .eq('id', companyId)
    .single()

  if (company?.parent_company_id && company.company_type === 'location') {
    const setting = await getCorporateSetting(
      supabase,
      company.parent_company_id,
      'paint_line'
    )

    if (setting?.setting_value?.vendor_code) {
      return {
        vendorCode: setting.setting_value.vendor_code,
        vendorName: setting.setting_value.vendor_name || setting.setting_value.vendor_code,
      }
    }
  }

  return null
}

/** Get effective approved vendor codes for a company */
export async function getEffectiveVendors(
  supabase: any,
  companyId: string
): Promise<string[]> {
  // Get own vendors
  const { data: ownVendors } = await supabase
    .from('company_vendors')
    .select('vendor_code')
    .eq('company_id', companyId)
    .eq('is_active', true)

  const ownCodes = (ownVendors || []).map((v: any) => v.vendor_code)
  if (ownCodes.length > 0) return ownCodes

  // If child location, check parent's corporate settings
  const { data: company } = await supabase
    .from('companies')
    .select('parent_company_id, company_type')
    .eq('id', companyId)
    .single()

  if (company?.parent_company_id && company.company_type === 'location') {
    const setting = await getCorporateSetting(
      supabase,
      company.parent_company_id,
      'approved_vendors'
    )

    if (setting?.setting_value?.vendor_codes) {
      return setting.setting_value.vendor_codes
    }
  }

  return ownCodes
}
