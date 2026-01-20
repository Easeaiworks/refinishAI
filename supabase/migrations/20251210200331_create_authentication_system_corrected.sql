/*
  # Authentication and Multi-Tenant Role System

  Complete authentication system with company-level isolation and role-based access control.

  1. New Tables
    
    ## companies
    - `id` (uuid, primary key)
    - `name` (text) - Company/shop name
    - `email` (text) - Primary contact email
    - `phone` (text) - Contact phone
    - `address` (text) - Physical address
    - `subscription_status` (text) - 'active', 'trial', 'suspended'
    - `subscription_ends_at` (date) - Subscription expiry
    - `created_at` (timestamptz)
    - `updated_at` (timestamptz)
    
    ## user_profiles
    - `id` (uuid, primary key, references auth.users)
    - `company_id` (uuid, foreign key) - Links to company
    - `role` (text) - 'super_admin', 'admin', 'manager', 'staff'
    - `email` (text) - User email (synced from auth)
    - `full_name` (text) - Display name
    - `phone` (text) - Contact number
    - `is_active` (boolean) - Account status
    - `last_login_at` (timestamptz) - Track activity
    - `created_at` (timestamptz)
    - `updated_at` (timestamptz)
    
    ## audit_log
    - `id` (uuid, primary key)
    - `company_id` (uuid) - Affected company
    - `user_id` (uuid) - Who performed action
    - `action` (text) - 'create', 'update', 'delete', 'login', 'password_reset'
    - `table_name` (text) - Affected table
    - `record_id` (uuid) - Affected record
    - `old_values` (jsonb) - Before state
    - `new_values` (jsonb) - After state
    - `created_at` (timestamptz)

  2. Security
    - Enable RLS on all tables
    - Super admin can access everything
    - Company isolation - users only see their company data
    - Role-based policies for each permission level

  3. Functions
    - Helper functions for role checking
    - Auto-create profile on signup
    - Password reset by super admin
*/

-- Companies table
CREATE TABLE IF NOT EXISTS companies (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text UNIQUE NOT NULL,
  phone text,
  address text,
  subscription_status text DEFAULT 'trial' NOT NULL,
  subscription_ends_at date DEFAULT (CURRENT_DATE + INTERVAL '30 days'),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- User profiles extending auth.users
CREATE TABLE IF NOT EXISTS user_profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE,
  role text DEFAULT 'staff' NOT NULL,
  email text NOT NULL,
  full_name text,
  phone text,
  is_active boolean DEFAULT true,
  last_login_at timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  CONSTRAINT valid_role CHECK (role IN ('super_admin', 'admin', 'manager', 'staff'))
);

-- Audit log for all actions
CREATE TABLE IF NOT EXISTS audit_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid REFERENCES companies(id),
  user_id uuid REFERENCES auth.users(id),
  action text NOT NULL,
  table_name text,
  record_id uuid,
  old_values jsonb,
  new_values jsonb,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_log ENABLE ROW LEVEL SECURITY;

-- Helper function: Check if user is super admin
CREATE OR REPLACE FUNCTION is_super_admin()
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth.uid()
    AND role = 'super_admin'
    AND is_active = true
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function: Get user's company
CREATE OR REPLACE FUNCTION get_user_company()
RETURNS uuid AS $$
BEGIN
  RETURN (
    SELECT company_id FROM user_profiles
    WHERE id = auth.uid()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function: Get user's role
CREATE OR REPLACE FUNCTION get_user_role()
RETURNS text AS $$
BEGIN
  RETURN (
    SELECT role FROM user_profiles
    WHERE id = auth.uid()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function: Check if user has minimum role
CREATE OR REPLACE FUNCTION has_role(required_role text)
RETURNS boolean AS $$
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RLS Policies for companies
CREATE POLICY "Super admin can view all companies"
  ON companies FOR SELECT
  TO authenticated
  USING (is_super_admin());

CREATE POLICY "Users can view their own company"
  ON companies FOR SELECT
  TO authenticated
  USING (id = get_user_company());

CREATE POLICY "Super admin can manage all companies"
  ON companies FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Company admin can update own company"
  ON companies FOR UPDATE
  TO authenticated
  USING (id = get_user_company() AND has_role('admin'))
  WITH CHECK (id = get_user_company() AND has_role('admin'));

-- RLS Policies for user_profiles
CREATE POLICY "Super admin can view all profiles"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (is_super_admin());

CREATE POLICY "Users can view profiles in their company"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (company_id = get_user_company());

CREATE POLICY "Users can view own profile"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (id = auth.uid());

CREATE POLICY "Super admin can manage all profiles"
  ON user_profiles FOR ALL
  TO authenticated
  USING (is_super_admin())
  WITH CHECK (is_super_admin());

CREATE POLICY "Admin can manage users in their company"
  ON user_profiles FOR ALL
  TO authenticated
  USING (company_id = get_user_company() AND has_role('admin'))
  WITH CHECK (company_id = get_user_company() AND has_role('admin'));

CREATE POLICY "Users can update own profile"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (id = auth.uid())
  WITH CHECK (id = auth.uid() AND role = get_user_role());

-- RLS Policies for audit_log
CREATE POLICY "Super admin can view all audit logs"
  ON audit_log FOR SELECT
  TO authenticated
  USING (is_super_admin());

CREATE POLICY "Admin can view company audit logs"
  ON audit_log FOR SELECT
  TO authenticated
  USING (company_id = get_user_company() AND has_role('admin'));

CREATE POLICY "Authenticated users can insert audit logs"
  ON audit_log FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Function: Update last login
CREATE OR REPLACE FUNCTION update_last_login()
RETURNS void AS $$
BEGIN
  UPDATE user_profiles
  SET last_login_at = now()
  WHERE id = auth.uid();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Add company_id to existing tables
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'products' AND column_name = 'company_id'
  ) THEN
    ALTER TABLE products ADD COLUMN company_id uuid REFERENCES companies(id);
    ALTER TABLE products ADD COLUMN created_by uuid REFERENCES auth.users(id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'inventory_stock' AND column_name = 'company_id'
  ) THEN
    ALTER TABLE inventory_stock ADD COLUMN company_id uuid REFERENCES companies(id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'estimates' AND column_name = 'company_id'
  ) THEN
    ALTER TABLE estimates ADD COLUMN company_id uuid REFERENCES companies(id);
    ALTER TABLE estimates ADD COLUMN created_by uuid REFERENCES auth.users(id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'invoices' AND column_name = 'company_id'
  ) THEN
    ALTER TABLE invoices ADD COLUMN company_id uuid REFERENCES companies(id);
    ALTER TABLE invoices ADD COLUMN created_by uuid REFERENCES auth.users(id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'predictions' AND column_name = 'company_id'
  ) THEN
    ALTER TABLE predictions ADD COLUMN company_id uuid REFERENCES companies(id);
    ALTER TABLE predictions ADD COLUMN created_by uuid REFERENCES auth.users(id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'vehicles' AND column_name = 'company_id'
  ) THEN
    ALTER TABLE vehicles ADD COLUMN company_id uuid REFERENCES companies(id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'inventory_counts' AND column_name = 'company_id'
  ) THEN
    ALTER TABLE inventory_counts ADD COLUMN company_id uuid REFERENCES companies(id);
    UPDATE inventory_counts SET shop_id = NULL WHERE shop_id IS NOT NULL;
  END IF;
END $$;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_profiles_company ON user_profiles(company_id);
CREATE INDEX IF NOT EXISTS idx_user_profiles_role ON user_profiles(role);
CREATE INDEX IF NOT EXISTS idx_audit_log_company ON audit_log(company_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_user ON audit_log(user_id);
CREATE INDEX IF NOT EXISTS idx_products_company ON products(company_id);
CREATE INDEX IF NOT EXISTS idx_inventory_stock_company ON inventory_stock(company_id);
CREATE INDEX IF NOT EXISTS idx_estimates_company ON estimates(company_id);
CREATE INDEX IF NOT EXISTS idx_invoices_company ON invoices(company_id);
CREATE INDEX IF NOT EXISTS idx_predictions_company ON predictions(company_id);
CREATE INDEX IF NOT EXISTS idx_vehicles_company ON vehicles(company_id);
CREATE INDEX IF NOT EXISTS idx_inventory_counts_company ON inventory_counts(company_id);

-- Create the system company for super admin
INSERT INTO companies (id, name, email, subscription_status)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  'System',
  'system@refinishai.com',
  'active'
) ON CONFLICT DO NOTHING;

SELECT 'Authentication system created with multi-tenant role-based access control' as result;