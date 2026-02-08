import Link from 'next/link'
import { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'refinishAI - Smart Inventory Management for Auto Body Shops',
  description: 'Track paint, manage estimates, generate invoices, and optimize your shop with AI-powered insights. The complete inventory management solution for auto body shops.',
}

export default function Home() {
  return (
    <div className="min-h-screen bg-white">
      {/* Hero Section */}
      <section className="bg-gradient-to-b from-slate-900 to-slate-800 text-white py-20 px-4 sm:px-6 lg:px-8">
        <div className="max-w-6xl mx-auto">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div>
              <h1 className="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight mb-6">
                Smart Inventory Management for Auto Body Shops
              </h1>
              <p className="text-lg sm:text-xl text-slate-300 mb-8 leading-relaxed">
                Track paint, manage estimates, generate invoices, and optimize your shop with AI-powered insights.
              </p>
              <div className="flex flex-col sm:flex-row gap-4">
                <Link
                  href="/auth/login"
                  className="inline-block px-8 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition duration-200 text-center"
                >
                  Start Free Trial
                </Link>
                <a
                  href="#features"
                  className="inline-block px-8 py-3 border-2 border-white hover:bg-white hover:text-slate-900 text-white font-semibold rounded-lg transition duration-200 text-center"
                >
                  Learn More
                </a>
              </div>
            </div>

            {/* Dashboard Mockup */}
            <div className="bg-slate-800 rounded-lg overflow-hidden shadow-2xl">
              <div className="bg-slate-700 px-4 py-3 border-b border-slate-600 flex gap-2">
                <div className="w-3 h-3 rounded-full bg-red-500"></div>
                <div className="w-3 h-3 rounded-full bg-yellow-500"></div>
                <div className="w-3 h-3 rounded-full bg-green-500"></div>
              </div>
              <div className="aspect-video bg-gradient-to-br from-slate-700 to-slate-800 p-6 flex flex-col justify-center">
                <div className="space-y-4">
                  <div className="h-3 bg-slate-600 rounded w-3/4"></div>
                  <div className="h-2 bg-slate-600 rounded w-1/2"></div>
                  <div className="grid grid-cols-2 gap-4 mt-6">
                    <div className="bg-slate-600 rounded h-16 flex items-center justify-center text-slate-400 text-sm">
                      📊 Analytics
                    </div>
                    <div className="bg-slate-600 rounded h-16 flex items-center justify-center text-slate-400 text-sm">
                      📦 Inventory
                    </div>
                    <div className="bg-slate-600 rounded h-16 flex items-center justify-center text-slate-400 text-sm">
                      📋 Estimates
                    </div>
                    <div className="bg-slate-600 rounded h-16 flex items-center justify-center text-slate-400 text-sm">
                      💰 Invoices
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-20 px-4 sm:px-6 lg:px-8 bg-white">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-slate-900 mb-4">Powerful Features Built for Your Shop</h2>
            <p className="text-xl text-slate-600">Everything you need to manage your auto body shop operations</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {/* Feature 1 */}
            <div className="bg-white border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200">
              <div className="text-4xl mb-4">📦</div>
              <h3 className="text-xl font-bold text-slate-900 mb-3">Inventory Management</h3>
              <p className="text-slate-600 text-sm">
                Track every product with real-time stock levels and automated low stock alerts to keep your shop running smoothly.
              </p>
            </div>

            {/* Feature 2 */}
            <div className="bg-white border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200">
              <div className="text-4xl mb-4">📋</div>
              <h3 className="text-xl font-bold text-slate-900 mb-3">Estimates & Invoices</h3>
              <p className="text-slate-600 text-sm">
                Generate professional estimates and invoices instantly with one-click payment tracking integrated into your workflow.
              </p>
            </div>

            {/* Feature 3 */}
            <div className="bg-white border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200">
              <div className="text-4xl mb-4">📊</div>
              <h3 className="text-xl font-bold text-slate-900 mb-3">Smart Analytics</h3>
              <p className="text-slate-600 text-sm">
                Leverage AI-powered insights to understand sales trends and optimize your inventory for maximum profitability.
              </p>
            </div>

            {/* Feature 4 */}
            <div className="bg-white border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200">
              <div className="text-4xl mb-4">✓</div>
              <h3 className="text-xl font-bold text-slate-900 mb-3">Physical Counts</h3>
              <p className="text-slate-600 text-sm">
                Streamline inventory verification with guided counting workflows and automatic variance detection to ensure accuracy.
              </p>
            </div>

            {/* Feature 5 */}
            <div className="bg-white border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200">
              <div className="text-4xl mb-4">🏢</div>
              <h3 className="text-xl font-bold text-slate-900 mb-3">Multi-Location</h3>
              <p className="text-slate-600 text-sm">
                Manage multiple locations with corporate accounts and consolidated reporting for enterprise-scale operations.
              </p>
            </div>

            {/* Feature 6 */}
            <div className="bg-white border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200">
              <div className="text-4xl mb-4">💼</div>
              <h3 className="text-xl font-bold text-slate-900 mb-3">Insurance Rates</h3>
              <p className="text-slate-600 text-sm">
                Configure custom labor rates per insurer and streamline billing processes to improve operational efficiency.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* How It Works Section */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 bg-slate-50">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-slate-900 mb-4">How It Works</h2>
            <p className="text-xl text-slate-600">Get up and running in three simple steps</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {/* Step 1 */}
            <div className="relative">
              <div className="flex flex-col items-center text-center">
                <div className="w-16 h-16 bg-blue-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mb-6">
                  1
                </div>
                <h3 className="text-xl font-bold text-slate-900 mb-3">Sign Up & Configure</h3>
                <p className="text-slate-600">
                  Create your account and set up your shop profile with essential information in minutes.
                </p>
              </div>
              {/* Connector line */}
              <div className="hidden md:block absolute top-8 left-full w-full h-0.5 bg-gradient-to-r from-blue-600 to-transparent transform -translate-y-1/2"></div>
            </div>

            {/* Step 2 */}
            <div className="relative">
              <div className="flex flex-col items-center text-center">
                <div className="w-16 h-16 bg-blue-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mb-6">
                  2
                </div>
                <h3 className="text-xl font-bold text-slate-900 mb-3">Import Inventory</h3>
                <p className="text-slate-600">
                  Bulk import your existing inventory or add products manually to your smart inventory system.
                </p>
              </div>
              <div className="hidden md:block absolute top-8 left-full w-full h-0.5 bg-gradient-to-r from-blue-600 to-transparent transform -translate-y-1/2"></div>
            </div>

            {/* Step 3 */}
            <div className="relative">
              <div className="flex flex-col items-center text-center">
                <div className="w-16 h-16 bg-blue-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mb-6">
                  3
                </div>
                <h3 className="text-xl font-bold text-slate-900 mb-3">Start Managing</h3>
                <p className="text-slate-600">
                  Manage estimates, invoices, and analytics while AI insights optimize your shop operations.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Pricing Section */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 bg-white">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-slate-900 mb-4">Simple, Transparent Pricing</h2>
            <p className="text-xl text-slate-600">Choose the plan that fits your shop</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {/* Starter Plan */}
            <div className="border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200 flex flex-col">
              <h3 className="text-2xl font-bold text-slate-900 mb-2">Starter</h3>
              <p className="text-slate-600 mb-6">Perfect for small shops</p>
              <div className="mb-6">
                <span className="text-4xl font-bold text-slate-900">$0</span>
                <span className="text-slate-600">/month</span>
              </div>
              <ul className="space-y-4 mb-8 flex-grow">
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Up to 5 users</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Inventory management</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Estimates & invoices</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Physical counts</span>
                </li>
              </ul>
              <Link
                href="/auth/login"
                className="w-full px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition duration-200 text-center"
              >
                Get Started
              </Link>
            </div>

            {/* Professional Plan */}
            <div className="border-2 border-blue-600 rounded-lg p-8 hover:shadow-lg transition duration-200 flex flex-col bg-blue-50 relative">
              <div className="absolute top-0 right-0 bg-blue-600 text-white px-4 py-1 rounded-bl-lg text-sm font-semibold">
                Popular
              </div>
              <h3 className="text-2xl font-bold text-slate-900 mb-2">Professional</h3>
              <p className="text-slate-600 mb-6">For growing shops</p>
              <div className="mb-6">
                <span className="text-4xl font-bold text-slate-900">$0</span>
                <span className="text-slate-600">/month</span>
              </div>
              <ul className="space-y-4 mb-8 flex-grow">
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Everything in Starter</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Smart analytics</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Reorder automation</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Priority support</span>
                </li>
              </ul>
              <Link
                href="/auth/login"
                className="w-full px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition duration-200 text-center"
              >
                Get Started
              </Link>
            </div>

            {/* Enterprise Plan */}
            <div className="border border-slate-200 rounded-lg p-8 hover:shadow-lg transition duration-200 flex flex-col">
              <h3 className="text-2xl font-bold text-slate-900 mb-2">Enterprise</h3>
              <p className="text-slate-600 mb-6">For large networks</p>
              <div className="mb-6">
                <span className="text-4xl font-bold text-slate-900">$0</span>
                <span className="text-slate-600">/month</span>
              </div>
              <ul className="space-y-4 mb-8 flex-grow">
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Everything in Professional</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Multi-location support</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Corporate admin tools</span>
                </li>
                <li className="flex items-start">
                  <span className="text-blue-600 mr-3 text-lg">✓</span>
                  <span className="text-slate-700">Dedicated support</span>
                </li>
              </ul>
              <Link
                href="/auth/login"
                className="w-full px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition duration-200 text-center"
              >
                Get Started
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Trust Section */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 bg-slate-50">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl font-bold text-slate-900 mb-4">Trusted by Auto Body Shops Across North America</h2>
            <p className="text-slate-600">Join hundreds of shops improving their operations with refinishAI</p>
          </div>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {[1, 2, 3, 4, 5, 6, 7, 8].map((i) => (
              <div key={i} className="bg-white border border-slate-200 rounded-lg h-24 flex items-center justify-center">
                <div className="text-slate-400 text-center">
                  <p className="text-sm font-semibold">Logo {i}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 bg-gradient-to-r from-blue-600 to-blue-700 text-white">
        <div className="max-w-4xl mx-auto text-center">
          <h2 className="text-4xl font-bold mb-6">Ready to Modernize Your Shop?</h2>
          <p className="text-xl text-blue-100 mb-8">Start your free trial today and see the refinishAI difference</p>
          <Link
            href="/auth/login"
            className="inline-block px-8 py-4 bg-white hover:bg-slate-100 text-blue-600 font-bold rounded-lg transition duration-200"
          >
            Start Free Trial
          </Link>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-slate-900 text-slate-300 py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-6xl mx-auto">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
            <div>
              <h3 className="text-white font-bold text-lg mb-4">refinishAI</h3>
              <p className="text-sm">Smart inventory management for auto body shops.</p>
            </div>
            <div>
              <h4 className="text-white font-semibold mb-4">Product</h4>
              <ul className="space-y-2 text-sm">
                <li>
                  <a href="#features" className="hover:text-white transition">
                    Features
                  </a>
                </li>
                <li>
                  <Link href="/auth/login" className="hover:text-white transition">
                    Login
                  </Link>
                </li>
              </ul>
            </div>
            <div>
              <h4 className="text-white font-semibold mb-4">Company</h4>
              <ul className="space-y-2 text-sm">
                <li>
                  <Link href="/terms" className="hover:text-white transition">
                    Terms
                  </Link>
                </li>
                <li>
                  <Link href="/privacy" className="hover:text-white transition">
                    Privacy
                  </Link>
                </li>
              </ul>
            </div>
            <div>
              <h4 className="text-white font-semibold mb-4">Support</h4>
              <ul className="space-y-2 text-sm">
                <li>
                  <Link href="/dashboard/help" className="hover:text-white transition">
                    Help
                  </Link>
                </li>
              </ul>
            </div>
          </div>

          <div className="border-t border-slate-800 pt-8">
            <div className="flex flex-col sm:flex-row justify-between items-center">
              <p className="text-sm">
                refinishAI Inc. © 2026. All rights reserved.
              </p>
              <p className="text-sm mt-4 sm:mt-0">Made in Canada 🍁</p>
            </div>
          </div>
        </div>
      </footer>
    </div>
  )
}
