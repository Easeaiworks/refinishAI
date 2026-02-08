'use client'

import { AlertCircle } from 'lucide-react'
import Link from 'next/link'

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <html lang="en">
      <body className="font-sans antialiased bg-slate-50">
        <div className="min-h-screen flex items-center justify-center px-4">
          <div className="w-full max-w-md">
            {/* Error Card */}
            <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
              <div className="bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-8">
                <div className="flex justify-center mb-4">
                  <div className="w-16 h-16 bg-red-500/20 rounded-full flex items-center justify-center">
                    <AlertCircle className="w-8 h-8 text-red-600" />
                  </div>
                </div>
                <h1 className="text-2xl font-bold text-white text-center">
                  Something went wrong
                </h1>
              </div>

              {/* Content */}
              <div className="p-6">
                <p className="text-slate-600 text-center mb-6">
                  {error.message || 'An unexpected error occurred. Please try again.'}
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
                <div className="space-y-3">
                  <button
                    onClick={() => reset()}
                    className="w-full px-4 py-2.5 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition-colors"
                  >
                    Try Again
                  </button>
                  <Link
                    href="/dashboard"
                    className="block w-full px-4 py-2.5 bg-slate-100 text-slate-700 text-sm font-medium rounded-lg hover:bg-slate-200 transition-colors text-center"
                  >
                    Go to Dashboard
                  </Link>
                </div>

                {/* RefinishAI Branding */}
                <div className="mt-6 pt-6 border-t border-slate-200">
                  <p className="text-xs text-slate-500 text-center">
                    RefinishAI - Intelligent Inventory Forecasting
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </body>
    </html>
  )
}
