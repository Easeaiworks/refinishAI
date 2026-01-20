import { createClient } from 'npm:@supabase/supabase-js@2.57.4';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Client-Info, Apikey',
};

interface VehicleData {
  year: number | null;
  make: string | null;
  model: string | null;
  bodyStyle: string | null;
  engineDisplacement: string | null;
  engineCylinders: string | null;
}

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, {
      status: 200,
      headers: corsHeaders,
    });
  }

  try {
    const { vin } = await req.json();

    if (!vin || vin.length < 11) {
      return new Response(
        JSON.stringify({ error: 'Invalid VIN provided. VIN must be at least 11 characters.' }),
        {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      );
    }

    const nhtsaUrl = `https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVin/${encodeURIComponent(vin)}?format=json`;
    const response = await fetch(nhtsaUrl);
    
    if (!response.ok) {
      throw new Error('Failed to fetch vehicle data from NHTSA');
    }

    const data = await response.json();
    
    if (!data.Results || data.Results.length === 0) {
      return new Response(
        JSON.stringify({ error: 'No vehicle data found for this VIN' }),
        {
          status: 404,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      );
    }

    const results = data.Results;
    
    const getValue = (variableId: number): string | null => {
      const result = results.find((r: any) => r.VariableId === variableId);
      return result?.Value || null;
    };

    const vehicleData: VehicleData = {
      year: parseInt(getValue(29) || '') || null,
      make: getValue(26),
      model: getValue(28),
      bodyStyle: getValue(5),
      engineDisplacement: getValue(11),
      engineCylinders: getValue(9),
    };

    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseKey);

    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      throw new Error('No authorization header');
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);
    
    if (userError || !user) {
      throw new Error('Unauthorized');
    }

    const { data: profile } = await supabase
      .from('user_profiles')
      .select('company_id')
      .eq('id', user.id)
      .single();

    const companyId = profile?.company_id;

    const { data: existingVehicle } = await supabase
      .from('vehicles')
      .select('*')
      .eq('vin', vin.toUpperCase())
      .maybeSingle();

    let vehicleId = existingVehicle?.id;

    if (!existingVehicle && vehicleData.make && vehicleData.model) {
      const { data: newVehicle, error: insertError } = await supabase
        .from('vehicles')
        .insert({
          vin: vin.toUpperCase(),
          year: vehicleData.year,
          make: vehicleData.make,
          model: vehicleData.model,
          body_style: vehicleData.bodyStyle,
          company_id: companyId,
        })
        .select()
        .single();

      if (insertError) {
        console.error('Error inserting vehicle:', insertError);
      } else {
        vehicleId = newVehicle.id;

        const { data: panelTypes } = await supabase
          .from('panel_types')
          .select('*')
          .in('code', ['HOOD', 'FENDER_F_L', 'FENDER_F_R', 'DOOR_F_L', 'DOOR_F_R', 'DOOR_R_L', 'DOOR_R_R', 'TRUNK', 'BUMPER_F', 'BUMPER_R', 'ROOF']);

        if (panelTypes && panelTypes.length > 0) {
          const bodyStyleMultiplier = getBodyStyleMultiplier(vehicleData.bodyStyle);
          
          const panelsToInsert = panelTypes.map(pt => ({
            vehicle_id: vehicleId,
            panel_type_id: pt.id,
            area_sqft: pt.typical_area_sqft * bodyStyleMultiplier,
          }));

          await supabase.from('vehicle_panels').insert(panelsToInsert);
        }
      }
    }

    return new Response(
      JSON.stringify({
        success: true,
        vehicle: vehicleData,
        vehicleId,
        existing: !!existingVehicle,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    );
  } catch (error: any) {
    console.error('Error in decode-vin function:', error);
    return new Response(
      JSON.stringify({ error: error.message || 'Internal server error' }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    );
  }
});

function getBodyStyleMultiplier(bodyStyle: string | null): number {
  if (!bodyStyle) return 1.0;
  
  const style = bodyStyle.toLowerCase();
  
  if (style.includes('truck') || style.includes('pickup')) return 1.3;
  if (style.includes('suv') || style.includes('sport utility')) return 1.2;
  if (style.includes('van') || style.includes('minivan')) return 1.25;
  if (style.includes('sedan') || style.includes('4-door')) return 1.0;
  if (style.includes('coupe') || style.includes('2-door')) return 0.9;
  if (style.includes('hatchback')) return 0.85;
  if (style.includes('convertible')) return 0.9;
  
  return 1.0;
}
