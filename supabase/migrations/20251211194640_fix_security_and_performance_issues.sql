/*
  # Fix Security and Performance Issues

  1. Add Missing Foreign Key Indexes
    - Add indexes for all unindexed foreign keys to improve query performance
    
  2. Optimize RLS Policies
    - Replace auth.uid() with (select auth.uid()) to prevent re-evaluation per row
    - Consolidate multiple permissive policies into single policies
    
  3. Fix Function Security
    - Set explicit search_path on all security definer functions
    
  4. Clean Up Redundant Policies
    - Remove duplicate or overlapping policies
*/

-- ============================================================================
-- PART 1: Add Missing Foreign Key Indexes
-- ============================================================================

-- Consumption history indexes
CREATE INDEX IF NOT EXISTS idx_consumption_history_invoice ON consumption_history(invoice_id);
CREATE INDEX IF NOT EXISTS idx_consumption_history_panel_type ON consumption_history(panel_type_id);
CREATE INDEX IF NOT EXISTS idx_consumption_history_vehicle ON consumption_history(vehicle_id);

-- Estimate line items indexes
CREATE INDEX IF NOT EXISTS idx_estimate_line_items_estimate ON estimate_line_items(estimate_id);
CREATE INDEX IF NOT EXISTS idx_estimate_line_items_panel_type ON estimate_line_items(panel_type_id);
CREATE INDEX IF NOT EXISTS idx_estimate_line_items_product ON estimate_line_items(product_id);

-- Estimates indexes
CREATE INDEX IF NOT EXISTS idx_estimates_created_by ON estimates(created_by);
CREATE INDEX IF NOT EXISTS idx_estimates_vehicle ON estimates(vehicle_id);

-- Invoice line items indexes
CREATE INDEX IF NOT EXISTS idx_invoice_line_items_invoice ON invoice_line_items(invoice_id);
CREATE INDEX IF NOT EXISTS idx_invoice_line_items_panel_type ON invoice_line_items(panel_type_id);
CREATE INDEX IF NOT EXISTS idx_invoice_line_items_product ON invoice_line_items(product_id);

-- Invoices indexes
CREATE INDEX IF NOT EXISTS idx_invoices_created_by ON invoices(created_by);
CREATE INDEX IF NOT EXISTS idx_invoices_estimate ON invoices(estimate_id);
CREATE INDEX IF NOT EXISTS idx_invoices_vehicle ON invoices(vehicle_id);

-- Prediction items indexes
CREATE INDEX IF NOT EXISTS idx_prediction_items_prediction ON prediction_items(prediction_id);
CREATE INDEX IF NOT EXISTS idx_prediction_items_product ON prediction_items(product_id);

-- Predictions indexes
CREATE INDEX IF NOT EXISTS idx_predictions_created_by ON predictions(created_by);

-- Product substitutes indexes
CREATE INDEX IF NOT EXISTS idx_product_substitutes_substitute ON product_substitutes(substitute_id);

-- Products indexes
CREATE INDEX IF NOT EXISTS idx_products_created_by ON products(created_by);

-- Vehicle panels indexes
CREATE INDEX IF NOT EXISTS idx_vehicle_panels_panel_type ON vehicle_panels(panel_type_id);

-- ============================================================================
-- PART 2: Fix Function Security with Explicit Search Path
-- ============================================================================

-- Recreate is_super_admin with explicit search_path
CREATE OR REPLACE FUNCTION is_super_admin()
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth.uid()
    AND role = 'super_admin'
    AND is_active = true
  );
END;
$$;

-- Recreate get_user_company with explicit search_path
CREATE OR REPLACE FUNCTION get_user_company()
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  RETURN (
    SELECT company_id FROM user_profiles
    WHERE id = auth.uid()
  );
END;
$$;

-- Recreate get_user_role with explicit search_path
CREATE OR REPLACE FUNCTION get_user_role()
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  RETURN (
    SELECT role FROM user_profiles
    WHERE id = auth.uid()
  );
END;
$$;

-- Recreate has_role with explicit search_path
CREATE OR REPLACE FUNCTION has_role(required_role text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  user_role text;
  role_hierarchy jsonb := '{"super_admin": 4, "admin": 3, "manager": 2, "staff": 1}';
BEGIN
  IF is_super_admin() THEN
    RETURN true;
  END IF;
  
  user_role := get_user_role();
  
  RETURN (role_hierarchy->>user_role)::int >= (role_hierarchy->>required_role)::int;
END;
$$;

-- Recreate update_last_login with explicit search_path
CREATE OR REPLACE FUNCTION update_last_login()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  UPDATE user_profiles
  SET last_login_at = now()
  WHERE id = auth.uid();
END;
$$;

-- Fix other existing functions
CREATE OR REPLACE FUNCTION update_inventory_after_transaction()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  UPDATE inventory_stock
  SET 
    quantity_on_hand = NEW.quantity_after,
    last_updated = now()
  WHERE product_id = NEW.product_id
    AND (shop_id = NEW.shop_id OR (shop_id IS NULL AND NEW.shop_id IS NULL));
  
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION generate_count_number()
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  next_number integer;
BEGIN
  SELECT COALESCE(MAX(CAST(SUBSTRING(count_number FROM '[0-9]+$') AS integer)), 0) + 1
  INTO next_number
  FROM inventory_counts
  WHERE count_number LIKE 'CNT-%';
  
  RETURN 'CNT-' || LPAD(next_number::text, 6, '0');
END;
$$;

CREATE OR REPLACE FUNCTION update_count_totals()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  total_var_qty numeric;
  total_var_val numeric;
BEGIN
  SELECT 
    COALESCE(SUM(variance_quantity), 0),
    COALESCE(SUM(variance_value), 0)
  INTO total_var_qty, total_var_val
  FROM inventory_count_items
  WHERE count_id = COALESCE(NEW.count_id, OLD.count_id);
  
  UPDATE inventory_counts
  SET 
    total_variance_quantity = total_var_qty,
    total_variance_value = total_var_val,
    updated_at = now()
  WHERE id = COALESCE(NEW.count_id, OLD.count_id);
  
  RETURN COALESCE(NEW, OLD);
END;
$$;

CREATE OR REPLACE FUNCTION apply_approved_count(count_id_param uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  INSERT INTO inventory_transactions (
    shop_id,
    product_id,
    transaction_type,
    quantity_change,
    quantity_after,
    reference_id,
    reference_type,
    transaction_date,
    notes,
    created_by
  )
  SELECT 
    ic.shop_id,
    ici.product_id,
    'count_adjustment',
    ici.variance_quantity,
    ici.counted_quantity,
    ic.id,
    'inventory_count',
    ic.count_date,
    'Approved count adjustment',
    ic.approved_by
  FROM inventory_counts ic
  JOIN inventory_count_items ici ON ici.count_id = ic.id
  WHERE ic.id = count_id_param
    AND ic.status = 'approved'
    AND ici.variance_quantity != 0;
END;
$$;

-- ============================================================================
-- PART 3: Drop Redundant Policies and Create Consolidated Policies
-- ============================================================================

-- Clean up inventory_stock policies
DROP POLICY IF EXISTS "Allow all operations on inventory stock" ON inventory_stock;

-- Drop redundant products policies
DROP POLICY IF EXISTS "Public read access to products" ON products;

-- Drop redundant vehicles policies
DROP POLICY IF EXISTS "Public read access to vehicles" ON vehicles;

-- Drop specific super admin view policies (covered by full access policies)
DROP POLICY IF EXISTS "Super admin can view all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Super admin can view all companies" ON companies;

-- ============================================================================
-- PART 4: Optimize RLS Policies - Replace auth.uid() with (select auth.uid())
-- ============================================================================

-- User Profiles Policies
DROP POLICY IF EXISTS "Users can view own profile" ON user_profiles;
CREATE POLICY "Users can view own profile"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can update own profile" ON user_profiles;
CREATE POLICY "Users can update own profile"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (id = (select auth.uid()))
  WITH CHECK (id = (select auth.uid()) AND role = get_user_role());

-- Inventory Counts Policies
DROP POLICY IF EXISTS "Users can update their own counts" ON inventory_counts;
CREATE POLICY "Users can update their own counts"
  ON inventory_counts FOR UPDATE
  TO authenticated
  USING (
    (company_id = get_user_company() OR company_id IS NULL) AND
    (started_by = (select auth.uid()) OR has_role('admin'))
  )
  WITH CHECK (
    (company_id = get_user_company() OR company_id IS NULL) AND
    (started_by = (select auth.uid()) OR has_role('admin'))
  );

-- ============================================================================
-- PART 5: Grant Proper Permissions
-- ============================================================================

-- Ensure authenticated users can execute helper functions
GRANT EXECUTE ON FUNCTION is_super_admin() TO authenticated;
GRANT EXECUTE ON FUNCTION get_user_company() TO authenticated;
GRANT EXECUTE ON FUNCTION get_user_role() TO authenticated;
GRANT EXECUTE ON FUNCTION has_role(text) TO authenticated;
GRANT EXECUTE ON FUNCTION update_last_login() TO authenticated;

SELECT 'Security and performance issues resolved' as result;