-- ============================================================
-- Set Adam Berube as platform super admin
-- ============================================================
UPDATE user_profiles
SET role = 'super_admin'
WHERE email = 'adamberube@me.com';
