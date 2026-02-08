'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Building2, MapPin, Users, Plus, Edit2, Trash2, Save,
  Settings, Shield, AlertCircle, CheckCircle, X, Palette,
  Lock, Unlock, ChevronDown, ChevronUp, Search
} from 'lucide-react'
import {
  getCompanyWithChildren,
  addChildLocation,
  removeChildLocation,
  getCorporateSettings,
  saveCorporateSetting,
} from '@/lib/services/company-hierarchy-service'
import { getPaintManufacturers } from '@/lib/services/paint-line-filter'
import type { CompanyWithHierarchy, CorporateSettingRow, NewLocationData } from '@/lib/types'

type TabType = 'overview' | 'locations' | 'settings' | 'users'

export default function CorporateDashboardPage() {
  const supabase = createClient()

  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)
  const [userRole, setUserRole] = useState('')
  const [isCorporate, setIsCorporate] = useState(false)
  const [companyId, setCompanyId] = useState('')

  const [company, setCompany] = useState<CompanyWithHierarchy | null>(null)
  const [settings, setSettings] = useState<CorporateSettingRow[]>([])
  const [allUsers, setAllUsers] = useState<any[]>([])
  const [paintManufacturers, setPaintManufacturers] = useState<Array<{ code: string; name: string }>>([])

  const [activeTab, setActiveTab] = useState<TabType>('overview')
  const [showAddLocation, setShowAddLocation] = useState(false)
  const [newLocation, setNewLocation] = useState<NewLocationData>({ name: '', location_code: '' })
  const [saving, setSaving] = useState(false)
  const [searchTerm, setSearchTerm] = useState('')

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    try {
      setLoading(true)
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id, role, is_corporate_user')
        .eq('id', user.id)
        .single()

      if (!profile) return
      setUserRole(profile.role)

      // Check access: must be admin+ and corporate user at a corporate parent
      if (!['admin', 'super_admin'].includes(profile.role)) {
        setLoading(false)
        return
      }

      const { data: companyData } = await supabase
        .from('companies')
        .select('company_type')
        .eq('id', profile.company_id)
        .single()

      if (companyData?.company_type !== 'corporate' || !profile.is_corporate_user) {
        setLoading(false)
        return
      }

      setIsCorporate(true)
      setCompanyId(profile.company_id)
      await loadData(profile.company_id)
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const loadData = async (cId?: string) => {
    const id = cId || companyId
    if (!id) return

    try {
      // Load company with children
      const companyHierarchy = await getCompanyWithChildren(supabase, id)
      setCompany(companyHierarchy)

      // Load corporate settings
      const corpSettings = await getCorporateSettings(supabase, id)
      setSettings(corpSettings)

      // Load all users across the group
      const childIds = companyHierarchy?.childLocations?.map(c => c.id) || []
      const allCompanyIds = [id, ...childIds]

      const { data: users } = await supabase
        .from('user_profiles')
        .select('*, companies:company_id(id, name, location_code)')
        .in('company_id', allCompanyIds)
        .order('full_name')

      setAllUsers(users || [])

      // Load paint manufacturers
      const mfgs = await getPaintManufacturers(supabase)
      setPaintManufacturers(mfgs)
    } catch (err: any) {
      setError(err.message)
    }
  }

  const handleAddLocation = async () => {
    if (!newLocation.name || !newLocation.location_code) {
      setError('Location name and code are required')
      return
    }

    try {
      setSaving(true)
      setError(null)
      await addChildLocation(supabase, companyId, newLocation)
      setSuccess(`Location "${newLocation.name}" added successfully`)
      setNewLocation({ name: '', location_code: '' })
      setShowAddLocation(false)
      await loadData()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  const handleRemoveLocation = async (childId: string, childName: string) => {
    if (!confirm(`Remove location "${childName}"? This cannot be undone.`)) return

    try {
      setError(null)
      await removeChildLocation(supabase, childId)
      setSuccess(`Location "${childName}" removed`)
      await loadData()
    } catch (err: any) {
      setError(err.message)
    }
  }

  const handleSavePaintLine = async (vendorCode: string) => {
    try {
      setSaving(true)
      setError(null)
      const mfg = paintManufacturers.find(m => m.code === vendorCode)
      await saveCorporateSetting(supabase, companyId, 'paint_line', {
        vendor_code: vendorCode,
        vendor_name: mfg?.name || vendorCode,
      }, true)
      setSuccess('Paint line updated for all locations')
      await loadData()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  const getPaintLineSetting = (): { vendor_code?: string; vendor_name?: string } => {
    const s = settings.find(s => s.setting_key === 'paint_line')
    return s?.setting_value || {}
  }

  const totalUsers = allUsers.length
  const totalLocations = company?.childLocations?.length || 0

  // Access guard
  if (loading) {
    return (
      <div className="p-6">
        <div className="animate-pulse space-y-4">
          <div className="h-8 bg-gray-200 rounded w-1/3"></div>
          <div className="h-64 bg-gray-200 rounded"></div>
        </div>
      </div>
    )
  }

  if (!isCorporate || !['admin', 'super_admin'].includes(userRole)) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <Building2 className="w-16 h-16 text-gray-400 mx-auto mb-4" />
          <h2 className="text-2xl font-bold text-gray-900 mb-2">Corporate Access Only</h2>
          <p className="text-gray-600">This page is for corporate admin users managing multi-location groups.</p>
        </div>
      </div>
    )
  }

  const filteredUsers = allUsers.filter(u =>
    u.full_name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    u.email?.toLowerCase().includes(searchTerm.toLowerCase())
  )

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-5">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
              <Building2 className="w-6 h-6 text-blue-600" />
            </div>
            <div>
              <h1 className="text-2xl font-bold text-white">{company?.name || 'Corporate'}</h1>
              <p className="text-slate-300 mt-1 text-sm">Manage locations, users, and group settings</p>
            </div>
          </div>
        </div>
      </div>

      {/* Alerts */}
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 p-3 rounded-lg flex justify-between items-center">
          <div className="flex items-center gap-2"><AlertCircle className="w-4 h-4" />{error}</div>
          <button onClick={() => setError(null)}>×</button>
        </div>
      )}
      {success && (
        <div className="bg-green-50 border border-green-200 text-green-700 p-3 rounded-lg flex justify-between items-center">
          <div className="flex items-center gap-2"><CheckCircle className="w-4 h-4" />{success}</div>
          <button onClick={() => setSuccess(null)}>×</button>
        </div>
      )}

      {/* Overview Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="overflow-hidden rounded-xl bg-white rounded-xl border border-gray-200 shadow-sm p-5">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Locations</p>
              <p className="text-3xl font-bold text-gray-900 mt-1">{totalLocations}</p>
            </div>
            <MapPin className="w-8 h-8 text-blue-500" />
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100 -mx-5 -mb-5 mt-5"></div>
        </div>
        <div className="overflow-hidden rounded-xl bg-white rounded-xl border border-gray-200 shadow-sm p-5">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Total Users</p>
              <p className="text-3xl font-bold text-gray-900 mt-1">{totalUsers}</p>
            </div>
            <Users className="w-8 h-8 text-green-500" />
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100 -mx-5 -mb-5 mt-5"></div>
        </div>
        <div className="overflow-hidden rounded-xl bg-white rounded-xl border border-gray-200 shadow-sm p-5">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Paint Line</p>
              <p className="text-lg font-bold text-purple-700 mt-1">
                {getPaintLineSetting().vendor_name || 'Not Set'}
              </p>
            </div>
            <Palette className="w-8 h-8 text-purple-500" />
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100 -mx-5 -mb-5 mt-5"></div>
        </div>
        <div className="overflow-hidden rounded-xl bg-white rounded-xl border border-gray-200 shadow-sm p-5">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Status</p>
              <p className="text-lg font-bold text-green-700 mt-1 capitalize">
                {company?.subscription_status || 'Unknown'}
              </p>
            </div>
            <Shield className="w-8 h-8 text-gray-400" />
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100 -mx-5 -mb-5 mt-5"></div>
        </div>
      </div>

      {/* Tabs */}
      <div className="bg-gray-50 border-b border-gray-200">
        <div className="flex gap-0">
          {(['locations', 'settings', 'users'] as TabType[]).map(tab => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className={`capitalize transition-colors ${
                activeTab === tab
                  ? 'bg-white text-blue-700 font-semibold border-b-2 border-blue-600 px-4 py-3 text-sm'
                  : 'text-gray-600 hover:text-gray-900 hover:bg-gray-100 px-4 py-3 text-sm font-medium'
              }`}
            >
              {tab === 'settings' ? 'Group Settings' : tab}
            </button>
          ))}
        </div>
      </div>

      {/* Locations Tab */}
      {activeTab === 'locations' && (
        <div className="space-y-4">
          <div className="flex justify-between items-center">
            <p className="text-gray-600">{totalLocations} location{totalLocations !== 1 ? 's' : ''} in this group</p>
            <button
              onClick={() => setShowAddLocation(true)}
              className="flex items-center gap-2 px-4 py-2 bg-blue-500 hover:bg-blue-400 text-white rounded-lg"
            >
              <Plus className="w-4 h-4" />
              Add Location
            </button>
          </div>

          {/* Add Location Form */}
          {showAddLocation && (
            <div className="bg-purple-50 border border-purple-200 rounded-lg p-4">
              <h3 className="font-medium text-purple-900 mb-3">Add New Location</h3>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Location Name *</label>
                  <input
                    type="text"
                    value={newLocation.name}
                    onChange={e => setNewLocation({ ...newLocation, name: e.target.value })}
                    placeholder="e.g. Downtown Boston"
                    className="w-full border rounded-lg px-3 py-2"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Location Code *</label>
                  <input
                    type="text"
                    value={newLocation.location_code}
                    onChange={e => setNewLocation({ ...newLocation, location_code: e.target.value })}
                    placeholder="e.g. #1234 or BOS-01"
                    className="w-full border rounded-lg px-3 py-2"
                  />
                </div>
                <div className="flex items-end gap-2">
                  <button
                    onClick={handleAddLocation}
                    disabled={saving}
                    className="px-4 py-2 bg-blue-500 hover:bg-blue-400 text-white rounded-lg disabled:opacity-50"
                  >
                    {saving ? 'Adding...' : 'Add'}
                  </button>
                  <button
                    onClick={() => setShowAddLocation(false)}
                    className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg"
                  >
                    Cancel
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* Locations Table */}
          {(company?.childLocations || []).length === 0 ? (
            <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden p-12 text-center">
              <MapPin className="w-12 h-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-gray-900 mb-2">No Locations Yet</h3>
              <p className="text-gray-500">Add your first location to get started.</p>
            </div>
          ) : (
            <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
              <table className="w-full">
                <thead className="bg-slate-100 border-b border-gray-200">
                  <tr>
                    <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Location</th>
                    <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Code</th>
                    <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Users</th>
                    <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                    <th className="text-right px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {(company?.childLocations || []).map(loc => (
                    <tr key={loc.id} className="hover:bg-gray-50">
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-2">
                          <MapPin className="w-4 h-4 text-blue-500" />
                          <span className="font-medium text-gray-900">{loc.name}</span>
                          {loc.is_headquarters && (
                            <span className="text-xs bg-amber-100 text-amber-700 px-2 py-0.5 rounded-full">HQ</span>
                          )}
                        </div>
                      </td>
                      <td className="px-4 py-3 text-gray-600">{loc.location_code || '—'}</td>
                      <td className="px-4 py-3 text-gray-600">{loc.userCount || 0}</td>
                      <td className="px-4 py-3">
                        <span className={`text-xs px-2 py-1 rounded-full font-medium ${
                          loc.subscription_status === 'active' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'
                        }`}>
                          {loc.subscription_status}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-right">
                        <button
                          onClick={() => handleRemoveLocation(loc.id, loc.name)}
                          className="text-red-500 hover:text-red-700 p-1"
                          title="Remove location"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* Group Settings Tab */}
      {activeTab === 'settings' && (
        <div className="space-y-6">
          {/* Paint Line */}
          <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
            <div className="bg-gray-50 px-6 py-3.5 border-b border-gray-200">
              <div className="flex items-center gap-2">
                <Palette className="w-5 h-5 text-purple-600" />
                <h3 className="text-sm font-semibold text-gray-700 uppercase tracking-wide">Paint Line Contract</h3>
                <span title="Enforced across all locations"><Lock className="w-4 h-4 text-amber-500" /></span>
              </div>
            </div>
            <div className="p-6">
              <p className="text-sm text-gray-600 mb-4">
                Setting a paint line here applies to ALL locations in this group. Each location will only see products
                from this paint manufacturer in their reorder reports.
              </p>
              <div className="flex items-center gap-4">
                <div className="w-64">
                  <select
                    value={getPaintLineSetting().vendor_code || ''}
                    onChange={e => handleSavePaintLine(e.target.value)}
                    disabled={saving}
                    className="w-full border rounded-lg px-3 py-2"
                  >
                    <option value="">No paint line selected</option>
                    {paintManufacturers.map(m => (
                      <option key={m.code} value={m.code}>{m.name}</option>
                    ))}
                  </select>
                </div>
                {getPaintLineSetting().vendor_name && (
                  <span className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-purple-100 text-purple-800 rounded-full text-sm font-medium">
                    <Palette className="w-3.5 h-3.5" />
                    {getPaintLineSetting().vendor_name}
                  </span>
                )}
              </div>
            </div>
          </div>

          {/* Info Box */}
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <h4 className="font-medium text-blue-900 mb-2">How Cascading Settings Work</h4>
            <p className="text-sm text-blue-800">
              Settings configured here apply to all locations in your group. Paint line contracts are enforced
              across every location — each shop will only see products from your contracted paint manufacturer
              in their reorder reports. Non-paint products (abrasives, masking, safety, etc.) from all vendors
              remain visible.
            </p>
          </div>
        </div>
      )}

      {/* Users Tab */}
      {activeTab === 'users' && (
        <div className="space-y-4">
          <div className="flex items-center gap-4">
            <div className="flex-1 relative">
              <Search className="w-4 h-4 absolute left-3 top-3 text-gray-400" />
              <input
                type="text"
                value={searchTerm}
                onChange={e => setSearchTerm(e.target.value)}
                placeholder="Search users by name or email..."
                className="w-full pl-10 pr-4 py-2 border rounded-lg"
              />
            </div>
            <p className="text-sm text-gray-500">{filteredUsers.length} user{filteredUsers.length !== 1 ? 's' : ''}</p>
          </div>

          <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
            <table className="w-full">
              <thead className="bg-slate-100 border-b border-gray-200">
                <tr>
                  <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">User</th>
                  <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Location</th>
                  <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Role</th>
                  <th className="text-left px-4 py-3 text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                </tr>
              </thead>
              <tbody className="divide-y">
                {filteredUsers.map(user => (
                  <tr key={user.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3">
                      <div>
                        <p className="font-medium text-gray-900">{user.full_name || 'Unnamed'}</p>
                        <p className="text-sm text-gray-500">{user.email}</p>
                      </div>
                    </td>
                    <td className="px-4 py-3 text-gray-600">
                      <div className="flex items-center gap-1">
                        {user.companies?.location_code ? (
                          <span className="text-xs bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full">
                            {user.companies.location_code}
                          </span>
                        ) : null}
                        <span className="text-sm">{user.companies?.name || '—'}</span>
                      </div>
                      {user.is_corporate_user && (
                        <span className="text-xs bg-green-100 text-green-700 px-2 py-0.5 rounded-full mt-1 inline-block">
                          Corporate User
                        </span>
                      )}
                    </td>
                    <td className="px-4 py-3">
                      <span className={`text-xs px-2 py-1 rounded-full font-medium ${
                        user.role === 'super_admin' ? 'bg-red-100 text-red-700'
                        : user.role === 'admin' ? 'bg-purple-100 text-purple-700'
                        : user.role === 'manager' ? 'bg-blue-100 text-blue-700'
                        : 'bg-gray-100 text-gray-700'
                      }`}>
                        {user.role?.replace('_', ' ')}
                      </span>
                    </td>
                    <td className="px-4 py-3">
                      <span className={`text-xs px-2 py-1 rounded-full ${
                        user.is_active ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'
                      }`}>
                        {user.is_active ? 'Active' : 'Inactive'}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  )
}
