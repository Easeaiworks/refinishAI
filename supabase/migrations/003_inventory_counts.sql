/*
  # Inventory Counts System with Manager Verification & ML Learning

  Features:
  - Physical inventory count sessions
  - Product-level count items with variance tracking
  - Manager verification workflow
  - Company-configurable tolerance thresholds
  - Data structure for ML learning
*/

-- Company Settings (for tolerance thresholds and preferences)
CREATE TABLE IF NOT EXISTS company_settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE NOT NULL,

  -- Variance tolerance settings (percentage)
  variance_tolerance_pct numeric DEFAULT 5.0, -- 5% variance is acceptable
  high_value_threshold numeric DEFAULT 100.0, -- Items over this cost require manager review
  require_manager_approval boolean DEFAULT true,

  -- Count settings
  default_count_type text DEFAULT 'full',
  auto_adjust_inventory boolean DEFAULT false, -- Auto-adjust after approval

  -- ML settings
  enable_ml_learning boolean DEFAULT true,

  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),

  UNIQUE(company_id)
);

-- Inventory Counts (main session)
CREATE TABLE IF NOT EXISTS inventory_counts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE NOT NULL,

  -- Count details
  count_type text NOT NULL DEFAULT 'full', -- 'full', 'spot_check', 'cycle'
  count_date date NOT NULL DEFAULT CURRENT_DATE,

  -- Status workflow: draft -> pending_review -> approved -> completed -> rejected
  status text NOT NULL DEFAULT 'draft',

  -- Counts summary
  items_counted integer DEFAULT 0,
  total_expected_value numeric DEFAULT 0,
  total_counted_value numeric DEFAULT 0,

  -- Variance summary
  variance_count integer DEFAULT 0, -- Number of items with variance
  positive_variance_count integer DEFAULT 0,
  negative_variance_count integer DEFAULT 0,
  total_variance_value numeric DEFAULT 0,
  variance_pct numeric DEFAULT 0,

  -- Flags
  requires_review boolean DEFAULT false, -- Set if variance exceeds tolerance
  is_verified boolean DEFAULT false,

  -- User tracking
  counted_by uuid REFERENCES auth.users(id),
  verified_by uuid REFERENCES auth.users(id),
  verified_at timestamptz,

  -- Notes
  notes text,
  rejection_reason text,

  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Inventory Count Items (line items)
CREATE TABLE IF NOT EXISTS inventory_count_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  count_id uuid REFERENCES inventory_counts(id) ON DELETE CASCADE NOT NULL,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,

  -- Quantities
  expected_quantity numeric NOT NULL DEFAULT 0, -- From system
  counted_quantity numeric, -- Physical count (null = not counted yet)

  -- Variance
  variance_quantity numeric GENERATED ALWAYS AS (
    COALESCE(counted_quantity, 0) - expected_quantity
  ) STORED,
  variance_pct numeric,

  -- Value tracking
  unit_cost numeric DEFAULT 0,
  expected_value numeric GENERATED ALWAYS AS (expected_quantity * unit_cost) STORED,
  counted_value numeric GENERATED ALWAYS AS (COALESCE(counted_quantity, 0) * unit_cost) STORED,
  variance_value numeric GENERATED ALWAYS AS (
    (COALESCE(counted_quantity, 0) - expected_quantity) * unit_cost
  ) STORED,

  -- Flags
  is_counted boolean DEFAULT false,
  requires_review boolean DEFAULT false, -- Exceeds tolerance
  is_high_value boolean DEFAULT false,

  -- Notes
  notes text,

  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),

  UNIQUE(count_id, product_id)
);

-- Count Verifications (manager approval history)
CREATE TABLE IF NOT EXISTS count_verifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  count_id uuid REFERENCES inventory_counts(id) ON DELETE CASCADE NOT NULL,

  -- Verification details
  action text NOT NULL, -- 'approved', 'rejected', 'requested_recount'
  verified_by uuid REFERENCES auth.users(id) NOT NULL,
  verified_at timestamptz DEFAULT now(),

  -- Notes
  notes text,
  rejection_reason text,

  -- Snapshot of variance at time of verification
  variance_count integer,
  variance_value numeric,
  variance_pct numeric,

  created_at timestamptz DEFAULT now()
);

-- Inventory Adjustments (history of changes from counts)
CREATE TABLE IF NOT EXISTS inventory_adjustments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE NOT NULL,
  count_id uuid REFERENCES inventory_counts(id) ON DELETE SET NULL,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,

  -- Adjustment details
  adjustment_type text NOT NULL, -- 'count_variance', 'manual', 'system'
  previous_quantity numeric NOT NULL,
  new_quantity numeric NOT NULL,
  adjustment_quantity numeric GENERATED ALWAYS AS (new_quantity - previous_quantity) STORED,

  -- Value tracking
  unit_cost numeric DEFAULT 0,
  adjustment_value numeric GENERATED ALWAYS AS ((new_quantity - previous_quantity) * unit_cost) STORED,

  -- User tracking
  adjusted_by uuid REFERENCES auth.users(id),

  -- Notes
  reason text,

  created_at timestamptz DEFAULT now()
);

-- ML Learning Data (aggregated count patterns)
CREATE TABLE IF NOT EXISTS count_learning_data (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,

  -- Aggregated stats
  total_counts integer DEFAULT 0,
  total_positive_variances integer DEFAULT 0,
  total_negative_variances integer DEFAULT 0,

  -- Average variance patterns
  avg_variance_pct numeric DEFAULT 0,
  avg_variance_quantity numeric DEFAULT 0,

  -- Patterns
  typical_shrinkage_pct numeric DEFAULT 0, -- Negative variances
  typical_overstock_pct numeric DEFAULT 0, -- Positive variances

  -- Confidence
  data_points integer DEFAULT 0,
  confidence_score numeric DEFAULT 0,

  -- Time-based patterns
  last_count_date date,
  days_since_last_count integer,

  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),

  UNIQUE(company_id, product_id)
);

-- Enable RLS
ALTER TABLE company_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_counts ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_count_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE count_verifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_adjustments ENABLE ROW LEVEL SECURITY;
ALTER TABLE count_learning_data ENABLE ROW LEVEL SECURITY;

-- RLS Policies (allow all for now, will restrict by company later)
CREATE POLICY "Allow all on company_settings" ON company_settings FOR ALL TO public USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on inventory_counts" ON inventory_counts FOR ALL TO public USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on inventory_count_items" ON inventory_count_items FOR ALL TO public USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on count_verifications" ON count_verifications FOR ALL TO public USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on inventory_adjustments" ON inventory_adjustments FOR ALL TO public USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on count_learning_data" ON count_learning_data FOR ALL TO public USING (true) WITH CHECK (true);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_inventory_counts_company ON inventory_counts(company_id);
CREATE INDEX IF NOT EXISTS idx_inventory_counts_status ON inventory_counts(status);
CREATE INDEX IF NOT EXISTS idx_inventory_counts_date ON inventory_counts(count_date);
CREATE INDEX IF NOT EXISTS idx_count_items_count_id ON inventory_count_items(count_id);
CREATE INDEX IF NOT EXISTS idx_count_items_product ON inventory_count_items(product_id);
CREATE INDEX IF NOT EXISTS idx_count_learning_product ON count_learning_data(product_id);

-- Function to update count summary after items are updated
CREATE OR REPLACE FUNCTION update_count_summary()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE inventory_counts
  SET
    items_counted = (
      SELECT COUNT(*) FROM inventory_count_items
      WHERE count_id = NEW.count_id AND is_counted = true
    ),
    variance_count = (
      SELECT COUNT(*) FROM inventory_count_items
      WHERE count_id = NEW.count_id AND variance_quantity != 0
    ),
    positive_variance_count = (
      SELECT COUNT(*) FROM inventory_count_items
      WHERE count_id = NEW.count_id AND variance_quantity > 0
    ),
    negative_variance_count = (
      SELECT COUNT(*) FROM inventory_count_items
      WHERE count_id = NEW.count_id AND variance_quantity < 0
    ),
    total_expected_value = (
      SELECT COALESCE(SUM(expected_value), 0) FROM inventory_count_items
      WHERE count_id = NEW.count_id
    ),
    total_counted_value = (
      SELECT COALESCE(SUM(counted_value), 0) FROM inventory_count_items
      WHERE count_id = NEW.count_id AND is_counted = true
    ),
    total_variance_value = (
      SELECT COALESCE(SUM(variance_value), 0) FROM inventory_count_items
      WHERE count_id = NEW.count_id AND is_counted = true
    ),
    updated_at = now()
  WHERE id = NEW.count_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update count summary
DROP TRIGGER IF EXISTS trigger_update_count_summary ON inventory_count_items;
CREATE TRIGGER trigger_update_count_summary
AFTER INSERT OR UPDATE ON inventory_count_items
FOR EACH ROW
EXECUTE FUNCTION update_count_summary();

-- Function to update ML learning data after count is completed
CREATE OR REPLACE FUNCTION update_count_learning()
RETURNS TRIGGER AS $$
BEGIN
  -- Only run when count is completed
  IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
    INSERT INTO count_learning_data (company_id, product_id, total_counts, avg_variance_pct, last_count_date, data_points)
    SELECT
      NEW.company_id,
      ici.product_id,
      1,
      ici.variance_pct,
      NEW.count_date,
      1
    FROM inventory_count_items ici
    WHERE ici.count_id = NEW.id AND ici.is_counted = true
    ON CONFLICT (company_id, product_id) DO UPDATE
    SET
      total_counts = count_learning_data.total_counts + 1,
      total_positive_variances = count_learning_data.total_positive_variances +
        CASE WHEN EXCLUDED.avg_variance_pct > 0 THEN 1 ELSE 0 END,
      total_negative_variances = count_learning_data.total_negative_variances +
        CASE WHEN EXCLUDED.avg_variance_pct < 0 THEN 1 ELSE 0 END,
      avg_variance_pct = (count_learning_data.avg_variance_pct * count_learning_data.data_points + EXCLUDED.avg_variance_pct) / (count_learning_data.data_points + 1),
      data_points = count_learning_data.data_points + 1,
      last_count_date = EXCLUDED.last_count_date,
      updated_at = now();
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update ML learning data
DROP TRIGGER IF EXISTS trigger_update_count_learning ON inventory_counts;
CREATE TRIGGER trigger_update_count_learning
AFTER UPDATE ON inventory_counts
FOR EACH ROW
EXECUTE FUNCTION update_count_learning();
