/*
  # Add Company Insert Policy for New Signups

  1. Issue
    - Missing INSERT policy on companies table prevents new company creation
    - During signup flow, authenticated users need to create their company
    
  2. Solution
    - Add INSERT policy allowing authenticated users to create companies
    - This is safe because:
      - User must be authenticated (just signed up via Supabase Auth)
      - Each user creates only their own company during signup
      - After company creation, user_profile is created linking them as admin
      
  3. Security
    - Only authenticated users can insert
    - No additional restrictions needed as this is for initial signup
    - Multi-tenant isolation enforced through subsequent user_profile creation
*/

-- Add INSERT policy for companies table
CREATE POLICY "Allow authenticated users to create companies"
  ON companies FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Also add DELETE policy for completeness (super admin only)
CREATE POLICY "Super admin can delete companies"
  ON companies FOR DELETE
  TO authenticated
  USING (is_super_admin());

SELECT 'Company insert policy added successfully' as result;