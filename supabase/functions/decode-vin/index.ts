import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

interface NHTSAResult {
  Variable: string
  Value: string | null
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Verify authorization
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: 'Missing authorization header' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Create Supabase client
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    const supabase = createClient(supabaseUrl, supabaseKey)

    // Verify the JWT token
    const token = authHeader.replace('Bearer ', '')
    const { data: { user }, error: authError } = await supabase.auth.getUser(token)

    if (authError || !user) {
      return new Response(
        JSON.stringify({ error: 'Invalid or expired token' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Get VIN from request body
    const { vin } = await req.json()

    if (!vin || vin.length < 11) {
      return new Response(
        JSON.stringify({ error: 'VIN must be at least 11 characters' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Call NHTSA API (free government API for VIN decoding)
    const nhtsaUrl = `https://vpic.nhtsa.dot.gov/api/vehicles/decodevin/${vin}?format=json`
    const nhtsaResponse = await fetch(nhtsaUrl)
    const nhtsaData = await nhtsaResponse.json()

    if (!nhtsaData.Results) {
      return new Response(
        JSON.stringify({ error: 'Failed to decode VIN from NHTSA' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Parse NHTSA results
    const results: NHTSAResult[] = nhtsaData.Results
    const getValue = (variableName: string): string | null => {
      const result = results.find(r => r.Variable === variableName)
      return result?.Value || null
    }

    // Extract vehicle information
    const vehicle = {
      vin: vin.toUpperCase(),
      year: getValue('Model Year'),
      make: getValue('Make'),
      model: getValue('Model'),
      bodyStyle: getValue('Body Class'),
      trim: getValue('Trim'),
      driveType: getValue('Drive Type'),
      fuelType: getValue('Fuel Type - Primary'),
      engineCylinders: getValue('Engine Number of Cylinders'),
      engineDisplacement: getValue('Displacement (L)'),
      transmissionStyle: getValue('Transmission Style'),
      plantCountry: getValue('Plant Country'),
      plantCity: getValue('Plant City'),
      vehicleType: getValue('Vehicle Type'),
      manufacturer: getValue('Manufacturer Name'),
      series: getValue('Series'),
      doors: getValue('Doors'),
    }

    // Check for error codes from NHTSA
    const errorCode = getValue('Error Code')
    if (errorCode && errorCode !== '0') {
      const errorText = getValue('Error Text')
      return new Response(
        JSON.stringify({
          error: errorText || 'Invalid VIN',
          vehicle: null
        }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Get user's company_id
    const { data: userProfile } = await supabase
      .from('user_profiles')
      .select('company_id')
      .eq('id', user.id)
      .single()

    let vehicleId = null

    // Try to find or create vehicle in database
    if (userProfile?.company_id) {
      // Check if vehicle already exists
      const { data: existingVehicle } = await supabase
        .from('vehicles')
        .select('id')
        .eq('vin', vin.toUpperCase())
        .eq('company_id', userProfile.company_id)
        .single()

      if (existingVehicle) {
        vehicleId = existingVehicle.id
      } else {
        // Create new vehicle record
        const { data: newVehicle, error: insertError } = await supabase
          .from('vehicles')
          .insert({
            vin: vin.toUpperCase(),
            year: vehicle.year ? parseInt(vehicle.year) : null,
            make: vehicle.make,
            model: vehicle.model,
            body_style: vehicle.bodyStyle,
            company_id: userProfile.company_id,
          })
          .select('id')
          .single()

        if (!insertError && newVehicle) {
          vehicleId = newVehicle.id
        }
      }
    }

    return new Response(
      JSON.stringify({
        vehicle,
        vehicleId,
        message: 'VIN decoded successfully'
      }),
      {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    )

  } catch (error) {
    console.error('Error decoding VIN:', error)
    return new Response(
      JSON.stringify({ error: 'Internal server error' }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
