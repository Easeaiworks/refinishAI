'use client'

import React, { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  FileText,
  Search,
  Filter,
  ChevronDown,
  ChevronUp,
  Calendar,
  DollarSign,
  Clock,
  CheckCircle,
  AlertCircle,
  X
} from 'lucide-react'

interface Vehicle {
  year: number
  make: string
  model: string
  body_style: string
}

interface EstimateLineItem {
  id: string
  estimate_id: string
  description: string
  quantity: number
  unit_price: number
  line_total: number
  is_refinish: boolean
  created_at: string
}

interface Estimate {
  id: string
  company_id: string
  estimate_number: string
  estimate_date: string
  customer_name: string
  customer_email: string
  customer_phone: string
  vehicle_id: string | null
  vehicles: Vehicle | null
  insurance_company_id: string | null
  status: 'Quoted' | 'Approved' | 'In Progress' | 'Completed'
  total_amount: number
  notes: string
  created_at: string
}

export default function EstimatesPage() {
  const [estimates, setEstimates] = useState<Estimate[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [statusFilter, setStatusFilter] = useState<'all' | 'Quoted' | 'Approved' | 'In Progress' | 'Completed'>('all')
  const [startDate, setStartDate] = useState('')
  const [endDate, setEndDate] = useState('')
  const [companyId, setCompanyId] = useState<string | null>(null)
  const [expandedEstimateId, setExpandedEstimateId] = useState<string | null>(null)
  const [expandedLineItems, setExpandedLineItems] = useState<Record<string, EstimateLineItem[]>>({})
  const [insuranceCompanies, setInsuranceCompanies] = useState<Record<string, string>>({})
  const supabase = createClient()

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    // Get user's company
    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id')
        .eq('id', user.id)
        .single()

      if (profile?.company_id) {
        setCompanyId(profile.company_id)
        await loadEstimates(profile.company_id)
        await loadInsuranceCompanies()
        return
      }
    }
    setLoading(false)
  }

  const loadEstimates = async (compId?: string) => {
    const company = compId || companyId
    if (!company) return

    setLoading(true)

    try {
      const { data, error } = await supabase
        .from('estimates')
        .select(`*, vehicles:vehicle_id(year, make, model, body_style)`)
        .eq('company_id', company)
        .order('estimate_date', { ascending: false })

      if (data) {
        setEstimates(data as Estimate[])
      }

      if (error) {
        console.error('Error loading estimates:', error)
      }
    } catch (error) {
      console.error('Error loading estimates:', error)
    } finally {
      setLoading(false)
    }
  }

  const loadInsuranceCompanies = async () => {
    try {
      const { data, error } = await supabase
        .from('insurance_companies')
        .select('id, name, code')

      if (data) {
        const insurersMap: Record<string, string> = {}
        data.forEach((insurer: any) => {
          insurersMap[insurer.id] = insurer.name
        })
        setInsuranceCompanies(insurersMap)
      }

      if (error) {
        console.error('Error loading insurance companies:', error)
      }
    } catch (error) {
      console.error('Error loading insurance companies:', error)
    }
  }

  const loadLineItems = async (estimateId: string) => {
    try {
      const { data, error } = await supabase
        .from('estimate_line_items')
        .select('*')
        .eq('estimate_id', estimateId)
        .order('created_at')

      if (data) {
        setExpandedLineItems(prev => ({
          ...prev,
          [estimateId]: data as EstimateLineItem[]
        }))
      }

      if (error) {
        console.error('Error loading line items:', error)
      }
    } catch (error) {
      console.error('Error loading line items:', error)
    }
  }

  const toggleExpand = (estimateId: string) => {
    if (expandedEstimateId === estimateId) {
      setExpandedEstimateId(null)
    } else {
      setExpandedEstimateId(estimateId)
      if (!expandedLineItems[estimateId]) {
        loadLineItems(estimateId)
      }
    }
  }

  const getVehicleDisplay = (estimate: Estimate) => {
    if (estimate.vehicles) {
      const v = estimate.vehicles
      return `${v.year} ${v.make} ${v.model}`
    }
    return estimate.customer_name
  }

  const getInsuranceName = (insuranceId: string | null) => {
    if (!insuranceId) return '-'
    return insuranceCompanies[insuranceId] || 'Unknown'
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'Quoted':
        return 'bg-blue-100 text-blue-700'
      case 'Approved':
        return 'bg-green-100 text-green-700'
      case 'In Progress':
        return 'bg-orange-100 text-orange-700'
      case 'Completed':
        return 'bg-gray-100 text-gray-700'
      default:
        return 'bg-gray-100 text-gray-700'
    }
  }

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'Quoted':
        return <FileText className="w-3 h-3" />
      case 'Approved':
        return <CheckCircle className="w-3 h-3" />
      case 'In Progress':
        return <Clock className="w-3 h-3" />
      case 'Completed':
        return <CheckCircle className="w-3 h-3" />
      default:
        return <AlertCircle className="w-3 h-3" />
    }
  }

  // Filter estimates
  const filteredEstimates = estimates.filter(estimate => {
    const matchesSearch =
      estimate.estimate_number.toLowerCase().includes(searchTerm.toLowerCase()) ||
      estimate.customer_name.toLowerCase().includes(searchTerm.toLowerCase())

    const matchesStatus = statusFilter === 'all' || estimate.status === statusFilter

    let matchesDate = true
    if (startDate || endDate) {
      const estimateDate = new Date(estimate.estimate_date)
      if (startDate) {
        matchesDate = matchesDate && estimateDate >= new Date(startDate)
      }
      if (endDate) {
        matchesDate = matchesDate && estimateDate <= new Date(endDate)
      }
    }

    return matchesSearch && matchesStatus && matchesDate
  })

  // Calculate stats
  const totalEstimates = estimates.length
  const activeCount = estimates.filter(e =>
    e.status === 'Quoted' || e.status === 'Approved' || e.status === 'In Progress'
  ).length
  const completedCount = estimates.filter(e => e.status === 'Completed').length
  const totalValue = estimates.reduce((sum, e) => sum + e.total_amount, 0)

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-5">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold text-white">Estimates Management</h1>
              <p className="text-slate-300 mt-1 text-sm">View and manage vehicle repair estimates</p>
            </div>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <div className="p-4">
            <p className="text-2xl font-bold text-gray-900">{totalEstimates}</p>
          </div>
          <div className="bg-gray-50 px-4 py-2.5 border-t border-gray-100">
            <p className="text-xs font-semibold text-gray-600 uppercase tracking-wider">Total Estimates</p>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <div className="p-4">
            <p className="text-2xl font-bold text-blue-600">{activeCount}</p>
          </div>
          <div className="bg-gray-50 px-4 py-2.5 border-t border-gray-100">
            <p className="text-xs font-semibold text-gray-600 uppercase tracking-wider">Active</p>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <div className="p-4">
            <p className="text-2xl font-bold text-green-600">{completedCount}</p>
          </div>
          <div className="bg-gray-50 px-4 py-2.5 border-t border-gray-100">
            <p className="text-xs font-semibold text-gray-600 uppercase tracking-wider">Completed</p>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <div className="p-4">
            <p className="text-2xl font-bold text-gray-900">${totalValue.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
          </div>
          <div className="bg-gray-50 px-4 py-2.5 border-t border-gray-100">
            <p className="text-xs font-semibold text-gray-600 uppercase tracking-wider">Total Value</p>
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-gray-50 px-5 py-3 border-b border-gray-200">
          <h3 className="text-xs font-semibold text-gray-600 uppercase tracking-wider">Filters</h3>
        </div>
        <div className="p-4">
          <div className="flex flex-col sm:flex-row gap-4">
          {/* Search */}
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Search by estimate # or customer name..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>

          {/* Status Filter */}
          <div className="relative">
            <Filter className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <select
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value as any)}
              className="pl-10 pr-8 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white"
            >
              <option value="all">All Statuses</option>
              <option value="Quoted">Quoted</option>
              <option value="Approved">Approved</option>
              <option value="In Progress">In Progress</option>
              <option value="Completed">Completed</option>
            </select>
          </div>

          {/* Start Date */}
          <div className="relative">
            <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="date"
              value={startDate}
              onChange={(e) => setStartDate(e.target.value)}
              className="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              placeholder="Start Date"
            />
          </div>

          {/* End Date */}
          <div className="relative">
            <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="date"
              value={endDate}
              onChange={(e) => setEndDate(e.target.value)}
              className="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              placeholder="End Date"
            />
          </div>
          </div>
        </div>
      </div>

      {/* Estimates Table */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : filteredEstimates.length === 0 ? (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
          <FileText className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No estimates found</h3>
          <p className="text-gray-600">
            {searchTerm || statusFilter !== 'all' || startDate || endDate
              ? 'Try adjusting your filters'
              : 'No estimates yet'
            }
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-slate-100 border-b border-gray-200">
                <tr>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Estimate #</th>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Date</th>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Customer</th>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Vehicle</th>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Insurance</th>
                  <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                  <th className="text-right py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                  <th className="text-center py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Details</th>
                </tr>
              </thead>
              <tbody>
                {filteredEstimates.map((estimate) => (
                  <React.Fragment key={estimate.id}>
                    <tr className="border-b border-gray-100 hover:bg-gray-50">
                      <td className="py-3 px-4 font-mono text-sm text-gray-900">{estimate.estimate_number}</td>
                      <td className="py-3 px-4 text-sm text-gray-600">
                        {new Date(estimate.estimate_date).toLocaleDateString()}
                      </td>
                      <td className="py-3 px-4">
                        <p className="font-medium text-gray-900">{estimate.customer_name}</p>
                        <p className="text-xs text-gray-500">{estimate.customer_email}</p>
                      </td>
                      <td className="py-3 px-4 text-sm text-gray-900">
                        {getVehicleDisplay(estimate)}
                      </td>
                      <td className="py-3 px-4 text-sm text-gray-600">
                        {getInsuranceName(estimate.insurance_company_id)}
                      </td>
                      <td className="py-3 px-4">
                        <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium ${getStatusColor(estimate.status)}`}>
                          {getStatusIcon(estimate.status)}
                          {estimate.status}
                        </span>
                      </td>
                      <td className="py-3 px-4 text-right text-gray-900 font-medium">
                        ${estimate.total_amount.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                      </td>
                      <td className="py-3 px-4 text-center">
                        <button
                          onClick={() => toggleExpand(estimate.id)}
                          className="p-1 hover:bg-gray-200 rounded inline-flex items-center justify-center"
                        >
                          {expandedEstimateId === estimate.id ? (
                            <ChevronUp className="w-5 h-5 text-gray-600" />
                          ) : (
                            <ChevronDown className="w-5 h-5 text-gray-600" />
                          )}
                        </button>
                      </td>
                    </tr>

                    {/* Expanded Line Items */}
                    {expandedEstimateId === estimate.id && expandedLineItems[estimate.id] && (
                      <tr className="bg-gray-50 border-b border-gray-100">
                        <td colSpan={8} className="py-4 px-4">
                          <div className="space-y-3">
                            <h4 className="text-sm font-semibold text-gray-900 mb-3">Line Items</h4>
                            <div className="overflow-x-auto">
                              <table className="w-full text-sm">
                                <thead>
                                  <tr className="border-b border-gray-200">
                                    <th className="text-left py-2 px-3 text-xs font-medium text-gray-600">Description</th>
                                    <th className="text-center py-2 px-3 text-xs font-medium text-gray-600">Qty</th>
                                    <th className="text-right py-2 px-3 text-xs font-medium text-gray-600">Unit Price</th>
                                    <th className="text-right py-2 px-3 text-xs font-medium text-gray-600">Total</th>
                                    <th className="text-center py-2 px-3 text-xs font-medium text-gray-600">Type</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  {expandedLineItems[estimate.id].map((item) => (
                                    <tr key={item.id} className="border-b border-gray-100 hover:bg-white">
                                      <td className="py-2 px-3 text-gray-900">{item.description}</td>
                                      <td className="py-2 px-3 text-center text-gray-600">{item.quantity}</td>
                                      <td className="py-2 px-3 text-right text-gray-600">
                                        ${item.unit_price.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                                      </td>
                                      <td className="py-2 px-3 text-right text-gray-900 font-medium">
                                        ${item.line_total.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                                      </td>
                                      <td className="py-2 px-3 text-center">
                                        {item.is_refinish && (
                                          <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-purple-100 text-purple-700">
                                            Refinish
                                          </span>
                                        )}
                                      </td>
                                    </tr>
                                  ))}
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </td>
                      </tr>
                    )}
                  </React.Fragment>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  )
}

