// ─── Licensing & Billing Types ───

export interface SubscriptionPlan {
  id: string
  name: string
  description: string | null
  billing_period: 'monthly' | 'annual'
  base_price: number
  included_users: number
  price_per_additional_user: number
  features: Record<string, boolean>
  stripe_price_id: string | null
  is_active: boolean
  sort_order: number
  created_at: string
  updated_at: string
}

export interface CompanySubscription {
  id: string
  company_id: string
  plan_id: string
  billing_period: 'monthly' | 'annual'
  current_price: number
  additional_users_purchased: number
  status: 'trial' | 'active' | 'past_due' | 'cancelled' | 'suspended'
  started_at: string
  current_period_start: string
  current_period_end: string
  auto_renew: boolean
  stripe_subscription_id: string | null
  stripe_customer_id: string | null
  cancelled_at: string | null
  created_at: string
  updated_at: string
  // Joined data
  plan?: SubscriptionPlan
  company?: { id: string; name: string; email: string }
}

export interface BillingInvoice {
  id: string
  company_id: string
  subscription_id: string | null
  invoice_number: string
  invoice_date: string
  due_date: string
  subtotal: number
  tax: number
  total: number
  description: string | null
  line_items: InvoiceLineItem[]
  status: 'draft' | 'sent' | 'paid' | 'overdue' | 'cancelled'
  issued_by: string
  notes: string | null
  stripe_invoice_id: string | null
  created_at: string
  updated_at: string
  // Joined
  company?: { id: string; name: string; email: string }
  issuer?: { full_name: string; email: string }
}

export interface InvoiceLineItem {
  description: string
  quantity: number
  unit_price: number
  total: number
}

export interface PaymentRecord {
  id: string
  invoice_id: string | null
  company_id: string
  amount: number
  payment_method: 'stripe' | 'manual' | 'check' | 'wire'
  status: 'pending' | 'completed' | 'failed' | 'refunded'
  stripe_payment_intent_id: string | null
  transaction_ref: string | null
  notes: string | null
  recorded_by: string
  paid_at: string | null
  created_at: string
  // Joined
  company?: { id: string; name: string }
  invoice?: { invoice_number: string }
  recorder?: { full_name: string }
}

export interface UserLimitStatus {
  active_users: number
  included_users: number
  additional_purchased: number
  total_limit: number
  slots_remaining: number
  can_add_user: boolean
}

export interface SubscriptionStatus {
  active: boolean
  expired: boolean
  expiring_soon: boolean
  days_left: number
  status: string
  message: string
}

export interface NewInvoiceData {
  company_id: string
  subscription_id?: string
  description: string
  line_items: InvoiceLineItem[]
  due_date: string
  notes?: string
  issued_by: string
}

export interface NewPaymentData {
  invoice_id?: string
  company_id: string
  amount: number
  payment_method: 'stripe' | 'manual' | 'check' | 'wire'
  transaction_ref?: string
  notes?: string
  recorded_by: string
}
