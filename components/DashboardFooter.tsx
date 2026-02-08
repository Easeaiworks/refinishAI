import Link from 'next/link'

export default function DashboardFooter() {
  return (
    <footer className="bg-slate-800 text-slate-400 mt-12 border-t border-slate-700">
      {/* Main content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 py-8">
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-8">
          {/* Column 1: Branding & Copyright */}
          <div className="flex flex-col">
            <div className="flex items-center gap-2 mb-2">
              <div className="w-6 h-6 bg-blue-600 rounded flex items-center justify-center text-white text-xs font-bold">
                R
              </div>
              <span className="font-semibold text-slate-300">refinishAI</span>
            </div>
            <p className="text-sm text-slate-500">© 2026 RefinishAI Inc.</p>
          </div>

          {/* Column 2: Product Links */}
          <div>
            <h3 className="font-semibold text-slate-300 mb-4 text-sm">Product</h3>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/dashboard/help" className="text-slate-400 hover:text-white transition">
                  Help
                </Link>
              </li>
              <li>
                <a href="#" className="text-slate-400 hover:text-white transition">
                  What's New
                </a>
              </li>
              <li>
                <a href="#" className="text-slate-400 hover:text-white transition">
                  System Status
                </a>
              </li>
            </ul>
          </div>

          {/* Column 3: Legal Links */}
          <div>
            <h3 className="font-semibold text-slate-300 mb-4 text-sm">Legal</h3>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/terms" className="text-slate-400 hover:text-white transition">
                  Terms of Service
                </Link>
              </li>
              <li>
                <Link href="/privacy" className="text-slate-400 hover:text-white transition">
                  Privacy Policy
                </Link>
              </li>
              <li>
                <a href="#" className="text-slate-400 hover:text-white transition">
                  Cookie Policy
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>

      {/* Bottom bar */}
      <div className="border-t border-slate-700 bg-slate-900/50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 py-4 flex flex-col sm:flex-row justify-between items-center text-xs text-slate-500 gap-3">
          <span>Made in Canada</span>
          <span>v1.0.0</span>
        </div>
      </div>
    </footer>
  )
}
