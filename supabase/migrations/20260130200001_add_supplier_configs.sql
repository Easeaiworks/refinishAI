-- Supplier Configurations Table
-- Stores supplier API settings and preferences

CREATE TABLE IF NOT EXISTS supplier_configs (
  id text PRIMARY KEY,
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE,
  code text NOT NULL,
  name text NOT NULL,
  api_endpoint text,
  api_key_encrypted text, -- Store encrypted
  enabled boolean DEFAULT false,
  last_sync timestamptz,
  logo_url text,
  settings jsonb DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE supplier_configs ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view their company's supplier configs"
  ON supplier_configs FOR SELECT
  TO authenticated
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles WHERE id = auth.uid()
    )
    OR company_id IS NULL -- Global configs
  );

CREATE POLICY "Admins can manage supplier configs"
  ON supplier_configs FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE id = auth.uid()
      AND role IN ('admin', 'super_admin')
      AND (company_id = supplier_configs.company_id OR supplier_configs.company_id IS NULL)
    )
  );

-- Supplier Price Cache Table
-- Caches product prices from suppliers for faster lookups

CREATE TABLE IF NOT EXISTS supplier_price_cache (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  supplier_code text NOT NULL,
  supplier_sku text NOT NULL,
  product_name text NOT NULL,
  category text,
  unit_type text,
  unit_cost numeric(10,2),
  msrp numeric(10,2),
  in_stock boolean DEFAULT true,
  lead_time_days integer,
  fetched_at timestamptz DEFAULT now(),
  expires_at timestamptz DEFAULT (now() + interval '24 hours'),

  UNIQUE(supplier_code, supplier_sku)
);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_supplier_price_cache_supplier ON supplier_price_cache(supplier_code);
CREATE INDEX IF NOT EXISTS idx_supplier_price_cache_category ON supplier_price_cache(category);
CREATE INDEX IF NOT EXISTS idx_supplier_price_cache_expires ON supplier_price_cache(expires_at);

-- Function to clean expired cache
CREATE OR REPLACE FUNCTION clean_expired_price_cache()
RETURNS void AS $$
BEGIN
  DELETE FROM supplier_price_cache WHERE expires_at < now();
END;
$$ LANGUAGE plpgsql;
