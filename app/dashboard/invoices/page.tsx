'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import {
  Receipt,
  Search,
  Filter,
  ChevronDown,
  ChevronUp,
  Calendar,
  DollarSign,
  TrendingUp,
  Clock,
  X,
  FileText
} from 'lucide-react'

interface Vehicle {
  year: number | null
  make: string | null
  model: string | null
  body_style: string | null
}

interface Invoice {
  id: string
  company_id: string
  invoice_number: string
  customer_name: string
  customer_email: string | null
  invoice_date: string
  completion_date: string | null
  vehicle_id: string | null
  vehicles: Vehicle | null
  insurance_company_id: string | null
  total_amount: number
  labor_cost: number | null
  total_labor_cost: number | null
  total_parts_cost: number | null
  total_materials_cost: number | null
  total_sublet_cost: number | null
  material_cost: number | null
  deductible: number | null
  body_labor_hours: number | null
  refinish_labor_hours: number | null
  mechanical_labor_hours: number | null
  structural_labor_hours: number | null
  aluminum_labor_hours: number | null
  estimate_id: string | null
  notes: string | null
}

interface InvoiceLineItem {
  id: string
  invoice_id: string
  description: string
  quantity: number
  unit_price: number
  line_total: number
  is_refinish: boolean
}

interface InsuranceCompany {
  id: string
  name: string
  code: string
}

export default function InvoicesPage() {
  const [invoices, setInvoices] = useState<Invoice[]>([])
  const [lineItems, setLineItems] = useState<Record<string, InvoiceLineItem[]>>({})
  const [insuranceCompanies, setInsuranceCompanies] = useState<InsuranceCompany[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [startDate, setStartDate] = useState('')
  const [endDate, setEndDate] = useState('')
  const [expandedInvoice, setExpandedInvoice] = useState<string | null>(null)
  const [companyId, setCompanyId] = useState<string | null>(null)
  const supabase = createClient()

  useEffect(() => {
    loadInitialData()
  }, [])

  const loadInitialData = async () => {
    const { data: { user } } = await supabase.auth.getUser()
    if (user) {
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('company_id')
        .eq('id', user.id)
        .single()

      if (profile?.company_id) {
        setCompanyId(profile.company_id)
        await loadInvoices(profile.company_id)
        await loadInsuranceCompanies()
        return
      }
    }
    setLoading(false)
  }

  const loadInvoices = async (compId?: string) => {
    const company = compId || companyId
    if (!company) return

    setLoading(true)

    const { data, error } = await supabase
      .from('invoices')
      .select(`*, vehicles:vehicle_id(year, make, model, body_style)`)
      .eq('company_id', company)
      .order('invoice_date', { ascending: false })

    if (data) {
      setInvoices(data)
    }

    setLoading(false)
  }

  const loadInsuranceCompanies = async () => {
    const { data } = await supabase
      .from('insurance_companies')
      .select('id, name, code')

    if (data) {
      setInsuranceCompanies(data)
    }
  }

  const toggleExpanded = async (invoiceId: string) => {
    if (expandedInvoice === invoiceId) {
      setExpandedInvoice(null)
      return
    }

    // Load line items if not already loaded
    if (!lineItems[invoiceId]) {
      const { data } = await supabase
        .from('invoice_line_items')
        .select('*')
        .eq('invoice_id', invoiceId)
        .order('created_at')

      if (data) {
        setLineItems(prev => ({ ...prev, [invoiceId]: data }))
      }
    }

    setExpandedInvoice(invoiceId)
  }

  const getInsuranceCompanyName = (companyId: string | null) => {
    if (!companyId) return null
    const insurer = insuranceCompanies.find(i => i.id === companyId)
    return insurer?.name || insurer?.code || null
  }

  const getVehicleDisplay = (vehicle: Vehicle | null, customerName: string) => {
    if (!vehicle || !vehicle.make) {
      return customerName
    }
    const year = vehicle.year ? `${vehicle.year} ` : ''
    return `${year}${vehicle.make}${vehicle.model ? ` ${vehicle.model}` : ''}`
  }

  const formatCurrency = (value: number | null) => {
    if (value === null || value === undefined) return '$0.00'
    return `$${value.toFixed(2)}`
  }

  const filteredInvoices = invoices.filter(invoice => {
    const matchesSearch =
      invoice.invoice_number.toLowerCase().includes(searchTerm.toLowerCase()) ||
      invoice.customer_name.toLowerCase().includes(searchTerm.toLowerCase())

    const invoiceDate = new Date(invoice.invoice_date)
    const matchesStartDate = !startDate || invoiceDate >= new Date(startDate)
    const matchesEndDate = !endDate || invoiceDate <= new Date(endDate + 'T23:59:59')

    return matchesSearch && matchesStartDate && matchesEndDate
  })

  // Calculate stats
  const totalInvoices = filteredInvoices.length
  const totalRevenue = filteredInvoices.reduce((sum, inv) => sum + inv.total_amount, 0)
  const avgJobValue = totalInvoices > 0 ? totalRevenue / totalInvoices : 0

  const currentDate = new Date()
  const currentMonth = currentDate.getMonth()
  const currentYear = currentDate.getFullYear()
  const jobsThisMonth = filteredInvoices.filter(inv => {
    const invDate = new Date(inv.invoice_date)
    return invDate.getMonth() === currentMonth && invDate.getFullYear() === currentYear
  }).length

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Invoices & Job History</h1>
          <p className="text-gray-600 mt-2">View and manage all customer invoices and completed jobs</p>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Total Invoices</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{totalInvoices}</p>
            </div>
            <Receipt className="w-6 h-6 text-blue-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Total Revenue</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{formatCurrency(totalRevenue)}</p>
            </div>
            <DollarSign className="w-6 h-6 text-green-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Avg Job Value</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{formatCurrency(avgJobValue)}</p>
            </div>
            <TrendingUp className="w-6 h-6 text-purple-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Jobs This Month</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{jobsThisMonth}</p>
            </div>
            <Clock className="w-6 h-6 text-orange-500" />
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
        <div className="flex flex-col sm:flex-row gap-4">
          {/* Search */}
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Search by invoice number or customer name..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>

          {/* Start Date */}
          <div className="flex items-center gap-2">
            <Calendar className="w-5 h-5 text-gray-400" />
            <input
              type="date"
              value={startDate}
              onChange={(e) => setStartDate(e.target.value)}
              className="px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>

          {/* End Date */}
          <div className="flex items-center gap-2">
            <input
              type="date"
              value={endDate}
              onChange={(e) => setEndDate(e.target.value)}
              className="px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
        </div>
      </div>

      {/* Invoices Table */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : filteredInvoices.length === 0 ? (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center">
          <Receipt className="w-12 h-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">No invoices found</h3>
          <p className="text-gray-600">
            {searchTerm || startDate || endDate
              ? 'Try adjusting your filters'
              : 'No invoices have been created yet'
            }
          </p>
        </div>
      ) : (
        <div className="space-y-4">
          {filteredInvoices.map((invoice) => (
            <div key={invoice.id} className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
              {/* Invoice Row */}
              <button
                onClick={() => toggleExpanded(invoice.id)}
                className="w-full hover:bg-gray-50 transition-colors px-6 py-4"
              >
                <div className="flex items-center justify-between">
                  <div className="flex-1 text-left">
                    <div className="grid grid-cols-7 gap-4 items-center">
                      <div>
                        <p className="font-mono text-sm font-semibold text-gray-900">{invoice.invoice_number}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">
                          {new Date(invoice.invoice_date).toLocaleDateString()}
                        </p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">
                          {invoice.completion_date ? new Date(invoice.completion_date).toLocaleDateString() : '-'}
                        </p>
                      </div>
                      <div>
                        <p className="text-sm font-medium text-gray-900">{invoice.customer_name}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">
                          {getVehicleDisplay(invoice.vehicles, invoice.customer_name)}
                        </p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">
                          {getInsuranceCompanyName(invoice.insurance_company_id) || '-'}
                        </p>
                      </div>
                      <div>
                        <p className="text-sm font-semibold text-gray-900">{formatCurrency(invoice.total_amount)}</p>
                      </div>
                    </div>
                  </div>
                  <div className="ml-4">
                    {expandedInvoice === invoice.id ? (
                      <ChevronUp className="w-5 h-5 text-gray-400" />
                    ) : (
                      <ChevronDown className="w-5 h-5 text-gray-400" />
                    )}
                  </div>
                </div>
              </button>

              {/* Expanded Details */}
              {expandedInvoice === invoice.id && (
                <div className="border-t border-gray-200 bg-gray-50 p-6 space-y-6">
                  {/* Labor Breakdown Section */}
                  {(invoice.body_labor_hours ||
                    invoice.refinish_labor_hours ||
                    invoice.mechanical_labor_hours ||
                    invoice.structural_labor_hours ||
                    invoice.aluminum_labor_hours) && (
                    <div>
                      <h4 className="text-sm font-semibold text-gray-900 mb-3">Labor Breakdown</h4>
                      <div className="grid grid-cols-2 md:grid-cols-5 gap-3 mb-4">
                        {invoice.body_labor_hours !== null && invoice.body_labor_hours > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Body</p>
                            <p className="text-sm font-semibold text-gray-900">{invoice.body_labor_hours} hrs</p>
                          </div>
                        )}
                        {invoice.refinish_labor_hours !== null && invoice.refinish_labor_hours > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Refinish</p>
                            <p className="text-sm font-semibold text-gray-900">{invoice.refinish_labor_hours} hrs</p>
                          </div>
                        )}
                        {invoice.mechanical_labor_hours !== null && invoice.mechanical_labor_hours > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Mechanical</p>
                            <p className="text-sm font-semibold text-gray-900">{invoice.mechanical_labor_hours} hrs</p>
                          </div>
                        )}
                        {invoice.structural_labor_hours !== null && invoice.structural_labor_hours > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Structural</p>
                            <p className="text-sm font-semibold text-gray-900">{invoice.structural_labor_hours} hrs</p>
                          </div>
                        )}
                        {invoice.aluminum_labor_hours !== null && invoice.aluminum_labor_hours > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Aluminum</p>
                            <p className="text-sm font-semibold text-gray-900">{invoice.aluminum_labor_hours} hrs</p>
                          </div>
                        )}
                      </div>

                      {/* Cost Breakdown */}
                      <div className="grid grid-cols-2 md:grid-cols-5 gap-3">
                        {(invoice.total_labor_cost || invoice.labor_cost) && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Labor Cost</p>
                            <p className="text-sm font-semibold text-gray-900">{formatCurrency(invoice.total_labor_cost || invoice.labor_cost)}</p>
                          </div>
                        )}
                        {invoice.total_parts_cost !== null && invoice.total_parts_cost > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Parts Cost</p>
                            <p className="text-sm font-semibold text-gray-900">{formatCurrency(invoice.total_parts_cost)}</p>
                          </div>
                        )}
                        {(invoice.total_materials_cost || invoice.material_cost) && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Materials Cost</p>
                            <p className="text-sm font-semibold text-gray-900">{formatCurrency(invoice.total_materials_cost || invoice.material_cost)}</p>
                          </div>
                        )}
                        {invoice.total_sublet_cost !== null && invoice.total_sublet_cost > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Sublet Cost</p>
                            <p className="text-sm font-semibold text-gray-900">{formatCurrency(invoice.total_sublet_cost)}</p>
                          </div>
                        )}
                        {invoice.deductible !== null && invoice.deductible > 0 && (
                          <div className="bg-white rounded border border-gray-200 p-3">
                            <p className="text-xs text-gray-600">Deductible</p>
                            <p className="text-sm font-semibold text-gray-900">{formatCurrency(invoice.deductible)}</p>
                          </div>
                        )}
                      </div>
                    </div>
                  )}

                  {/* Estimate Link */}
                  {invoice.estimate_id && (
                    <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 flex items-center gap-2">
                      <FileText className="w-4 h-4 text-blue-600" />
                      <span className="text-sm text-blue-700">
                        Linked Estimate: EST-{invoice.estimate_id.slice(0, 8).toUpperCase()}
                      </span>
                    </div>
                  )}

                  {/* Line Items Table */}
                  {lineItems[invoice.id] && lineItems[invoice.id].length > 0 && (
                    <div>
                      <h4 className="text-sm font-semibold text-gray-900 mb-3">Line Items</h4>
                      <div className="overflow-x-auto">
                        <table className="w-full text-sm">
                          <thead className="bg-gray-100 border-y border-gray-300">
                            <tr>
                              <th className="text-left py-2 px-3 font-semibold text-gray-700">Description</th>
                              <th className="text-right py-2 px-3 font-semibold text-gray-700">Qty</th>
                              <th className="text-right py-2 px-3 font-semibold text-gray-700">Unit Price</th>
                              <th className="text-right py-2 px-3 font-semibold text-gray-700">Total</th>
                              <th className="text-center py-2 px-3 font-semibold text-gray-700">Type</th>
                            </tr>
                          </thead>
                          <tbody>
                            {lineItems[invoice.id].map((item) => (
                              <tr key={item.id} className="border-b border-gray-200 hover:bg-white">
                                <td className="py-2 px-3 text-gray-900">{item.description}</td>
                                <td className="py-2 px-3 text-right text-gray-600">{item.quantity}</td>
                                <td className="py-2 px-3 text-right text-gray-600">
                                  {formatCurrency(item.unit_price)}
                                </td>
                                <td className="py-2 px-3 text-right font-medium text-gray-900">
                                  {formatCurrency(item.line_total)}
                                </td>
                                <td className="py-2 px-3 text-center">
                                  {item.is_refinish && (
                                    <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
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
                  )}

                  {/* Notes */}
                  {invoice.notes && (
                    <div className="bg-white border border-gray-200 rounded-lg p-4">
                      <p className="text-sm font-semibold text-gray-900 mb-2">Notes</p>
                      <p className="text-sm text-gray-600">{invoice.notes}</p>
                    </div>
                  )}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
