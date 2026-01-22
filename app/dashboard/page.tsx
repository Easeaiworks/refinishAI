import { createClient } from '@/lib/supabase/server'
import { Package, TrendingUp, ClipboardList, AlertCircle, Upload, Search } from 'lucide-react'

export const dynamic = 'force-dynamic'

export default async function DashboardPage() {
  // Temporarily simplified - no database queries
  const userName = 'User'
  const shopName = 'your shop'
  const estimateCount = 0
  const invoiceCount = 0
  const productCount = 0

  return (
    <div className="space-y-8">
      {/* Welcome Section */}
      <div>
        <h1 className="text-3xl font-bold text-gray-900">
          Welcome back, {userName}!
        </h1>
        <p className="text-gray-600 mt-2">
          Here&apos;s what&apos;s happening with {shopName} today.
        </p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">Active Estimates</p>
              <p className="text-3xl font-bold text-gray-900 mt-2">{estimateCount}</p>
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
              <p className="text-3xl font-bold text-gray-900 mt-2">{invoiceCount}</p>
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
              <p className="text-3xl font-bold text-gray-900 mt-2">{productCount}</p>
            </div>
            <div className="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
              <Package className="w-6 h-6 text-purple-600" />
            </div>
          </div>
          <p className="text-sm text-gray-500 mt-4">In catalog</p>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
        <h2 className="text-xl font-bold text-gray-900 mb-4">Quick Actions</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          
          
            href="/dashboard/upload"
            className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center"
          >
            <Upload className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">Upload Data</p>
            <p className="text-sm text-gray-500">Import estimates/invoices</p>
          </a>
          
          
            href="/dashboard/vehicles"
            className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center"
          >
            <Search className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">Lookup Vehicle</p>
            <p className="text-sm text-gray-500">Decode VIN</p>
          </a>
          
          
            href="/dashboard/predictions"
            className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center"
          >
            <TrendingUp className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">View Predictions</p>
            <p className="text-sm text-gray-500">AI forecasts</p>
          </a>
          
          
            href="/dashboard/inventory"
            className="p-4 border-2 border-dashed border-gray-300 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition-all text-center"
          >
            <Package className="w-8 h-8 text-gray-400 mx-auto mb-2" />
            <p className="font-medium text-gray-900">Manage Inventory</p>
            <p className="text-sm text-gray-500">Stock levels</p>
          </a>
        </div>
      </div>

      {/* Getting Started */}
      <div className="bg-blue-50 border border-blue-200 rounded-xl p-6">
        <div className="flex gap-4">
          <AlertCircle className="w-6 h-6 text-blue-600 flex-shrink-0" />
          <div>
            <h3 className="font-bold text-blue-900 mb-2">Getting Started</h3>
            <p className="text-blue-800 mb-4">
              To start using RefinishAI&apos;s predictive capabilities, upload your historical estimates and invoices.
              The system will analyze patterns and provide inventory forecasting recommendations.
            </p>
            
              href="/dashboard/upload"
              className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              Upload Your First Data
            </a>
          </div>
        </div>
      </div>
    </div>
  )
}
