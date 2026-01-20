/*
  # Consolidate Multiple Permissive Policies - Corrected

  1. Security Improvements
    - Replace multiple permissive policies with single consolidated policies
    - Maintain clear access control with simplified logic
    - Only handle tables that actually have necessary columns
    
  2. Tables Updated
    - audit_log
    - companies
    - estimates
    - inventory_counts
    - inventory_count_items
    - inventory_stock
    - inventory_transactions (uses shop_id)
    - invoices
    - predictions
    - products
    - user_profiles
    - vehicles
    
  3. Policy Pattern
    - Each table gets ONE permissive policy per action
    - Super admin access included within main policy
    - Clear, maintainable access control rules
    
  Note: Line item tables and some reference tables don't have company_id,
  so they rely on parent table relationships for access control.
*/

-- ============================================================================
-- AUDIT LOG - Consolidate SELECT policies
-- ============================================================================

DROP POLICY IF EXISTS "Admin can view company audit logs" ON audit_log;
DROP POLICY IF EXISTS "Super admin can view all audit logs" ON audit_log;

CREATE POLICY "View audit logs"
  ON audit_log FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() AND has_role('admin'))
  );

-- ============================================================================
-- COMPANIES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Super admin can view all companies" ON companies;
DROP POLICY IF EXISTS "Super admin can manage all companies" ON companies;
DROP POLICY IF EXISTS "Users can view their own company" ON companies;
DROP POLICY IF EXISTS "Company admin can update own company" ON companies;

CREATE POLICY "View companies"
  ON companies FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    id = get_user_company()
  );

CREATE POLICY "Update companies"
  ON companies FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    (id = get_user_company() AND has_role('admin'))
  )
  WITH CHECK (
    is_super_admin() OR
    (id = get_user_company() AND has_role('admin'))
  );

-- ============================================================================
-- ESTIMATES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company estimates" ON estimates;
DROP POLICY IF EXISTS "Super admin full access to estimates" ON estimates;
DROP POLICY IF EXISTS "Users can create estimates" ON estimates;
DROP POLICY IF EXISTS "Admin and Manager can manage estimates" ON estimates;
DROP POLICY IF EXISTS "Admin can delete estimates" ON estimates;

CREATE POLICY "View estimates"
  ON estimates FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Create estimates"
  ON estimates FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND created_by = (select auth.uid()))
  );

CREATE POLICY "Update estimates"
  ON estimates FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

CREATE POLICY "Delete estimates"
  ON estimates FOR DELETE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('admin'))
  );

-- ============================================================================
-- ESTIMATE LINE ITEMS - Keep existing policies (they rely on parent relationship)
-- ============================================================================

-- No changes needed - existing policies use JOIN to estimates table

-- ============================================================================
-- INVENTORY COUNTS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company counts" ON inventory_counts;
DROP POLICY IF EXISTS "Super admin full access to counts" ON inventory_counts;
DROP POLICY IF EXISTS "Staff can create counts" ON inventory_counts;
DROP POLICY IF EXISTS "Users can update their own counts" ON inventory_counts;
DROP POLICY IF EXISTS "Admin can delete counts" ON inventory_counts;

CREATE POLICY "View inventory counts"
  ON inventory_counts FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Create inventory counts"
  ON inventory_counts FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND started_by = (select auth.uid()))
  );

CREATE POLICY "Update inventory counts"
  ON inventory_counts FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND (started_by = (select auth.uid()) OR has_role('admin')))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND (started_by = (select auth.uid()) OR has_role('admin')))
  );

CREATE POLICY "Delete inventory counts"
  ON inventory_counts FOR DELETE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('admin'))
  );

-- ============================================================================
-- INVENTORY COUNT ITEMS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can manage count items" ON inventory_count_items;
DROP POLICY IF EXISTS "Super admin full access to count items" ON inventory_count_items;

CREATE POLICY "Manage count items"
  ON inventory_count_items FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    EXISTS (
      SELECT 1 FROM inventory_counts ic
      WHERE ic.id = inventory_count_items.count_id
      AND (ic.company_id = get_user_company() OR ic.company_id IS NULL)
      AND (ic.started_by = (select auth.uid()) OR has_role('admin'))
    )
  )
  WITH CHECK (
    is_super_admin() OR
    EXISTS (
      SELECT 1 FROM inventory_counts ic
      WHERE ic.id = inventory_count_items.count_id
      AND (ic.company_id = get_user_company() OR ic.company_id IS NULL)
      AND (ic.started_by = (select auth.uid()) OR has_role('admin'))
    )
  );

-- ============================================================================
-- INVENTORY STOCK - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company inventory" ON inventory_stock;
DROP POLICY IF EXISTS "Admin and Manager can manage company inventory" ON inventory_stock;
DROP POLICY IF EXISTS "Super admin full access to inventory stock" ON inventory_stock;

CREATE POLICY "View inventory stock"
  ON inventory_stock FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage inventory stock"
  ON inventory_stock FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- INVENTORY TRANSACTIONS - Consolidate policies (uses shop_id not company_id)
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company transactions" ON inventory_transactions;
DROP POLICY IF EXISTS "Super admin full access to transactions" ON inventory_transactions;
DROP POLICY IF EXISTS "Admin and Manager can create transactions" ON inventory_transactions;

CREATE POLICY "View inventory transactions"
  ON inventory_transactions FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (shop_id = get_user_company() OR shop_id IS NULL)
  );

CREATE POLICY "Create inventory transactions"
  ON inventory_transactions FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    ((shop_id = get_user_company() OR shop_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- INVOICES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company invoices" ON invoices;
DROP POLICY IF EXISTS "Super admin full access to invoices" ON invoices;
DROP POLICY IF EXISTS "Admin and Manager can manage invoices" ON invoices;

CREATE POLICY "View invoices"
  ON invoices FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage invoices"
  ON invoices FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- INVOICE LINE ITEMS - Keep existing policies (they rely on parent relationship)
-- ============================================================================

-- No changes needed - existing policies use JOIN to invoices table if they exist

-- ============================================================================
-- PREDICTIONS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company predictions" ON predictions;
DROP POLICY IF EXISTS "Super admin full access to predictions" ON predictions;
DROP POLICY IF EXISTS "Admin and Manager can manage predictions" ON predictions;

CREATE POLICY "View predictions"
  ON predictions FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage predictions"
  ON predictions FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- PRODUCTS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company products" ON products;
DROP POLICY IF EXISTS "Super admin full access to products" ON products;
DROP POLICY IF EXISTS "Admin and Manager can manage company products" ON products;

CREATE POLICY "View products"
  ON products FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage products"
  ON products FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- USER PROFILES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own profile" ON user_profiles;
DROP POLICY IF EXISTS "Users can view profiles in their company" ON user_profiles;
DROP POLICY IF EXISTS "Admin can manage users in their company" ON user_profiles;
DROP POLICY IF EXISTS "Super admin can manage all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON user_profiles;

CREATE POLICY "View user profiles"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    id = (select auth.uid()) OR
    (company_id = get_user_company() AND has_role('admin'))
  );

CREATE POLICY "Update user profiles"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    id = (select auth.uid()) OR
    (company_id = get_user_company() AND has_role('admin'))
  )
  WITH CHECK (
    is_super_admin() OR
    (id = (select auth.uid()) AND role = get_user_role()) OR
    (company_id = get_user_company() AND has_role('admin'))
  );

CREATE POLICY "Create user profiles"
  ON user_profiles FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    (company_id = get_user_company() AND has_role('admin'))
  );

CREATE POLICY "Delete user profiles"
  ON user_profiles FOR DELETE
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() AND has_role('admin') AND id != (select auth.uid()))
  );

-- ============================================================================
-- VEHICLES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company vehicles" ON vehicles;
DROP POLICY IF EXISTS "Super admin full access to vehicles" ON vehicles;
DROP POLICY IF EXISTS "Users can manage company vehicles" ON vehicles;

CREATE POLICY "View vehicles"
  ON vehicles FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage vehicles"
  ON vehicles FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  )
  WITH CHECK (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

SELECT 'All permissive policies consolidated successfully' as result;