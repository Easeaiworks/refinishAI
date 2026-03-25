'use client'

import { useState, useRef, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Building2, ChevronDown, Check } from 'lucide-react'

interface Company {
  id: string
  name: string
  city?: string
}

interface CompanySwitcherProps {
  currentCompanyId: string
  currentCompanyName: string
  companies: Company[]
}

export default function CompanySwitcher({
  currentCompanyId,
  currentCompanyName,
  companies,
}: CompanySwitcherProps) {
  const [open, setOpen] = useState(false)
  const [switching, setSwitching] = useState(false)
  const ref = useRef<HTMLDivElement>(null)
  const router = useRouter()

  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  // Don't render if only one company
  if (companies.length <= 1) {
    return (
      <div className="flex items-center gap-1.5 px-2 py-1">
        <Building2 className="w-3.5 h-3.5 text-slate-400" />
        <span className="text-xs font-medium text-slate-400 max-w-[140px] truncate">
          {currentCompanyName}
        </span>
      </div>
    )
  }

  const handleSwitch = async (companyId: string) => {
    if (companyId === currentCompanyId || switching) return

    setSwitching(true)
    try {
      const res = await fetch('/api/switch-company', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ company_id: companyId }),
      })

      if (res.ok) {
        setOpen(false)
        // Full page reload to refresh all server components with new company context
        window.location.href = '/dashboard'
      } else {
        const data = await res.json()
        alert(data.error || 'Failed to switch company')
      }
    } catch {
      alert('Failed to switch company')
    } finally {
      setSwitching(false)
    }
  }

  return (
    <div ref={ref} className="relative">
      <button
        onClick={() => setOpen(!open)}
        disabled={switching}
        className={`flex items-center gap-1.5 px-2.5 py-1.5 rounded-md text-sm transition-colors ${
          open
            ? 'bg-slate-700 text-white'
            : 'text-slate-300 hover:bg-slate-800 hover:text-white'
        } ${switching ? 'opacity-50' : ''}`}
      >
        <Building2 className="w-3.5 h-3.5" />
        <span className="max-w-[140px] truncate text-xs font-medium">
          {switching ? 'Switching...' : currentCompanyName}
        </span>
        <ChevronDown className={`w-3 h-3 transition-transform ${open ? 'rotate-180' : ''}`} />
      </button>

      {open && (
        <div className="absolute top-full left-0 mt-1.5 w-64 bg-white rounded-lg shadow-xl border border-gray-200 py-1 z-50">
          <div className="px-3 py-2 border-b border-gray-100">
            <p className="text-xs font-semibold text-gray-500 uppercase tracking-wide">Switch Company</p>
          </div>
          {companies.map((company) => {
            const isActive = company.id === currentCompanyId
            return (
              <button
                key={company.id}
                onClick={() => handleSwitch(company.id)}
                disabled={switching}
                className={`flex items-center justify-between w-full px-3 py-2.5 text-sm transition-colors ${
                  isActive
                    ? 'bg-blue-50 text-blue-700 font-medium'
                    : 'text-gray-700 hover:bg-gray-50'
                }`}
              >
                <div className="flex items-center gap-2.5">
                  <Building2 className={`w-4 h-4 ${isActive ? 'text-blue-600' : 'text-gray-400'}`} />
                  <div className="text-left">
                    <p className="font-medium">{company.name}</p>
                    {company.city && (
                      <p className="text-xs text-gray-400">{company.city}</p>
                    )}
                  </div>
                </div>
                {isActive && <Check className="w-4 h-4 text-blue-600" />}
              </button>
            )
          })}
        </div>
      )}
    </div>
  )
}
