'use client'

import { AlertCircle } from 'lucide-react'
import Link from 'next/link'

export default function DashboardError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="space-y-6">
      {/* Error Card */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="bg-gradient-to-r from-red-600 to-red-700 px-6 py-6">
          <div className="flex items-center gap-3">
            <AlertCircle className="w-6 h-6 text-white flex-shrink-0" />
            <h1 className="text-xl font-bold text-white">
              Something went wrong
            </h1>
          </div>
        </div>

        {/* Content */}
        <div className="p-6">
          <p className="text-slate-600 mb-6">
            {error.message || 'An unexpected error occurred while loading this page.'}
          </p>

          {/* Error Details */}
          {error.digest && (
            <div className="bg-slate-50 rounded-lg p-3 mb-6">
              <p className="text-xs text-slate-500 font-mono break-all">
                Error ID: {error.digest}
              </p>
            </div>
          )}

          {/* Actions */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <button
              onClick={() => reset()}
              className="px-4 py-2.5 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition-colors"
            >
              Try Again
            </button>
            <Link
              href="/dashboard"
              className="px-4 py-2.5 bg-slate-100 text-slate-700 text-sm font-medium rounded-lg hover:bg-slate-200 transition-colors text-center"
            >
              Go to Dashboard
            </Link>
          </div>
        </div>
      </div>
    </div>
  )
}
