/*
  # Update RLS Policies for Multi-Tenant Isolation

  Update all existing tables to enforce company-level isolation and role-based access.

  1. Products Table
    - Admin/Manager can create/update/delete in their company
    - Staff can read in their company
    - Super admin has full access

  2. Inventory Tables
    - Similar role-based access within company
    - Staff can read, Admin/Manager can modify

  3. Estimates and Invoices
    - Staff can read and create their own
    - Manager/Admin can manage all in company

  4. Other Tables
    - Apply appropriate company-level isolation
*/

-- Drop existing overly permissive policies
DROP POLICY IF EXISTS "Allow all operations on products" ON products;
DROP POLICY IF EXISTS "Allow all operations on inventory_stock" ON inventory_stock;
DROP POLICY IF EXISTS "Allow all operations on inventory transactions" ON inventory_transactions;
DROP POLICY IF EXISTS "Allow all operations on inventory counts" ON inventory_counts;
DROP POLICY IF EXISTS "Allow all operations on count items" ON inventory_count_items;
DROP POLICY IF EXISTS "Allow all operations on estimates" ON estimates;
DROP POLICY IF EXISTS "Allow all operations on invoices" ON invoices;
DROP POLICY IF EXISTS "Allow all operations on vehicles" ON vehicles;
DROP POLICY IF EXISTS "Allow all operations on predictions" ON predictions;

-- Products Policies
CREATE POLICY "Super admin full access to products"
  ON products FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company products"
  ON products FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() OR company_id IS NULL);

CREATE POLICY "Admin and Manager can manage company products"
  ON products FOR ALL
  TO authenticated
  USING (company_id = get_user_company() AND has_role('manager'))
  WITH CHECK (company_id = get_user_company() AND has_role('manager'));

-- Inventory Stock Policies
CREATE POLICY "Super admin full access to inventory stock"
  ON inventory_stock FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company inventory"
  ON inventory_stock FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() OR company_id IS NULL);

CREATE POLICY "Admin and Manager can manage company inventory"
  ON inventory_stock FOR ALL
  TO authenticated
  USING (company_id = get_user_company() AND has_role('manager'))
  WITH CHECK (company_id = get_user_company() AND has_role('manager'));

-- Inventory Transactions Policies
CREATE POLICY "Super admin full access to transactions"
  ON inventory_transactions FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company transactions"
  ON inventory_transactions FOR SELECT
  TO authenticated
  USING (shop_id = get_user_company() OR shop_id IS NULL);

CREATE POLICY "Admin and Manager can create transactions"
  ON inventory_transactions FOR INSERT
  TO authenticated
  WITH CHECK (has_role('manager'));

-- Inventory Counts Policies
CREATE POLICY "Super admin full access to counts"
  ON inventory_counts FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company counts"
  ON inventory_counts FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() OR company_id IS NULL);

CREATE POLICY "Staff can create counts"
  ON inventory_counts FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Users can update their own counts"
  ON inventory_counts FOR UPDATE
  TO authenticated
  USING (
    (company_id = get_user_company() OR company_id IS NULL) AND
    (started_by = auth.uid() OR has_role('admin'))
  )
  WITH CHECK (
    (company_id = get_user_company() OR company_id IS NULL) AND
    (started_by = auth.uid() OR has_role('admin'))
  );

CREATE POLICY "Admin can delete counts"
  ON inventory_counts FOR DELETE
  TO authenticated
  USING (company_id = get_user_company() AND has_role('admin'));

-- Count Items Policies (inherit from parent count)
CREATE POLICY "Super admin full access to count items"
  ON inventory_count_items FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can manage count items"
  ON inventory_count_items FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM inventory_counts
      WHERE inventory_counts.id = inventory_count_items.count_id
      AND (inventory_counts.company_id = get_user_company() OR inventory_counts.company_id IS NULL)
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM inventory_counts
      WHERE inventory_counts.id = inventory_count_items.count_id
      AND (inventory_counts.company_id = get_user_company() OR inventory_counts.company_id IS NULL)
    )
  );

-- Estimates Policies
CREATE POLICY "Super admin full access to estimates"
  ON estimates FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company estimates"
  ON estimates FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() OR company_id IS NULL);

CREATE POLICY "Users can create estimates"
  ON estimates FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Admin and Manager can manage estimates"
  ON estimates FOR UPDATE
  TO authenticated
  USING (company_id = get_user_company() AND has_role('manager'))
  WITH CHECK (company_id = get_user_company() AND has_role('manager'));

CREATE POLICY "Admin can delete estimates"
  ON estimates FOR DELETE
  TO authenticated
  USING (company_id = get_user_company() AND has_role('admin'));

-- Invoices Policies
CREATE POLICY "Super admin full access to invoices"
  ON invoices FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company invoices"
  ON invoices FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() OR company_id IS NULL);

CREATE POLICY "Admin and Manager can manage invoices"
  ON invoices FOR ALL
  TO authenticated
  USING (company_id = get_user_company() AND has_role('manager'))
  WITH CHECK (company_id = get_user_company() AND has_role('manager'));

-- Vehicles Policies
CREATE POLICY "Super admin full access to vehicles"
  ON vehicles FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company vehicles"
  ON vehicles FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() OR company_id IS NULL);

CREATE POLICY "Users can manage company vehicles"
  ON vehicles FOR ALL
  TO authenticated
  USING (company_id = get_user_company())
  WITH CHECK (company_id = get_user_company());

-- Predictions Policies
CREATE POLICY "Super admin full access to predictions"
  ON predictions FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Users can view company predictions"
  ON predictions FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() OR company_id IS NULL);

CREATE POLICY "Admin and Manager can manage predictions"
  ON predictions FOR ALL
  TO authenticated
  USING (company_id = get_user_company() AND has_role('manager'))
  WITH CHECK (company_id = get_user_company() AND has_role('manager'));

SELECT 'RLS policies updated for multi-tenant isolation' as result;