-- Allow admins to create insurance companies (not just super_admins)
-- Also fix user profile company_id issues

-- Drop the restrictive policy
DROP POLICY IF EXISTS "Super admins can manage insurance companies" ON insurance_companies;

-- Create new policy that allows admins and super_admins to manage insurance companies
CREATE POLICY "Admins can manage insurance companies" ON insurance_companies
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role IN ('admin', 'super_admin')
    )
  );

-- Make sure all super_admin profiles have a company_id set
-- Get the first company and assign it to any super_admin without one
DO $$
DECLARE
  v_company_id uuid;
BEGIN
  -- Get a company ID (preferring CHC if it exists)
  SELECT id INTO v_company_id
  FROM companies
  WHERE name ILIKE '%CHC%'
  LIMIT 1;

  -- If no CHC, get any company
  IF v_company_id IS NULL THEN
    SELECT id INTO v_company_id FROM companies LIMIT 1;
  END IF;

  -- Update any super_admin profiles that don't have a company_id
  IF v_company_id IS NOT NULL THEN
    UPDATE user_profiles
    SET company_id = v_company_id
    WHERE role = 'super_admin'
    AND company_id IS NULL;

    RAISE NOTICE 'Updated super_admin profiles with company_id: %', v_company_id;
  END IF;
END $$;

-- Verify the fix
SELECT
  up.id,
  up.full_name,
  up.role,
  up.company_id,
  c.name as company_name
FROM user_profiles up
LEFT JOIN companies c ON up.company_id = c.id
WHERE up.role = 'super_admin';
