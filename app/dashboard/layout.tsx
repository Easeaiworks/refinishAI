import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import Link from 'next/link'
import DashboardNav from '@/components/DashboardNav'
import DashboardFooter from '@/components/DashboardFooter'

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/auth/login')
  }

  // Get user profile with company details (including company_type for corporate nav)
  const { data: profile } = await supabase
    .from('user_profiles')
    .select('*, companies(*)')
    .eq('id', user.id)
    .single()

  // Load accessible companies for company switcher
  // Super admins see all companies; corporate users see parent + children; others see just their own
  let accessibleCompanies: { id: string; name: string; city?: string }[] = []
  if (profile?.role === 'super_admin') {
    const { data: allCompanies } = await supabase
      .from('companies')
      .select('id, name, city')
      .order('name')
    accessibleCompanies = allCompanies || []
  } else if (profile?.is_corporate_user && profile?.companies?.company_type === 'corporate') {
    const { data: corpCompanies } = await supabase
      .from('companies')
      .select('id, name, city')
      .or(`id.eq.${profile.company_id},parent_company_id.eq.${profile.company_id}`)
      .order('name')
    accessibleCompanies = corpCompanies || []
  } else if (profile?.company_id) {
    accessibleCompanies = [{ id: profile.company_id, name: profile.companies?.name || 'My Company', city: profile.companies?.city }]
  }

  // Check subscription status for banner
  let subscriptionBanner: { type: 'warning' | 'error'; message: string } | null = null
  if (profile?.company_id) {
    try {
      const { data: sub } = await supabase
        .from('company_subscriptions')
        .select('status, current_period_end')
        .eq('company_id', profile.company_id)
        .order('created_at', { ascending: false })
        .limit(1)
        .single()

      if (sub) {
        const today = new Date()
        const periodEnd = new Date(sub.current_period_end)
        const daysLeft = Math.ceil((periodEnd.getTime() - today.getTime()) / (1000 * 60 * 60 * 24))

        if (daysLeft <= 0 || sub.status === 'cancelled' || sub.status === 'suspended') {
          subscriptionBanner = {
            type: 'error',
            message: sub.status === 'suspended'
              ? 'Your subscription has been suspended. Please contact support.'
              : 'Your subscription has expired. Please renew to continue using all features.',
          }
        } else if (daysLeft <= 14 && ['trial', 'active'].includes(sub.status)) {
          subscriptionBanner = {
            type: 'warning',
            message: `Your subscription expires in ${daysLeft} day${daysLeft === 1 ? '' : 's'}. Renew now to avoid interruption.`,
          }
        }
      }
    } catch {
      // No subscription found - ignore
    }
  }

  const isAdmin = profile?.role === 'admin' || profile?.role === 'super_admin'

  return (
    <div className="min-h-screen bg-slate-100 flex flex-col">
      <DashboardNav user={user} profile={profile} companies={accessibleCompanies} />
      {subscriptionBanner && (
        <div
          className={`px-4 py-2.5 text-sm font-medium text-center ${
            subscriptionBanner.type === 'error'
              ? 'bg-red-600 text-white'
              : 'bg-amber-500 text-amber-950'
          }`}
        >
          {subscriptionBanner.message}
          {isAdmin && (
            <Link
              href="/dashboard/company/billing"
              className={`ml-3 underline font-semibold ${
                subscriptionBanner.type === 'error' ? 'text-red-100' : 'text-amber-900'
              }`}
            >
              Manage Billing
            </Link>
          )}
        </div>
      )}
      <main className="flex-1 max-w-7xl mx-auto px-4 sm:px-6 py-6 w-full">
        {children}
      </main>
      <DashboardFooter />
    </div>
  )
}
