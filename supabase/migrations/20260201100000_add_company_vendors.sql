-- Company Vendors Table
-- Controls which manufacturers/vendors each company has access to

CREATE TABLE IF NOT EXISTS company_vendors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  vendor_code VARCHAR(50) NOT NULL, -- 'ppg', 'axalta', 'sherwin_williams', etc.
  vendor_name VARCHAR(100) NOT NULL,
  is_active BOOLEAN DEFAULT true,
  is_primary BOOLEAN DEFAULT false, -- Primary vendor for this company
  discount_percent DECIMAL(5,2) DEFAULT 0,
  account_number VARCHAR(100),
  notes TEXT,
  added_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  -- Each company can only have one entry per vendor
  UNIQUE(company_id, vendor_code)
);

-- Index for fast lookups
CREATE INDEX idx_company_vendors_company ON company_vendors(company_id);
CREATE INDEX idx_company_vendors_vendor ON company_vendors(vendor_code);
CREATE INDEX idx_company_vendors_active ON company_vendors(company_id, is_active);

-- RLS Policies
ALTER TABLE company_vendors ENABLE ROW LEVEL SECURITY;

-- Users can view their company's vendors
CREATE POLICY "Users can view own company vendors"
  ON company_vendors FOR SELECT
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles WHERE id = auth.uid()
    )
  );

-- Only admins can manage vendors
CREATE POLICY "Admins can manage company vendors"
  ON company_vendors FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE id = auth.uid()
      AND company_id = company_vendors.company_id
      AND role IN ('admin', 'super_admin')
    )
  );

-- Add vendor_code to products table for filtering
ALTER TABLE products ADD COLUMN IF NOT EXISTS vendor_code VARCHAR(50);

-- Create index on products vendor_code
CREATE INDEX IF NOT EXISTS idx_products_vendor ON products(vendor_code);

-- Create a view for easy vendor access checking
CREATE OR REPLACE VIEW user_allowed_vendors AS
SELECT
  up.id as user_id,
  up.company_id,
  cv.vendor_code,
  cv.vendor_name,
  cv.is_primary,
  cv.discount_percent
FROM user_profiles up
JOIN company_vendors cv ON cv.company_id = up.company_id
WHERE cv.is_active = true;

-- Available vendors master list (reference data)
CREATE TABLE IF NOT EXISTS vendor_catalog (
  code VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  logo_url VARCHAR(255),
  website VARCHAR(255),
  description TEXT,
  product_categories TEXT[], -- Array of categories they offer
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert the main paint vendors
INSERT INTO vendor_catalog (code, name, website, description, product_categories) VALUES
  ('ppg', 'PPG Industries', 'https://www.ppg.com', 'Global coatings and specialty materials company', ARRAY['Paint', 'Primer', 'Clear Coat', 'Basecoat', 'Reducer', 'Hardener']),
  ('axalta', 'Axalta Coating Systems', 'https://www.axalta.com', 'Leading global coatings company', ARRAY['Paint', 'Primer', 'Clear Coat', 'Basecoat', 'Reducer', 'Hardener']),
  ('sherwin_williams', 'Sherwin-Williams Automotive', 'https://www.sherwin-williams.com/automotive', 'Complete automotive refinish solutions', ARRAY['Paint', 'Primer', 'Clear Coat', 'Basecoat', 'Reducer', 'Hardener']),
  ('basf', 'BASF Coatings', 'https://www.basf-coatings.com', 'Innovative coating solutions', ARRAY['Paint', 'Primer', 'Clear Coat', 'Basecoat']),
  ('dupont', 'DuPont Performance Coatings', 'https://www.dupont.com', 'Advanced performance coatings', ARRAY['Paint', 'Primer', 'Clear Coat']),
  ('3m', '3M Automotive', 'https://www.3m.com/automotive', 'Abrasives, tapes, and specialty products', ARRAY['Abrasives', 'Supplies', 'Safety', 'Consumables']),
  ('norton', 'Norton Abrasives', 'https://www.nortonabrasives.com', 'Professional grade abrasives', ARRAY['Abrasives', 'Supplies']),
  ('sata', 'SATA GmbH', 'https://www.sata.com', 'Premium spray guns and equipment', ARRAY['Equipment', 'Supplies']),
  ('devilbiss', 'DeVilbiss', 'https://www.devilbissautomotive.com', 'Spray finishing equipment', ARRAY['Equipment', 'Supplies']),
  ('generic', 'Generic/Other', NULL, 'Generic or unbranded products', ARRAY['Supplies', 'Consumables', 'Safety'])
ON CONFLICT (code) DO NOTHING;

-- Update trigger for company_vendors
CREATE OR REPLACE FUNCTION update_company_vendors_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER company_vendors_updated
  BEFORE UPDATE ON company_vendors
  FOR EACH ROW
  EXECUTE FUNCTION update_company_vendors_timestamp();
