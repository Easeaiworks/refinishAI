import { SupabaseClient } from '@supabase/supabase-js'
import type { BillingInvoice, PaymentRecord, NewInvoiceData, NewPaymentData } from '@/lib/types/billing'

// ─── Invoice Number Generator ───

async function generateInvoiceNumber(supabase: SupabaseClient): Promise<string> {
  const now = new Date()
  const prefix = `INV-${now.getFullYear()}${String(now.getMonth() + 1).padStart(2, '0')}`

  // Get highest existing number this month
  const { data } = await supabase
    .from('billing_invoices')
    .select('invoice_number')
    .like('invoice_number', `${prefix}-%`)
    .order('invoice_number', { ascending: false })
    .limit(1)

  let sequence = 1
  if (data && data.length > 0) {
    const lastNum = data[0].invoice_number.split('-').pop()
    sequence = parseInt(lastNum || '0', 10) + 1
  }

  return `${prefix}-${String(sequence).padStart(4, '0')}`
}

// ─── Invoice Operations ───

export async function createInvoice(
  supabase: SupabaseClient,
  invoiceData: NewInvoiceData
): Promise<BillingInvoice> {
  const invoiceNumber = await generateInvoiceNumber(supabase)

  const subtotal = invoiceData.line_items.reduce((sum, item) => sum + item.total, 0)

  const { data, error } = await supabase
    .from('billing_invoices')
    .insert({
      company_id: invoiceData.company_id,
      subscription_id: invoiceData.subscription_id || null,
      invoice_number: invoiceNumber,
      invoice_date: new Date().toISOString().split('T')[0],
      due_date: invoiceData.due_date,
      subtotal,
      tax: 0,
      total: subtotal,
      description: invoiceData.description,
      line_items: invoiceData.line_items,
      status: 'draft',
      issued_by: invoiceData.issued_by,
      notes: invoiceData.notes || null,
    })
    .select()
    .single()

  if (error) throw error
  return data
}

export async function getAllInvoices(supabase: SupabaseClient): Promise<BillingInvoice[]> {
  const { data, error } = await supabase
    .from('billing_invoices')
    .select('*, company:companies(id, name, email)')
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}

export async function getCompanyInvoices(
  supabase: SupabaseClient,
  companyId: string
): Promise<BillingInvoice[]> {
  const { data, error } = await supabase
    .from('billing_invoices')
    .select('*')
    .eq('company_id', companyId)
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}

export async function getInvoiceById(
  supabase: SupabaseClient,
  invoiceId: string
): Promise<BillingInvoice | null> {
  const { data, error } = await supabase
    .from('billing_invoices')
    .select('*, company:companies(id, name, email)')
    .eq('id', invoiceId)
    .single()

  if (error) return null
  return data
}

export async function updateInvoiceStatus(
  supabase: SupabaseClient,
  invoiceId: string,
  status: BillingInvoice['status']
): Promise<BillingInvoice> {
  const { data, error } = await supabase
    .from('billing_invoices')
    .update({ status })
    .eq('id', invoiceId)
    .select()
    .single()

  if (error) throw error
  return data
}

// ─── Payment Operations ───

export async function recordPayment(
  supabase: SupabaseClient,
  paymentData: NewPaymentData
): Promise<PaymentRecord> {
  const { data, error } = await supabase
    .from('payment_history')
    .insert({
      invoice_id: paymentData.invoice_id || null,
      company_id: paymentData.company_id,
      amount: paymentData.amount,
      payment_method: paymentData.payment_method,
      status: 'completed',
      transaction_ref: paymentData.transaction_ref || null,
      notes: paymentData.notes || null,
      recorded_by: paymentData.recorded_by,
      paid_at: new Date().toISOString(),
    })
    .select()
    .single()

  if (error) throw error

  // If tied to an invoice, mark it paid
  if (paymentData.invoice_id) {
    await updateInvoiceStatus(supabase, paymentData.invoice_id, 'paid')
  }

  return data
}

export async function getAllPayments(supabase: SupabaseClient): Promise<PaymentRecord[]> {
  const { data, error } = await supabase
    .from('payment_history')
    .select('*, company:companies(id, name), invoice:billing_invoices(invoice_number), recorder:user_profiles!recorded_by(full_name)')
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}

export async function getCompanyPayments(
  supabase: SupabaseClient,
  companyId: string
): Promise<PaymentRecord[]> {
  const { data, error } = await supabase
    .from('payment_history')
    .select('*, invoice:billing_invoices(invoice_number)')
    .eq('company_id', companyId)
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}

export async function getInvoicePayments(
  supabase: SupabaseClient,
  invoiceId: string
): Promise<PaymentRecord[]> {
  const { data, error } = await supabase
    .from('payment_history')
    .select('*')
    .eq('invoice_id', invoiceId)
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}
