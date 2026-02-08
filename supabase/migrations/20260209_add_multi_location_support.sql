-- ============================================================
-- Multi-Location Company Support
-- Adds parent/child company hierarchy, corporate settings,
-- and corporate user access for multi-location groups
-- ============================================================

-- ─── EXTEND COMPANIES TABLE ───
ALTER TABLE companies
  ADD COLUMN IF NOT EXISTS parent_company_id UUID REFERENCES companies(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS company_type VARCHAR(20) DEFAULT 'single'
    CHECK (company_type IN ('single', 'corporate', 'location')),
  ADD COLUMN IF NOT EXISTS location_code VARCHAR(50),
  ADD COLUMN IF NOT EXISTS is_headquarters BOOLEAN DEFAULT false;

-- Backfill existing companies as single locations
UPDATE companies SET company_type = 'single' WHERE company_type IS NULL;

-- Indexes for hierarchy queries
CREATE INDEX IF NOT EXISTS idx_companies_parent ON companies(parent_company_id);
CREATE INDEX IF NOT EXISTS idx_companies_type ON companies(company_type);

-- ─── EXTEND USER PROFILES ───
ALTER TABLE user_profiles
  ADD COLUMN IF NOT EXISTS is_corporate_user BOOLEAN DEFAULT false;

-- ─── CORPORATE SETTINGS TABLE ───
-- Stores group-wide policies that cascade from parent to all child locations
CREATE TABLE IF NOT EXISTS corporate_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  setting_key VARCHAR(100) NOT NULL,
  setting_value JSONB NOT NULL DEFAULT '{}',
  enforce_lock BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(parent_company_id, setting_key)
);

CREATE INDEX IF NOT EXISTS idx_corporate_settings_parent ON corporate_settings(parent_company_id);

-- ─── RLS HELPER: GET ACCESSIBLE COMPANY IDS ───
-- Returns all company IDs a user can access based on their role and corporate status
CREATE OR REPLACE FUNCTION get_accessible_company_ids()
RETURNS SETOF UUID AS $$
DECLARE
  v_user_id UUID;
  v_company_id UUID;
  v_role TEXT;
  v_is_corporate BOOLEAN;
  v_company_type TEXT;
BEGIN
  v_user_id := auth.uid();

  -- Get user's profile
  SELECT company_id, role, is_corporate_user
  INTO v_company_id, v_role, v_is_corporate
  FROM user_profiles
  WHERE id = v_user_id;

  -- Super admin: all companies
  IF v_role = 'super_admin' THEN
    RETURN QUERY SELECT id FROM companies;
    RETURN;
  END IF;

  -- Get company type
  SELECT company_type INTO v_company_type
  FROM companies WHERE id = v_company_id;

  -- Corporate user at parent company: parent + all children
  IF v_is_corporate AND v_company_type = 'corporate' THEN
    RETURN QUERY
      SELECT id FROM companies
      WHERE id = v_company_id
         OR parent_company_id = v_company_id;
    RETURN;
  END IF;

  -- Regular user: just their company
  RETURN QUERY SELECT v_company_id;
  RETURN;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- ─── RLS ON CORPORATE SETTINGS ───
ALTER TABLE corporate_settings ENABLE ROW LEVEL SECURITY;

-- Super admin: full access
CREATE POLICY "Super admin full access to corporate_settings"
  ON corporate_settings
  FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE id = auth.uid() AND role = 'super_admin'
    )
  );

-- Corporate admin: can manage their own parent company's settings
CREATE POLICY "Corporate admin manage own settings"
  ON corporate_settings
  FOR ALL
  USING (
    parent_company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid()
        AND role IN ('admin', 'super_admin')
        AND is_corporate_user = true
    )
  );

-- Child location admin: read-only on parent's settings
CREATE POLICY "Location admin read parent settings"
  ON corporate_settings
  FOR SELECT
  USING (
    parent_company_id IN (
      SELECT c.parent_company_id FROM companies c
      JOIN user_profiles up ON up.company_id = c.id
      WHERE up.id = auth.uid()
        AND c.parent_company_id IS NOT NULL
    )
  );

-- ─── UPDATE COMPANIES RLS FOR HIERARCHY ───
-- Corporate users can view child locations
CREATE POLICY "Corporate users view child locations"
  ON companies
  FOR SELECT
  USING (
    id IN (SELECT get_accessible_company_ids())
  );

-- Corporate admins can update child locations
CREATE POLICY "Corporate admins update child locations"
  ON companies
  FOR UPDATE
  USING (
    id IN (SELECT get_accessible_company_ids())
    AND EXISTS (
      SELECT 1 FROM user_profiles
      WHERE id = auth.uid()
        AND role IN ('admin', 'super_admin')
    )
  );

-- ─── AUTO-UPDATE TIMESTAMP FOR CORPORATE SETTINGS ───
CREATE OR REPLACE FUNCTION update_corporate_settings_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER corporate_settings_updated_at
  BEFORE UPDATE ON corporate_settings
  FOR EACH ROW
  EXECUTE FUNCTION update_corporate_settings_timestamp();
