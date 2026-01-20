'use client'

import { useState } from 'react'
import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { 
  LayoutDashboard, 
  Upload, 
  TrendingUp, 
  Search, 
  Package, 
  ClipboardList, 
  Users, 
  Shield, 
  LogOut,
  Menu,
  X
} from 'lucide-react'
import { createClient } from '@/lib/supabase/client'

interface DashboardNavProps {
  user: any
  profile: any
}

export default function DashboardNav({ user, profile }: DashboardNavProps) {
  const pathname = usePathname()
  const router = useRouter()
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)
  const supabase = createClient()

  const handleSignOut = async () => {
    await supabase.auth.signOut()
    router.push('/auth/login')
    router.refresh()
  }

  const navigation = [
    { name: 'Dashboard', href: '/dashboard', icon: LayoutDashboard, roles: ['staff', 'manager', 'admin', 'super_admin'] },
    { name: 'Upload Data', href: '/dashboard/upload', icon: Upload, roles: ['manager', 'admin', 'super_admin'] },
    { name: 'Predictions', href: '/dashboard/predictions', icon: TrendingUp, roles: ['staff', 'manager', 'admin', 'super_admin'] },
    { name: 'Vehicle Lookup', href: '/dashboard/vehicles', icon: Search, roles: ['staff', 'manager', 'admin', 'super_admin'] },
    { name: 'Inventory', href: '/dashboard/inventory', icon: Package, roles: ['staff', 'manager', 'admin', 'super_admin'] },
    { name: 'Counts', href: '/dashboard/counts', icon: ClipboardList, roles: ['staff', 'manager', 'admin', 'super_admin'] },
    { name: 'Users', href: '/dashboard/users', icon: Users, roles: ['admin', 'super_admin'] },
    { name: 'Super Admin', href: '/dashboard/admin', icon: Shield, roles: ['super_admin'] },
  ]

  const allowedNav = navigation.filter(item => 
    item.roles.includes(profile?.role || 'staff')
  )

  return (
    <nav className="bg-white shadow-sm border-b border-gray-200">
      <div className="max-w-7xl mx-auto px-6">
        <div className="flex items-center justify-between h-16">
          {/* Logo and Company */}
          <div className="flex items-center gap-4">
            <Link href="/dashboard" className="flex items-center gap-3">
              <div className="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-xl">R</span>
              </div>
              <div className="hidden sm:block">
                <h1 className="text-xl font-bold text-gray-900">RefinishAI</h1>
                <p className="text-xs text-gray-500">{profile?.companies?.name || 'Loading...'}</p>
              </div>
            </Link>
          </div>

          {/* Desktop Navigation */}
          <div className="hidden lg:flex items-center gap-1">
            {allowedNav.map((item) => {
              const Icon = item.icon
              const isActive = pathname === item.href
              return (
                <Link
                  key={item.name}
                  href={item.href}
                  className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                    isActive
                      ? 'bg-blue-50 text-blue-700'
                      : 'text-gray-700 hover:bg-gray-100'
                  }`}
                >
                  <Icon className="w-4 h-4" />
                  {item.name}
                </Link>
              )
            })}
          </div>

          {/* User Menu */}
          <div className="flex items-center gap-4">
            <div className="hidden sm:block text-right">
              <p className="text-sm font-medium text-gray-900">{profile?.full_name || user.email}</p>
              <p className="text-xs text-gray-500 capitalize">{profile?.role?.replace('_', ' ')}</p>
            </div>
            <button
              onClick={handleSignOut}
              className="p-2 text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded-lg transition-colors"
              title="Sign Out"
            >
              <LogOut className="w-5 h-5" />
            </button>
            
            {/* Mobile menu button */}
            <button
              onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
              className="lg:hidden p-2 text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded-lg"
            >
              {mobileMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
            </button>
          </div>
        </div>

        {/* Mobile Navigation */}
        {mobileMenuOpen && (
          <div className="lg:hidden border-t border-gray-200 py-4">
            <div className="space-y-1">
              {allowedNav.map((item) => {
                const Icon = item.icon
                const isActive = pathname === item.href
                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    onClick={() => setMobileMenuOpen(false)}
                    className={`flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-colors ${
                      isActive
                        ? 'bg-blue-50 text-blue-700'
                        : 'text-gray-700 hover:bg-gray-100'
                    }`}
                  >
                    <Icon className="w-5 h-5" />
                    {item.name}
                  </Link>
                )
              })}
            </div>
          </div>
        )}
      </div>
    </nav>
  )
}
