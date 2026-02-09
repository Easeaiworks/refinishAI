import { NextRequest, NextResponse } from 'next/server'
import { stripe } from '@/lib/stripe'
import { createClient } from '@/lib/supabase/server'
import { getPlanById } from '@/lib/services/subscription-service'
import { rateLimitResponse } from '@/lib/rate-limit'

export async function POST(request: NextRequest) {
  try {
    // Rate limit: 5 checkout attempts per minute per IP
    const rateLimited = await rateLimitResponse(request, {
      maxRequests: 5,
      windowSeconds: 60,
      prefix: 'rl:checkout',
    })
    if (rateLimited) return rateLimited

    const body = await request.json()
    const { company_id, plan_id, billing_period } = body

    // Validate required fields
    if (!company_id || !plan_id || !billing_period) {
      return NextResponse.json(
        { error: 'Missing required fields: company_id, plan_id, billing_period' },
        { status: 400 }
      )
    }

    // Get Supabase client
    const supabase = await createClient()

    // Verify user is authenticated and belongs to the company
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Verify user belongs to this company and is admin
    const { data: userProfile } = await supabase
      .from('user_profiles')
      .select('company_id, role')
      .eq('id', user.id)
      .single()

    if (!userProfile || userProfile.company_id !== company_id) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    if (!['admin', 'super_admin'].includes(userProfile.role)) {
      return NextResponse.json({ error: 'Admin role required' }, { status: 403 })
    }

    // Look up the plan from Supabase
    const plan = await getPlanById(supabase, plan_id)
    if (!plan) {
      return NextResponse.json(
        { error: 'Plan not found' },
        { status: 404 }
      )
    }

    // Validate stripe_price_id exists
    if (!plan.stripe_price_id) {
      return NextResponse.json(
        { error: 'Plan is not configured for Stripe checkout' },
        { status: 400 }
      )
    }

    // Get company details for metadata
    const { data: company, error: companyError } = await supabase
      .from('companies')
      .select('id, name, email')
      .eq('id', company_id)
      .single()

    if (companyError || !company) {
      return NextResponse.json(
        { error: 'Company not found' },
        { status: 404 }
      )
    }

    // Check if company already has a Stripe customer ID
    const { data: subscription } = await supabase
      .from('company_subscriptions')
      .select('stripe_customer_id')
      .eq('company_id', company_id)
      .single()

    let customerId = subscription?.stripe_customer_id

    // Create or retrieve Stripe customer
    if (!customerId) {
      const customer = await stripe.customers.create({
        email: company.email || undefined,
        name: company.name,
        metadata: {
          company_id: company_id,
        },
      })
      customerId = customer.id
    }

    // Create Stripe checkout session
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      mode: 'subscription',
      payment_method_types: ['card'],
      line_items: [
        {
          price: plan.stripe_price_id,
          quantity: 1,
        },
      ],
      success_url: `${process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'}/dashboard/company/billing?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'}/dashboard/company/billing`,
      metadata: {
        company_id: company_id,
        plan_id: plan_id,
        billing_period: billing_period,
      },
    })

    return NextResponse.json({
      sessionUrl: session.url,
      sessionId: session.id,
    })
  } catch (error) {
    console.error('Checkout error:', error)
    return NextResponse.json(
      { error: 'Failed to create checkout session' },
      { status: 500 }
    )
  }
}
