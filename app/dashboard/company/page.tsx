'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Building2, Save, Plus, Trash2, ChevronDown, ChevronUp,
  DollarSign, Shield, Settings, Users, Phone, Mail, MapPin,
  Globe, FileText, AlertCircle, CheckCircle, Edit2, X
} from 'lucide-react'

interface Company {
  id: string
  name: string
  email: string | null
  phone: string | null
  address: string | null
  city: string | null
  state: string | null
  zip: string | null
  website: string | null
  subscription_status: string
  created_at: string
}

interface InsuranceCompany {
  id: string
  name: string
  code: string | null
  phone: string | null
  website: string | null
  is_active: boolean
}

interface LaborRateType {
  id: string
  code: string
  name: string
  description: string | null
  sort_order: number
}

interface CompanyInsuranceRate {
  id: string
  company_id: string
  insurance_company_id: string
  is_drp: boolean
  drp_code: string | null
  account_number: string | null
  contact_name: string | null
  contact_phone: string | null
  contact_email: string | null
  is_active: boolean
  insurance_company?: InsuranceCompany
  rates?: { labor_rate_type_id: string; hourly_rate: number; labor_rate_type?: LaborRateType }[]
}

export default function CompanyAdminPage() {
  const supabase = createClient()

  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)

  const [company, setCompany] = useState<Company | null>(null)
  const [companyForm, setCompanyForm] = useState<Partial<Company>>({})
  const [editingCompany, setEditingCompany] = useState(false)

  const [insuranceCompanies, setInsuranceCompanies] = useState<InsuranceCompany[]>([])
  const [laborRateTypes, setLaborRateTypes] = useState<LaborRateType[]>([])
  const [companyInsuranceRates, setCompanyInsuranceRates] = useState<CompanyInsuranceRate[]>([])

  const [expandedInsurer, setExpandedInsurer] = useState<string | null>(null)
  const [showAddInsurer, setShowAddInsurer] = useState(false)
  const [selectedInsurerId, setSelectedInsurerId] = useState('')
  const [newInsurerForm, setNewInsurerForm] = useState({
    is_drp: false,
    drp_code: '',
    account_number: '',
    contact_name: '',
    contact_phone: '',
    contact_email: ''
  })
  const [rateInputs, setRateInputs] = useState<Record<string, Record<string, number>>>({})

  const [activeTab, setActiveTab] = useState<'profile' | 'insurance' | 'settings'>('profile')

  useEffect(() => {
    loadData()
  }, [])

  const loadData = async () => {
    try {
      setLoading(true)
      setError(null)

      const { data: { user } } = await supabase.auth.getUser()
      if (!user) throw new Error('Not authenticated')

      // Get user's company
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id, role')
        .eq('id', user.id)
        .single()

      if (!profile?.company_id) throw new Error('No company found')
      if (!['admin', 'super_admin'].includes(profile.role || '')) {
        throw new Error('You do not have permission to access this page')
      }

      // Load company details
      const { data: companyData } = await supabase
        .from('companies')
        .select('*')
        .eq('id', profile.company_id)
        .single()

      setCompany(companyData)
      setCompanyForm(companyData || {})

      // Load all insurance companies
      const { data: insurers } = await supabase
        .from('insurance_companies')
        .select('*')
        .eq('is_active', true)
        .order('name')

      setInsuranceCompanies(insurers || [])

      // Load labor rate types
      const { data: rateTypes } = await supabase
        .from('labor_rate_types')
        .select('*')
        .eq('is_active', true)
        .order('sort_order')

      setLaborRateTypes(rateTypes || [])

      // Load company's insurance relationships with rates
      const { data: companyRates } = await supabase
        .from('company_insurance_rates')
        .select(`
          *,
          insurance_company:insurance_companies(*),
          rates:insurance_labor_rates(
            labor_rate_type_id,
            hourly_rate,
            labor_rate_type:labor_rate_types(*)
          )
        `)
        .eq('company_id', profile.company_id)

      setCompanyInsuranceRates(companyRates || [])

      // Initialize rate inputs
      const inputs: Record<string, Record<string, number>> = {}
      for (const cr of companyRates || []) {
        inputs[cr.id] = {}
        for (const rate of cr.rates || []) {
          const typeCode = (rate.labor_rate_type as any)?.code
          if (typeCode) {
            inputs[cr.id][typeCode] = rate.hourly_rate
          }
        }
      }
      setRateInputs(inputs)

    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const saveCompanyProfile = async () => {
    if (!company) return

    try {
      setSaving(true)
      setError(null)

      const { error: updateError } = await supabase
        .from('companies')
        .update({
          name: companyForm.name,
          email: companyForm.email,
          phone: companyForm.phone,
          address: companyForm.address,
          city: companyForm.city,
          state: companyForm.state,
          zip: companyForm.zip,
          website: companyForm.website
        })
        .eq('id', company.id)

      if (updateError) throw updateError

      setSuccess('Company profile saved successfully')
      setEditingCompany(false)
      loadData()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  const addInsuranceCompany = async () => {
    if (!company || !selectedInsurerId) return

    try {
      setSaving(true)
      setError(null)

      // Create the relationship
      const { data: newRelation, error: insertError } = await supabase
        .from('company_insurance_rates')
        .insert({
          company_id: company.id,
          insurance_company_id: selectedInsurerId,
          is_drp: newInsurerForm.is_drp,
          drp_code: newInsurerForm.drp_code || null,
          account_number: newInsurerForm.account_number || null,
          contact_name: newInsurerForm.contact_name || null,
          contact_phone: newInsurerForm.contact_phone || null,
          contact_email: newInsurerForm.contact_email || null,
          is_active: true
        })
        .select()
        .single()

      if (insertError) throw insertError

      // Add default rates
      const defaultRates = laborRateTypes.map(rt => ({
        company_insurance_id: newRelation.id,
        labor_rate_type_id: rt.id,
        hourly_rate: getDefaultRate(rt.code),
        effective_date: new Date().toISOString().split('T')[0]
      }))

      await supabase.from('insurance_labor_rates').insert(defaultRates)

      setSuccess('Insurance company added successfully')
      setShowAddInsurer(false)
      setSelectedInsurerId('')
      setNewInsurerForm({
        is_drp: false,
        drp_code: '',
        account_number: '',
        contact_name: '',
        contact_phone: '',
        contact_email: ''
      })
      loadData()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  const getDefaultRate = (code: string): number => {
    const defaults: Record<string, number> = {
      'BODY': 52,
      'REFINISH': 52,
      'MECHANICAL': 85,
      'STRUCTURAL': 65,
      'ALUMINUM': 75,
      'GLASS': 52,
      'DETAIL': 45,
      'DIAGNOSTIC': 110
    }
    return defaults[code] || 50
  }

  const saveRates = async (companyInsuranceId: string) => {
    try {
      setSaving(true)
      setError(null)

      const rates = rateInputs[companyInsuranceId] || {}
      const effectiveDate = new Date().toISOString().split('T')[0]

      for (const rateType of laborRateTypes) {
        const hourlyRate = rates[rateType.code]
        if (hourlyRate !== undefined) {
          await supabase
            .from('insurance_labor_rates')
            .upsert({
              company_insurance_id: companyInsuranceId,
              labor_rate_type_id: rateType.id,
              hourly_rate: hourlyRate,
              effective_date: effectiveDate
            }, {
              onConflict: 'company_insurance_id,labor_rate_type_id,effective_date'
            })
        }
      }

      setSuccess('Labor rates saved successfully')
    } catch (err: any) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  const removeInsuranceCompany = async (id: string) => {
    if (!confirm('Remove this insurance company? This will delete all associated labor rates.')) return

    try {
      const { error } = await supabase
        .from('company_insurance_rates')
        .delete()
        .eq('id', id)

      if (error) throw error

      setSuccess('Insurance company removed')
      loadData()
    } catch (err: any) {
      setError(err.message)
    }
  }

  const updateInsurerDetails = async (id: string, updates: Partial<CompanyInsuranceRate>) => {
    try {
      const { error } = await supabase
        .from('company_insurance_rates')
        .update(updates)
        .eq('id', id)

      if (error) throw error
      loadData()
    } catch (err: any) {
      setError(err.message)
    }
  }

  const getConfiguredInsurerIds = () => {
    return new Set(companyInsuranceRates.map(r => r.insurance_company_id))
  }

  if (loading) {
    return (
      <div className="p-6">
        <div className="animate-pulse space-y-4">
          <div className="h-8 bg-gray-200 rounded w-1/4"></div>
          <div className="h-64 bg-gray-200 rounded"></div>
        </div>
      </div>
    )
  }

  if (error && !company) {
    return (
      <div className="p-6">
        <div className="bg-red-50 border border-red-200 text-red-700 p-4 rounded-lg">
          {error}
        </div>
      </div>
    )
  }

  return (
    <div className="p-6 max-w-6xl mx-auto">
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
          <Building2 className="w-7 h-7 text-blue-600" />
          Company Administration
        </h1>
        <p className="text-gray-600 mt-1">
          Manage your company profile, insurance partners, and labor rates
        </p>
      </div>

      {/* Alerts */}
      {error && (
        <div className="mb-4 bg-red-50 border border-red-200 text-red-700 p-3 rounded-lg flex justify-between items-center">
          <div className="flex items-center gap-2">
            <AlertCircle className="w-4 h-4" />
            {error}
          </div>
          <button onClick={() => setError(null)}>×</button>
        </div>
      )}
      {success && (
        <div className="mb-4 bg-green-50 border border-green-200 text-green-700 p-3 rounded-lg flex justify-between items-center">
          <div className="flex items-center gap-2">
            <CheckCircle className="w-4 h-4" />
            {success}
          </div>
          <button onClick={() => setSuccess(null)}>×</button>
        </div>
      )}

      {/* Tabs */}
      <div className="flex gap-1 mb-6 border-b">
        <button
          onClick={() => setActiveTab('profile')}
          className={`px-4 py-2 font-medium text-sm border-b-2 transition-colors ${
            activeTab === 'profile'
              ? 'border-blue-600 text-blue-600'
              : 'border-transparent text-gray-600 hover:text-gray-900'
          }`}
        >
          <Building2 className="w-4 h-4 inline mr-2" />
          Company Profile
        </button>
        <button
          onClick={() => setActiveTab('insurance')}
          className={`px-4 py-2 font-medium text-sm border-b-2 transition-colors ${
            activeTab === 'insurance'
              ? 'border-blue-600 text-blue-600'
              : 'border-transparent text-gray-600 hover:text-gray-900'
          }`}
        >
          <DollarSign className="w-4 h-4 inline mr-2" />
          Insurance & Labor Rates
        </button>
      </div>

      {/* Company Profile Tab */}
      {activeTab === 'profile' && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-lg font-semibold">Company Information</h2>
            {!editingCompany ? (
              <button
                onClick={() => setEditingCompany(true)}
                className="flex items-center gap-2 px-3 py-2 text-blue-600 hover:bg-blue-50 rounded-lg"
              >
                <Edit2 className="w-4 h-4" />
                Edit
              </button>
            ) : (
              <div className="flex gap-2">
                <button
                  onClick={() => {
                    setEditingCompany(false)
                    setCompanyForm(company || {})
                  }}
                  className="px-3 py-2 text-gray-600 hover:bg-gray-100 rounded-lg"
                >
                  Cancel
                </button>
                <button
                  onClick={saveCompanyProfile}
                  disabled={saving}
                  className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50"
                >
                  <Save className="w-4 h-4" />
                  Save
                </button>
              </div>
            )}
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Company Name
              </label>
              {editingCompany ? (
                <input
                  type="text"
                  value={companyForm.name || ''}
                  onChange={(e) => setCompanyForm({ ...companyForm, name: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2"
                />
              ) : (
                <p className="text-gray-900 py-2">{company?.name || '—'}</p>
              )}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                <Mail className="w-4 h-4 inline mr-1" />
                Email
              </label>
              {editingCompany ? (
                <input
                  type="email"
                  value={companyForm.email || ''}
                  onChange={(e) => setCompanyForm({ ...companyForm, email: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2"
                />
              ) : (
                <p className="text-gray-900 py-2">{company?.email || '—'}</p>
              )}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                <Phone className="w-4 h-4 inline mr-1" />
                Phone
              </label>
              {editingCompany ? (
                <input
                  type="tel"
                  value={companyForm.phone || ''}
                  onChange={(e) => setCompanyForm({ ...companyForm, phone: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2"
                />
              ) : (
                <p className="text-gray-900 py-2">{company?.phone || '—'}</p>
              )}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                <Globe className="w-4 h-4 inline mr-1" />
                Website
              </label>
              {editingCompany ? (
                <input
                  type="url"
                  value={companyForm.website || ''}
                  onChange={(e) => setCompanyForm({ ...companyForm, website: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2"
                />
              ) : (
                <p className="text-gray-900 py-2">{company?.website || '—'}</p>
              )}
            </div>

            <div className="md:col-span-2">
              <label className="block text-sm font-medium text-gray-700 mb-1">
                <MapPin className="w-4 h-4 inline mr-1" />
                Address
              </label>
              {editingCompany ? (
                <input
                  type="text"
                  value={companyForm.address || ''}
                  onChange={(e) => setCompanyForm({ ...companyForm, address: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2"
                  placeholder="Street address"
                />
              ) : (
                <p className="text-gray-900 py-2">{company?.address || '—'}</p>
              )}
            </div>

            {editingCompany && (
              <>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">City</label>
                  <input
                    type="text"
                    value={companyForm.city || ''}
                    onChange={(e) => setCompanyForm({ ...companyForm, city: e.target.value })}
                    className="w-full border rounded-lg px-3 py-2"
                  />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">State</label>
                    <input
                      type="text"
                      value={companyForm.state || ''}
                      onChange={(e) => setCompanyForm({ ...companyForm, state: e.target.value })}
                      className="w-full border rounded-lg px-3 py-2"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">ZIP</label>
                    <input
                      type="text"
                      value={companyForm.zip || ''}
                      onChange={(e) => setCompanyForm({ ...companyForm, zip: e.target.value })}
                      className="w-full border rounded-lg px-3 py-2"
                    />
                  </div>
                </div>
              </>
            )}
          </div>

          {!editingCompany && (company?.city || company?.state || company?.zip) && (
            <p className="text-gray-600 mt-2">
              {[company?.city, company?.state, company?.zip].filter(Boolean).join(', ')}
            </p>
          )}

          <div className="mt-6 pt-6 border-t">
            <div className="flex items-center justify-between">
              <div>
                <span className="text-sm text-gray-500">Subscription Status:</span>
                <span className={`ml-2 px-2 py-1 rounded-full text-xs font-medium ${
                  company?.subscription_status === 'active'
                    ? 'bg-green-100 text-green-700'
                    : 'bg-gray-100 text-gray-600'
                }`}>
                  {company?.subscription_status || 'Unknown'}
                </span>
              </div>
              <div className="text-sm text-gray-500">
                Member since {company?.created_at ? new Date(company.created_at).toLocaleDateString() : '—'}
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Insurance & Labor Rates Tab */}
      {activeTab === 'insurance' && (
        <div className="space-y-4">
          {/* Add Insurance Button */}
          <div className="flex justify-between items-center">
            <p className="text-gray-600">
              Configure labor rates for each insurance company you work with
            </p>
            <button
              onClick={() => setShowAddInsurer(true)}
              className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              <Plus className="w-4 h-4" />
              Add Insurance Company
            </button>
          </div>

          {/* Add Insurance Modal */}
          {showAddInsurer && (
            <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
              <div className="bg-white rounded-lg shadow-xl max-w-lg w-full">
                <div className="p-6 border-b flex justify-between items-center">
                  <h3 className="text-lg font-semibold">Add Insurance Company</h3>
                  <button onClick={() => setShowAddInsurer(false)} className="text-gray-400 hover:text-gray-600">
                    <X className="w-5 h-5" />
                  </button>
                </div>
                <div className="p-6 space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Select Insurance Company
                    </label>
                    <select
                      value={selectedInsurerId}
                      onChange={(e) => setSelectedInsurerId(e.target.value)}
                      className="w-full border rounded-lg px-3 py-2"
                    >
                      <option value="">Choose...</option>
                      {insuranceCompanies
                        .filter(ic => !getConfiguredInsurerIds().has(ic.id))
                        .map(ic => (
                          <option key={ic.id} value={ic.id}>{ic.name}</option>
                        ))
                      }
                    </select>
                  </div>

                  <label className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      checked={newInsurerForm.is_drp}
                      onChange={(e) => setNewInsurerForm({ ...newInsurerForm, is_drp: e.target.checked })}
                      className="rounded"
                    />
                    <span className="text-sm font-medium">DRP (Direct Repair Program)</span>
                  </label>

                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">DRP Code</label>
                      <input
                        type="text"
                        value={newInsurerForm.drp_code}
                        onChange={(e) => setNewInsurerForm({ ...newInsurerForm, drp_code: e.target.value })}
                        className="w-full border rounded-lg px-3 py-2"
                      />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Account #</label>
                      <input
                        type="text"
                        value={newInsurerForm.account_number}
                        onChange={(e) => setNewInsurerForm({ ...newInsurerForm, account_number: e.target.value })}
                        className="w-full border rounded-lg px-3 py-2"
                      />
                    </div>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Contact Name</label>
                    <input
                      type="text"
                      value={newInsurerForm.contact_name}
                      onChange={(e) => setNewInsurerForm({ ...newInsurerForm, contact_name: e.target.value })}
                      className="w-full border rounded-lg px-3 py-2"
                      placeholder="Adjuster / Rep name"
                    />
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Contact Phone</label>
                      <input
                        type="tel"
                        value={newInsurerForm.contact_phone}
                        onChange={(e) => setNewInsurerForm({ ...newInsurerForm, contact_phone: e.target.value })}
                        className="w-full border rounded-lg px-3 py-2"
                      />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Contact Email</label>
                      <input
                        type="email"
                        value={newInsurerForm.contact_email}
                        onChange={(e) => setNewInsurerForm({ ...newInsurerForm, contact_email: e.target.value })}
                        className="w-full border rounded-lg px-3 py-2"
                      />
                    </div>
                  </div>
                </div>
                <div className="p-6 border-t bg-gray-50 flex justify-end gap-3">
                  <button
                    onClick={() => setShowAddInsurer(false)}
                    className="px-4 py-2 text-gray-700 hover:bg-gray-100 rounded-lg"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={addInsuranceCompany}
                    disabled={!selectedInsurerId || saving}
                    className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50"
                  >
                    {saving ? 'Adding...' : 'Add & Set Rates'}
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* Insurance Company List */}
          {companyInsuranceRates.length === 0 ? (
            <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
              <Shield className="w-12 h-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-gray-900 mb-2">No Insurance Companies Configured</h3>
              <p className="text-gray-500 mb-4">
                Add insurance companies to configure labor rates for accurate estimate calculations.
              </p>
            </div>
          ) : (
            <div className="space-y-3">
              {companyInsuranceRates.map((cir) => (
                <div key={cir.id} className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                  {/* Header */}
                  <div
                    className="p-4 flex items-center justify-between cursor-pointer hover:bg-gray-50"
                    onClick={() => setExpandedInsurer(expandedInsurer === cir.id ? null : cir.id)}
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                        <span className="text-blue-600 font-bold">
                          {cir.insurance_company?.code || cir.insurance_company?.name?.substring(0, 2)}
                        </span>
                      </div>
                      <div>
                        <h3 className="font-semibold text-gray-900">{cir.insurance_company?.name}</h3>
                        <div className="flex items-center gap-2 text-sm text-gray-500">
                          {cir.is_drp && (
                            <span className="bg-green-100 text-green-700 px-2 py-0.5 rounded-full text-xs font-medium">
                              DRP
                            </span>
                          )}
                          {cir.account_number && <span>Acct: {cir.account_number}</span>}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-right text-sm text-gray-500">
                        {cir.rates?.length || 0} rates configured
                      </div>
                      {expandedInsurer === cir.id ? (
                        <ChevronUp className="w-5 h-5 text-gray-400" />
                      ) : (
                        <ChevronDown className="w-5 h-5 text-gray-400" />
                      )}
                    </div>
                  </div>

                  {/* Expanded Content */}
                  {expandedInsurer === cir.id && (
                    <div className="border-t p-4 bg-gray-50">
                      {/* Contact Info */}
                      {(cir.contact_name || cir.contact_phone || cir.contact_email) && (
                        <div className="mb-4 p-3 bg-white rounded-lg border">
                          <h4 className="text-sm font-medium text-gray-700 mb-2">Contact Information</h4>
                          <div className="grid grid-cols-3 gap-4 text-sm">
                            <div>
                              <span className="text-gray-500">Name:</span>
                              <span className="ml-2">{cir.contact_name || '—'}</span>
                            </div>
                            <div>
                              <span className="text-gray-500">Phone:</span>
                              <span className="ml-2">{cir.contact_phone || '—'}</span>
                            </div>
                            <div>
                              <span className="text-gray-500">Email:</span>
                              <span className="ml-2">{cir.contact_email || '—'}</span>
                            </div>
                          </div>
                        </div>
                      )}

                      {/* Labor Rates Grid */}
                      <div className="mb-4">
                        <h4 className="text-sm font-medium text-gray-700 mb-3">Labor Rates ($/hour)</h4>
                        <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                          {laborRateTypes.map((rt) => (
                            <div key={rt.id} className="bg-white rounded-lg border p-3">
                              <label className="block text-xs font-medium text-gray-600 mb-1">
                                {rt.name}
                              </label>
                              <div className="relative">
                                <span className="absolute left-2 top-2 text-gray-400">$</span>
                                <input
                                  type="number"
                                  step="0.01"
                                  min="0"
                                  value={rateInputs[cir.id]?.[rt.code] ?? ''}
                                  onChange={(e) => {
                                    setRateInputs(prev => ({
                                      ...prev,
                                      [cir.id]: {
                                        ...(prev[cir.id] || {}),
                                        [rt.code]: parseFloat(e.target.value) || 0
                                      }
                                    }))
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 border rounded text-right font-mono"
                                />
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>

                      {/* Actions */}
                      <div className="flex justify-between items-center pt-3 border-t">
                        <button
                          onClick={() => removeInsuranceCompany(cir.id)}
                          className="flex items-center gap-2 px-3 py-2 text-red-600 hover:bg-red-50 rounded-lg"
                        >
                          <Trash2 className="w-4 h-4" />
                          Remove
                        </button>
                        <button
                          onClick={() => saveRates(cir.id)}
                          disabled={saving}
                          className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50"
                        >
                          <Save className="w-4 h-4" />
                          {saving ? 'Saving...' : 'Save Rates'}
                        </button>
                      </div>
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}

          {/* Rate Guide */}
          <div className="bg-blue-50 rounded-lg p-4 mt-6">
            <h4 className="font-medium text-blue-900 mb-2">Industry Standard Labor Types</h4>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3 text-sm text-blue-800">
              <div><strong>Body:</strong> R&I, R&R, repair</div>
              <div><strong>Refinish:</strong> Paint, prime, clear</div>
              <div><strong>Mechanical:</strong> Suspension, drivetrain</div>
              <div><strong>Structural:</strong> Frame, measuring</div>
              <div><strong>Aluminum:</strong> Specialized aluminum</div>
              <div><strong>Glass:</strong> Windshield install</div>
              <div><strong>Detail:</strong> Final cleaning</div>
              <div><strong>Diagnostic:</strong> Scans, calibration</div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
