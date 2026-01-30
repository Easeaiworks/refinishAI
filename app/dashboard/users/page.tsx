'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Users, Plus, Edit2, Trash2, X, Shield, Mail, User,
  CheckCircle, XCircle, AlertTriangle, RefreshCw, Search,
  Lock, Unlock, UserPlus, Building2
} from 'lucide-react'

interface UserProfile {
  id: string
  email: string
  full_name: string
  role: string
  is_active: boolean
  created_at: string
  last_login?: string
  company_id?: string
  companies?: {
    id: string
    name: string
  }
}

interface Company {
  id: string
  name: string
}

export default function UsersPage() {
  const [users, setUsers] = useState<UserProfile[]>([])
  const [companies, setCompanies] = useState<Company[]>([])
  const [loading, setLoading] = useState(true)
  const [showAddModal, setShowAddModal] = useState(false)
  const [showDeleteModal, setShowDeleteModal] = useState(false)
  const [editingUser, setEditingUser] = useState<UserProfile | null>(null)
  const [deletingUser, setDeletingUser] = useState<UserProfile | null>(null)
  const [searchTerm, setSearchTerm] = useState('')
  const [roleFilter, setRoleFilter] = useState('all')
  const [statusFilter, setStatusFilter] = useState('all')
  const [currentUser, setCurrentUser] = useState<{ id: string; role: string } | null>(null)
  const supabase = createClient()

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    setLoading(true)

    // Get current user
    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('id, role')
        .eq('id', user.id)
        .single()

      if (profile) {
        setCurrentUser(profile)
      }
    }

    // Load companies
    const { data: companiesData } = await supabase
      .from('companies')
      .select('id, name')
      .order('name')

    if (companiesData) setCompanies(companiesData)

    // Load users
    await loadUsers()
    setLoading(false)
  }

  const loadUsers = async () => {
    const { data, error } = await supabase
      .from('user_profiles')
      .select('*, companies(id, name)')
      .order('created_at', { ascending: false })

    if (data) setUsers(data as any)
    if (error) console.error('Error loading users:', error)
  }

  const getRoleBadgeColor = (role: string) => {
    switch (role) {
      case 'super_admin': return 'bg-red-100 text-red-800'
      case 'admin': return 'bg-purple-100 text-purple-800'
      case 'manager': return 'bg-blue-100 text-blue-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  const toggleUserStatus = async (userId: string, currentStatus: boolean) => {
    const { error } = await supabase
      .from('user_profiles')
      .update({ is_active: !currentStatus, updated_at: new Date().toISOString() })
      .eq('id', userId)

    if (!error) loadUsers()
  }

  const updateUserRole = async (userId: string, newRole: string) => {
    const { error } = await supabase
      .from('user_profiles')
      .update({ role: newRole, updated_at: new Date().toISOString() })
      .eq('id', userId)

    if (!error) loadUsers()
  }

  const deleteUser = async (userId: string) => {
    // Deactivate user (soft delete)
    const { error } = await supabase
      .from('user_profiles')
      .update({ is_active: false, deleted_at: new Date().toISOString() })
      .eq('id', userId)

    if (!error) {
      setShowDeleteModal(false)
      setDeletingUser(null)
      loadUsers()
    }
  }

  const canManageUsers = currentUser?.role === 'admin' || currentUser?.role === 'super_admin'
  const isSuperAdmin = currentUser?.role === 'super_admin'

  const filteredUsers = users.filter(user => {
    const matchesSearch = !searchTerm ||
      user.full_name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      user.email?.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesRole = roleFilter === 'all' || user.role === roleFilter
    const matchesStatus = statusFilter === 'all' ||
      (statusFilter === 'active' && user.is_active) ||
      (statusFilter === 'inactive' && !user.is_active)

    return matchesSearch && matchesRole && matchesStatus
  })

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">User Management</h1>
          <p className="text-gray-600 mt-2">Manage team members and their access</p>
        </div>
        {canManageUsers && (
          <button
            onClick={() => setShowAddModal(true)}
            className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
          >
            <UserPlus className="w-5 h-5" />
            Invite User
          </button>
        )}
      </div>

      {/* Access Control Warning */}
      {!canManageUsers && (
        <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
          <div className="flex items-center gap-3">
            <AlertTriangle className="w-5 h-5 text-yellow-600" />
            <div>
              <p className="font-medium text-yellow-800">View Only Access</p>
              <p className="text-sm text-yellow-700">
                You can view users but need Admin or Super Admin role to make changes.
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <p className="text-sm text-gray-600">Total Users</p>
          <p className="text-2xl font-bold text-gray-900 mt-1">{users.length}</p>
        </div>
        <div
          className="bg-white rounded-lg shadow-sm border border-gray-200 p-4 cursor-pointer hover:bg-green-50"
          onClick={() => setStatusFilter(statusFilter === 'active' ? 'all' : 'active')}
        >
          <p className="text-sm text-gray-600">Active</p>
          <p className="text-2xl font-bold text-green-600 mt-1">
            {users.filter(u => u.is_active).length}
          </p>
        </div>
        <div
          className="bg-white rounded-lg shadow-sm border border-gray-200 p-4 cursor-pointer hover:bg-gray-100"
          onClick={() => setStatusFilter(statusFilter === 'inactive' ? 'all' : 'inactive')}
        >
          <p className="text-sm text-gray-600">Inactive</p>
          <p className="text-2xl font-bold text-gray-500 mt-1">
            {users.filter(u => !u.is_active).length}
          </p>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <p className="text-sm text-gray-600">Admins</p>
          <p className="text-2xl font-bold text-purple-600 mt-1">
            {users.filter(u => u.role === 'admin' || u.role === 'super_admin').length}
          </p>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <p className="text-sm text-gray-600">Companies</p>
          <p className="text-2xl font-bold text-blue-600 mt-1">
            {companies.length}
          </p>
        </div>
      </div>

      {/* Role Info */}
      <div className="bg-gradient-to-r from-blue-50 to-purple-50 border border-blue-200 rounded-lg p-4">
        <h3 className="font-semibold text-gray-900 mb-3 flex items-center gap-2">
          <Shield className="w-5 h-5 text-blue-600" />
          Role Permissions
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 text-sm">
          <div className="bg-white rounded-lg p-3 border border-gray-200">
            <p className="font-medium text-gray-900 flex items-center gap-2">
              <span className="w-2 h-2 bg-gray-400 rounded-full"></span>
              Staff
            </p>
            <p className="text-gray-600 mt-1">View inventory, basic updates, count sheets</p>
          </div>
          <div className="bg-white rounded-lg p-3 border border-gray-200">
            <p className="font-medium text-gray-900 flex items-center gap-2">
              <span className="w-2 h-2 bg-blue-500 rounded-full"></span>
              Manager
            </p>
            <p className="text-gray-600 mt-1">+ Inventory management, estimates, approvals</p>
          </div>
          <div className="bg-white rounded-lg p-3 border border-gray-200">
            <p className="font-medium text-gray-900 flex items-center gap-2">
              <span className="w-2 h-2 bg-purple-500 rounded-full"></span>
              Admin
            </p>
            <p className="text-gray-600 mt-1">+ User management, company settings</p>
          </div>
          <div className="bg-white rounded-lg p-3 border border-gray-200">
            <p className="font-medium text-gray-900 flex items-center gap-2">
              <span className="w-2 h-2 bg-red-500 rounded-full"></span>
              Super Admin
            </p>
            <p className="text-gray-600 mt-1">Full platform access, all companies</p>
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
        <div className="flex flex-col sm:flex-row gap-4">
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Search by name or email..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <select
            value={roleFilter}
            onChange={(e) => setRoleFilter(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
          >
            <option value="all">All Roles</option>
            <option value="staff">Staff</option>
            <option value="manager">Manager</option>
            <option value="admin">Admin</option>
            <option value="super_admin">Super Admin</option>
          </select>
          <select
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
          >
            <option value="all">All Status</option>
            <option value="active">Active Only</option>
            <option value="inactive">Inactive Only</option>
          </select>
        </div>
      </div>

      {/* Users Table */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : filteredUsers.length === 0 ? (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
          <Users className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No users found</h3>
          <p className="text-gray-600">
            {searchTerm || roleFilter !== 'all' || statusFilter !== 'all'
              ? 'Try adjusting your filters'
              : 'Invite team members to get started'
            }
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">User</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Email</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Role</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Company</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Status</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">Joined</th>
                  {canManageUsers && (
                    <th className="text-right py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>
                  )}
                </tr>
              </thead>
              <tbody>
                {filteredUsers.map((user) => {
                  const isCurrentUser = user.id === currentUser?.id
                  const canEditRole = canManageUsers && !isCurrentUser &&
                    (isSuperAdmin || user.role !== 'super_admin')

                  return (
                    <tr key={user.id} className={`border-b border-gray-100 hover:bg-gray-50 ${!user.is_active ? 'opacity-60' : ''}`}>
                      <td className="py-3 px-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center">
                            <User className="w-5 h-5 text-blue-600" />
                          </div>
                          <div>
                            <p className="font-medium text-gray-900">
                              {user.full_name || 'Unnamed User'}
                              {isCurrentUser && (
                                <span className="ml-2 text-xs text-blue-600">(You)</span>
                              )}
                            </p>
                          </div>
                        </div>
                      </td>
                      <td className="py-3 px-4 text-gray-600">{user.email}</td>
                      <td className="py-3 px-4">
                        {canEditRole ? (
                          <select
                            value={user.role}
                            onChange={(e) => updateUserRole(user.id, e.target.value)}
                            className={`px-2 py-1 rounded-full text-xs font-medium border-0 cursor-pointer ${getRoleBadgeColor(user.role)}`}
                          >
                            <option value="staff">staff</option>
                            <option value="manager">manager</option>
                            <option value="admin">admin</option>
                            {isSuperAdmin && <option value="super_admin">super admin</option>}
                          </select>
                        ) : (
                          <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${getRoleBadgeColor(user.role)}`}>
                            {user.role.replace('_', ' ')}
                          </span>
                        )}
                      </td>
                      <td className="py-3 px-4">
                        <span className="inline-flex items-center gap-1 text-gray-600">
                          <Building2 className="w-3 h-3" />
                          {user.companies?.name || 'No Company'}
                        </span>
                      </td>
                      <td className="py-3 px-4">
                        {canManageUsers && !isCurrentUser ? (
                          <button
                            onClick={() => toggleUserStatus(user.id, user.is_active)}
                            className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium transition-colors ${
                              user.is_active
                                ? 'bg-green-100 text-green-700 hover:bg-green-200'
                                : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                            }`}
                          >
                            {user.is_active ? (
                              <>
                                <CheckCircle className="w-3 h-3" />
                                Active
                              </>
                            ) : (
                              <>
                                <XCircle className="w-3 h-3" />
                                Inactive
                              </>
                            )}
                          </button>
                        ) : (
                          <span className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium ${
                            user.is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'
                          }`}>
                            {user.is_active ? (
                              <>
                                <CheckCircle className="w-3 h-3" />
                                Active
                              </>
                            ) : (
                              <>
                                <XCircle className="w-3 h-3" />
                                Inactive
                              </>
                            )}
                          </span>
                        )}
                      </td>
                      <td className="py-3 px-4 text-sm text-gray-500">
                        {new Date(user.created_at).toLocaleDateString()}
                      </td>
                      {canManageUsers && (
                        <td className="py-3 px-4 text-right">
                          <div className="flex items-center justify-end gap-1">
                            <button
                              onClick={() => {
                                setEditingUser(user)
                                setShowAddModal(true)
                              }}
                              className="p-1.5 text-blue-600 hover:bg-blue-50 rounded"
                              title="Edit User"
                            >
                              <Edit2 className="w-4 h-4" />
                            </button>
                            {!isCurrentUser && user.role !== 'super_admin' && (
                              <button
                                onClick={() => {
                                  setDeletingUser(user)
                                  setShowDeleteModal(true)
                                }}
                                className="p-1.5 text-red-600 hover:bg-red-50 rounded"
                                title="Deactivate User"
                              >
                                <Trash2 className="w-4 h-4" />
                              </button>
                            )}
                          </div>
                        </td>
                      )}
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Add/Edit User Modal */}
      {showAddModal && (
        <UserModal
          user={editingUser}
          companies={companies}
          isSuperAdmin={isSuperAdmin}
          onClose={() => {
            setShowAddModal(false)
            setEditingUser(null)
          }}
          onSave={() => {
            loadUsers()
            setShowAddModal(false)
            setEditingUser(null)
          }}
        />
      )}

      {/* Delete Confirmation Modal */}
      {showDeleteModal && deletingUser && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-md w-full p-6">
            <div className="flex items-center gap-4 mb-4">
              <div className="w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
                <AlertTriangle className="w-6 h-6 text-red-600" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Deactivate User</h2>
                <p className="text-gray-600 mt-1">This action can be reversed later</p>
              </div>
            </div>

            <p className="text-gray-600 mb-6">
              Are you sure you want to deactivate <strong>{deletingUser.full_name || deletingUser.email}</strong>?
              They will lose access to the platform until reactivated.
            </p>

            <div className="flex gap-3">
              <button
                onClick={() => {
                  setShowDeleteModal(false)
                  setDeletingUser(null)
                }}
                className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={() => deleteUser(deletingUser.id)}
                className="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700"
              >
                Deactivate User
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

// User Modal Component
function UserModal({
  user,
  companies,
  isSuperAdmin,
  onClose,
  onSave
}: {
  user: UserProfile | null
  companies: Company[]
  isSuperAdmin: boolean
  onClose: () => void
  onSave: () => void
}) {
  const [formData, setFormData] = useState({
    email: user?.email || '',
    full_name: user?.full_name || '',
    role: user?.role || 'staff',
    company_id: user?.company_id || (companies.length > 0 ? companies[0].id : ''),
  })
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState('')
  const supabase = createClient()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setSaving(true)
    setError('')

    try {
      if (user) {
        // Update existing user
        const { error: updateError } = await supabase
          .from('user_profiles')
          .update({
            full_name: formData.full_name,
            role: formData.role,
            company_id: formData.company_id || null,
            updated_at: new Date().toISOString()
          })
          .eq('id', user.id)

        if (updateError) throw updateError
      } else {
        // For new users, we would typically send an invite
        // For now, just create the profile (in production, use Supabase Auth Admin API)
        const { error: insertError } = await supabase
          .from('user_profiles')
          .insert({
            email: formData.email,
            full_name: formData.full_name,
            role: formData.role,
            company_id: formData.company_id || null,
            is_active: true
          })

        if (insertError) throw insertError
      }

      onSave()
    } catch (err: any) {
      console.error('Error saving user:', err)
      setError(err.message || 'Error saving user')
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-md w-full p-6">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-xl font-bold text-gray-900">
            {user ? 'Edit User' : 'Invite New User'}
          </h2>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg">
            <X className="w-5 h-5" />
          </button>
        </div>

        {error && (
          <div className="mb-4 p-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              <Mail className="w-4 h-4 inline mr-1" />
              Email
            </label>
            <input
              type="email"
              required
              value={formData.email}
              onChange={(e) => setFormData({ ...formData, email: e.target.value })}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              disabled={!!user}
              placeholder="user@company.com"
            />
            {!user && (
              <p className="text-xs text-gray-500 mt-1">
                An invite will be sent to this email address
              </p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              <User className="w-4 h-4 inline mr-1" />
              Full Name
            </label>
            <input
              type="text"
              required
              value={formData.full_name}
              onChange={(e) => setFormData({ ...formData, full_name: e.target.value })}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
              placeholder="John Smith"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              <Building2 className="w-4 h-4 inline mr-1" />
              Company
            </label>
            <select
              value={formData.company_id}
              onChange={(e) => setFormData({ ...formData, company_id: e.target.value })}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            >
              <option value="">No Company</option>
              {companies.map(company => (
                <option key={company.id} value={company.id}>{company.name}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              <Shield className="w-4 h-4 inline mr-1" />
              Role
            </label>
            <select
              value={formData.role}
              onChange={(e) => setFormData({ ...formData, role: e.target.value })}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            >
              <option value="staff">Staff</option>
              <option value="manager">Manager</option>
              <option value="admin">Admin</option>
              {isSuperAdmin && <option value="super_admin">Super Admin</option>}
            </select>
          </div>

          <div className="flex gap-3 pt-4">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
              disabled={saving}
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={saving}
              className="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400"
            >
              {saving ? (
                <>
                  <RefreshCw className="w-4 h-4 animate-spin" />
                  Saving...
                </>
              ) : (
                user ? 'Save Changes' : 'Send Invite'
              )}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
