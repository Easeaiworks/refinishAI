/*
  # Fix User Profile Creation Trigger

  1. Changes
    - Add automatic trigger to create user_profiles entry when auth.users record is created
    - This ensures all users have a profile automatically
    
  2. Security
    - No RLS changes needed, trigger runs with SECURITY DEFINER
*/

-- Function to automatically create user profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.user_profiles (id, email, role, is_active)
  VALUES (
    NEW.id,
    NEW.email,
    'staff',
    true
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists and recreate
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Create trigger on auth.users
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

SELECT 'User profile trigger created successfully' as result;
