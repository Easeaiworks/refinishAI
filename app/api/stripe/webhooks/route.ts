import { NextRequest, NextResponse } from 'next/server'
import { stripe } from '@/lib/stripe'
import { createClient } from '@/lib/supabase/server'
import { assignPlan, updateSubscriptionStatus } from '@/lib/services/subscription-service'
import Stripe from 'stripe'

export async function POST(request: NextRequest) {
  try {
    // Get raw body for signature verification
    const rawBody = await request.text()
    const signature = request.headers.get('stripe-signature')

    if (!signature) {
      return NextResponse.json(
        { error: 'Missing stripe-signature header' },
        { status: 400 }
      )
    }

    // Verify Stripe signature
    let event: Stripe.Event
    try {
      event = stripe.webhooks.constructEvent(
        rawBody,
        signature,
        process.env.STRIPE_WEBHOOK_SECRET || ''
      )
    } catch (error) {
      console.error('Webhook signature verification failed:', error)
      return NextResponse.json(
        { error: 'Webhook signature verification failed' },
        { status: 400 }
      )
    }

    const supabase = await createClient()

    // Handle different event types
    switch (event.type) {
      case 'checkout.session.completed': {
        const session = event.data.object as Stripe.Checkout.Session
        const companyId = session.metadata?.company_id
        const planId = session.metadata?.plan_id
        const billingPeriod = session.metadata?.billing_period as 'monthly' | 'annual' | undefined

        if (companyId && planId && billingPeriod) {
          // Create or update company subscription
          await assignPlan(supabase, companyId, planId, billingPeriod)

          // Update subscription with Stripe IDs
          const { data: subscription } = await supabase
            .from('company_subscriptions')
            .select('id')
            .eq('company_id', companyId)
            .single()

          if (subscription && session.subscription) {
            await supabase
              .from('company_subscriptions')
              .update({
                stripe_customer_id: session.customer as string,
                stripe_subscription_id: session.subscription as string,
              })
              .eq('id', subscription.id)
          }
        }
        break
      }

      case 'customer.subscription.updated': {
        const subscription = event.data.object as Stripe.Subscription
        const customerId = subscription.customer as string

        // Find company with this Stripe customer ID
        const { data: companySubscription } = await supabase
          .from('company_subscriptions')
          .select('id, company_id, status')
          .eq('stripe_customer_id', customerId)
          .single()

        if (companySubscription) {
          const newStatus = subscription.status === 'active' ? 'active' : 'past_due'
          await updateSubscriptionStatus(supabase, companySubscription.id, newStatus as any)
        }
        break
      }

      case 'customer.subscription.deleted': {
        const subscription = event.data.object as Stripe.Subscription
        const customerId = subscription.customer as string

        // Find company with this Stripe customer ID
        const { data: companySubscription } = await supabase
          .from('company_subscriptions')
          .select('id')
          .eq('stripe_customer_id', customerId)
          .single()

        if (companySubscription) {
          await updateSubscriptionStatus(supabase, companySubscription.id, 'cancelled')
        }
        break
      }

      case 'invoice.payment_succeeded': {
        const invoice = event.data.object as Stripe.Invoice
        const customerId = typeof invoice.customer === 'string' ? invoice.customer : (invoice.customer as { id: string })?.id || ''
        // payment_intent may be a string ID or expanded object depending on Stripe version
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        const invoiceAny = event.data.object as any
        const paymentIntentId: string | null = typeof invoiceAny.payment_intent === 'string'
          ? invoiceAny.payment_intent
          : invoiceAny.payment_intent?.id || null

        // Find company
        const { data: companySubSuccess } = await supabase
          .from('company_subscriptions')
          .select('company_id')
          .eq('stripe_customer_id', customerId)
          .single()

        if (companySubSuccess && paymentIntentId) {
          // Record payment
          const { data: existingPayment } = await supabase
            .from('payment_history')
            .select('id')
            .eq('stripe_payment_intent_id', paymentIntentId)
            .single()

          if (!existingPayment) {
            await supabase.from('payment_history').insert({
              company_id: companySubSuccess.company_id,
              amount: (invoice.total || 0) / 100, // Convert from cents
              payment_method: 'stripe',
              status: 'completed',
              stripe_payment_intent_id: paymentIntentId,
              transaction_ref: invoice.id,
              paid_at: new Date().toISOString(),
              created_at: new Date().toISOString(),
            })
          }

          // Update billing invoice status if it exists
          if (invoice.id) {
            await supabase
              .from('billing_invoices')
              .update({
                status: 'paid',
                stripe_invoice_id: invoice.id,
              })
              .eq('stripe_invoice_id', invoice.id)
          }
        }
        break
      }

      case 'invoice.payment_failed': {
        const failedInvoice = event.data.object as Stripe.Invoice
        const failedCustomerId = typeof failedInvoice.customer === 'string' ? failedInvoice.customer : (failedInvoice.customer as { id: string })?.id || ''
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        const failedInvoiceAny = event.data.object as any
        const failedPaymentIntentId: string | null = typeof failedInvoiceAny.payment_intent === 'string'
          ? failedInvoiceAny.payment_intent
          : failedInvoiceAny.payment_intent?.id || null

        // Find company
        const { data: companySubFailed } = await supabase
          .from('company_subscriptions')
          .select('id, company_id')
          .eq('stripe_customer_id', failedCustomerId)
          .single()

        if (companySubFailed) {
          // Update subscription status to past_due
          await updateSubscriptionStatus(supabase, companySubFailed.id, 'past_due')

          // Record failed payment
          if (failedPaymentIntentId) {
            const { data: existingFailedPayment } = await supabase
              .from('payment_history')
              .select('id')
              .eq('stripe_payment_intent_id', failedPaymentIntentId)
              .single()

            if (!existingFailedPayment) {
              await supabase.from('payment_history').insert({
                company_id: companySubFailed.company_id,
                amount: (failedInvoice.total || 0) / 100, // Convert from cents
                payment_method: 'stripe',
                status: 'failed',
                stripe_payment_intent_id: failedPaymentIntentId,
                transaction_ref: failedInvoice.id,
                created_at: new Date().toISOString(),
              })
            }
          }
        }
        break
      }

      default:
        // Unhandled event type
        console.log(`Unhandled event type: ${event.type}`)
    }

    return NextResponse.json({ received: true })
  } catch (error) {
    console.error('Webhook error:', error)
    return NextResponse.json(
      { error: 'Webhook processing failed' },
      { status: 500 }
    )
  }
}
