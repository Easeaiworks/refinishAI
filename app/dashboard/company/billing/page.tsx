'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { CreditCard, AlertCircle, CheckCircle, ArrowRight, Users } from 'lucide-react'
import type { CompanySubscription, SubscriptionPlan, BillingInvoice, PaymentRecord } from '@/lib/types/billing'

export default function BillingPage() {
  const supabase = createClient()

  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [checkoutLoading, setCheckoutLoading] = useState(false)

  const [currentSubscription, setCurrentSubscription] = useState<CompanySubscription | null>(null)
  const [allPlans, setAllPlans] = useState<SubscriptionPlan[]>([])
  const [invoices, setInvoices] = useState<BillingInvoice[]>([])
  const [payments, setPayments] = useState<PaymentRecord[]>([])

  const companyId = 'current-company-id' // This should come from auth context in real app

  useEffect(() => {
    loadBillingData()
  }, [])

  async function loadBillingData() {
    try {
      setLoading(true)
      setError(null)

      // Get current subscription
      const { data: subscription } = await supabase
        .from('company_subscriptions')
        .select('*, plan:subscription_plans(*)')
        .eq('company_id', companyId)
        .order('created_at', { ascending: false })
        .limit(1)
        .single()

      setCurrentSubscription(subscription)

      // Get all plans
      const { data: plans } = await supabase
        .from('subscription_plans')
        .select('*')
        .eq('is_active', true)
        .order('sort_order', { ascending: true })

      setAllPlans(plans || [])

      // Get invoices
      const { data: invoiceData } = await supabase
        .from('billing_invoices')
        .select('*')
        .eq('company_id', companyId)
        .order('invoice_date', { ascending: false })

      setInvoices(invoiceData || [])

      // Get payment history
      const { data: paymentData } = await supabase
        .from('payment_history')
        .select('*')
        .eq('company_id', companyId)
        .order('created_at', { ascending: false })

      setPayments(paymentData || [])
    } catch (err) {
      console.error('Error loading billing data:', err)
      setError('Failed to load billing information')
    } finally {
      setLoading(false)
    }
  }

  async function handleSubscribe(planId: string) {
    try {
      setCheckoutLoading(true)
      const billingPeriod = 'monthly' // Could add toggle for annual

      const response = await fetch('/api/stripe/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          company_id: companyId,
          plan_id: planId,
          billing_period: billingPeriod,
        }),
      })

      if (!response.ok) {
        const errorData = await response.json()
        throw new Error(errorData.error || 'Failed to create checkout session')
      }

      const { sessionUrl } = await response.json()
      if (sessionUrl) {
        window.location.href = sessionUrl
      }
    } catch (err) {
      console.error('Checkout error:', err)
      setError(err instanceof Error ? err.message : 'Failed to start checkout')
    } finally {
      setCheckoutLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="p-6 max-w-7xl mx-auto">
        <div className="animate-pulse space-y-4">
          <div className="h-8 bg-gray-200 rounded w-1/4"></div>
          <div className="h-64 bg-gray-200 rounded"></div>
        </div>
      </div>
    )
  }

  return (
    <div className="p-6 max-w-7xl mx-auto">
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
          <CreditCard className="w-7 h-7 text-blue-600" />
          Billing & Subscription
        </h1>
        <p className="text-gray-600 mt-1">Manage your subscription plan and view payment history</p>
      </div>

      {/* Error Alert */}
      {error && (
        <div className="mb-4 bg-red-50 border border-red-200 text-red-700 p-4 rounded-lg flex items-center gap-2">
          <AlertCircle className="w-5 h-5" />
          {error}
        </div>
      )}

      {/* Current Plan Card */}
      {currentSubscription && (
        <div className="mb-6 bg-white rounded-lg shadow border border-gray-200 overflow-hidden">
          <div className="bg-gradient-to-r from-blue-600 to-blue-700 p-6 text-white">
            <h2 className="text-xl font-bold mb-4">Current Plan</h2>
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
              <div>
                <p className="text-blue-100 text-sm">Plan Name</p>
                <p className="text-lg font-semibold">{currentSubscription.plan?.name}</p>
              </div>
              <div>
                <p className="text-blue-100 text-sm">Billing Period</p>
                <p className="text-lg font-semibold capitalize">{currentSubscription.billing_period}</p>
              </div>
              <div>
                <p className="text-blue-100 text-sm">Status</p>
                <div className="mt-1 flex items-center gap-2">
                  {currentSubscription.status === 'active' ? (
                    <>
                      <CheckCircle className="w-5 h-5 text-green-400" />
                      <span className="font-semibold capitalize">{currentSubscription.status}</span>
                    </>
                  ) : (
                    <>
                      <AlertCircle className="w-5 h-5 text-yellow-400" />
                      <span className="font-semibold capitalize">{currentSubscription.status}</span>
                    </>
                  )}
                </div>
              </div>
              <div>
                <p className="text-blue-100 text-sm">Renewal Date</p>
                <p className="text-lg font-semibold">
                  {new Date(currentSubscription.current_period_end).toLocaleDateString()}
                </p>
              </div>
            </div>
          </div>

          {/* User Limit Progress */}
          <div className="px-6 py-4 border-t border-gray-200">
            <div className="flex items-center justify-between mb-2">
              <div className="flex items-center gap-2 text-gray-700">
                <Users className="w-4 h-4" />
                <span className="font-medium">User Limit</span>
              </div>
              <span className="text-sm font-semibold text-gray-900">
                {(currentSubscription.additional_users_purchased || 0) + (currentSubscription.plan?.included_users || 0)} users
              </span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div
                className="bg-blue-600 h-2 rounded-full transition-all"
                style={{
                  width: `${Math.min(
                    100,
                    (((currentSubscription.additional_users_purchased || 0) +
                      (currentSubscription.plan?.included_users || 0)) /
                      ((currentSubscription.additional_users_purchased || 0) +
                        (currentSubscription.plan?.included_users || 0))) *
                      100
                  )}%`,
                }}
              ></div>
            </div>
          </div>

          {/* Footer with Action */}
          <div className="px-6 py-4 bg-gray-50 border-t border-gray-200">
            <button className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 font-medium text-sm">
              Manage Subscription
              <ArrowRight className="w-4 h-4" />
            </button>
          </div>
        </div>
      )}

      {/* Available Plans */}
      <div className="mb-6">
        <h2 className="text-lg font-bold text-gray-900 mb-4">Available Plans</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {allPlans.map((plan) => {
            const isCurrentPlan = currentSubscription?.plan_id === plan.id
            return (
              <div
                key={plan.id}
                className={`bg-white rounded-lg shadow border-2 overflow-hidden transition-all ${
                  isCurrentPlan ? 'border-blue-600 ring-1 ring-blue-100' : 'border-gray-200'
                }`}
              >
                <div className="p-6">
                  <h3 className="text-xl font-bold text-gray-900 mb-2">{plan.name}</h3>
                  <p className="text-gray-600 text-sm mb-4">{plan.description}</p>

                  <div className="mb-6">
                    <span className="text-3xl font-bold text-gray-900">${plan.base_price}</span>
                    <span className="text-gray-600 text-sm">/month</span>
                  </div>

                  {/* Features List */}
                  <ul className="space-y-2 mb-6">
                    <li className="flex items-center gap-2 text-sm text-gray-700">
                      <CheckCircle className="w-4 h-4 text-green-600" />
                      {plan.included_users} included users
                    </li>
                    {plan.features &&
                      Object.entries(plan.features)
                        .filter(([, enabled]) => enabled)
                        .slice(0, 3)
                        .map(([feature]) => (
                          <li key={feature} className="flex items-center gap-2 text-sm text-gray-700">
                            <CheckCircle className="w-4 h-4 text-green-600" />
                            {feature}
                          </li>
                        ))}
                  </ul>

                  {/* Action Button */}
                  <button
                    onClick={() => !isCurrentPlan && handleSubscribe(plan.id)}
                    disabled={isCurrentPlan || checkoutLoading}
                    className={`w-full py-2 rounded-lg font-medium transition-colors ${
                      isCurrentPlan
                        ? 'bg-gray-100 text-gray-700 cursor-default'
                        : 'bg-blue-600 text-white hover:bg-blue-700 disabled:bg-gray-400'
                    }`}
                  >
                    {isCurrentPlan ? 'Current Plan' : checkoutLoading ? 'Loading...' : 'Subscribe'}
                  </button>
                </div>
              </div>
            )
          })}
        </div>
      </div>

      {/* Invoice History */}
      <div className="mb-6">
        <h2 className="text-lg font-bold text-gray-900 mb-4">Invoice History</h2>
        <div className="bg-white rounded-lg shadow border border-gray-200 overflow-hidden">
          <table className="w-full">
            <thead>
              <tr className="bg-slate-100 border-b border-gray-200">
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Invoice #</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Date</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Amount</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Status</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Due Date</th>
              </tr>
            </thead>
            <tbody>
              {invoices.length > 0 ? (
                invoices.map((invoice) => (
                  <tr key={invoice.id} className="border-b border-gray-200 hover:bg-gray-50">
                    <td className="px-6 py-3 text-sm font-medium text-gray-900">{invoice.invoice_number}</td>
                    <td className="px-6 py-3 text-sm text-gray-700">
                      {new Date(invoice.invoice_date).toLocaleDateString()}
                    </td>
                    <td className="px-6 py-3 text-sm font-medium text-gray-900">${invoice.total.toFixed(2)}</td>
                    <td className="px-6 py-3 text-sm">
                      <span
                        className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                          invoice.status === 'paid'
                            ? 'bg-green-100 text-green-800'
                            : invoice.status === 'overdue'
                              ? 'bg-red-100 text-red-800'
                              : 'bg-gray-100 text-gray-800'
                        }`}
                      >
                        {invoice.status.charAt(0).toUpperCase() + invoice.status.slice(1)}
                      </span>
                    </td>
                    <td className="px-6 py-3 text-sm text-gray-700">
                      {new Date(invoice.due_date).toLocaleDateString()}
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={5} className="px-6 py-8 text-center text-gray-500">
                    No invoices yet
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Payment History */}
      <div>
        <h2 className="text-lg font-bold text-gray-900 mb-4">Payment History</h2>
        <div className="bg-white rounded-lg shadow border border-gray-200 overflow-hidden">
          <table className="w-full">
            <thead>
              <tr className="bg-slate-100 border-b border-gray-200">
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Date</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Amount</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Method</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Status</th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-gray-700">Reference</th>
              </tr>
            </thead>
            <tbody>
              {payments.length > 0 ? (
                payments.map((payment) => (
                  <tr key={payment.id} className="border-b border-gray-200 hover:bg-gray-50">
                    <td className="px-6 py-3 text-sm text-gray-700">
                      {new Date(payment.created_at).toLocaleDateString()}
                    </td>
                    <td className="px-6 py-3 text-sm font-medium text-gray-900">${payment.amount.toFixed(2)}</td>
                    <td className="px-6 py-3 text-sm text-gray-700 capitalize">{payment.payment_method}</td>
                    <td className="px-6 py-3 text-sm">
                      <span
                        className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                          payment.status === 'completed'
                            ? 'bg-green-100 text-green-800'
                            : payment.status === 'failed'
                              ? 'bg-red-100 text-red-800'
                              : 'bg-gray-100 text-gray-800'
                        }`}
                      >
                        {payment.status.charAt(0).toUpperCase() + payment.status.slice(1)}
                      </span>
                    </td>
                    <td className="px-6 py-3 text-sm text-gray-700 font-mono">{payment.transaction_ref || '—'}</td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={5} className="px-6 py-8 text-center text-gray-500">
                    No payment history
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
