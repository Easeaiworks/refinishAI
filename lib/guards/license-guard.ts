import { SupabaseClient } from '@supabase/supabase-js'
import { checkSubscriptionStatus, canAddUser } from '@/lib/services/subscription-service'
import type { SubscriptionStatus } from '@/lib/types/billing'

/**
 * Check the current subscription status for a company
 * Returns status information including whether subscription is active, expired, or expiring soon
 */
export async function checkSubscriptionGuard(
  supabase: SupabaseClient,
  companyId: string
): Promise<SubscriptionStatus> {
  return checkSubscriptionStatus(supabase, companyId)
}

/**
 * Enforce user limit for a company
 * Throws an error if the company has reached their user limit
 */
export async function enforceUserLimit(supabase: SupabaseClient, companyId: string): Promise<void> {
  const canAdd = await canAddUser(supabase, companyId)

  if (!canAdd) {
    throw new Error('User limit reached. Please upgrade your plan or purchase additional user seats.')
  }
}

/**
 * Guard function to check if a company can perform an action
 * Verifies subscription is active and user limit is not exceeded
 */
export async function enforceSubscriptionGuard(
  supabase: SupabaseClient,
  companyId: string
): Promise<void> {
  const status = await checkSubscriptionStatus(supabase, companyId)

  if (!status.active) {
    throw new Error(`Subscription is not active: ${status.message}`)
  }
}
