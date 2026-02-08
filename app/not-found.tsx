import Link from 'next/link'

export default function NotFound() {
  return (
    <html lang="en">
      <body className="font-sans antialiased bg-slate-50">
        <div className="min-h-screen flex items-center justify-center px-4">
          <div className="w-full max-w-md">
            {/* 404 Card */}
            <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
              <div className="bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-8">
                <div className="text-center">
                  <h1 className="text-7xl font-bold text-white mb-2">404</h1>
                  <h2 className="text-2xl font-bold text-white">
                    Page Not Found
                  </h2>
                </div>
              </div>

              {/* Content */}
              <div className="p-6">
                <p className="text-slate-600 text-center mb-6">
                  The page you&apos;re looking for doesn&apos;t exist or has been moved.
                </p>

                {/* Actions */}
                <div>
                  <Link
                    href="/dashboard"
                    className="block w-full px-4 py-2.5 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition-colors text-center"
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
