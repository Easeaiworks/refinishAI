-- Comprehensive fix for all outstanding issues
-- Run this in Supabase SQL Editor

-- 1. Create company_vendors table if it doesn't exist
CREATE TABLE IF NOT EXISTS company_vendors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  vendor_code VARCHAR(50) NOT NULL,
  vendor_name VARCHAR(100) NOT NULL,
  is_active BOOLEAN DEFAULT true,
  is_primary BOOLEAN DEFAULT false,
  discount_percent DECIMAL(5,2) DEFAULT 0,
  account_number VARCHAR(100),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(company_id, vendor_code)
);

-- 2. Enable RLS on company_vendors
ALTER TABLE company_vendors ENABLE ROW LEVEL SECURITY;

-- 3. Drop existing policies if they exist and recreate
DROP POLICY IF EXISTS "Users can view their company vendors" ON company_vendors;
DROP POLICY IF EXISTS "Admins can manage company vendors" ON company_vendors;
DROP POLICY IF EXISTS "Super admins can manage all company vendors" ON company_vendors;

-- 4. Create RLS policies for company_vendors
-- Allow users to view their own company's vendors
CREATE POLICY "Users can view their company vendors" ON company_vendors
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

-- Allow admins to manage their company's vendors
CREATE POLICY "Admins can manage company vendors" ON company_vendors
  FOR ALL USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid()
      AND role IN ('admin', 'super_admin')
    )
  );

-- Allow super_admins full access to all company vendors
CREATE POLICY "Super admins can manage all company vendors" ON company_vendors
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role = 'super_admin'
    )
  );

-- 5. Create vendor_catalog table if it doesn't exist
CREATE TABLE IF NOT EXISTS vendor_catalog (
  code VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  website VARCHAR(255),
  description TEXT,
  product_categories TEXT[],
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Enable RLS on vendor_catalog
ALTER TABLE vendor_catalog ENABLE ROW LEVEL SECURITY;

-- 7. Fix vendor_catalog RLS policies
DROP POLICY IF EXISTS "Anyone can view vendor catalog" ON vendor_catalog;
CREATE POLICY "Anyone can view vendor catalog" ON vendor_catalog
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Super admins can manage vendor catalog" ON vendor_catalog;
CREATE POLICY "Super admins can manage vendor catalog" ON vendor_catalog
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role = 'super_admin'
    )
  );

-- 8. Populate vendor_catalog with default vendors
INSERT INTO vendor_catalog (code, name, website, description, product_categories) VALUES
  ('PPG', 'PPG Industries', 'https://www.ppgrefinish.com', 'Major automotive paint and coatings manufacturer', ARRAY['Paint', 'Clearcoat', 'Primer', 'Hardeners']),
  ('3M', '3M Automotive', 'https://www.3m.com/automotive', 'Abrasives, adhesives, and finishing products', ARRAY['Abrasives', 'Adhesives', 'Tape', 'Polishing']),
  ('AXALTA', 'Axalta Coating Systems', 'https://www.axalta.com', 'Cromax, Standox, Spies Hecker brands', ARRAY['Paint', 'Clearcoat', 'Primer']),
  ('BASF', 'BASF Automotive Refinish', 'https://www.basf.com', 'Glasurit and R-M paint systems', ARRAY['Paint', 'Clearcoat', 'Primer']),
  ('SHERWIN', 'Sherwin-Williams Automotive', 'https://www.sherwin-automotive.com', 'Automotive refinish coatings', ARRAY['Paint', 'Clearcoat', 'Primer']),
  ('SIKKENS', 'Sikkens (AkzoNobel)', 'https://www.sikkens-acoat.com', 'Premium automotive refinish', ARRAY['Paint', 'Clearcoat', 'Basecoat']),
  ('NORTON', 'Norton Abrasives', 'https://www.nortonabrasives.com', 'Sandpaper and abrasive products', ARRAY['Sandpaper', 'Discs', 'Abrasives']),
  ('MIRKA', 'Mirka Abrasives', 'https://www.mirka.com', 'Finnish abrasives manufacturer', ARRAY['Sandpaper', 'Discs', 'Polishing']),
  ('INDASA', 'Indasa Abrasives', 'https://www.indasa-abrasives.com', 'Portuguese abrasives manufacturer', ARRAY['Sandpaper', 'Discs', 'Abrasives']),
  ('SIA', 'sia Abrasives', 'https://www.sia-abrasives.com', 'Swiss precision abrasives', ARRAY['Sandpaper', 'Discs', 'Abrasives']),
  ('SUNMIGHT', 'Sunmight Abrasives', 'https://www.sunmight.com', 'Professional automotive abrasives', ARRAY['Sandpaper', 'Discs', 'Abrasives']),
  ('KLINGSPOR', 'Klingspor Abrasives', 'https://www.klingspor.com', 'German abrasives manufacturer', ARRAY['Sandpaper', 'Discs', 'Belts']),
  ('EVERCOAT', 'Evercoat (ITW)', 'https://www.evercoat.com', 'Body fillers and putties', ARRAY['Body Filler', 'Putty', 'Fiberglass']),
  ('UPOL', 'U-POL', 'https://www.u-pol.com', 'Body fillers and aerosols', ARRAY['Body Filler', 'Primers', 'Aerosols']),
  ('USC', 'U.S. Chemical & Plastics', 'https://www.uschem.com', 'Body fillers and finishing products', ARRAY['Body Filler', 'Putty', 'Glazes']),
  ('SEM', 'SEM Products', 'https://www.semproducts.com', 'Interior repair and refinishing', ARRAY['Interior', 'Adhesion Promoter', 'Trim'])
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name,
  website = EXCLUDED.website,
  description = EXCLUDED.description,
  product_categories = EXCLUDED.product_categories,
  is_active = true;

-- 9. Ensure Adam is super_admin (update by email)
UPDATE user_profiles
SET role = 'super_admin'
WHERE id IN (
  SELECT id FROM auth.users WHERE email = 'adam@chcpaint.com'
);

-- Also try with alternate email if present
UPDATE user_profiles
SET role = 'super_admin'
WHERE id IN (
  SELECT id FROM auth.users WHERE email = 'adamberube@me.com'
);

-- 10. Verify the fixes
DO $$
BEGIN
  RAISE NOTICE 'company_vendors table exists: %', EXISTS (SELECT FROM pg_tables WHERE tablename = 'company_vendors');
  RAISE NOTICE 'vendor_catalog table exists: %', EXISTS (SELECT FROM pg_tables WHERE tablename = 'vendor_catalog');
  RAISE NOTICE 'Vendor count: %', (SELECT COUNT(*) FROM vendor_catalog);
END $$;
