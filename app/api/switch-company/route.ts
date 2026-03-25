import { createClient } from '@/lib/supabase/server'
import { NextRequest, NextResponse } from 'next/server'

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { company_id } = await request.json()
    if (!company_id) {
      return NextResponse.json({ error: 'company_id required' }, { status: 400 })
    }

    // Get user profile to check role
    const { data: profile } = await supabase
      .from('user_profiles')
      .select('role, company_id, is_corporate_user')
      .eq('id', user.id)
      .single()

    if (!profile) {
      return NextResponse.json({ error: 'Profile not found' }, { status: 404 })
    }

    // Super admins can switch to any company
    // Corporate users can switch to parent + children
    // Regular users can only stay on their company
    let allowed = false

    if (profile.role === 'super_admin') {
      allowed = true
    } else if (profile.is_corporate_user) {
      // Check if target company is in their accessible set
      const { data: accessible } = await supabase.rpc('get_accessible_company_ids')
      if (accessible && accessible.includes(company_id)) {
        allowed = true
      }
    }

    if (!allowed) {
      return NextResponse.json({ error: 'Not authorized to switch to this company' }, { status: 403 })
    }

    // Update the user's active company
    const { error } = await supabase
      .from('user_profiles')
      .update({ company_id: company_id })
      .eq('id', user.id)

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json({ success: true, company_id })
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 })
  }
}
