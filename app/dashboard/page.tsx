import { createClient } from '@/lib/supabase/server'
import { Package, TrendingUp, ClipboardList, AlertCircle, Upload, Search, DollarSign } from 'lucide-react'

export const dynamic = 'force-dynamic'

export default async function DashboardPage() {
  const supabase = await createClient()

  // Get user and company_id
  const { data: { user } } = await supabase.auth.getUser()
  const { data: profile } = await supabase
    .from('user_profiles')
    .select('company_id, full_name, companies(name)')
    .eq('id', user?.id)
    .single()

  const companyId = profile?.company_id
  const userName = profile?.full_name || 'User'
  const companiesData = profile?.companies as any
  const shopName = Array.isArray(companiesData) ? companiesData[0]?.name : companiesData?.name || 'your shop'

  // Fetch all counts in parallel
  const [
    { count: estimateCount },
    { count: invoiceCount },
    { count: productCount },
  ] = await Promise.all([
    supabase
      .from('estimates')
      .select('*', { count: 'exact', head: true })
      .eq('company_id', companyId)
      .in('status', ['Quoted', 'Approved', 'In Progress']),
    supabase
      .from('invoices')
      .select('*', { count: 'exact', head: true })
      .eq('company_id', companyId),
    supabase
      .from('products')
      .select('*', { count: 'exact', head: true })
      .eq('company_id', companyId),
  ])

  // Get inventory value: join products to inventory_stock via product_id
  // Filter to only products belonging to this company
  const { data: stockData } = await supabase
    .from('products')
    .select('unit_cost, inventory_stock(quantity_on_hand)')
    .eq('company_id', companyId)

  const totalInventoryValue = (stockData || []).reduce((sum: number, product: any) => {
    const unitCost = product.unit_cost || 0
    // inventory_stock is an array (one-to-many), sum all stock entries
    const totalQty = Array.isArray(product.inventory_stock)
      ? product.inventory_stock.reduce((q: number, s: any) => q + (s.quantity_on_hand || 0), 0)
      : 0
    return sum + (unitCost * totalQty)
  }, 0)

  return (
    <div className="space-y-6">
      {/* Page Header Banner */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-5">
          <h1 className="text-2xl font-bold text-white">
            Welcome back, {userName}
          </h1>
          <p className="text-slate-300 mt-1 text-sm">
            Here&apos;s what&apos;s happening with {shopName} today.
          </p>
        </div>
      </div>

      {/* Stat Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="p-5">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-500">Active Estimates</p>
                <p className="text-3xl font-bold text-gray-900 mt-1">{estimateCount || 0}</p>
              </div>
              <div className="w-11 h-11 bg-blue-50 rounded-lg flex items-center justify-center">
                <ClipboardList className="w-5 h-5 text-blue-600" />
              </div>
            </div>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">In your pipeline</p>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="p-5">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-500">Completed Jobs</p>
                <p className="text-3xl font-bold text-gray-900 mt-1">{invoiceCount || 0}</p>
              </div>
              <div className="w-11 h-11 bg-green-50 rounded-lg flex items-center justify-center">
                <TrendingUp className="w-5 h-5 text-green-600" />
              </div>
            </div>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">Historical data</p>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="p-5">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-500">Products Tracked</p>
                <p className="text-3xl font-bold text-gray-900 mt-1">{productCount || 0}</p>
              </div>
              <div className="w-11 h-11 bg-purple-50 rounded-lg flex items-center justify-center">
                <Package className="w-5 h-5 text-purple-600" />
              </div>
            </div>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">In catalog</p>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
          <div className="p-5">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-500">Total Inventory Value</p>
                <p className="text-3xl font-bold text-gray-900 mt-1">${totalInventoryValue.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
              </div>
              <div className="w-11 h-11 bg-amber-50 rounded-lg flex items-center justify-center">
                <DollarSign className="w-5 h-5 text-amber-600" />
              </div>
            </div>
          </div>
          <div className="bg-gray-50 px-5 py-2.5 border-t border-gray-100">
            <p className="text-xs text-gray-500">Stock value</p>
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-gray-50 px-6 py-3.5 border-b border-gray-200">
          <h2 className="text-sm font-semibold text-gray-700 uppercase tracking-wide">Quick Actions</h2>
        </div>
        <div className="p-5">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            <a href="/dashboard/upload" className="group p-5 bg-gray-50 border border-gray-200 rounded-lg hover:border-blue-300 hover:bg-blue-50 transition-all text-center">
              <Upload className="w-7 h-7 text-gray-400 group-hover:text-blue-500 mx-auto mb-2.5 transition-colors" />
              <p className="font-semibold text-gray-900 text-sm">Upload Data</p>
              <p className="text-xs text-gray-500 mt-1">Import estimates/invoices</p>
            </a>
            <a href="/dashboard/vehicles" className="group p-5 bg-gray-50 border border-gray-200 rounded-lg hover:border-blue-300 hover:bg-blue-50 transition-all text-center">
              <Search className="w-7 h-7 text-gray-400 group-hover:text-blue-500 mx-auto mb-2.5 transition-colors" />
              <p className="font-semibold text-gray-900 text-sm">Lookup Vehicle</p>
              <p className="text-xs text-gray-500 mt-1">Decode VIN</p>
            </a>
            <a href="/dashboard/predictions" className="group p-5 bg-gray-50 border border-gray-200 rounded-lg hover:border-blue-300 hover:bg-blue-50 transition-all text-center">
              <TrendingUp className="w-7 h-7 text-gray-400 group-hover:text-blue-500 mx-auto mb-2.5 transition-colors" />
              <p className="font-semibold text-gray-900 text-sm">View Predictions</p>
              <p className="text-xs text-gray-500 mt-1">AI forecasts</p>
            </a>
            <a href="/dashboard/inventory" className="group p-5 bg-gray-50 border border-gray-200 rounded-lg hover:border-blue-300 hover:bg-blue-50 transition-all text-center">
              <Package className="w-7 h-7 text-gray-400 group-hover:text-blue-500 mx-auto mb-2.5 transition-colors" />
              <p className="font-semibold text-gray-900 text-sm">Manage Inventory</p>
              <p className="text-xs text-gray-500 mt-1">Stock levels</p>
            </a>
          </div>
        </div>
      </div>

      {/* Getting Started */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="bg-blue-600 px-6 py-3.5">
          <h3 className="text-sm font-semibold text-white uppercase tracking-wide">Getting Started</h3>
        </div>
        <div className="p-6">
          <div className="flex gap-4">
            <AlertCircle className="w-6 h-6 text-blue-600 flex-shrink-0 mt-0.5" />
            <div>
              <p className="text-gray-700 mb-4">
                To start using RefinishAI&apos;s predictive capabilities, upload your historical estimates and invoices.
                The system will analyze patterns and provide inventory forecasting recommendations.
              </p>
              <a href="/dashboard/upload" className="inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition-colors">
                Upload Your First Data
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
