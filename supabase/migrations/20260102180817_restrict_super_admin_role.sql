/*
  # Restrict Super Admin Role Assignment

  1. Changes
    - Add database trigger to prevent unauthorized super_admin role assignments
    - Only allows the existing super_admin to remain
    - Blocks any attempts to create new super_admin users
    
  2. Security
    - Protects the super_admin role from being assigned to multiple users
    - Ensures only the system owner maintains super_admin privileges
*/

-- Function to prevent unauthorized super_admin assignments
CREATE OR REPLACE FUNCTION prevent_super_admin_assignment()
RETURNS trigger AS $$
DECLARE
  existing_super_admin_id uuid;
BEGIN
  -- If role is being set to super_admin
  IF NEW.role = 'super_admin' THEN
    -- Get the existing super_admin ID (there should only be one)
    SELECT id INTO existing_super_admin_id 
    FROM user_profiles 
    WHERE role = 'super_admin' 
    LIMIT 1;
    
    -- If this is not the existing super_admin, block the change
    IF existing_super_admin_id IS NOT NULL AND NEW.id != existing_super_admin_id THEN
      RAISE EXCEPTION 'Cannot assign super_admin role. This role is restricted to the system owner.';
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop trigger if exists and recreate
DROP TRIGGER IF EXISTS check_super_admin_assignment ON user_profiles;

-- Create trigger to check super_admin assignments
CREATE TRIGGER check_super_admin_assignment
  BEFORE INSERT OR UPDATE ON user_profiles
  FOR EACH ROW
  EXECUTE FUNCTION prevent_super_admin_assignment();

SELECT 'Super admin role restriction applied successfully' as result;
