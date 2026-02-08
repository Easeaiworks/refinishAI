'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Shield, Building2, Users, TrendingUp,
  X, Plus, Trash2, Edit2, Package, Search,
  ChevronDown, ChevronRight, Mail, Key, UserPlus,
  RefreshCw, Check, XCircle, Eye, EyeOff, Truck, DollarSign,
  MapPin, Lock
} from 'lucide-react'

interface Company {
  id: string
  name: string
  email: string
  phone?: string
  address?: string
  city?: string
  state?: string
  zip?: string
  website?: string
  subscription_status: string
  created_at: string
  parent_company_id?: string
  company_type: 'single' | 'corporate' | 'location'
  location_code?: string
  is_headquarters?: boolean
  users?: UserProfile[]
  vendors?: CompanyVendor[]
  child_locations?: Company[]
}

interface UserProfile {
  id: string
  email: string
  full_name: string
  role: string
  company_id: string
  is_active: boolean
  is_corporate_user?: boolean
  created_at: string
}

interface VendorCatalog {
  code: string
  name: string
  website?: string
  description?: string
  product_categories?: string[]
  is_active: boolean
}

interface CompanyVendor {
  id: string
  company_id: string
  vendor_code: string
  vendor_name: string
  is_active: boolean
  is_primary: boolean
  discount_percent: number
  account_number?: string
}

interface InsuranceCompany {
  id: string
  name: string
  code: string
  phone?: string
  email?: string
  website?: string
  is_active: boolean
}

interface CompanyInsuranceRate {
  id: string
  company_id: string
  insurance_company_id: string
  is_drp: boolean
  drp_code?: string
  account_number?: string
  contact_name?: string
  insurance_company?: InsuranceCompany
  company?: Company
}

interface CorporateSettings {
  parent_company_id: string
  setting_key: string
  setting_value: Record<string, any>
  enforce_lock: boolean
}

interface LocationRow {
  id: string
  name: string
  location_code: string
}

export default function SuperAdminPage() {
  const [companies, setCompanies] = useState<Company[]>([])
  const [allUsers, setAllUsers] = useState<UserProfile[]>([])
  const [vendorCatalog, setVendorCatalog] = useState<VendorCatalog[]>([])
  const [companyVendors, setCompanyVendors] = useState<CompanyVendor[]>([])
  const [insuranceCompanies, setInsuranceCompanies] = useState<InsuranceCompany[]>([])
  const [companyInsuranceRates, setCompanyInsuranceRates] = useState<CompanyInsuranceRate[]>([])
  const [stats, setStats] = useState({
    totalCompanies: 0,
    activeCompanies: 0,
    totalUsers: 0,
    totalProducts: 0
  })
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [expandedCompany, setExpandedCompany] = useState<string | null>(null)
  const [userRole, setUserRole] = useState<string>('')
  const [activeTab, setActiveTab] = useState<'companies' | 'users' | 'vendors' | 'insurance'>('companies')
  const [companiesViewMode, setCompaniesViewMode] = useState<'list' | 'hierarchy'>('list')

  // Modals
  const [showAddCompanyModal, setShowAddCompanyModal] = useState(false)
  const [showAddUserModal, setShowAddUserModal] = useState(false)
  const [showResetPasswordModal, setShowResetPasswordModal] = useState(false)
  const [showVendorModal, setShowVendorModal] = useState(false)
  const [editingCompany, setEditingCompany] = useState<Company | null>(null)
  const [selectedUser, setSelectedUser] = useState<UserProfile | null>(null)
  const [selectedCompanyForUser, setSelectedCompanyForUser] = useState<string>('')
  const [selectedCompanyForVendor, setSelectedCompanyForVendor] = useState<Company | null>(null)

  const supabase = createClient()

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    setLoading(true)

    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('role, company_id')
        .eq('id', user.id)
        .single()

      if (profile) {
        setUserRole(profile.role)
        if (profile.role !== 'super_admin') {
          setLoading(false)
          return
        }
      }
    }

    await loadData()
    setLoading(false)
  }

  const loadData = async () => {
    // Load companies
    const { data: companiesData } = await supabase
      .from('companies')
      .select('*')
      .order('created_at', { ascending: false })

    // Load all users
    const { data: usersData } = await supabase
      .from('user_profiles')
      .select('*')
      .order('created_at', { ascending: false })

    // Load vendor catalog
    const { data: catalogData } = await supabase
      .from('vendor_catalog')
      .select('*')
      .eq('is_active', true)
      .order('name')

    // Load all company vendors
    const { data: vendorsData } = await supabase
      .from('company_vendors')
      .select('*')

    // Load insurance companies
    const { data: insuranceData } = await supabase
      .from('insurance_companies')
      .select('*')
      .eq('is_active', true)
      .order('name')

    // Load all company insurance rates
    const { data: insuranceRatesData } = await supabase
      .from('company_insurance_rates')
      .select('*, insurance_company:insurance_companies(*)')

    // Load stats
    const { count: productCount } = await supabase
      .from('products')
      .select('*', { count: 'exact', head: true })

    if (companiesData) {
      const companiesWithData = companiesData.map((company: any) => ({
        ...company,
        users: usersData?.filter(u => u.company_id === company.id) || [],
        vendors: vendorsData?.filter(v => v.company_id === company.id) || []
      }))

      setCompanies(companiesWithData)
      setAllUsers(usersData || [])
      setVendorCatalog(catalogData || [])
      setCompanyVendors(vendorsData || [])
      setInsuranceCompanies(insuranceData || [])
      setCompanyInsuranceRates(insuranceRatesData || [])
      setStats({
        totalCompanies: companiesData.length,
        activeCompanies: companiesData.filter((c: any) => c.subscription_status === 'active').length,
        totalUsers: usersData?.length || 0,
        totalProducts: productCount || 0
      })
    }
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active': return 'bg-green-100 text-green-800'
      case 'trial': return 'bg-blue-100 text-blue-800'
      case 'suspended': return 'bg-red-100 text-red-800'
      case 'cancelled': return 'bg-gray-100 text-gray-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  const getRoleColor = (role: string) => {
    switch (role) {
      case 'super_admin': return 'bg-red-100 text-red-800'
      case 'admin': return 'bg-purple-100 text-purple-800'
      case 'manager': return 'bg-blue-100 text-blue-800'
      case 'staff': return 'bg-gray-100 text-gray-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  const getCompanyTypeBadge = (company: Company) => {
    if (company.company_type === 'single') {
      return <span className="px-2 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-700">Single</span>
    } else if (company.company_type === 'corporate') {
      const childCount = companies.filter(c => c.parent_company_id === company.id).length
      return <span className="px-2 py-1 rounded-full text-xs font-medium bg-purple-100 text-purple-700">Corporate ({childCount})</span>
    } else if (company.company_type === 'location') {
      return <span className="px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-700">{company.location_code}</span>
    }
    return null
  }

  const updateCompanyStatus = async (companyId: string, status: string) => {
    await supabase
      .from('companies')
      .update({ subscription_status: status })
      .eq('id', companyId)
    await loadData()
  }

  const updateUserRole = async (userId: string, role: string) => {
    await supabase
      .from('user_profiles')
      .update({ role })
      .eq('id', userId)
    await loadData()
  }

  const toggleUserActive = async (userId: string, isActive: boolean) => {
    await supabase
      .from('user_profiles')
      .update({ is_active: !isActive })
      .eq('id', userId)
    await loadData()
  }

  const deleteCompany = async (companyId: string) => {
    if (!confirm('Are you sure? This will delete the company and all associated data.')) return
    await supabase.from('companies').delete().eq('id', companyId)
    await loadData()
  }

  const addVendorToCompany = async (companyId: string, vendorCode: string, vendorName: string, isPrimary: boolean = false) => {
    await supabase.from('company_vendors').insert({
      company_id: companyId,
      vendor_code: vendorCode,
      vendor_name: vendorName,
      is_active: true,
      is_primary: isPrimary,
      discount_percent: 0
    })
    await loadData()
  }

  const removeVendorFromCompany = async (vendorId: string) => {
    await supabase.from('company_vendors').delete().eq('id', vendorId)
    await loadData()
  }

  const toggleVendorPrimary = async (vendorId: string, companyId: string) => {
    await supabase
      .from('company_vendors')
      .update({ is_primary: false })
      .eq('company_id', companyId)

    await supabase
      .from('company_vendors')
      .update({ is_primary: true })
      .eq('id', vendorId)

    await loadData()
  }

  const filteredCompanies = companies.filter(c =>
    c.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    c.email?.toLowerCase().includes(searchTerm.toLowerCase())
  )

  const filteredUsers = allUsers.filter(u =>
    u.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
    u.full_name?.toLowerCase().includes(searchTerm.toLowerCase())
  )

  const getChildLocations = (parentId: string) => {
    return companies.filter(c => c.parent_company_id === parentId && c.company_type === 'location')
  }

  if (userRole !== 'super_admin') {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <Shield className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <h2 className="text-2xl font-bold text-gray-900 mb-2">Access Denied</h2>
          <p className="text-gray-600">You need Super Admin privileges to access this page.</p>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center">
            <Shield className="w-6 h-6 text-red-600" />
          </div>
          <div>
            <h1 className="text-3xl font-bold text-gray-900">Super Admin Panel</h1>
            <p className="text-gray-600">Manage companies, users, and vendors</p>
          </div>
        </div>
        <div className="flex gap-2">
          <button
            onClick={() => setShowAddCompanyModal(true)}
            className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            <Plus className="w-4 h-4" />
            Add Company
          </button>
        </div>
      </div>

      {/* Stats */}
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
              <p className="text-sm font-medium text-gray-600">Active Subscriptions</p>
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
              <p className="text-sm font-medium text-gray-600">Total Products</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{stats.totalProducts}</p>
            </div>
            <div className="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
              <Package className="w-6 h-6 text-orange-600" />
            </div>
          </div>
        </div>
      </div>

      {/* Tabs */}
      <div className="border-b border-gray-200">
        <nav className="flex gap-4">
          <button
            onClick={() => setActiveTab('companies')}
            className={`pb-3 px-1 text-sm font-medium border-b-2 transition-colors ${
              activeTab === 'companies'
                ? 'border-blue-600 text-blue-600'
                : 'border-transparent text-gray-500 hover:text-gray-700'
            }`}
          >
            <Building2 className="w-4 h-4 inline-block mr-2" />
            Companies ({companies.length})
          </button>
          <button
            onClick={() => setActiveTab('users')}
            className={`pb-3 px-1 text-sm font-medium border-b-2 transition-colors ${
              activeTab === 'users'
                ? 'border-blue-600 text-blue-600'
                : 'border-transparent text-gray-500 hover:text-gray-700'
            }`}
          >
            <Users className="w-4 h-4 inline-block mr-2" />
            Users ({allUsers.length})
          </button>
          <button
            onClick={() => setActiveTab('vendors')}
            className={`pb-3 px-1 text-sm font-medium border-b-2 transition-colors ${
              activeTab === 'vendors'
                ? 'border-blue-600 text-blue-600'
                : 'border-transparent text-gray-500 hover:text-gray-700'
            }`}
          >
            <Truck className="w-4 h-4 inline-block mr-2" />
            Vendor Assignments
          </button>
          <button
            onClick={() => setActiveTab('insurance')}
            className={`pb-3 px-1 text-sm font-medium border-b-2 transition-colors ${
              activeTab === 'insurance'
                ? 'border-blue-600 text-blue-600'
                : 'border-transparent text-gray-500 hover:text-gray-700'
            }`}
          >
            <DollarSign className="w-4 h-4 inline-block mr-2" />
            Insurance Rates
          </button>
        </nav>
      </div>

      {/* Search */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
        <input
          type="text"
          placeholder={activeTab === 'companies' ? 'Search companies...' : activeTab === 'users' ? 'Search users...' : 'Search...'}
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        />
      </div>

      {/* Companies Tab */}
      {activeTab === 'companies' && (
        <div className="space-y-4">
          {/* View Toggle */}
          <div className="flex gap-2">
            <button
              onClick={() => setCompaniesViewMode('list')}
              className={`px-4 py-2 rounded-lg font-medium transition-colors ${
                companiesViewMode === 'list'
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
              }`}
            >
              List View
            </button>
            <button
              onClick={() => setCompaniesViewMode('hierarchy')}
              className={`px-4 py-2 rounded-lg font-medium transition-colors ${
                companiesViewMode === 'hierarchy'
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
              }`}
            >
              Hierarchy View
            </button>
          </div>

          {/* Companies List/Hierarchy */}
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            {loading ? (
              <div className="flex items-center justify-center py-12">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
              </div>
            ) : filteredCompanies.length === 0 ? (
              <div className="text-center py-12">
                <Building2 className="w-12 h-12 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-600">No companies found</p>
              </div>
            ) : companiesViewMode === 'list' ? (
              <ListViewCompanies
                filteredCompanies={filteredCompanies}
                expandedCompany={expandedCompany}
                setExpandedCompany={setExpandedCompany}
                getCompanyTypeBadge={getCompanyTypeBadge}
                updateCompanyStatus={updateCompanyStatus}
                setEditingCompany={setEditingCompany}
                setShowAddCompanyModal={setShowAddCompanyModal}
                setSelectedCompanyForVendor={setSelectedCompanyForVendor}
                setShowVendorModal={setShowVendorModal}
                setSelectedCompanyForUser={setSelectedCompanyForUser}
                setShowAddUserModal={setShowAddUserModal}
                deleteCompany={deleteCompany}
                updateUserRole={updateUserRole}
                toggleUserActive={toggleUserActive}
                setSelectedUser={setSelectedUser}
                setShowResetPasswordModal={setShowResetPasswordModal}
                getChildLocations={getChildLocations}
              />
            ) : (
              <HierarchyViewCompanies
                companies={filteredCompanies}
                expandedCompany={expandedCompany}
                setExpandedCompany={setExpandedCompany}
                getCompanyTypeBadge={getCompanyTypeBadge}
                updateCompanyStatus={updateCompanyStatus}
                setEditingCompany={setEditingCompany}
                setShowAddCompanyModal={setShowAddCompanyModal}
                setSelectedCompanyForVendor={setSelectedCompanyForVendor}
                setShowVendorModal={setShowVendorModal}
                setSelectedCompanyForUser={setSelectedCompanyForUser}
                setShowAddUserModal={setShowAddUserModal}
                deleteCompany={deleteCompany}
                getChildLocations={getChildLocations}
              />
            )}
          </div>
        </div>
      )}

      {/* Users Tab */}
      {activeTab === 'users' && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">User</th>
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Company</th>
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Role</th>
                <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700">Status</th>
                <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredUsers.map((user) => {
                const company = companies.find(c => c.id === user.company_id)
                return (
                  <tr key={user.id} className="border-b border-gray-100 hover:bg-gray-50">
                    <td className="py-3 px-4">
                      <div className="flex items-center gap-3">
                        <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white text-sm font-medium ${
                          user.is_active ? 'bg-blue-500' : 'bg-gray-400'
                        }`}>
                          {user.full_name?.charAt(0) || user.email.charAt(0).toUpperCase()}
                        </div>
                        <div>
                          <div className="flex items-center gap-2">
                            <p className="font-medium text-gray-900">{user.full_name || 'No name'}</p>
                            {user.is_corporate_user && (
                              <span className="px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-700">Corporate User</span>
                            )}
                          </div>
                          <p className="text-sm text-gray-500">{user.email}</p>
                        </div>
                      </div>
                    </td>
                    <td className="py-3 px-4 text-gray-600">{company?.name || 'No company'}</td>
                    <td className="py-3 px-4">
                      <select
                        value={user.role}
                        onChange={(e) => updateUserRole(user.id, e.target.value)}
                        className={`px-2 py-1 rounded text-xs font-medium border-0 cursor-pointer ${getRoleColor(user.role)}`}
                      >
                        <option value="staff">Staff</option>
                        <option value="manager">Manager</option>
                        <option value="admin">Admin</option>
                        <option value="super_admin">Super Admin</option>
                      </select>
                    </td>
                    <td className="py-3 px-4 text-center">
                      <button
                        onClick={() => toggleUserActive(user.id, user.is_active)}
                        className={`px-2.5 py-1 rounded-full text-xs font-medium ${
                          user.is_active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
                        }`}
                      >
                        {user.is_active ? 'Active' : 'Inactive'}
                      </button>
                    </td>
                    <td className="py-3 px-4 text-right">
                      <button
                        onClick={() => {
                          setSelectedUser(user)
                          setShowResetPasswordModal(true)
                        }}
                        className="p-2 text-orange-600 hover:bg-orange-50 rounded-lg"
                      >
                        <Key className="w-4 h-4" />
                      </button>
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
      )}

      {/* Vendors Tab */}
      {activeTab === 'vendors' && (
        <div className="space-y-6">
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <h3 className="font-semibold text-blue-900 mb-2">Vendor Management</h3>
            <p className="text-blue-800 text-sm">
              Assign vendors to companies. Each company can have multiple vendors, with one marked as primary.
              Click the truck icon next to any company above, or expand a company to see assigned vendors.
            </p>
          </div>

          <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            <div className="p-4 border-b border-gray-200 bg-gray-50">
              <h3 className="font-semibold text-gray-900">Available Vendors</h3>
            </div>
            <div className="divide-y divide-gray-100">
              {vendorCatalog.map(vendor => (
                <div key={vendor.code} className="p-4 flex items-center justify-between">
                  <div>
                    <p className="font-medium text-gray-900">{vendor.name}</p>
                    <p className="text-sm text-gray-500">{vendor.description}</p>
                    {vendor.product_categories && (
                      <div className="flex gap-1 mt-1">
                        {vendor.product_categories.map(cat => (
                          <span key={cat} className="px-2 py-0.5 bg-gray-100 text-gray-600 text-xs rounded">
                            {cat}
                          </span>
                        ))}
                      </div>
                    )}
                  </div>
                  <div className="text-sm text-gray-500">
                    {companyVendors.filter(cv => cv.vendor_code === vendor.code).length} companies
                  </div>
                </div>
              ))}
            </div>
          </div>

          <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            <div className="p-4 border-b border-gray-200 bg-gray-50">
              <h3 className="font-semibold text-gray-900">Company Vendor Assignments</h3>
            </div>
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Company</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Assigned Vendors</th>
                  <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>
                </tr>
              </thead>
              <tbody>
                {companies.map(company => (
                  <tr key={company.id} className="border-b border-gray-100 hover:bg-gray-50">
                    <td className="py-3 px-4">
                      <p className="font-medium text-gray-900">{company.name}</p>
                      {company.company_type === 'corporate' && (
                        <p className="text-xs text-gray-500 mt-1">Changes to primary vendor will cascade to all locations</p>
                      )}
                    </td>
                    <td className="py-3 px-4">
                      {company.vendors && company.vendors.length > 0 ? (
                        <div className="flex flex-wrap gap-2">
                          {company.vendors.map(v => (
                            <span
                              key={v.id}
                              className={`px-2 py-1 rounded text-xs font-medium ${
                                v.is_primary ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-700'
                              }`}
                            >
                              {v.vendor_name} {v.is_primary && '(Primary)'}
                            </span>
                          ))}
                        </div>
                      ) : (
                        <span className="text-gray-400 text-sm">No vendors assigned</span>
                      )}
                    </td>
                    <td className="py-3 px-4 text-right">
                      <button
                        onClick={() => {
                          setSelectedCompanyForVendor(company)
                          setShowVendorModal(true)
                        }}
                        className="px-3 py-1.5 text-sm text-purple-600 hover:bg-purple-50 rounded-lg font-medium"
                      >
                        Manage
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Insurance Tab */}
      {activeTab === 'insurance' && (
        <div className="space-y-6">
          <div className="bg-green-50 border border-green-200 rounded-lg p-4">
            <h3 className="font-semibold text-green-900 mb-2">Insurance Rate Management</h3>
            <p className="text-green-800 text-sm">
              View all insurance companies in the system and see which shops have configured rates for each insurer.
              Each shop manages their own rates through Settings → Insurance.
            </p>
          </div>

          {/* Insurance Companies List */}
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            <div className="p-4 border-b border-gray-200 bg-gray-50">
              <h3 className="font-semibold text-gray-900">Insurance Companies ({insuranceCompanies.length})</h3>
            </div>
            <div className="divide-y divide-gray-100">
              {insuranceCompanies.map(insurer => {
                const shopCount = companyInsuranceRates.filter(r => r.insurance_company_id === insurer.id).length
                return (
                  <div key={insurer.id} className="p-4 flex items-center justify-between hover:bg-gray-50">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                        <span className="text-green-700 font-semibold text-sm">{insurer.code}</span>
                      </div>
                      <div>
                        <p className="font-medium text-gray-900">{insurer.name}</p>
                        {insurer.website && (
                          <p className="text-xs text-gray-500">{insurer.website}</p>
                        )}
                      </div>
                    </div>
                    <div className="text-right">
                      <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${
                        shopCount > 0 ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-600'
                      }`}>
                        {shopCount} {shopCount === 1 ? 'shop' : 'shops'}
                      </span>
                    </div>
                  </div>
                )
              })}
              {insuranceCompanies.length === 0 && (
                <div className="p-8 text-center text-gray-500">
                  <DollarSign className="w-12 h-12 mx-auto mb-4 text-gray-300" />
                  <p>No insurance companies found in the system.</p>
                  <p className="text-sm">Run the insurance migration to seed default insurers.</p>
                </div>
              )}
            </div>
          </div>

          {/* Company Insurance Configurations */}
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            <div className="p-4 border-b border-gray-200 bg-gray-50">
              <h3 className="font-semibold text-gray-900">Shop Insurance Configurations</h3>
            </div>
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Company</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Insurance</th>
                  <th className="text-center py-3 px-4 text-sm font-semibold text-gray-700">DRP</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Account #</th>
                </tr>
              </thead>
              <tbody>
                {companyInsuranceRates.length === 0 ? (
                  <tr>
                    <td colSpan={4} className="py-8 text-center text-gray-500">
                      No insurance configurations found. Shops can configure rates from their Settings page.
                    </td>
                  </tr>
                ) : (
                  companyInsuranceRates.map(rate => {
                    const company = companies.find(c => c.id === rate.company_id)
                    return (
                      <tr key={rate.id} className="border-b border-gray-100 hover:bg-gray-50">
                        <td className="py-3 px-4">
                          <p className="font-medium text-gray-900">{company?.name || 'Unknown'}</p>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex items-center gap-2">
                            <span className="text-xs font-medium text-gray-500">{rate.insurance_company?.code}</span>
                            <span className="text-gray-900">{rate.insurance_company?.name}</span>
                          </div>
                        </td>
                        <td className="py-3 px-4 text-center">
                          {rate.is_drp ? (
                            <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                              DRP
                            </span>
                          ) : (
                            <span className="text-gray-400">—</span>
                          )}
                        </td>
                        <td className="py-3 px-4 text-gray-600 text-sm">
                          {rate.account_number || '—'}
                        </td>
                      </tr>
                    )
                  })
                )}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Modals */}
      {showAddCompanyModal && (
        <CompanyModal
          company={editingCompany}
          onClose={() => {
            setShowAddCompanyModal(false)
            setEditingCompany(null)
          }}
          onSave={() => {
            loadData()
            setShowAddCompanyModal(false)
            setEditingCompany(null)
          }}
        />
      )}

      {showAddUserModal && (
        <AddUserModal
          companies={companies}
          defaultCompanyId={selectedCompanyForUser}
          onClose={() => {
            setShowAddUserModal(false)
            setSelectedCompanyForUser('')
          }}
          onSave={() => {
            loadData()
            setShowAddUserModal(false)
            setSelectedCompanyForUser('')
          }}
        />
      )}

      {showResetPasswordModal && selectedUser && (
        <ResetPasswordModal
          user={selectedUser}
          onClose={() => {
            setShowResetPasswordModal(false)
            setSelectedUser(null)
          }}
        />
      )}

      {showVendorModal && selectedCompanyForVendor && (
        <VendorManagementModal
          company={selectedCompanyForVendor}
          vendorCatalog={vendorCatalog}
          onClose={() => {
            setShowVendorModal(false)
            setSelectedCompanyForVendor(null)
          }}
          onSave={() => {
            loadData()
          }}
        />
      )}
    </div>
  )
}

// List View Companies
function ListViewCompanies({
  filteredCompanies,
  expandedCompany,
  setExpandedCompany,
  getCompanyTypeBadge,
  updateCompanyStatus,
  setEditingCompany,
  setShowAddCompanyModal,
  setSelectedCompanyForVendor,
  setShowVendorModal,
  setSelectedCompanyForUser,
  setShowAddUserModal,
  deleteCompany,
  updateUserRole,
  toggleUserActive,
  setSelectedUser,
  setShowResetPasswordModal,
  getChildLocations
}: any) {
  return (
    <div className="divide-y divide-gray-100">
      {filteredCompanies.map((company: Company) => (
        <div key={company.id} className="hover:bg-gray-50">
          <div
            className="flex items-center justify-between p-4 cursor-pointer"
            onClick={() => setExpandedCompany(expandedCompany === company.id ? null : company.id)}
          >
            <div className="flex items-center gap-4 flex-1">
              <button className="text-gray-400">
                {expandedCompany === company.id ? (
                  <ChevronDown className="w-5 h-5" />
                ) : (
                  <ChevronRight className="w-5 h-5" />
                )}
              </button>
              <div className="flex-1">
                <div className="flex items-center gap-2">
                  <p className="font-medium text-gray-900">{company.name}</p>
                  {getCompanyTypeBadge(company)}
                </div>
                {company.company_type === 'location' && company.parent_company_id && (
                  <p className="text-xs text-gray-500">Code: {company.location_code}</p>
                )}
                <p className="text-sm text-gray-500">{company.email}</p>
              </div>
            </div>

            <div className="flex items-center gap-4">
              <span className="text-sm text-gray-500">
                {company.users?.length || 0} users
              </span>

              <select
                value={company.subscription_status}
                onChange={(e) => {
                  e.stopPropagation()
                  updateCompanyStatus(company.id, e.target.value)
                }}
                onClick={(e) => e.stopPropagation()}
                className={`px-2.5 py-1 rounded-full text-xs font-medium border-0 cursor-pointer ${getStatusColor(company.subscription_status)}`}
              >
                <option value="active">Active</option>
                <option value="trial">Trial</option>
                <option value="suspended">Suspended</option>
                <option value="cancelled">Cancelled</option>
              </select>

              <div className="flex gap-1">
                <button
                  onClick={(e) => {
                    e.stopPropagation()
                    setEditingCompany(company)
                    setShowAddCompanyModal(true)
                  }}
                  className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg"
                  title="Edit"
                >
                  <Edit2 className="w-4 h-4" />
                </button>
                <button
                  onClick={(e) => {
                    e.stopPropagation()
                    setSelectedCompanyForVendor(company)
                    setShowVendorModal(true)
                  }}
                  className="p-2 text-purple-600 hover:bg-purple-50 rounded-lg"
                  title="Manage Vendors"
                >
                  <Truck className="w-4 h-4" />
                </button>
                <button
                  onClick={(e) => {
                    e.stopPropagation()
                    setSelectedCompanyForUser(company.id)
                    setShowAddUserModal(true)
                  }}
                  className="p-2 text-green-600 hover:bg-green-50 rounded-lg"
                  title="Add User"
                >
                  <UserPlus className="w-4 h-4" />
                </button>
                <button
                  onClick={(e) => {
                    e.stopPropagation()
                    deleteCompany(company.id)
                  }}
                  className="p-2 text-red-600 hover:bg-red-50 rounded-lg"
                  title="Delete"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>

          {expandedCompany === company.id && (
            <div className="px-4 pb-4 pl-14 bg-gray-50">
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
                <div>
                  <p className="text-xs text-gray-500 uppercase">Created</p>
                  <p className="font-medium">{new Date(company.created_at).toLocaleDateString()}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500 uppercase">Phone</p>
                  <p className="font-medium">{company.phone || '-'}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500 uppercase">Location</p>
                  <p className="font-medium">{company.city && company.state ? `${company.city}, ${company.state}` : '-'}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500 uppercase">Type</p>
                  <p className="font-medium">{company.company_type}</p>
                </div>
              </div>

              {/* Child Locations Section */}
              {company.company_type === 'corporate' && (
                <div className="mt-4 mb-4">
                  <p className="text-xs text-gray-500 uppercase mb-2">Locations</p>
                  <div className="bg-white rounded-lg border border-gray-200 overflow-hidden">
                    {getChildLocations(company.id).length === 0 ? (
                      <div className="p-3 text-center text-gray-500 text-sm">No locations yet</div>
                    ) : (
                      <table className="w-full text-sm">
                        <thead className="bg-gray-50 border-b border-gray-200">
                          <tr>
                            <th className="text-left py-2 px-3 text-xs font-semibold text-gray-700">Location Name</th>
                            <th className="text-left py-2 px-3 text-xs font-semibold text-gray-700">Code</th>
                            <th className="text-center py-2 px-3 text-xs font-semibold text-gray-700">Users</th>
                            <th className="text-right py-2 px-3 text-xs font-semibold text-gray-700">Actions</th>
                          </tr>
                        </thead>
                        <tbody>
                          {getChildLocations(company.id).map((location: Company) => (
                            <tr key={location.id} className="border-b border-gray-100">
                              <td className="py-2 px-3">
                                <p className="font-medium text-gray-900">{location.name}</p>
                              </td>
                              <td className="py-2 px-3">
                                <span className="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded">{location.location_code}</span>
                              </td>
                              <td className="py-2 px-3 text-center text-gray-600">{location.users?.length || 0}</td>
                              <td className="py-2 px-3 text-right">
                                <div className="flex gap-1 justify-end">
                                  <button
                                    onClick={() => {
                                      setEditingCompany(location)
                                      setShowAddCompanyModal(true)
                                    }}
                                    className="p-1 text-blue-600 hover:bg-blue-50 rounded"
                                  >
                                    <Edit2 className="w-3 h-3" />
                                  </button>
                                  <button
                                    onClick={() => deleteCompany(location.id)}
                                    className="p-1 text-red-600 hover:bg-red-50 rounded"
                                  >
                                    <Trash2 className="w-3 h-3" />
                                  </button>
                                </div>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    )}
                  </div>
                </div>
              )}

              {/* Users Section */}
              {company.users && company.users.length > 0 && (
                <div className="mt-4">
                  <p className="text-xs text-gray-500 uppercase mb-2">Users</p>
                  <div className="space-y-2">
                    {company.users.map(user => (
                      <div
                        key={user.id}
                        className="flex items-center justify-between p-3 bg-white rounded-lg border border-gray-200"
                      >
                        <div className="flex items-center gap-3">
                          <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white text-sm font-medium ${
                            user.is_active ? 'bg-blue-500' : 'bg-gray-400'
                          }`}>
                            {user.full_name?.charAt(0) || user.email.charAt(0).toUpperCase()}
                          </div>
                          <div>
                            <div className="flex items-center gap-2">
                              <p className="font-medium text-gray-900">{user.full_name || 'No name'}</p>
                              {user.is_corporate_user && (
                                <span className="px-1.5 py-0.5 bg-green-100 text-green-700 text-xs rounded font-medium">Corp</span>
                              )}
                            </div>
                            <p className="text-sm text-gray-500">{user.email}</p>
                          </div>
                        </div>
                        <div className="flex items-center gap-2">
                          <select
                            value={user.role}
                            onChange={(e) => updateUserRole(user.id, e.target.value)}
                            className={`px-2 py-1 rounded text-xs font-medium border-0 cursor-pointer ${getStatusColor(user.role)}`}
                          >
                            <option value="staff">Staff</option>
                            <option value="manager">Manager</option>
                            <option value="admin">Admin</option>
                            <option value="super_admin">Super Admin</option>
                          </select>
                          <button
                            onClick={() => toggleUserActive(user.id, user.is_active)}
                            className={`p-1.5 rounded ${user.is_active ? 'text-green-600 hover:bg-green-50' : 'text-gray-400 hover:bg-gray-100'}`}
                          >
                            {user.is_active ? <Check className="w-4 h-4" /> : <XCircle className="w-4 h-4" />}
                          </button>
                          <button
                            onClick={() => {
                              setSelectedUser(user)
                              setShowResetPasswordModal(true)
                            }}
                            className="p-1.5 text-orange-600 hover:bg-orange-50 rounded"
                          >
                            <Key className="w-4 h-4" />
                          </button>
                        </div>
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
  )
}

// Hierarchy View Companies
function HierarchyViewCompanies({
  companies,
  expandedCompany,
  setExpandedCompany,
  getCompanyTypeBadge,
  updateCompanyStatus,
  setEditingCompany,
  setShowAddCompanyModal,
  setSelectedCompanyForVendor,
  setShowVendorModal,
  setSelectedCompanyForUser,
  setShowAddUserModal,
  deleteCompany,
  getChildLocations
}: any) {
  const corporateCompanies = companies.filter((c: Company) => c.company_type === 'corporate')
  const singleCompanies = companies.filter((c: Company) => c.company_type === 'single')
  const orphanedLocations = companies.filter((c: Company) => c.company_type === 'location' && !c.parent_company_id)

  return (
    <div className="divide-y divide-gray-100">
      {/* Corporate Groups */}
      {corporateCompanies.length > 0 && (
        <>
          <div className="p-4 bg-gray-50 font-semibold text-gray-700 text-sm">Corporate Groups</div>
          {corporateCompanies.map((company: Company) => (
            <div key={company.id} className="hover:bg-gray-50">
              <div
                className="flex items-center justify-between p-4 cursor-pointer"
                onClick={() => setExpandedCompany(expandedCompany === company.id ? null : company.id)}
              >
                <div className="flex items-center gap-4 flex-1">
                  <button className="text-gray-400">
                    {expandedCompany === company.id ? (
                      <ChevronDown className="w-5 h-5" />
                    ) : (
                      <ChevronRight className="w-5 h-5" />
                    )}
                  </button>
                  <div className="flex-1">
                    <div className="flex items-center gap-2">
                      <p className="font-medium text-gray-900">{company.name}</p>
                      {getCompanyTypeBadge(company)}
                    </div>
                    <p className="text-sm text-gray-500">{company.email}</p>
                  </div>
                </div>

                <div className="flex items-center gap-4">
                  <select
                    value={company.subscription_status}
                    onChange={(e) => {
                      e.stopPropagation()
                      updateCompanyStatus(company.id, e.target.value)
                    }}
                    onClick={(e) => e.stopPropagation()}
                    className={`px-2.5 py-1 rounded-full text-xs font-medium border-0 cursor-pointer ${getStatusColor(company.subscription_status)}`}
                  >
                    <option value="active">Active</option>
                    <option value="trial">Trial</option>
                    <option value="suspended">Suspended</option>
                    <option value="cancelled">Cancelled</option>
                  </select>

                  <div className="flex gap-1">
                    <button
                      onClick={(e) => {
                        e.stopPropagation()
                        setEditingCompany(company)
                        setShowAddCompanyModal(true)
                      }}
                      className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg"
                    >
                      <Edit2 className="w-4 h-4" />
                    </button>
                    <button
                      onClick={(e) => {
                        e.stopPropagation()
                        setSelectedCompanyForVendor(company)
                        setShowVendorModal(true)
                      }}
                      className="p-2 text-purple-600 hover:bg-purple-50 rounded-lg"
                    >
                      <Truck className="w-4 h-4" />
                    </button>
                    <button
                      onClick={(e) => {
                        e.stopPropagation()
                        deleteCompany(company.id)
                      }}
                      className="p-2 text-red-600 hover:bg-red-50 rounded-lg"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>

              {/* Child Locations */}
              {expandedCompany === company.id && (
                <div className="px-4 pb-4 pl-14 bg-gray-50 space-y-4">
                  <div>
                    <p className="text-xs text-gray-500 uppercase mb-2">Locations</p>
                    {getChildLocations(company.id).length === 0 ? (
                      <div className="text-sm text-gray-500 italic">No locations</div>
                    ) : (
                      <div className="space-y-1">
                        {getChildLocations(company.id).map((location: Company) => (
                          <div key={location.id} className="p-3 bg-white rounded-lg border border-gray-200 flex items-center justify-between">
                            <div className="flex items-center gap-3">
                              <MapPin className="w-4 h-4 text-blue-600" />
                              <div>
                                <p className="font-medium text-gray-900">{location.name}</p>
                                <p className="text-xs text-gray-500">{location.location_code} • {location.users?.length || 0} users</p>
                              </div>
                            </div>
                            <div className="flex gap-1">
                              <button
                                onClick={() => {
                                  setEditingCompany(location)
                                  setShowAddCompanyModal(true)
                                }}
                                className="p-1 text-blue-600 hover:bg-blue-50 rounded"
                              >
                                <Edit2 className="w-3 h-3" />
                              </button>
                              <button
                                onClick={() => deleteCompany(location.id)}
                                className="p-1 text-red-600 hover:bg-red-50 rounded"
                              >
                                <Trash2 className="w-3 h-3" />
                              </button>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                </div>
              )}
            </div>
          ))}
        </>
      )}

      {/* Single Location Companies */}
      {singleCompanies.length > 0 && (
        <>
          <div className="p-4 bg-gray-50 font-semibold text-gray-700 text-sm">Single Location Companies</div>
          {singleCompanies.map((company: Company) => (
            <div key={company.id} className="hover:bg-gray-50">
              <div className="flex items-center justify-between p-4">
                <div className="flex items-center gap-4 flex-1">
                  <Building2 className="w-5 h-5 text-gray-400" />
                  <div className="flex-1">
                    <div className="flex items-center gap-2">
                      <p className="font-medium text-gray-900">{company.name}</p>
                      {getCompanyTypeBadge(company)}
                    </div>
                    <p className="text-sm text-gray-500">{company.email}</p>
                  </div>
                </div>

                <div className="flex items-center gap-4">
                  <select
                    value={company.subscription_status}
                    onChange={(e) => updateCompanyStatus(company.id, e.target.value)}
                    className={`px-2.5 py-1 rounded-full text-xs font-medium border-0 cursor-pointer ${getStatusColor(company.subscription_status)}`}
                  >
                    <option value="active">Active</option>
                    <option value="trial">Trial</option>
                    <option value="suspended">Suspended</option>
                    <option value="cancelled">Cancelled</option>
                  </select>

                  <div className="flex gap-1">
                    <button
                      onClick={() => {
                        setEditingCompany(company)
                        setShowAddCompanyModal(true)
                      }}
                      className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg"
                    >
                      <Edit2 className="w-4 h-4" />
                    </button>
                    <button
                      onClick={() => {
                        setSelectedCompanyForVendor(company)
                        setShowVendorModal(true)
                      }}
                      className="p-2 text-purple-600 hover:bg-purple-50 rounded-lg"
                    >
                      <Truck className="w-4 h-4" />
                    </button>
                    <button
                      onClick={() => {
                        setSelectedCompanyForUser(company.id)
                        setShowAddUserModal(true)
                      }}
                      className="p-2 text-green-600 hover:bg-green-50 rounded-lg"
                    >
                      <UserPlus className="w-4 h-4" />
                    </button>
                    <button
                      onClick={() => deleteCompany(company.id)}
                      className="p-2 text-red-600 hover:bg-red-50 rounded-lg"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </>
      )}

      {/* Orphaned Locations */}
      {orphanedLocations.length > 0 && (
        <>
          <div className="p-4 bg-orange-50 font-semibold text-orange-700 text-sm">Orphaned Locations (No Parent)</div>
          {orphanedLocations.map((company: Company) => (
            <div key={company.id} className="hover:bg-gray-50">
              <div className="flex items-center justify-between p-4">
                <div className="flex items-center gap-4 flex-1">
                  <MapPin className="w-5 h-5 text-orange-400" />
                  <div className="flex-1">
                    <div className="flex items-center gap-2">
                      <p className="font-medium text-gray-900">{company.name}</p>
                      {getCompanyTypeBadge(company)}
                    </div>
                    <p className="text-sm text-gray-500">{company.email}</p>
                  </div>
                </div>

                <div className="flex gap-1">
                  <button
                    onClick={() => {
                      setEditingCompany(company)
                      setShowAddCompanyModal(true)
                    }}
                    className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg"
                  >
                    <Edit2 className="w-4 h-4" />
                  </button>
                  <button
                    onClick={() => deleteCompany(company.id)}
                    className="p-2 text-red-600 hover:bg-red-50 rounded-lg"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </>
      )}
    </div>
  )
}

function getStatusColor(status: string) {
  switch (status) {
    case 'super_admin': return 'bg-red-100 text-red-800'
    case 'admin': return 'bg-purple-100 text-purple-800'
    case 'manager': return 'bg-blue-100 text-blue-800'
    case 'staff': return 'bg-gray-100 text-gray-800'
    case 'active': return 'bg-green-100 text-green-800'
    case 'trial': return 'bg-blue-100 text-blue-800'
    case 'suspended': return 'bg-red-100 text-red-800'
    case 'cancelled': return 'bg-gray-100 text-gray-800'
    default: return 'bg-gray-100 text-gray-800'
  }
}

// Company Modal with Multi-Location Support
function CompanyModal({ company, onClose, onSave }: { company: Company | null; onClose: () => void; onSave: () => void }) {
  const [companyType, setCompanyType] = useState<'single' | 'corporate'>(company?.company_type === 'corporate' ? 'corporate' : 'single')
  const [formData, setFormData] = useState({
    name: company?.name || '',
    email: company?.email || '',
    phone: company?.phone || '',
    address: company?.address || '',
    city: company?.city || '',
    state: company?.state || '',
    zip: company?.zip || '',
    website: company?.website || '',
    subscription_status: company?.subscription_status || 'trial'
  })
  const [locations, setLocations] = useState<LocationRow[]>(
    company?.company_type === 'location'
      ? [{ id: company.id, name: company.name, location_code: company.location_code || '' }]
      : [{ id: '1', name: '', location_code: '' }]
  )
  const [saving, setSaving] = useState(false)
  const supabase = createClient()

  const addLocationRow = () => {
    setLocations([...locations, { id: Date.now().toString(), name: '', location_code: '' }])
  }

  const removeLocationRow = (id: string) => {
    setLocations(locations.filter(l => l.id !== id))
  }

  const updateLocationRow = (id: string, field: string, value: string) => {
    setLocations(locations.map(l => l.id === id ? { ...l, [field]: value } : l))
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setSaving(true)
    try {
      if (company) {
        await supabase.from('companies').update(formData).eq('id', company.id)
      } else {
        if (companyType === 'single') {
          await supabase.from('companies').insert([{
            ...formData,
            company_type: 'single'
          }])
        } else {
          const { data: parentData } = await supabase.from('companies').insert([{
            name: formData.name,
            email: formData.email,
            phone: formData.phone,
            address: formData.address,
            city: formData.city,
            state: formData.state,
            zip: formData.zip,
            website: formData.website,
            subscription_status: formData.subscription_status,
            company_type: 'corporate',
            is_headquarters: true
          }]).select()

          if (parentData && parentData.length > 0) {
            const parentId = parentData[0].id
            const validLocations = locations.filter(l => l.name && l.location_code)
            for (const loc of validLocations) {
              await supabase.from('companies').insert([{
                name: loc.name,
                email: formData.email,
                company_type: 'location',
                location_code: loc.location_code,
                parent_company_id: parentId,
                subscription_status: formData.subscription_status
              }])
            }
          }
        }
      }
      onSave()
    } catch (error) {
      alert('Error saving company')
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        <div className="flex items-center justify-between p-6 border-b border-gray-200 sticky top-0 bg-white">
          <h2 className="text-xl font-bold text-gray-900">{company ? 'Edit Company' : 'Add New Company'}</h2>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg"><X className="w-5 h-5" /></button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          {/* Company Type Selection - Show only on create */}
          {!company && (
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-3">Company Type *</label>
              <div className="space-y-2">
                <label className="flex items-center gap-3 cursor-pointer">
                  <input
                    type="radio"
                    value="single"
                    checked={companyType === 'single'}
                    onChange={(e) => setCompanyType(e.target.value as 'single' | 'corporate')}
                    className="w-4 h-4"
                  />
                  <span className="text-gray-700">Single Location Company</span>
                </label>
                <label className="flex items-center gap-3 cursor-pointer">
                  <input
                    type="radio"
                    value="corporate"
                    checked={companyType === 'corporate'}
                    onChange={(e) => setCompanyType(e.target.value as 'single' | 'corporate')}
                    className="w-4 h-4"
                  />
                  <span className="text-gray-700">Corporate / Multi-Location Group</span>
                </label>
              </div>
            </div>
          )}

          {/* Base Company Info */}
          <div className="space-y-4">
            <h3 className="font-semibold text-gray-900">{companyType === 'corporate' ? 'Parent Company Information' : 'Company Information'}</h3>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Company Name *</label>
              <input type="text" required value={formData.name} onChange={(e) => setFormData({ ...formData, name: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Email *</label>
              <input type="email" required value={formData.email} onChange={(e) => setFormData({ ...formData, email: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                <input type="tel" value={formData.phone} onChange={(e) => setFormData({ ...formData, phone: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Website</label>
                <input type="url" value={formData.website} onChange={(e) => setFormData({ ...formData, website: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
              </div>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Address</label>
              <input type="text" value={formData.address} onChange={(e) => setFormData({ ...formData, address: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
            </div>
            <div className="grid grid-cols-3 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">City</label>
                <input type="text" value={formData.city} onChange={(e) => setFormData({ ...formData, city: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">State</label>
                <input type="text" value={formData.state} onChange={(e) => setFormData({ ...formData, state: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">ZIP</label>
                <input type="text" value={formData.zip} onChange={(e) => setFormData({ ...formData, zip: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
              </div>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
              <select value={formData.subscription_status} onChange={(e) => setFormData({ ...formData, subscription_status: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg">
                <option value="trial">Trial</option>
                <option value="active">Active</option>
                <option value="suspended">Suspended</option>
                <option value="cancelled">Cancelled</option>
              </select>
            </div>
          </div>

          {/* Locations Section for Corporate */}
          {companyType === 'corporate' && !company && (
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <h3 className="font-semibold text-gray-900">Locations (at least 1 required)</h3>
                <button
                  type="button"
                  onClick={addLocationRow}
                  className="flex items-center gap-2 px-3 py-1.5 text-sm bg-blue-600 text-white rounded-lg hover:bg-blue-700"
                >
                  <Plus className="w-4 h-4" />
                  Add Location
                </button>
              </div>
              <div className="border border-gray-300 rounded-lg overflow-hidden">
                <table className="w-full text-sm">
                  <thead className="bg-gray-50 border-b border-gray-300">
                    <tr>
                      <th className="text-left py-3 px-4 font-semibold text-gray-700">Location Name</th>
                      <th className="text-left py-3 px-4 font-semibold text-gray-700">Location Code</th>
                      <th className="text-right py-3 px-4 font-semibold text-gray-700">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {locations.map((loc, idx) => (
                      <tr key={loc.id} className="border-b border-gray-200">
                        <td className="py-3 px-4">
                          <input
                            type="text"
                            placeholder="e.g., Downtown Shop"
                            value={loc.name}
                            onChange={(e) => updateLocationRow(loc.id, 'name', e.target.value)}
                            className="w-full px-3 py-2 border border-gray-300 rounded text-sm"
                          />
                        </td>
                        <td className="py-3 px-4">
                          <input
                            type="text"
                            placeholder="e.g., LOC-001"
                            value={loc.location_code}
                            onChange={(e) => updateLocationRow(loc.id, 'location_code', e.target.value)}
                            className="w-full px-3 py-2 border border-gray-300 rounded text-sm"
                          />
                        </td>
                        <td className="py-3 px-4 text-right">
                          <button
                            type="button"
                            onClick={() => removeLocationRow(loc.id)}
                            className="p-1 text-red-600 hover:bg-red-50 rounded"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          <div className="flex gap-3 pt-4 border-t border-gray-200">
            <button type="button" onClick={onClose} className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50">Cancel</button>
            <button type="submit" disabled={saving} className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400">{saving ? 'Saving...' : 'Save'}</button>
          </div>
        </form>
      </div>
    </div>
  )
}

// Add User Modal with Corporate User Support
function AddUserModal({ companies, defaultCompanyId, onClose, onSave }: { companies: Company[]; defaultCompanyId: string; onClose: () => void; onSave: () => void }) {
  const [formData, setFormData] = useState({
    email: '',
    full_name: '',
    password: '',
    company_id: defaultCompanyId || '',
    role: 'staff',
    is_corporate_user: false
  })
  const [saving, setSaving] = useState(false)
  const [showPassword, setShowPassword] = useState(false)
  const [error, setError] = useState('')
  const supabase = createClient()

  const selectedCompany = companies.find(c => c.id === formData.company_id)
  const isCorporateParent = selectedCompany?.company_type === 'corporate'

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setSaving(true)
    setError('')
    try {
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: formData.email,
        password: formData.password,
        options: { data: { full_name: formData.full_name } }
      })
      if (authError) throw authError
      if (authData.user) {
        await supabase.from('user_profiles').update({
          company_id: formData.company_id,
          role: formData.role,
          full_name: formData.full_name,
          is_corporate_user: isCorporateParent && formData.is_corporate_user
        }).eq('id', authData.user.id)
      }
      onSave()
    } catch (error: any) {
      setError(error.message || 'Error creating user')
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-lg w-full">
        <div className="flex items-center justify-between p-6 border-b border-gray-200">
          <h2 className="text-xl font-bold text-gray-900">Add New User</h2>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg"><X className="w-5 h-5" /></button>
        </div>
        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          {error && <div className="p-3 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">{error}</div>}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
            <input type="text" required value={formData.full_name} onChange={(e) => setFormData({ ...formData, full_name: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Email *</label>
            <input type="email" required value={formData.email} onChange={(e) => setFormData({ ...formData, email: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Password *</label>
            <div className="relative">
              <input type={showPassword ? 'text' : 'password'} required minLength={6} value={formData.password} onChange={(e) => setFormData({ ...formData, password: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg pr-10" />
              <button type="button" onClick={() => setShowPassword(!showPassword)} className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">
                {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Company *</label>
            <select required value={formData.company_id} onChange={(e) => setFormData({ ...formData, company_id: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg">
              <option value="">Select a company...</option>
              {companies.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Role *</label>
            <select value={formData.role} onChange={(e) => setFormData({ ...formData, role: e.target.value })} className="w-full px-3 py-2 border border-gray-300 rounded-lg">
              <option value="staff">Staff</option>
              <option value="manager">Manager</option>
              <option value="admin">Admin</option>
              <option value="super_admin">Super Admin</option>
            </select>
          </div>
          {isCorporateParent && (
            <label className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={formData.is_corporate_user}
                onChange={(e) => setFormData({ ...formData, is_corporate_user: e.target.checked })}
                className="w-4 h-4"
              />
              <span className="text-sm text-gray-700">Corporate access (all locations)</span>
            </label>
          )}
          <div className="flex gap-3 pt-4">
            <button type="button" onClick={onClose} className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50">Cancel</button>
            <button type="submit" disabled={saving} className="flex-1 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 disabled:bg-gray-400">{saving ? 'Creating...' : 'Create User'}</button>
          </div>
        </form>
      </div>
    </div>
  )
}

// Reset Password Modal
function ResetPasswordModal({ user, onClose }: { user: UserProfile; onClose: () => void }) {
  const [sending, setSending] = useState(false)
  const [sent, setSent] = useState(false)
  const [error, setError] = useState('')
  const supabase = createClient()

  const sendResetEmail = async () => {
    setSending(true)
    setError('')
    try {
      const { error } = await supabase.auth.resetPasswordForEmail(user.email, {
        redirectTo: `${window.location.origin}/auth/reset-password`
      })
      if (error) throw error
      setSent(true)
    } catch (error: any) {
      setError(error.message || 'Error sending reset email')
    } finally {
      setSending(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-md w-full p-6">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-xl font-bold text-gray-900">Reset Password</h2>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg"><X className="w-5 h-5" /></button>
        </div>
        {sent ? (
          <div className="text-center py-6">
            <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <Mail className="w-8 h-8 text-green-600" />
            </div>
            <h3 className="text-lg font-semibold text-gray-900 mb-2">Email Sent!</h3>
            <p className="text-gray-600 mb-4">Reset link sent to <strong>{user.email}</strong></p>
            <button onClick={onClose} className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Done</button>
          </div>
        ) : (
          <>
            {error && <div className="p-3 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm mb-4">{error}</div>}
            <div className="mb-6">
              <p className="text-gray-600 mb-4">Send a password reset email to:</p>
              <div className="p-4 bg-gray-50 rounded-lg">
                <p className="font-medium text-gray-900">{user.full_name || 'No name'}</p>
                <p className="text-gray-600">{user.email}</p>
              </div>
            </div>
            <div className="flex gap-3">
              <button onClick={onClose} className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50">Cancel</button>
              <button onClick={sendResetEmail} disabled={sending} className="flex-1 px-4 py-2 bg-orange-600 text-white rounded-lg hover:bg-orange-700 disabled:bg-gray-400 flex items-center justify-center gap-2">
                {sending ? <><RefreshCw className="w-4 h-4 animate-spin" />Sending...</> : <><Mail className="w-4 h-4" />Send Reset Email</>}
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  )
}

// Vendor Management Modal
function VendorManagementModal({ company, vendorCatalog, onClose, onSave }: { company: Company; vendorCatalog: VendorCatalog[]; onClose: () => void; onSave: () => void }) {
  const [companyVendors, setCompanyVendors] = useState<CompanyVendor[]>(company.vendors || [])
  const [saving, setSaving] = useState(false)
  const supabase = createClient()

  const loadVendors = async () => {
    const { data } = await supabase
      .from('company_vendors')
      .select('*')
      .eq('company_id', company.id)
    if (data) setCompanyVendors(data)
  }

  const addVendor = async (vendorCode: string, vendorName: string) => {
    setSaving(true)
    await supabase.from('company_vendors').insert({
      company_id: company.id,
      vendor_code: vendorCode,
      vendor_name: vendorName,
      is_active: true,
      is_primary: companyVendors.length === 0,
      discount_percent: 0
    })
    await loadVendors()
    onSave()
    setSaving(false)
  }

  const removeVendor = async (vendorId: string) => {
    setSaving(true)
    await supabase.from('company_vendors').delete().eq('id', vendorId)
    await loadVendors()
    onSave()
    setSaving(false)
  }

  const setPrimary = async (vendorId: string) => {
    setSaving(true)
    await supabase.from('company_vendors').update({ is_primary: false }).eq('company_id', company.id)
    await supabase.from('company_vendors').update({ is_primary: true }).eq('id', vendorId)
    await loadVendors()
    onSave()
    setSaving(false)
  }

  const assignedCodes = companyVendors.map(v => v.vendor_code)
  const availableVendors = vendorCatalog.filter(v => !assignedCodes.includes(v.code))

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full max-h-[80vh] overflow-hidden flex flex-col">
        <div className="flex items-center justify-between p-6 border-b border-gray-200">
          <div>
            <h2 className="text-xl font-bold text-gray-900">Manage Vendors</h2>
            <p className="text-gray-600">{company.name}</p>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg"><X className="w-5 h-5" /></button>
        </div>

        <div className="flex-1 overflow-auto p-6 space-y-6">
          {/* Assigned Vendors */}
          <div>
            <h3 className="font-semibold text-gray-900 mb-3">Assigned Vendors</h3>
            {companyVendors.length === 0 ? (
              <p className="text-gray-500 text-sm">No vendors assigned yet. Add vendors below.</p>
            ) : (
              <div className="space-y-2">
                {companyVendors.map(vendor => (
                  <div key={vendor.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                    <div className="flex items-center gap-3">
                      <Truck className="w-5 h-5 text-gray-400" />
                      <div>
                        <p className="font-medium text-gray-900">{vendor.vendor_name}</p>
                        <p className="text-xs text-gray-500">{vendor.vendor_code}</p>
                      </div>
                      {vendor.is_primary && (
                        <span className="px-2 py-0.5 bg-blue-100 text-blue-800 text-xs font-medium rounded">Primary</span>
                      )}
                    </div>
                    <div className="flex items-center gap-2">
                      {!vendor.is_primary && (
                        <button
                          onClick={() => setPrimary(vendor.id)}
                          disabled={saving}
                          className="text-sm text-blue-600 hover:text-blue-700 font-medium"
                        >
                          Set Primary
                        </button>
                      )}
                      <button
                        onClick={() => removeVendor(vendor.id)}
                        disabled={saving}
                        className="p-1.5 text-red-600 hover:bg-red-50 rounded"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Available Vendors */}
          <div>
            <h3 className="font-semibold text-gray-900 mb-3">Add Vendors</h3>
            {availableVendors.length === 0 ? (
              <p className="text-gray-500 text-sm">All available vendors have been assigned.</p>
            ) : (
              <div className="grid grid-cols-2 gap-2">
                {availableVendors.map(vendor => (
                  <button
                    key={vendor.code}
                    onClick={() => addVendor(vendor.code, vendor.name)}
                    disabled={saving}
                    className="flex items-center gap-3 p-3 border border-gray-200 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-colors text-left"
                  >
                    <Plus className="w-5 h-5 text-blue-600" />
                    <div>
                      <p className="font-medium text-gray-900">{vendor.name}</p>
                      <p className="text-xs text-gray-500">{vendor.code}</p>
                    </div>
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>

        <div className="p-4 border-t border-gray-200 bg-gray-50">
          <button onClick={onClose} className="w-full px-4 py-2 bg-gray-900 text-white rounded-lg hover:bg-gray-800">
            Done
          </button>
        </div>
      </div>
    </div>
  )
}
