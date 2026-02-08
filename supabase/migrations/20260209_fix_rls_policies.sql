-- Fix overly permissive RLS policies from initial migration
-- These "Allow all" policies let any authenticated user access any company's data
-- NOTE: company_settings table does not exist in this database, so we skip it

-- Drop permissive policies on tables that DO exist
DROP POLICY IF EXISTS "Allow all on count_verifications" ON count_verifications;
DROP POLICY IF EXISTS "Allow all on inventory_adjustments" ON inventory_adjustments;
DROP POLICY IF EXISTS "Allow all on count_learning_data" ON count_learning_data;

-- count_verifications: company members can view, managers+ can modify
CREATE POLICY "Users view own company count verifications"
  ON count_verifications FOR SELECT TO authenticated
  USING (
    company_id IN (SELECT company_id FROM user_profiles WHERE id = auth.uid())
  );

CREATE POLICY "Managers manage own company count verifications"
  ON count_verifications FOR ALL TO authenticated
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid() AND role IN ('manager', 'admin', 'super_admin')
    )
  );

-- inventory_adjustments: company members can view, managers+ can modify
CREATE POLICY "Users view own company inventory adjustments"
  ON inventory_adjustments FOR SELECT TO authenticated
  USING (
    company_id IN (SELECT company_id FROM user_profiles WHERE id = auth.uid())
  );

CREATE POLICY "Managers manage own company inventory adjustments"
  ON inventory_adjustments FOR ALL TO authenticated
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid() AND role IN ('manager', 'admin', 'super_admin')
    )
  );

-- count_learning_data: company members can view, admins can modify
CREATE POLICY "Users view own company count learning data"
  ON count_learning_data FOR SELECT TO authenticated
  USING (
    company_id IN (SELECT company_id FROM user_profiles WHERE id = auth.uid())
  );

CREATE POLICY "Admins manage own company count learning data"
  ON count_learning_data FOR ALL TO authenticated
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
    )
  );
