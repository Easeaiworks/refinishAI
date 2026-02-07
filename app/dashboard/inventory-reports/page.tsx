'use client'

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'

export default function InventoryReportsRedirect() {
  const router = useRouter()

  useEffect(() => {
    // Redirect to merged Analytics & Reports page with reports tab active
    router.replace('/dashboard/analytics?tab=reports')
  }, [router])

  return (
    <div className="flex items-center justify-center min-h-[400px]">
      <p className="text-gray-500">Redirecting to Analytics & Reports...</p>
    </div>
  )
}
