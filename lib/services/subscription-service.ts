import { SupabaseClient } from '@supabase/supabase-js'
import type { SubscriptionPlan, CompanySubscription, UserLimitStatus, SubscriptionStatus } from '@/lib/types/billing'

// ─── Plan Queries ───

export async function getActivePlans(supabase: SupabaseClient): Promise<SubscriptionPlan[]> {
  const { data, error } = await supabase
    .from('subscription_plans')
    .select('*')
    .eq('is_active', true)
    .order('sort_order', { ascending: true })

  if (error) throw error
  return data || []
}

export async function getAllPlans(supabase: SupabaseClient): Promise<SubscriptionPlan[]> {
  const { data, error } = await supabase
    .from('subscription_plans')
    .select('*')
    .order('sort_order', { ascending: true })

  if (error) throw error
  return data || []
}

export async function getPlanById(supabase: SupabaseClient, planId: string): Promise<SubscriptionPlan | null> {
  const { data, error } = await supabase
    .from('subscription_plans')
    .select('*')
    .eq('id', planId)
    .single()

  if (error) return null
  return data
}

export async function createPlan(
  supabase: SupabaseClient,
  plan: Partial<SubscriptionPlan>
): Promise<SubscriptionPlan> {
  const { data, error } = await supabase
    .from('subscription_plans')
    .insert(plan)
    .select()
    .single()

  if (error) throw error
  return data
}

export async function updatePlan(
  supabase: SupabaseClient,
  planId: string,
  updates: Partial<SubscriptionPlan>
): Promise<SubscriptionPlan> {
  const { data, error } = await supabase
    .from('subscription_plans')
    .update(updates)
    .eq('id', planId)
    .select()
    .single()

  if (error) throw error
  return data
}

// ─── Company Subscription Queries ───

export async function getCompanySubscription(
  supabase: SupabaseClient,
  companyId: string
): Promise<CompanySubscription | null> {
  const { data, error } = await supabase
    .from('company_subscriptions')
    .select('*, plan:subscription_plans(*)')
    .eq('company_id', companyId)
    .order('created_at', { ascending: false })
    .limit(1)
    .single()

  if (error) return null
  return data
}

export async function getAllSubscriptions(supabase: SupabaseClient): Promise<CompanySubscription[]> {
  const { data, error } = await supabase
    .from('company_subscriptions')
    .select('*, plan:subscription_plans(*), company:companies(id, name, email)')
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}

export async function assignPlan(
  supabase: SupabaseClient,
  companyId: string,
  planId: string,
  billingPeriod: 'monthly' | 'annual'
): Promise<CompanySubscription> {
  const plan = await getPlanById(supabase, planId)
  if (!plan) throw new Error('Plan not found')

  // Check if company already has a subscription
  const existing = await getCompanySubscription(supabase, companyId)

  const periodEnd = billingPeriod === 'annual'
    ? new Date(Date.now() + 365 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]
    : new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]

  if (existing) {
    // Update existing
    const { data, error } = await supabase
      .from('company_subscriptions')
      .update({
        plan_id: planId,
        billing_period: billingPeriod,
        current_price: plan.base_price,
        status: 'active',
        current_period_start: new Date().toISOString().split('T')[0],
        current_period_end: periodEnd,
      })
      .eq('id', existing.id)
      .select('*, plan:subscription_plans(*)')
      .single()

    if (error) throw error

    // Also update legacy subscription_status on companies table
    await supabase.from('companies').update({ subscription_status: 'active', subscription_ends_at: periodEnd }).eq('id', companyId)

    return data
  } else {
    // Create new
    const { data, error } = await supabase
      .from('company_subscriptions')
      .insert({
        company_id: companyId,
        plan_id: planId,
        billing_period: billingPeriod,
        current_price: plan.base_price,
        status: 'active',
        current_period_end: periodEnd,
      })
      .select('*, plan:subscription_plans(*)')
      .single()

    if (error) throw error

    await supabase.from('companies').update({ subscription_status: 'active', subscription_ends_at: periodEnd }).eq('id', companyId)

    return data
  }
}

export async function updateSubscriptionStatus(
  supabase: SupabaseClient,
  subscriptionId: string,
  status: CompanySubscription['status']
): Promise<void> {
  const { data, error } = await supabase
    .from('company_subscriptions')
    .update({
      status,
      ...(status === 'cancelled' ? { cancelled_at: new Date().toISOString() } : {}),
    })
    .eq('id', subscriptionId)
    .select('company_id')
    .single()

  if (error) throw error

  // Sync to companies table
  const statusMap: Record<string, string> = {
    trial: 'trial',
    active: 'active',
    past_due: 'active',
    cancelled: 'cancelled',
    suspended: 'suspended',
  }
  await supabase.from('companies').update({ subscription_status: statusMap[status] || status }).eq('id', data.company_id)
}

export async function cancelSubscription(supabase: SupabaseClient, companyId: string): Promise<void> {
  const sub = await getCompanySubscription(supabase, companyId)
  if (sub) {
    await updateSubscriptionStatus(supabase, sub.id, 'cancelled')
  }
}

// ─── User Limit Enforcement ───

export async function getUserLimitStatus(
  supabase: SupabaseClient,
  companyId: string
): Promise<UserLimitStatus> {
  // Get active user count
  const { count } = await supabase
    .from('user_profiles')
    .select('*', { count: 'exact', head: true })
    .eq('company_id', companyId)
    .eq('is_active', true)

  const activeUsers = count || 0

  // Get subscription
  const subscription = await getCompanySubscription(supabase, companyId)
  const includedUsers = subscription?.plan?.included_users || 5
  const additionalPurchased = subscription?.additional_users_purchased || 0
  const totalLimit = includedUsers + additionalPurchased

  return {
    active_users: activeUsers,
    included_users: includedUsers,
    additional_purchased: additionalPurchased,
    total_limit: totalLimit,
    slots_remaining: Math.max(0, totalLimit - activeUsers),
    can_add_user: activeUsers < totalLimit,
  }
}

export async function canAddUser(supabase: SupabaseClient, companyId: string): Promise<boolean> {
  const status = await getUserLimitStatus(supabase, companyId)
  return status.can_add_user
}

// ─── Subscription Status Check ───

export async function checkSubscriptionStatus(
  supabase: SupabaseClient,
  companyId: string
): Promise<SubscriptionStatus> {
  const subscription = await getCompanySubscription(supabase, companyId)

  if (!subscription) {
    return {
      active: false,
      expired: true,
      expiring_soon: false,
      days_left: 0,
      status: 'none',
      message: 'No active subscription',
    }
  }

  const today = new Date()
  const periodEnd = new Date(subscription.current_period_end)
  const daysLeft = Math.ceil((periodEnd.getTime() - today.getTime()) / (1000 * 60 * 60 * 24))

  const isActive = ['trial', 'active'].includes(subscription.status) && daysLeft > 0
  const isExpired = daysLeft <= 0 || subscription.status === 'cancelled'
  const isExpiringSoon = daysLeft > 0 && daysLeft <= 14

  return {
    active: isActive,
    expired: isExpired,
    expiring_soon: isExpiringSoon,
    days_left: Math.max(0, daysLeft),
    status: subscription.status,
    message: isExpired
      ? 'Subscription expired'
      : isExpiringSoon
        ? `Subscription expires in ${daysLeft} day${daysLeft === 1 ? '' : 's'}`
        : `${daysLeft} days remaining`,
  }
}

export async function isSubscriptionActive(supabase: SupabaseClient, companyId: string): Promise<boolean> {
  const status = await checkSubscriptionStatus(supabase, companyId)
  return status.active
}
