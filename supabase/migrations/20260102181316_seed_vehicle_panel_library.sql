/*
  # Seed Vehicle Panel Dimension Library

  1. Purpose
    - Populate panel_types table with standard automotive body panels
    - Add realistic surface area measurements for paint consumption calculations
    - Create panel_consumption_standards for accurate material estimation
    
  2. Panel Types Added
    - Hood, Front Fenders (L/R), Front Doors (L/R), Rear Doors (L/R)
    - Trunk/Tailgate, Front/Rear Bumpers, Roof, Quarter Panels (L/R)
    - Rocker Panels, Mirrors, Spoilers
    
  3. Consumption Standards
    - Industry-standard paint quantities per panel type
    - Covers Primer, Base Coat, and Clear Coat categories
    - Based on collision repair industry standards
    
  4. Notes
    - Surface areas are for standard sedan-sized vehicles
    - Values adjusted by body style multiplier in application logic
    - Consumption values account for 2-3 coats per product type
*/

-- Insert standard panel types with typical surface areas (sq ft)
INSERT INTO panel_types (code, name, typical_area_sqft) VALUES
  ('HOOD', 'Hood', 15.0),
  ('FENDER_F_L', 'Front Fender - Left', 10.0),
  ('FENDER_F_R', 'Front Fender - Right', 10.0),
  ('DOOR_F_L', 'Front Door - Left', 12.0),
  ('DOOR_F_R', 'Front Door - Right', 12.0),
  ('DOOR_R_L', 'Rear Door - Left', 11.0),
  ('DOOR_R_R', 'Rear Door - Right', 11.0),
  ('TRUNK', 'Trunk/Deck Lid', 13.0),
  ('TAILGATE', 'Tailgate', 16.0),
  ('BUMPER_F', 'Front Bumper', 8.0),
  ('BUMPER_R', 'Rear Bumper', 8.0),
  ('ROOF', 'Roof', 22.0),
  ('QUARTER_L', 'Quarter Panel - Left', 14.0),
  ('QUARTER_R', 'Quarter Panel - Right', 14.0),
  ('ROCKER_L', 'Rocker Panel - Left', 6.0),
  ('ROCKER_R', 'Rocker Panel - Right', 6.0),
  ('MIRROR_L', 'Side Mirror - Left', 0.5),
  ('MIRROR_R', 'Side Mirror - Right', 0.5),
  ('SPOILER', 'Rear Spoiler', 3.0),
  ('GRILLE', 'Front Grille', 2.0)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name,
  typical_area_sqft = EXCLUDED.typical_area_sqft;

-- Create consumption standards for each panel type
-- These are industry-standard quantities in gallons

-- Hood standards
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT 
  id,
  'Primer',
  0.25,
  'Standard primer coverage for hood - 2 coats'
FROM panel_types WHERE code = 'HOOD'
ON CONFLICT DO NOTHING;

INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT 
  id,
  'Base Coat',
  0.30,
  'Base coat coverage for hood - 2-3 coats'
FROM panel_types WHERE code = 'HOOD'
ON CONFLICT DO NOTHING;

INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT 
  id,
  'Clear Coat',
  0.35,
  'Clear coat coverage for hood - 2-3 coats'
FROM panel_types WHERE code = 'HOOD'
ON CONFLICT DO NOTHING;

-- Front Fender standards (applying to both L/R)
DO $$
DECLARE
  panel_code TEXT;
BEGIN
  FOREACH panel_code IN ARRAY ARRAY['FENDER_F_L', 'FENDER_F_R']
  LOOP
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Primer', 0.20, 'Standard primer for front fender'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Base Coat', 0.25, 'Base coat for front fender'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Clear Coat', 0.28, 'Clear coat for front fender'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

-- Front Door standards
DO $$
DECLARE
  panel_code TEXT;
BEGIN
  FOREACH panel_code IN ARRAY ARRAY['DOOR_F_L', 'DOOR_F_R']
  LOOP
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Primer', 0.22, 'Standard primer for front door'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Base Coat', 0.28, 'Base coat for front door'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Clear Coat', 0.32, 'Clear coat for front door'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

-- Rear Door standards
DO $$
DECLARE
  panel_code TEXT;
BEGIN
  FOREACH panel_code IN ARRAY ARRAY['DOOR_R_L', 'DOOR_R_R']
  LOOP
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Primer', 0.20, 'Standard primer for rear door'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Base Coat', 0.26, 'Base coat for rear door'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Clear Coat', 0.30, 'Clear coat for rear door'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

-- Trunk/Deck Lid standards
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.24, 'Standard primer for trunk/deck lid'
FROM panel_types WHERE code = 'TRUNK'
ON CONFLICT DO NOTHING;

INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Base Coat', 0.30, 'Base coat for trunk/deck lid'
FROM panel_types WHERE code = 'TRUNK'
ON CONFLICT DO NOTHING;

INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Clear Coat', 0.34, 'Clear coat for trunk/deck lid'
FROM panel_types WHERE code = 'TRUNK'
ON CONFLICT DO NOTHING;

-- Bumper standards
DO $$
DECLARE
  panel_code TEXT;
BEGIN
  FOREACH panel_code IN ARRAY ARRAY['BUMPER_F', 'BUMPER_R']
  LOOP
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Primer', 0.18, 'Flexible primer for bumper'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Base Coat', 0.22, 'Base coat for bumper'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Clear Coat', 0.25, 'Clear coat for bumper'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

-- Roof standards
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.35, 'Standard primer for roof'
FROM panel_types WHERE code = 'ROOF'
ON CONFLICT DO NOTHING;

INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Base Coat', 0.42, 'Base coat for roof'
FROM panel_types WHERE code = 'ROOF'
ON CONFLICT DO NOTHING;

INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Clear Coat', 0.48, 'Clear coat for roof'
FROM panel_types WHERE code = 'ROOF'
ON CONFLICT DO NOTHING;

-- Quarter Panel standards
DO $$
DECLARE
  panel_code TEXT;
BEGIN
  FOREACH panel_code IN ARRAY ARRAY['QUARTER_L', 'QUARTER_R']
  LOOP
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Primer', 0.26, 'Standard primer for quarter panel'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Base Coat', 0.32, 'Base coat for quarter panel'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Clear Coat', 0.36, 'Clear coat for quarter panel'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

-- Small components (mirrors, grilles, spoilers, rockers)
DO $$
DECLARE
  panel_code TEXT;
BEGIN
  FOREACH panel_code IN ARRAY ARRAY['MIRROR_L', 'MIRROR_R', 'GRILLE', 'SPOILER']
  LOOP
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Primer', 0.08, 'Primer for small component'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Base Coat', 0.10, 'Base coat for small component'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Clear Coat', 0.12, 'Clear coat for small component'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

DO $$
DECLARE
  panel_code TEXT;
BEGIN
  FOREACH panel_code IN ARRAY ARRAY['ROCKER_L', 'ROCKER_R']
  LOOP
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Primer', 0.12, 'Primer for rocker panel'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Base Coat', 0.15, 'Base coat for rocker panel'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
    
    INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
    SELECT id, 'Clear Coat', 0.18, 'Clear coat for rocker panel'
    FROM panel_types WHERE code = panel_code
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

SELECT 'Vehicle panel library seeded successfully' as result;
