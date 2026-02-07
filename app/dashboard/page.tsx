import { createClient } from '@/lib/supabase/server'
import { Package, TrendingUp, ClipboardList, AlertCircle, Upload, Search } from 'lucide-react'

export const dynamic = 'force-dynamic'

export default async function DashboardPage() {
  const supabase = createClient()

  // Get user and company_id
  const { data: { user } } = await supabase.auth.getUser()
  const { data: profile } = await supabase
    .from('user_profiles')
    .select('company_id, full_name, companies(name)')
    .eq('id', user?.id)
    .single()

  const companyId = profile?.company_id
  const userName = profile?.full_name || 'User'
  const shopName = profile?.companies?.name || 'your shop'

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
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold text-gray-900">
          Welcome back, {userName}!
        </h1>
        <p className="text-gray-600 mt-2">
          Here&apos;s what&apos;s happening with {shopName} today.
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Active Estimates</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{estimateCount || 0}</p>
            </div>
            <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <ClipboardList className="w-6 h-6 text-blue-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">In your pipeline</p>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Completed Jobs</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{invoiceCount || 0}</p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <TrendingUp className="w-6 h-6 text-green-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">Historical data</p>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Products Tracked</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{productCount || 0}</p>
            </div>
            <div className="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
              <Package className="w-6 h-6 text-purple-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">In catalog</p>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Total Inventory Value</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">${totalInventoryValue.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
            </div>
            <div className="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
              <TrendingUp className="w-6 h-6 text-orange-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">Stock value</p>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
        <h2 className="text-xl font-bold text-gray-900 mb-4">Quick Actions</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <a href="/dashboard/upload" className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center">
            <Upload className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">Upload Data</p>
            <p className="text-sm text-gray-500">Import estimates/invoices</p>
          </a>
          <a href="/dashboard/vehicles" className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center">
            <Search className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">Lookup Vehicle</p>
            <p className="text-sm text-gray-500">Decode VIN</p>
          </a>
          <a href="/dashboard/predictions" className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center">
            <TrendingUp className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">View Predictions</p>
            <p className="text-sm text-gray-500">AI forecasts</p>
          </a>
          <a href="/dashboard/inventory" className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center">
            <Package className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">Manage Inventory</p>
            <p className="text-sm text-gray-500">Stock levels</p>
          </a>
        </div>
      </div>

      <div className="bg-blue-50 border border-blue-200 rounded-xl p-6">
        <div className="flex gap-4">
          <AlertCircle className="w-6 h-6 text-blue-600 flex-shrink-0" />
          <div>
            <h3 className="font-bold text-blue-900 mb-2">Getting Started</h3>
            <p className="text-blue-800 mb-4">
              To start using RefinishAI&apos;s predictive capabilities, upload your historical estimates and invoices.
              The system will analyze patterns and provide inventory forecasting recommendations.
            </p>
            <a href="/dashboard/upload" className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
              Upload Your First Data
            </a>
          </div>
        </div>
      </div>
    </div>
  )
}
