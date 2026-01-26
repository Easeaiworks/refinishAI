'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Search, Car, Loader2, AlertCircle, CheckCircle } from 'lucide-react'

export default function VehiclesPage() {
  const [vin, setVin] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [vehicle, setVehicle] = useState<any>(null)
  const [panels, setPanels] = useState<any[]>([])

  const decodeVin = async () => {
    if (!vin || vin.length < 11) {
      setError('VIN must be at least 11 characters')
      return
    }

    setLoading(true)
    setError('')
    setVehicle(null)
    setPanels([])

    try {
      const supabase = createClient()
      const { data: { session } } = await supabase.auth.getSession()

      if (!session) {
        setError('Not authenticated')
        return
      }

      // Call the Supabase Edge Function
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_SUPABASE_URL}/functions/v1/decode-vin`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${session.access_token}`,
          },
          body: JSON.stringify({ vin: vin.toUpperCase() }),
        }
      )

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || 'Failed to decode VIN')
      }

      setVehicle(data.vehicle)

      // Fetch the vehicle panels
      if (data.vehicleId) {
        const { data: panelsData } = await supabase
          .from('vehicle_panels')
          .select(`
            *,
            panel_types (
              name,
              code,
              typical_area_sqft
            )
          `)
          .eq('vehicle_id', data.vehicleId)

        setPanels(panelsData || [])
      }

    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Vehicle Lookup</h1>
        <p className="text-gray-600 mt-2">
          Decode VIN to get vehicle details and panel information
        </p>
      </div>

      {/* VIN Input */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
        <div className="flex gap-4">
          <div className="flex-1">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Vehicle Identification Number (VIN)
            </label>
            <input
              type="text"
              value={vin}
              onChange={(e) => setVin(e.target.value.toUpperCase())}
              placeholder="Enter 17-digit VIN"
              maxLength={17}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              onKeyPress={(e) => e.key === 'Enter' && decodeVin()}
            />
            <p className="text-sm text-gray-500 mt-1">
              {vin.length}/17 characters
            </p>
          </div>
          <div className="flex items-end">
            <button
              onClick={decodeVin}
              disabled={loading || vin.length < 11}
              className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed flex items-center gap-2 h-fit"
            >
              {loading ? (
                <>
                  <Loader2 className="w-5 h-5 animate-spin" />
                  Decoding...
                </>
              ) : (
                <>
                  <Search className="w-5 h-5" />
                  Decode VIN
                </>
              )}
            </button>
          </div>
        </div>

        {/* Error Message */}
        {error && (
          <div className="mt-4 p-4 bg-red-50 border border-red-200 rounded-lg flex items-start gap-3">
            <AlertCircle className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
            <div>
              <p className="font-medium text-red-900">Error</p>
              <p className="text-red-700 text-sm">{error}</p>
            </div>
          </div>
        )}
      </div>

      {/* Vehicle Details */}
      {vehicle && (
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center gap-3 mb-4">
            <Car className="w-6 h-6 text-blue-600" />
            <h2 className="text-xl font-bold text-gray-900">Vehicle Details</h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <div>
              <p className="text-sm text-gray-600">VIN</p>
              <p className="font-medium text-gray-900">{vin}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Year</p>
              <p className="font-medium text-gray-900">{vehicle.year || 'N/A'}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Make</p>
              <p className="font-medium text-gray-900">{vehicle.make || 'N/A'}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Model</p>
              <p className="font-medium text-gray-900">{vehicle.model || 'N/A'}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Body Style</p>
              <p className="font-medium text-gray-900">{vehicle.bodyStyle || 'N/A'}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Engine</p>
              <p className="font-medium text-gray-900">
                {vehicle.engineCylinders ? `${vehicle.engineCylinders} Cyl` : 'N/A'}
                {vehicle.engineDisplacement && ` - ${vehicle.engineDisplacement}L`}
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Panel Information */}
      {panels.length > 0 && (
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div className="flex items-center gap-3 mb-4">
            <CheckCircle className="w-6 h-6 text-green-600" />
            <h2 className="text-xl font-bold text-gray-900">Panel Dimensions</h2>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b border-gray-200">
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-700">Panel</th>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-700">Code</th>
                  <th className="text-right py-3 px-4 text-sm font-medium text-gray-700">Area (sq ft)</th>
                  <th className="text-right py-3 px-4 text-sm font-medium text-gray-700">Typical Area</th>
                </tr>
              </thead>
              <tbody>
                {panels.map((panel) => (
                  <tr key={panel.id} className="border-b border-gray-100 hover:bg-gray-50">
                    <td className="py-3 px-4 text-gray-900">{panel.panel_types.name}</td>
                    <td className="py-3 px-4 text-gray-600 font-mono text-sm">{panel.panel_types.code}</td>
                    <td className="py-3 px-4 text-right font-medium text-gray-900">
                      {panel.area_sqft?.toFixed(2) || 'N/A'}
                    </td>
                    <td className="py-3 px-4 text-right text-gray-600">
                      {panel.panel_types.typical_area_sqft?.toFixed(2) || 'N/A'}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <div className="mt-4 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <p className="text-sm text-blue-800">
              <strong>Note:</strong> Panel areas are calculated based on vehicle body style. 
              Trucks use 1.3x multiplier, SUVs 1.2x, Sedans 1.0x, Coupes 0.9x.
            </p>
          </div>
        </div>
      )}
    </div>
  )
}
