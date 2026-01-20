/*
  # Inventory Count System

  Comprehensive physical inventory counting with variance analysis and approval workflow.

  1. New Tables
    
    ## inventory_counts
    - `id` (uuid, primary key)
    - `shop_id` (uuid) - Future: shop-specific counts
    - `count_number` (text) - Human-readable count identifier
    - `status` (text) - 'draft', 'in_progress', 'pending_approval', 'approved', 'rejected'
    - `count_date` (date) - When physical count was performed
    - `started_by` (uuid) - User who initiated count
    - `counted_by` (text) - Name of person doing physical count
    - `approved_by` (uuid) - Admin who approved/rejected
    - `approved_at` (timestamptz) - When approved/rejected
    - `approval_notes` (text) - Approval/rejection reason
    - `total_variance_quantity` (numeric) - Total units difference
    - `total_variance_value` (numeric) - Total dollar difference
    - `created_at` (timestamptz)
    - `updated_at` (timestamptz)
    
    ## inventory_count_items
    - `id` (uuid, primary key)
    - `count_id` (uuid, foreign key) - Links to inventory_counts
    - `product_id` (uuid, foreign key) - Product being counted
    - `expected_quantity` (numeric) - System quantity at count time
    - `counted_quantity` (numeric) - Physical count result
    - `variance_quantity` (numeric) - Difference (counted - expected)
    - `unit_cost` (numeric) - Cost per unit at count time
    - `variance_value` (numeric) - Dollar impact of variance
    - `notes` (text) - Count notes
    - `created_at` (timestamptz)
    
    ## product_substitutes
    - `id` (uuid, primary key)
    - `product_id` (uuid, foreign key) - Primary product
    - `substitute_id` (uuid, foreign key) - Can be swapped with
    - `compatibility_notes` (text)
    - `created_at` (timestamptz)
    
    ## inventory_sync_log
    - `id` (uuid, primary key)
    - `sync_type` (text) - 'import', 'export', 'api_sync'
    - `source_system` (text) - 'quickbooks', 'csv', 'api', etc.
    - `status` (text) - 'success', 'error', 'partial'
    - `records_processed` (integer)
    - `records_failed` (integer)
    - `error_details` (jsonb)
    - `sync_data` (jsonb) - Import/export payload
    - `created_at` (timestamptz)
    - `created_by` (uuid)

  2. Security
    - Enable RLS on all tables
    - Allow public access for now (will be role-based later)

  3. Indexes
    - Performance indexes for common queries
*/

-- Inventory count sessions
CREATE TABLE IF NOT EXISTS inventory_counts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_id uuid,
  count_number text UNIQUE NOT NULL,
  status text DEFAULT 'draft' NOT NULL,
  count_date date DEFAULT CURRENT_DATE,
  started_by uuid,
  counted_by text,
  approved_by uuid,
  approved_at timestamptz,
  approval_notes text,
  total_variance_quantity numeric DEFAULT 0,
  total_variance_value numeric DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Individual count line items
CREATE TABLE IF NOT EXISTS inventory_count_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  count_id uuid REFERENCES inventory_counts(id) ON DELETE CASCADE NOT NULL,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  expected_quantity numeric DEFAULT 0 NOT NULL,
  counted_quantity numeric,
  variance_quantity numeric DEFAULT 0,
  unit_cost numeric DEFAULT 0,
  variance_value numeric DEFAULT 0,
  notes text,
  created_at timestamptz DEFAULT now(),
  UNIQUE(count_id, product_id)
);

-- Product substitution mapping
CREATE TABLE IF NOT EXISTS product_substitutes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  substitute_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  compatibility_notes text,
  created_at timestamptz DEFAULT now(),
  UNIQUE(product_id, substitute_id),
  CHECK (product_id != substitute_id)
);

-- Sync and import/export log
CREATE TABLE IF NOT EXISTS inventory_sync_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sync_type text NOT NULL,
  source_system text,
  status text DEFAULT 'success',
  records_processed integer DEFAULT 0,
  records_failed integer DEFAULT 0,
  error_details jsonb,
  sync_data jsonb,
  created_at timestamptz DEFAULT now(),
  created_by uuid
);

-- Enable RLS
ALTER TABLE inventory_counts ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_count_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_substitutes ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_sync_log ENABLE ROW LEVEL SECURITY;

-- RLS Policies (open for now)
CREATE POLICY "Allow all operations on inventory counts"
  ON inventory_counts FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on count items"
  ON inventory_count_items FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on product substitutes"
  ON product_substitutes FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on sync log"
  ON inventory_sync_log FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_counts_status ON inventory_counts(status);
CREATE INDEX IF NOT EXISTS idx_counts_date ON inventory_counts(count_date);
CREATE INDEX IF NOT EXISTS idx_count_items_count ON inventory_count_items(count_id);
CREATE INDEX IF NOT EXISTS idx_count_items_product ON inventory_count_items(product_id);
CREATE INDEX IF NOT EXISTS idx_substitutes_product ON product_substitutes(product_id);
CREATE INDEX IF NOT EXISTS idx_sync_log_date ON inventory_sync_log(created_at);

-- Function to auto-generate count number
CREATE OR REPLACE FUNCTION generate_count_number()
RETURNS text AS $$
DECLARE
  next_num integer;
  count_num text;
BEGIN
  SELECT COALESCE(MAX(CAST(SUBSTRING(count_number FROM 'CNT-(\d+)') AS integer)), 0) + 1
  INTO next_num
  FROM inventory_counts;
  
  count_num := 'CNT-' || LPAD(next_num::text, 6, '0');
  RETURN count_num;
END;
$$ LANGUAGE plpgsql;

-- Function to update count totals
CREATE OR REPLACE FUNCTION update_count_totals()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE inventory_counts
  SET 
    total_variance_quantity = (
      SELECT COALESCE(SUM(ABS(variance_quantity)), 0)
      FROM inventory_count_items
      WHERE count_id = NEW.count_id
    ),
    total_variance_value = (
      SELECT COALESCE(SUM(variance_value), 0)
      FROM inventory_count_items
      WHERE count_id = NEW.count_id
    ),
    updated_at = now()
  WHERE id = NEW.count_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update totals when items change
CREATE TRIGGER trigger_update_count_totals
  AFTER INSERT OR UPDATE ON inventory_count_items
  FOR EACH ROW
  EXECUTE FUNCTION update_count_totals();

-- Function to apply approved count to inventory
CREATE OR REPLACE FUNCTION apply_approved_count()
RETURNS TRIGGER AS $$
BEGIN
  -- Only process when status changes to 'approved'
  IF NEW.status = 'approved' AND OLD.status != 'approved' THEN
    -- Create transactions for each variance
    INSERT INTO inventory_transactions (
      shop_id,
      product_id,
      transaction_type,
      quantity_change,
      quantity_after,
      cost_per_unit,
      transaction_date,
      reference_id,
      reference_type,
      notes
    )
    SELECT
      NEW.shop_id,
      ici.product_id,
      'adjustment',
      ici.variance_quantity,
      ici.counted_quantity,
      ici.unit_cost,
      NEW.count_date,
      NEW.id,
      'inventory_count',
      'Physical count adjustment - ' || NEW.count_number
    FROM inventory_count_items ici
    WHERE ici.count_id = NEW.id
      AND ici.variance_quantity != 0;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to apply count when approved
CREATE TRIGGER trigger_apply_approved_count
  AFTER UPDATE ON inventory_counts
  FOR EACH ROW
  EXECUTE FUNCTION apply_approved_count();

-- Add some common product substitutes for clear coats and primers
INSERT INTO product_substitutes (product_id, substitute_id, compatibility_notes)
SELECT 
  p1.id as product_id,
  p2.id as substitute_id,
  'Same category products are often interchangeable' as compatibility_notes
FROM products p1
CROSS JOIN products p2
WHERE p1.category = p2.category
  AND p1.category IN ('Clear Coat', 'Primer', 'Base Coat')
  AND p1.id != p2.id
  AND p1.supplier = p2.supplier
ON CONFLICT DO NOTHING;

SELECT 'Created inventory count system with ' || COUNT(*) || ' product substitution mappings' FROM product_substitutes;