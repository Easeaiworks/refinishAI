-- Insurance Company Labor Rate System
-- Enables tracking of labor rates by insurance company and labor type

-- Create insurance companies table
CREATE TABLE IF NOT EXISTS insurance_companies (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  code text UNIQUE, -- Short code like 'GECO' for GEICO
  phone text,
  email text,
  website text,
  claims_portal_url text,
  notes text,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create labor rate types table (standard industry categories)
CREATE TABLE IF NOT EXISTS labor_rate_types (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text UNIQUE NOT NULL, -- 'BODY', 'REFINISH', 'MECH', etc.
  name text NOT NULL,
  description text,
  sort_order integer DEFAULT 0,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- Create shop-insurance relationships (DRP and rates)
CREATE TABLE IF NOT EXISTS company_insurance_rates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  insurance_company_id uuid NOT NULL REFERENCES insurance_companies(id) ON DELETE CASCADE,
  is_drp boolean DEFAULT false, -- Direct Repair Program participant
  drp_code text, -- Shop's DRP code with this insurer
  account_number text,
  contact_name text,
  contact_phone text,
  contact_email text,
  notes text,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(company_id, insurance_company_id)
);

-- Create the actual labor rates per insurance company
CREATE TABLE IF NOT EXISTS insurance_labor_rates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_insurance_id uuid NOT NULL REFERENCES company_insurance_rates(id) ON DELETE CASCADE,
  labor_rate_type_id uuid NOT NULL REFERENCES labor_rate_types(id) ON DELETE CASCADE,
  hourly_rate numeric(10,2) NOT NULL,
  effective_date date DEFAULT CURRENT_DATE,
  expiration_date date,
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(company_insurance_id, labor_rate_type_id, effective_date)
);

-- Add insurance and labor tracking to estimates
ALTER TABLE estimates
ADD COLUMN IF NOT EXISTS insurance_company_id uuid REFERENCES insurance_companies(id),
ADD COLUMN IF NOT EXISTS claim_number text,
ADD COLUMN IF NOT EXISTS body_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS refinish_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS mechanical_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS structural_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS aluminum_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS glass_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_labor_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_parts_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_materials_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_sublet_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS deductible numeric(10,2) DEFAULT 0;

-- Add same columns to invoices for actual costs
ALTER TABLE invoices
ADD COLUMN IF NOT EXISTS insurance_company_id uuid REFERENCES insurance_companies(id),
ADD COLUMN IF NOT EXISTS claim_number text,
ADD COLUMN IF NOT EXISTS body_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS refinish_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS mechanical_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS structural_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS aluminum_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS glass_labor_hours numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_labor_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_parts_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_materials_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_sublet_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS deductible numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS labor_cost numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS material_cost numeric(10,2) DEFAULT 0;

-- Seed standard labor rate types
INSERT INTO labor_rate_types (code, name, description, sort_order) VALUES
  ('BODY', 'Body Labor', 'Standard body repair labor including disassembly, repair, and reassembly', 1),
  ('REFINISH', 'Refinish Labor', 'Paint and refinish labor including prep, prime, paint, and clear', 2),
  ('MECHANICAL', 'Mechanical Labor', 'Mechanical repairs including suspension, drivetrain, and engine work', 3),
  ('STRUCTURAL', 'Structural/Frame Labor', 'Frame and structural repair including measuring and pulling', 4),
  ('ALUMINUM', 'Aluminum Labor', 'Specialized aluminum body repair (typically higher rate)', 5),
  ('GLASS', 'Glass Labor', 'Windshield and glass installation labor', 6),
  ('DETAIL', 'Detail Labor', 'Final cleaning, polishing, and detail work', 7),
  ('DIAGNOSTIC', 'Diagnostic Labor', 'Scanning, calibration, and diagnostic operations', 8)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  sort_order = EXCLUDED.sort_order;

-- Seed major insurance companies
INSERT INTO insurance_companies (name, code, website) VALUES
  ('State Farm', 'STFM', 'https://www.statefarm.com'),
  ('GEICO', 'GECO', 'https://www.geico.com'),
  ('Progressive', 'PROG', 'https://www.progressive.com'),
  ('Allstate', 'ALLS', 'https://www.allstate.com'),
  ('USAA', 'USAA', 'https://www.usaa.com'),
  ('Liberty Mutual', 'LBMY', 'https://www.libertymutual.com'),
  ('Farmers Insurance', 'FARM', 'https://www.farmers.com'),
  ('Nationwide', 'NATN', 'https://www.nationwide.com'),
  ('Travelers', 'TRVL', 'https://www.travelers.com'),
  ('American Family', 'AMFM', 'https://www.amfam.com'),
  ('Erie Insurance', 'ERIE', 'https://www.erieinsurance.com'),
  ('Mercury Insurance', 'MERC', 'https://www.mercuryinsurance.com'),
  ('Hartford', 'HRTF', 'https://www.thehartford.com'),
  ('Auto-Owners', 'AUTO', 'https://www.auto-owners.com'),
  ('Customer Pay', 'CUST', NULL) -- For non-insurance jobs
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name,
  website = EXCLUDED.website;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_company_insurance_rates_company ON company_insurance_rates(company_id);
CREATE INDEX IF NOT EXISTS idx_company_insurance_rates_insurance ON company_insurance_rates(insurance_company_id);
CREATE INDEX IF NOT EXISTS idx_insurance_labor_rates_company_ins ON insurance_labor_rates(company_insurance_id);
CREATE INDEX IF NOT EXISTS idx_estimates_insurance ON estimates(insurance_company_id);
CREATE INDEX IF NOT EXISTS idx_invoices_insurance ON invoices(insurance_company_id);

-- Enable RLS on new tables
ALTER TABLE insurance_companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE labor_rate_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE company_insurance_rates ENABLE ROW LEVEL SECURITY;
ALTER TABLE insurance_labor_rates ENABLE ROW LEVEL SECURITY;

-- RLS Policies for insurance_companies (all users can read, super_admin can modify)
CREATE POLICY "All users can view insurance companies" ON insurance_companies
  FOR SELECT USING (true);

CREATE POLICY "Super admins can manage insurance companies" ON insurance_companies
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role = 'super_admin'
    )
  );

-- RLS Policies for labor_rate_types (all users can read)
CREATE POLICY "All users can view labor rate types" ON labor_rate_types
  FOR SELECT USING (true);

CREATE POLICY "Super admins can manage labor rate types" ON labor_rate_types
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role = 'super_admin'
    )
  );

-- RLS Policies for company_insurance_rates (company-scoped)
CREATE POLICY "Users can view their company insurance rates" ON company_insurance_rates
  FOR SELECT USING (
    company_id IN (
      SELECT company_id FROM user_profiles WHERE id = auth.uid()
    )
    OR EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role = 'super_admin'
    )
  );

CREATE POLICY "Admins can manage their company insurance rates" ON company_insurance_rates
  FOR ALL USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid()
      AND role IN ('admin', 'super_admin')
    )
  );

-- RLS Policies for insurance_labor_rates
CREATE POLICY "Users can view their company labor rates" ON insurance_labor_rates
  FOR SELECT USING (
    company_insurance_id IN (
      SELECT cir.id FROM company_insurance_rates cir
      JOIN user_profiles up ON cir.company_id = up.company_id
      WHERE up.id = auth.uid()
    )
    OR EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role = 'super_admin'
    )
  );

CREATE POLICY "Admins can manage their company labor rates" ON insurance_labor_rates
  FOR ALL USING (
    company_insurance_id IN (
      SELECT cir.id FROM company_insurance_rates cir
      JOIN user_profiles up ON cir.company_id = up.company_id
      WHERE up.id = auth.uid()
      AND up.role IN ('admin', 'super_admin')
    )
  );

-- Function to calculate labor cost for an estimate
CREATE OR REPLACE FUNCTION calculate_estimate_labor_cost(
  p_company_id uuid,
  p_insurance_company_id uuid,
  p_body_hours numeric DEFAULT 0,
  p_refinish_hours numeric DEFAULT 0,
  p_mechanical_hours numeric DEFAULT 0,
  p_structural_hours numeric DEFAULT 0,
  p_aluminum_hours numeric DEFAULT 0,
  p_glass_hours numeric DEFAULT 0
)
RETURNS TABLE (
  total_labor_cost numeric,
  body_cost numeric,
  refinish_cost numeric,
  mechanical_cost numeric,
  structural_cost numeric,
  aluminum_cost numeric,
  glass_cost numeric
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_body_rate numeric := 50; -- Default rates if not configured
  v_refinish_rate numeric := 50;
  v_mechanical_rate numeric := 75;
  v_structural_rate numeric := 60;
  v_aluminum_rate numeric := 70;
  v_glass_rate numeric := 50;
  v_company_insurance_id uuid;
BEGIN
  -- Get the company-insurance relationship
  SELECT cir.id INTO v_company_insurance_id
  FROM company_insurance_rates cir
  WHERE cir.company_id = p_company_id
  AND cir.insurance_company_id = p_insurance_company_id
  AND cir.is_active = true;

  -- If relationship exists, get the configured rates
  IF v_company_insurance_id IS NOT NULL THEN
    SELECT COALESCE(
      (SELECT hourly_rate FROM insurance_labor_rates ilr
       JOIN labor_rate_types lrt ON ilr.labor_rate_type_id = lrt.id
       WHERE ilr.company_insurance_id = v_company_insurance_id
       AND lrt.code = 'BODY'
       AND (ilr.expiration_date IS NULL OR ilr.expiration_date >= CURRENT_DATE)
       ORDER BY ilr.effective_date DESC LIMIT 1),
      v_body_rate
    ) INTO v_body_rate;

    SELECT COALESCE(
      (SELECT hourly_rate FROM insurance_labor_rates ilr
       JOIN labor_rate_types lrt ON ilr.labor_rate_type_id = lrt.id
       WHERE ilr.company_insurance_id = v_company_insurance_id
       AND lrt.code = 'REFINISH'
       AND (ilr.expiration_date IS NULL OR ilr.expiration_date >= CURRENT_DATE)
       ORDER BY ilr.effective_date DESC LIMIT 1),
      v_refinish_rate
    ) INTO v_refinish_rate;

    SELECT COALESCE(
      (SELECT hourly_rate FROM insurance_labor_rates ilr
       JOIN labor_rate_types lrt ON ilr.labor_rate_type_id = lrt.id
       WHERE ilr.company_insurance_id = v_company_insurance_id
       AND lrt.code = 'MECHANICAL'
       AND (ilr.expiration_date IS NULL OR ilr.expiration_date >= CURRENT_DATE)
       ORDER BY ilr.effective_date DESC LIMIT 1),
      v_mechanical_rate
    ) INTO v_mechanical_rate;

    SELECT COALESCE(
      (SELECT hourly_rate FROM insurance_labor_rates ilr
       JOIN labor_rate_types lrt ON ilr.labor_rate_type_id = lrt.id
       WHERE ilr.company_insurance_id = v_company_insurance_id
       AND lrt.code = 'STRUCTURAL'
       AND (ilr.expiration_date IS NULL OR ilr.expiration_date >= CURRENT_DATE)
       ORDER BY ilr.effective_date DESC LIMIT 1),
      v_structural_rate
    ) INTO v_structural_rate;

    SELECT COALESCE(
      (SELECT hourly_rate FROM insurance_labor_rates ilr
       JOIN labor_rate_types lrt ON ilr.labor_rate_type_id = lrt.id
       WHERE ilr.company_insurance_id = v_company_insurance_id
       AND lrt.code = 'ALUMINUM'
       AND (ilr.expiration_date IS NULL OR ilr.expiration_date >= CURRENT_DATE)
       ORDER BY ilr.effective_date DESC LIMIT 1),
      v_aluminum_rate
    ) INTO v_aluminum_rate;

    SELECT COALESCE(
      (SELECT hourly_rate FROM insurance_labor_rates ilr
       JOIN labor_rate_types lrt ON ilr.labor_rate_type_id = lrt.id
       WHERE ilr.company_insurance_id = v_company_insurance_id
       AND lrt.code = 'GLASS'
       AND (ilr.expiration_date IS NULL OR ilr.expiration_date >= CURRENT_DATE)
       ORDER BY ilr.effective_date DESC LIMIT 1),
      v_glass_rate
    ) INTO v_glass_rate;
  END IF;

  -- Return the calculated costs
  RETURN QUERY SELECT
    ROUND((p_body_hours * v_body_rate + p_refinish_hours * v_refinish_rate +
           p_mechanical_hours * v_mechanical_rate + p_structural_hours * v_structural_rate +
           p_aluminum_hours * v_aluminum_rate + p_glass_hours * v_glass_rate)::numeric, 2) as total_labor_cost,
    ROUND((p_body_hours * v_body_rate)::numeric, 2) as body_cost,
    ROUND((p_refinish_hours * v_refinish_rate)::numeric, 2) as refinish_cost,
    ROUND((p_mechanical_hours * v_mechanical_rate)::numeric, 2) as mechanical_cost,
    ROUND((p_structural_hours * v_structural_rate)::numeric, 2) as structural_cost,
    ROUND((p_aluminum_hours * v_aluminum_rate)::numeric, 2) as aluminum_cost,
    ROUND((p_glass_hours * v_glass_rate)::numeric, 2) as glass_cost;
END;
$$;

-- Grant execute permission on the function
GRANT EXECUTE ON FUNCTION calculate_estimate_labor_cost TO authenticated;
