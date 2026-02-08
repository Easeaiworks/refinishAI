import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import DashboardNav from '@/components/DashboardNav'

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

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      <DashboardNav user={user} profile={profile} />
      <main className="flex-1 max-w-7xl mx-auto px-6 py-8 w-full">
        {children}
      </main>
    </div>
  )
}
