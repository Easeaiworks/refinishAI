'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Shield, Building2, Users, TrendingUp, Settings, AlertTriangle,
  X, Check, Plus, Trash2, Edit2, Package, Lock, Unlock, Search,
  ChevronDown, ChevronRight, Save
} from 'lucide-react'

interface Company {
  id: string
  name: string
  email: string
  subscription_status: string
  created_at: string
  vendors?: CompanyVendor[]
}

interface CompanyVendor {
  id: string
  company_id: string
  vendor_code: string
  vendor_name: string
  is_active: boolean
  is_primary: boolean
  discount_percent: number
  account_number: string
  notes: string
}

interface VendorCatalog {
  code: string
  name: string
  logo_url: string | null
  website: string | null
  description: string | null
  product_categories: string[]
  is_active: boolean
}

export default function AdminPage() {
  const [companies, setCompanies] = useState<Company[]>([])
  const [vendorCatalog, setVendorCatalog] = useState<VendorCatalog[]>([])
  const [stats, setStats] = useState({
    totalCompanies: 0,
    activeCompanies: 0,
    totalUsers: 0,
    totalProducts: 0
  })
  const [loading, setLoading] = useState(true)
  const [selectedCompany, setSelectedCompany] = useState<Company | null>(null)
  const [showVendorModal, setShowVendorModal] = useState(false)
  const [companyVendors, setCompanyVendors] = useState<CompanyVendor[]>([])
  const [searchTerm, setSearchTerm] = useState('')
  const [expandedCompany, setExpandedCompany] = useState<string | null>(null)
  const [userRole, setUserRole] = useState<string>('')
  const [userCompanyId, setUserCompanyId] = useState<string | null>(null)
  const supabase = createClient()

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    setLoading(true)

    // Get current user's role
    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('role, company_id')
        .eq('id', user.id)
        .single()

      if (profile) {
        setUserRole(profile.role)
        setUserCompanyId(profile.company_id)
      }
    }

    await loadData()
    await loadVendorCatalog()
    setLoading(false)
  }

  const loadData = async () => {
    // Load companies with their vendors
    const { data: companiesData } = await supabase
      .from('companies')
      .select('*')
      .order('created_at', { ascending: false })

    // Load all company vendors
    const { data: vendorsData } = await supabase
      .from('company_vendors')
      .select('*')

    // Load stats
    const { count: userCount } = await supabase
      .from('user_profiles')
      .select('*', { count: 'exact', head: true })

    const { count: productCount } = await supabase
      .from('products')
      .select('*', { count: 'exact', head: true })

    if (companiesData) {
      // Merge vendors with companies
      const companiesWithVendors = companiesData.map(company => ({
        ...company,
        vendors: vendorsData?.filter(v => v.company_id === company.id) || []
      }))

      setCompanies(companiesWithVendors)
      setStats({
        totalCompanies: companiesData.length,
        activeCompanies: companiesData.filter(c => c.subscription_status === 'active').length,
        totalUsers: userCount || 0,
        totalProducts: productCount || 0
      })
    }
  }

  const loadVendorCatalog = async () => {
    const { data } = await supabase
      .from('vendor_catalog')
      .select('*')
      .eq('is_active', true)
      .order('name')

    if (data) setVendorCatalog(data)
  }

  const loadCompanyVendors = async (companyId: string) => {
    const { data } = await supabase
      .from('company_vendors')
      .select('*')
      .eq('company_id', companyId)
      .order('vendor_name')

    if (data) setCompanyVendors(data)
  }

  const openVendorModal = async (company: Company) => {
    setSelectedCompany(company)
    await loadCompanyVendors(company.id)
    setShowVendorModal(true)
  }

  const toggleVendor = async (vendorCode: string, vendorName: string, isCurrentlyActive: boolean) => {
    if (!selectedCompany) return

    const { data: { user } } = await supabase.auth.getUser()

    if (isCurrentlyActive) {
      // Remove vendor
      await supabase
        .from('company_vendors')
        .delete()
        .eq('company_id', selectedCompany.id)
        .eq('vendor_code', vendorCode)
    } else {
      // Add vendor
      await supabase
        .from('company_vendors')
        .insert({
          company_id: selectedCompany.id,
          vendor_code: vendorCode,
          vendor_name: vendorName,
          is_active: true,
          added_by: user?.id
        })
    }

    await loadCompanyVendors(selectedCompany.id)
    await loadData()
  }

  const setPrimaryVendor = async (vendorCode: string) => {
    if (!selectedCompany) return

    // Clear all primary flags for this company
    await supabase
      .from('company_vendors')
      .update({ is_primary: false })
      .eq('company_id', selectedCompany.id)

    // Set new primary
    await supabase
      .from('company_vendors')
      .update({ is_primary: true })
      .eq('company_id', selectedCompany.id)
      .eq('vendor_code', vendorCode)

    await loadCompanyVendors(selectedCompany.id)
  }

  const updateVendorDetails = async (vendorCode: string, field: string, value: any) => {
    if (!selectedCompany) return

    await supabase
      .from('company_vendors')
      .update({ [field]: value })
      .eq('company_id', selectedCompany.id)
      .eq('vendor_code', vendorCode)

    await loadCompanyVendors(selectedCompany.id)
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active': return 'bg-green-100 text-green-800'
      case 'trial': return 'bg-blue-100 text-blue-800'
      case 'suspended': return 'bg-red-100 text-red-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  const getVendorColor = (code: string) => {
    const colors: Record<string, string> = {
      ppg: 'bg-blue-500',
      axalta: 'bg-red-500',
      sherwin_williams: 'bg-yellow-500',
      basf: 'bg-purple-500',
      dupont: 'bg-orange-500',
      '3m': 'bg-red-600',
      norton: 'bg-green-600',
      sata: 'bg-gray-600',
      devilbiss: 'bg-indigo-500',
      generic: 'bg-gray-400'
    }
    return colors[code] || 'bg-gray-400'
  }

  const filteredCompanies = companies.filter(c =>
    c.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    c.email.toLowerCase().includes(searchTerm.toLowerCase())
  )

  const isSuperAdmin = userRole === 'super_admin'

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <div className="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center">
          <Shield className="w-6 h-6 text-red-600" />
        </div>
        <div>
          <h1 className="text-3xl font-bold text-gray-900">
            {isSuperAdmin ? 'Super Admin Panel' : 'Admin Settings'}
          </h1>
          <p className="text-gray-600">
            {isSuperAdmin ? 'Platform-wide management and vendor assignments' : 'Company settings and configuration'}
          </p>
        </div>
      </div>

      {/* Warning */}
      <div className="bg-red-50 border border-red-200 rounded-lg p-4">
        <div className="flex items-start gap-3">
          <AlertTriangle className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
          <div>
            <p className="font-semibold text-red-900">
              {isSuperAdmin ? 'Super Admin Access' : 'Admin Access'}
            </p>
            <p className="text-sm text-red-700 mt-1">
              {isSuperAdmin
                ? 'You have elevated permissions to manage all companies, users, and vendor assignments.'
                : 'You can manage company settings. Vendor changes require Super Admin approval.'}
            </p>
          </div>
        </div>
      </div>

      {/* Platform Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Total Companies</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{stats.totalCompanies}</p>
            </div>
            <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <Building2 className="w-6 h-6 text-blue-600" />
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Active Subs</p>
              <p className="text-3xl font-bold text-green-600 mt-2">{stats.activeCompanies}</p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <TrendingUp className="w-6 h-6 text-green-600" />
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Total Users</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{stats.totalUsers}</p>
            </div>
            <div className="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
              <Users className="w-6 h-6 text-purple-600" />
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Vendors Available</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{vendorCatalog.length}</p>
            </div>
            <div className="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
              <Package className="w-6 h-6 text-orange-600" />
            </div>
          </div>
        </div>
      </div>

      {/* Search */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
        <input
          type="text"
          placeholder="Search companies..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        />
      </div>

      {/* Companies List with Vendor Management */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
        <div className="px-6 py-4 border-b border-gray-200 flex items-center justify-between">
          <h2 className="text-lg font-bold text-gray-900">Companies & Vendor Assignments</h2>
          <div className="flex items-center gap-2 text-sm text-gray-500">
            <Lock className="w-4 h-4" />
            <span>Vendor access is locked per company</span>
          </div>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
          </div>
        ) : (
          <div className="divide-y divide-gray-100">
            {filteredCompanies.map((company) => (
              <div key={company.id} className="hover:bg-gray-50">
                {/* Company Row */}
                <div
                  className="flex items-center justify-between p-4 cursor-pointer"
                  onClick={() => setExpandedCompany(expandedCompany === company.id ? null : company.id)}
                >
                  <div className="flex items-center gap-4">
                    <button className="text-gray-400">
                      {expandedCompany === company.id ? (
                        <ChevronDown className="w-5 h-5" />
                      ) : (
                        <ChevronRight className="w-5 h-5" />
                      )}
                    </button>
                    <div>
                      <p className="font-medium text-gray-900">{company.name}</p>
                      <p className="text-sm text-gray-500">{company.email}</p>
                    </div>
                  </div>

                  <div className="flex items-center gap-4">
                    {/* Vendor Pills */}
                    <div className="flex items-center gap-1">
                      {company.vendors && company.vendors.length > 0 ? (
                        company.vendors.slice(0, 4).map(v => (
                          <span
                            key={v.vendor_code}
                            className={`px-2 py-1 rounded text-xs font-medium text-white ${getVendorColor(v.vendor_code)}`}
                            title={v.vendor_name}
                          >
                            {v.vendor_code.toUpperCase().slice(0, 3)}
                          </span>
                        ))
                      ) : (
                        <span className="text-sm text-gray-400">No vendors assigned</span>
                      )}
                      {company.vendors && company.vendors.length > 4 && (
                        <span className="text-xs text-gray-500">+{company.vendors.length - 4}</span>
                      )}
                    </div>

                    <span className={`px-2.5 py-0.5 rounded-full text-xs font-medium ${getStatusColor(company.subscription_status)}`}>
                      {company.subscription_status}
                    </span>

                    {isSuperAdmin && (
                      <button
                        onClick={(e) => {
                          e.stopPropagation()
                          openVendorModal(company)
                        }}
                        className="px-3 py-1.5 text-sm font-medium text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                      >
                        Manage Vendors
                      </button>
                    )}
                  </div>
                </div>

                {/* Expanded Details */}
                {expandedCompany === company.id && (
                  <div className="px-4 pb-4 pl-14 bg-gray-50">
                    <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
                      <div>
                        <p className="text-xs text-gray-500 uppercase">Joined</p>
                        <p className="font-medium">{new Date(company.created_at).toLocaleDateString()}</p>
                      </div>
                      <div>
                        <p className="text-xs text-gray-500 uppercase">Active Vendors</p>
                        <p className="font-medium">{company.vendors?.filter(v => v.is_active).length || 0}</p>
                      </div>
                      <div>
                        <p className="text-xs text-gray-500 uppercase">Primary Vendor</p>
                        <p className="font-medium">
                          {company.vendors?.find(v => v.is_primary)?.vendor_name || 'None set'}
                        </p>
                      </div>
                    </div>

                    {company.vendors && company.vendors.length > 0 && (
                      <div className="mt-3">
                        <p className="text-xs text-gray-500 uppercase mb-2">Assigned Vendors</p>
                        <div className="flex flex-wrap gap-2">
                          {company.vendors.map(v => (
                            <div
                              key={v.vendor_code}
                              className={`flex items-center gap-2 px-3 py-1.5 rounded-lg border ${
                                v.is_primary ? 'bg-blue-50 border-blue-200' : 'bg-white border-gray-200'
                              }`}
                            >
                              <span className={`w-2 h-2 rounded-full ${getVendorColor(v.vendor_code)}`}></span>
                              <span className="text-sm font-medium">{v.vendor_name}</span>
                              {v.is_primary && (
                                <span className="text-xs bg-blue-100 text-blue-700 px-1.5 rounded">Primary</span>
                              )}
                              {v.discount_percent > 0 && (
                                <span className="text-xs text-green-600">{v.discount_percent}% off</span>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Vendor Catalog Reference */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <h2 className="text-lg font-bold text-gray-900 mb-4">Available Vendor Catalog</h2>
        <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
          {vendorCatalog.map(vendor => (
            <div
              key={vendor.code}
              className="p-4 border border-gray-200 rounded-lg hover:border-gray-300 transition-colors"
            >
              <div className={`w-10 h-10 rounded-lg ${getVendorColor(vendor.code)} flex items-center justify-center text-white font-bold text-sm mb-3`}>
                {vendor.code.slice(0, 2).toUpperCase()}
              </div>
              <p className="font-medium text-gray-900">{vendor.name}</p>
              <p className="text-xs text-gray-500 mt-1">
                {vendor.product_categories?.slice(0, 3).join(', ')}
              </p>
            </div>
          ))}
        </div>
      </div>

      {/* Vendor Management Modal */}
      {showVendorModal && selectedCompany && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full max-h-[90vh] overflow-hidden flex flex-col">
            <div className="p-6 border-b border-gray-200">
              <div className="flex items-center justify-between">
                <div>
                  <h2 className="text-xl font-bold text-gray-900">Manage Vendors</h2>
                  <p className="text-gray-600 mt-1">{selectedCompany.name}</p>
                </div>
                <button
                  onClick={() => setShowVendorModal(false)}
                  className="text-gray-400 hover:text-gray-600"
                >
                  <X className="w-6 h-6" />
                </button>
              </div>
            </div>

            <div className="flex-1 overflow-auto p-6">
              <div className="space-y-3">
                {vendorCatalog.map(vendor => {
                  const companyVendor = companyVendors.find(cv => cv.vendor_code === vendor.code)
                  const isActive = !!companyVendor

                  return (
                    <div
                      key={vendor.code}
                      className={`p-4 rounded-lg border-2 transition-all ${
                        isActive
                          ? 'border-green-500 bg-green-50'
                          : 'border-gray-200 bg-white hover:border-gray-300'
                      }`}
                    >
                      <div className="flex items-start justify-between">
                        <div className="flex items-start gap-3">
                          <div className={`w-12 h-12 rounded-lg ${getVendorColor(vendor.code)} flex items-center justify-center text-white font-bold`}>
                            {vendor.code.slice(0, 2).toUpperCase()}
                          </div>
                          <div>
                            <p className="font-semibold text-gray-900">{vendor.name}</p>
                            <p className="text-sm text-gray-500">{vendor.description}</p>
                            <div className="flex flex-wrap gap-1 mt-2">
                              {vendor.product_categories?.map(cat => (
                                <span
                                  key={cat}
                                  className="px-2 py-0.5 bg-gray-100 text-gray-600 text-xs rounded"
                                >
                                  {cat}
                                </span>
                              ))}
                            </div>
                          </div>
                        </div>

                        <button
                          onClick={() => toggleVendor(vendor.code, vendor.name, isActive)}
                          className={`px-4 py-2 rounded-lg font-medium transition-colors ${
                            isActive
                              ? 'bg-red-100 text-red-700 hover:bg-red-200'
                              : 'bg-green-100 text-green-700 hover:bg-green-200'
                          }`}
                        >
                          {isActive ? (
                            <span className="flex items-center gap-2">
                              <Lock className="w-4 h-4" />
                              Remove Access
                            </span>
                          ) : (
                            <span className="flex items-center gap-2">
                              <Unlock className="w-4 h-4" />
                              Grant Access
                            </span>
                          )}
                        </button>
                      </div>

                      {/* Extra settings if active */}
                      {isActive && companyVendor && (
                        <div className="mt-4 pt-4 border-t border-green-200 grid grid-cols-3 gap-4">
                          <div>
                            <label className="block text-xs font-medium text-gray-700 mb-1">
                              Primary Vendor
                            </label>
                            <button
                              onClick={() => setPrimaryVendor(vendor.code)}
                              className={`w-full px-3 py-2 rounded-lg text-sm font-medium ${
                                companyVendor.is_primary
                                  ? 'bg-blue-600 text-white'
                                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                              }`}
                            >
                              {companyVendor.is_primary ? '★ Primary' : 'Set as Primary'}
                            </button>
                          </div>
                          <div>
                            <label className="block text-xs font-medium text-gray-700 mb-1">
                              Discount %
                            </label>
                            <input
                              type="number"
                              min="0"
                              max="50"
                              value={companyVendor.discount_percent || 0}
                              onChange={(e) => updateVendorDetails(vendor.code, 'discount_percent', parseFloat(e.target.value) || 0)}
                              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm"
                            />
                          </div>
                          <div>
                            <label className="block text-xs font-medium text-gray-700 mb-1">
                              Account #
                            </label>
                            <input
                              type="text"
                              value={companyVendor.account_number || ''}
                              onChange={(e) => updateVendorDetails(vendor.code, 'account_number', e.target.value)}
                              placeholder="Optional"
                              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm"
                            />
                          </div>
                        </div>
                      )}
                    </div>
                  )
                })}
              </div>
            </div>

            <div className="p-6 border-t border-gray-200 bg-gray-50">
              <div className="flex items-center justify-between">
                <p className="text-sm text-gray-600">
                  {companyVendors.filter(v => v.is_active !== false).length} vendors assigned
                </p>
                <button
                  onClick={() => {
                    setShowVendorModal(false)
                    loadData()
                  }}
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
                >
                  Done
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
