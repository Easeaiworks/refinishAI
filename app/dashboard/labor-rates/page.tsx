'use client'

import { useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  LaborRateService,
  InsuranceCompany,
  LaborRateType,
  CompanyInsuranceRate
} from '@/lib/labor-rates'

export default function LaborRatesPage() {
  const supabase = createClient()
  const [service] = useState(() => new LaborRateService(supabase))

  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)

  const [insuranceCompanies, setInsuranceCompanies] = useState<InsuranceCompany[]>([])
  const [laborRateTypes, setLaborRateTypes] = useState<LaborRateType[]>([])
  const [companyRates, setCompanyRates] = useState<CompanyInsuranceRate[]>([])
  const [companyId, setCompanyId] = useState<string | null>(null)
  const [userRole, setUserRole] = useState<string>('')

  const [selectedInsurer, setSelectedInsurer] = useState<string>('')
  const [showAddModal, setShowAddModal] = useState(false)
  const [editingRates, setEditingRates] = useState<CompanyInsuranceRate | null>(null)
  const [rateInputs, setRateInputs] = useState<Record<string, number>>({})
  const [isDrp, setIsDrp] = useState(false)
  const [drpCode, setDrpCode] = useState('')
  const [accountNumber, setAccountNumber] = useState('')
  const [contactName, setContactName] = useState('')
  const [contactPhone, setContactPhone] = useState('')
  const [contactEmail, setContactEmail] = useState('')
  const [saving, setSaving] = useState(false)

  useEffect(() => {
    loadData()
  }, [])

  const loadData = async () => {
    try {
      setLoading(true)
      setError(null)

      // Get user's company
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) throw new Error('Not authenticated')

      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id, role')
        .eq('id', user.id)
        .single()

      if (!profile?.company_id) throw new Error('No company found')

      setCompanyId(profile.company_id)
      setUserRole(profile.role || '')

      // Load all data
      const [insurers, types, rates] = await Promise.all([
        service.getInsuranceCompanies(),
        service.getLaborRateTypes(),
        service.getCompanyInsuranceRates(profile.company_id)
      ])

      setInsuranceCompanies(insurers)
      setLaborRateTypes(types)
      setCompanyRates(rates)
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const getConfiguredInsurerIds = () => {
    return new Set(companyRates.map(r => r.insurance_company_id))
  }

  const openAddModal = () => {
    setSelectedInsurer('')
    setRateInputs({})
    setIsDrp(false)
    setDrpCode('')
    setAccountNumber('')
    setContactName('')
    setContactPhone('')
    setContactEmail('')
    setShowAddModal(true)
    setEditingRates(null)
  }

  const openEditModal = (rate: CompanyInsuranceRate) => {
    setEditingRates(rate)
    setSelectedInsurer(rate.insurance_company_id)
    setIsDrp(rate.is_drp)
    setDrpCode(rate.drp_code || '')
    setAccountNumber(rate.account_number || '')
    setContactName(rate.contact_name || '')
    setContactPhone(rate.contact_phone || '')
    setContactEmail(rate.contact_email || '')

    // Populate rate inputs
    const inputs: Record<string, number> = {}
    for (const r of rate.rates || []) {
      if (r.labor_rate_type) {
        inputs[r.labor_rate_type.code] = r.hourly_rate
      }
    }
    setRateInputs(inputs)
    setShowAddModal(true)
  }

  const closeModal = () => {
    setShowAddModal(false)
    setEditingRates(null)
    setSelectedInsurer('')
    setRateInputs({})
  }

  const handleSave = async () => {
    if (!companyId) return
    if (!editingRates && !selectedInsurer) {
      setError('Please select an insurance company')
      return
    }

    try {
      setSaving(true)
      setError(null)

      let relationshipId: string

      if (editingRates) {
        // Update existing relationship
        await service.updateCompanyInsuranceRate(editingRates.id, {
          is_drp: isDrp,
          drp_code: drpCode || null,
          account_number: accountNumber || null,
          contact_name: contactName || null,
          contact_phone: contactPhone || null,
          contact_email: contactEmail || null
        })
        relationshipId = editingRates.id
      } else {
        // Create new relationship
        const relationship = await service.createCompanyInsuranceRate(
          companyId,
          selectedInsurer,
          {
            is_drp: isDrp,
            drp_code: drpCode || null,
            account_number: accountNumber || null,
            contact_name: contactName || null,
            contact_phone: contactPhone || null,
            contact_email: contactEmail || null
          }
        )
        relationshipId = relationship.id
      }

      // Save rates
      const rateData = laborRateTypes
        .filter(rt => rateInputs[rt.code] !== undefined)
        .map(rt => ({
          laborRateTypeId: rt.id,
          hourlyRate: rateInputs[rt.code]
        }))

      if (rateData.length > 0) {
        await service.setMultipleLaborRates(relationshipId, rateData)
      }

      setSuccess('Labor rates saved successfully')
      closeModal()
      loadData()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to remove this insurance company configuration?')) return

    try {
      await service.deleteCompanyInsuranceRate(id)
      setSuccess('Insurance configuration removed')
      loadData()
    } catch (err: any) {
      setError(err.message)
    }
  }

  const getRateForType = (rate: CompanyInsuranceRate, typeCode: string): number | null => {
    const found = rate.rates?.find(r => r.labor_rate_type?.code === typeCode)
    return found ? found.hourly_rate : null
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

  const canManage = ['admin', 'super_admin'].includes(userRole)

  return (
    <div className="p-6 max-w-7xl mx-auto">
      {/* Header */}
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Insurance Labor Rates</h1>
          <p className="text-gray-600 mt-1">
            Configure labor rates by insurance company for accurate estimate calculations
          </p>
        </div>
        {canManage && (
          <button
            onClick={openAddModal}
            className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 flex items-center gap-2"
          >
            <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
            </svg>
            Add Insurance Company
          </button>
        )}
      </div>

      {/* Alerts */}
      {error && (
        <div className="mb-4 bg-red-50 border border-red-200 text-red-700 p-3 rounded-lg flex justify-between items-center">
          <span>{error}</span>
          <button onClick={() => setError(null)} className="text-red-500 hover:text-red-700">×</button>
        </div>
      )}
      {success && (
        <div className="mb-4 bg-green-50 border border-green-200 text-green-700 p-3 rounded-lg flex justify-between items-center">
          <span>{success}</span>
          <button onClick={() => setSuccess(null)} className="text-green-500 hover:text-green-700">×</button>
        </div>
      )}

      {/* Main Content */}
      {companyRates.length === 0 ? (
        <div className="bg-white rounded-lg shadow p-12 text-center">
          <svg className="w-16 h-16 mx-auto text-gray-400 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
          </svg>
          <h3 className="text-lg font-medium text-gray-900 mb-2">No Labor Rates Configured</h3>
          <p className="text-gray-500 mb-4">
            Configure labor rates for each insurance company to accurately calculate estimate costs.
          </p>
          {canManage && (
            <button
              onClick={openAddModal}
              className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700"
            >
              Add Your First Insurance Company
            </button>
          )}
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Insurance Company</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">DRP</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Body</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Refinish</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Mechanical</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Structural</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Aluminum</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Glass</th>
                  {canManage && (
                    <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase">Actions</th>
                  )}
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {companyRates.map((rate) => (
                  <tr key={rate.id} className="hover:bg-gray-50">
                    <td className="px-4 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <div className="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                          <span className="text-blue-600 font-semibold text-sm">
                            {rate.insurance_company?.code || rate.insurance_company?.name?.substring(0, 2)}
                          </span>
                        </div>
                        <div className="ml-3">
                          <div className="text-sm font-medium text-gray-900">
                            {rate.insurance_company?.name}
                          </div>
                          {rate.account_number && (
                            <div className="text-xs text-gray-500">
                              Acct: {rate.account_number}
                            </div>
                          )}
                        </div>
                      </div>
                    </td>
                    <td className="px-4 py-4 whitespace-nowrap">
                      {rate.is_drp ? (
                        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                          DRP
                        </span>
                      ) : (
                        <span className="text-gray-400 text-sm">—</span>
                      )}
                    </td>
                    <td className="px-4 py-4 whitespace-nowrap text-center">
                      <span className="text-sm font-mono">
                        ${getRateForType(rate, 'BODY')?.toFixed(2) || '—'}
                      </span>
                    </td>
                    <td className="px-4 py-4 whitespace-nowrap text-center">
                      <span className="text-sm font-mono">
                        ${getRateForType(rate, 'REFINISH')?.toFixed(2) || '—'}
                      </span>
                    </td>
                    <td className="px-4 py-4 whitespace-nowrap text-center">
                      <span className="text-sm font-mono">
                        ${getRateForType(rate, 'MECHANICAL')?.toFixed(2) || '—'}
                      </span>
                    </td>
                    <td className="px-4 py-4 whitespace-nowrap text-center">
                      <span className="text-sm font-mono">
                        ${getRateForType(rate, 'STRUCTURAL')?.toFixed(2) || '—'}
                      </span>
                    </td>
                    <td className="px-4 py-4 whitespace-nowrap text-center">
                      <span className="text-sm font-mono">
                        ${getRateForType(rate, 'ALUMINUM')?.toFixed(2) || '—'}
                      </span>
                    </td>
                    <td className="px-4 py-4 whitespace-nowrap text-center">
                      <span className="text-sm font-mono">
                        ${getRateForType(rate, 'GLASS')?.toFixed(2) || '—'}
                      </span>
                    </td>
                    {canManage && (
                      <td className="px-4 py-4 whitespace-nowrap text-right text-sm font-medium">
                        <button
                          onClick={() => openEditModal(rate)}
                          className="text-blue-600 hover:text-blue-900 mr-3"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => handleDelete(rate.id)}
                          className="text-red-600 hover:text-red-900"
                        >
                          Remove
                        </button>
                      </td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Rate Guide */}
      <div className="mt-6 bg-blue-50 rounded-lg p-4">
        <h3 className="font-medium text-blue-900 mb-2">Labor Rate Types</h3>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm text-blue-800">
          <div><strong>Body:</strong> Standard body repair, R&I, R&R</div>
          <div><strong>Refinish:</strong> Paint, prime, clear coat</div>
          <div><strong>Mechanical:</strong> Suspension, drivetrain</div>
          <div><strong>Structural:</strong> Frame, measuring, pulling</div>
          <div><strong>Aluminum:</strong> Specialized aluminum work</div>
          <div><strong>Glass:</strong> Windshield, window install</div>
        </div>
      </div>

      {/* Add/Edit Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
            <div className="p-6 border-b">
              <h2 className="text-xl font-bold">
                {editingRates ? 'Edit Labor Rates' : 'Add Insurance Company'}
              </h2>
            </div>

            <div className="p-6 space-y-6">
              {/* Insurance Company Selection */}
              {!editingRates && (
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Insurance Company
                  </label>
                  <select
                    value={selectedInsurer}
                    onChange={(e) => setSelectedInsurer(e.target.value)}
                    className="w-full border rounded-lg px-3 py-2"
                  >
                    <option value="">Select an insurance company...</option>
                    {insuranceCompanies
                      .filter(ic => !getConfiguredInsurerIds().has(ic.id))
                      .map(ic => (
                        <option key={ic.id} value={ic.id}>{ic.name}</option>
                      ))
                    }
                  </select>
                </div>
              )}

              {(selectedInsurer || editingRates) && (
                <>
                  {/* DRP Status */}
                  <div className="flex items-center gap-4">
                    <label className="flex items-center gap-2">
                      <input
                        type="checkbox"
                        checked={isDrp}
                        onChange={(e) => setIsDrp(e.target.checked)}
                        className="rounded border-gray-300"
                      />
                      <span className="text-sm font-medium text-gray-700">
                        DRP (Direct Repair Program)
                      </span>
                    </label>
                  </div>

                  {/* Contact Info */}
                  <div className="grid grid-cols-2 gap-4">
                    {isDrp && (
                      <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">
                          DRP Code
                        </label>
                        <input
                          type="text"
                          value={drpCode}
                          onChange={(e) => setDrpCode(e.target.value)}
                          className="w-full border rounded-lg px-3 py-2"
                          placeholder="Your DRP code"
                        />
                      </div>
                    )}
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">
                        Account Number
                      </label>
                      <input
                        type="text"
                        value={accountNumber}
                        onChange={(e) => setAccountNumber(e.target.value)}
                        className="w-full border rounded-lg px-3 py-2"
                        placeholder="Shop account #"
                      />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">
                        Contact Name
                      </label>
                      <input
                        type="text"
                        value={contactName}
                        onChange={(e) => setContactName(e.target.value)}
                        className="w-full border rounded-lg px-3 py-2"
                        placeholder="Adjuster name"
                      />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">
                        Contact Phone
                      </label>
                      <input
                        type="text"
                        value={contactPhone}
                        onChange={(e) => setContactPhone(e.target.value)}
                        className="w-full border rounded-lg px-3 py-2"
                        placeholder="(555) 123-4567"
                      />
                    </div>
                    <div className="col-span-2">
                      <label className="block text-sm font-medium text-gray-700 mb-1">
                        Contact Email
                      </label>
                      <input
                        type="email"
                        value={contactEmail}
                        onChange={(e) => setContactEmail(e.target.value)}
                        className="w-full border rounded-lg px-3 py-2"
                        placeholder="adjuster@insurance.com"
                      />
                    </div>
                  </div>

                  {/* Labor Rates */}
                  <div>
                    <h3 className="font-medium text-gray-900 mb-3">Hourly Labor Rates</h3>
                    <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                      {laborRateTypes.map((type) => (
                        <div key={type.id}>
                          <label className="block text-sm font-medium text-gray-700 mb-1">
                            {type.name}
                          </label>
                          <div className="relative">
                            <span className="absolute left-3 top-2 text-gray-500">$</span>
                            <input
                              type="number"
                              step="0.01"
                              min="0"
                              value={rateInputs[type.code] ?? ''}
                              onChange={(e) => setRateInputs(prev => ({
                                ...prev,
                                [type.code]: parseFloat(e.target.value) || 0
                              }))}
                              className="w-full border rounded-lg pl-7 pr-3 py-2"
                              placeholder="0.00"
                            />
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </>
              )}
            </div>

            <div className="p-6 border-t bg-gray-50 flex justify-end gap-3">
              <button
                onClick={closeModal}
                className="px-4 py-2 text-gray-700 hover:text-gray-900"
              >
                Cancel
              </button>
              <button
                onClick={handleSave}
                disabled={saving || (!editingRates && !selectedInsurer)}
                className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 disabled:opacity-50"
              >
                {saving ? 'Saving...' : 'Save Labor Rates'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
