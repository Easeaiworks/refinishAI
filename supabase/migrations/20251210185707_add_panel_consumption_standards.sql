/*
  # Panel Consumption Standards

  Creates a reference table for standard paint consumption per panel type.
  This helps the AI learn realistic amounts of primer, base coat, and clear coat
  needed for each type of body panel.

  1. New Table
    - `panel_consumption_standards`
      - Links panel types to product categories
      - Stores typical quantities needed
      - Accounts for application method and coverage
  
  2. Seeded Data
    - Standards for all panel types
    - Realistic quantities based on industry norms
    - Separate entries for primer, base coat, and clear coat
*/

CREATE TABLE IF NOT EXISTS panel_consumption_standards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  panel_type_id uuid REFERENCES panel_types(id) ON DELETE CASCADE NOT NULL,
  product_category text NOT NULL,
  typical_quantity_gallons numeric NOT NULL,
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(panel_type_id, product_category)
);

ALTER TABLE panel_consumption_standards ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access to panel consumption standards"
  ON panel_consumption_standards FOR SELECT
  TO public
  USING (true);

-- Seed consumption standards for each panel type
-- Note: These are realistic estimates based on typical refinish practices
-- Small panels: ~0.03-0.05 gallons per coat
-- Medium panels: ~0.05-0.08 gallons per coat  
-- Large panels: ~0.08-0.15 gallons per coat

-- Hood (15 sq ft - Large panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.10, 'Large flat panel, typically 2 coats primer'
FROM panel_types WHERE code = 'HOOD'
UNION ALL
SELECT id, 'Base Coat', 0.12, 'Large surface requires good coverage, 2-3 coats'
FROM panel_types WHERE code = 'HOOD'
UNION ALL
SELECT id, 'Clear Coat', 0.10, 'Large panel, 2-3 coats clear for protection'
FROM panel_types WHERE code = 'HOOD';

-- Front Fender (10 sq ft - Medium panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.06, 'Medium panel with curves'
FROM panel_types WHERE code = 'FENDER_F'
UNION ALL
SELECT id, 'Base Coat', 0.08, 'Curved surface, 2-3 coats'
FROM panel_types WHERE code = 'FENDER_F'
UNION ALL
SELECT id, 'Clear Coat', 0.07, 'Medium panel, standard clear application'
FROM panel_types WHERE code = 'FENDER_F';

-- Front Door (12 sq ft - Medium panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.07, 'Door panel including edge coverage'
FROM panel_types WHERE code = 'DOOR_F'
UNION ALL
SELECT id, 'Base Coat', 0.09, 'Includes jamb and edge work'
FROM panel_types WHERE code = 'DOOR_F'
UNION ALL
SELECT id, 'Clear Coat', 0.08, 'Full door coverage'
FROM panel_types WHERE code = 'DOOR_F';

-- Rear Door (12 sq ft - Medium panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.07, 'Door panel including edge coverage'
FROM panel_types WHERE code = 'DOOR_R'
UNION ALL
SELECT id, 'Base Coat', 0.09, 'Includes jamb and edge work'
FROM panel_types WHERE code = 'DOOR_R'
UNION ALL
SELECT id, 'Clear Coat', 0.08, 'Full door coverage'
FROM panel_types WHERE code = 'DOOR_R';

-- Quarter Panel (16 sq ft - Large panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.11, 'Large complex panel with curves'
FROM panel_types WHERE code = 'QUARTER'
UNION ALL
SELECT id, 'Base Coat', 0.13, 'Complex shape requires careful application'
FROM panel_types WHERE code = 'QUARTER'
UNION ALL
SELECT id, 'Clear Coat', 0.11, 'Large panel, thorough coverage needed'
FROM panel_types WHERE code = 'QUARTER';

-- Roof (25 sq ft - Extra Large panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.15, 'Largest panel, typically horizontal'
FROM panel_types WHERE code = 'ROOF'
UNION ALL
SELECT id, 'Base Coat', 0.18, 'Maximum coverage area, 3 coats recommended'
FROM panel_types WHERE code = 'ROOF'
UNION ALL
SELECT id, 'Clear Coat', 0.15, 'Full roof requires substantial clear coat'
FROM panel_types WHERE code = 'ROOF';

-- Trunk/Deck Lid (12 sq ft - Medium panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.07, 'Trunk lid with edges'
FROM panel_types WHERE code = 'TRUNK'
UNION ALL
SELECT id, 'Base Coat', 0.09, 'Includes jamb areas'
FROM panel_types WHERE code = 'TRUNK'
UNION ALL
SELECT id, 'Clear Coat', 0.08, 'Standard coverage'
FROM panel_types WHERE code = 'TRUNK';

-- Front Bumper (8 sq ft - Small/Medium panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.05, 'Plastic bumper, flexible primer often needed'
FROM panel_types WHERE code = 'BUMPER_F'
UNION ALL
SELECT id, 'Base Coat', 0.06, 'Curved surface with texture'
FROM panel_types WHERE code = 'BUMPER_F'
UNION ALL
SELECT id, 'Clear Coat', 0.05, 'Moderate coverage'
FROM panel_types WHERE code = 'BUMPER_F';

-- Rear Bumper (8 sq ft - Small/Medium panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.05, 'Plastic bumper, flexible primer often needed'
FROM panel_types WHERE code = 'BUMPER_R'
UNION ALL
SELECT id, 'Base Coat', 0.06, 'Curved surface with texture'
FROM panel_types WHERE code = 'BUMPER_R'
UNION ALL
SELECT id, 'Clear Coat', 0.05, 'Moderate coverage'
FROM panel_types WHERE code = 'BUMPER_R';

-- Rocker Panel (6 sq ft - Small panel)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.04, 'Small narrow panel'
FROM panel_types WHERE code = 'ROCKER'
UNION ALL
SELECT id, 'Base Coat', 0.05, 'Linear panel, careful edge work'
FROM panel_types WHERE code = 'ROCKER'
UNION ALL
SELECT id, 'Clear Coat', 0.04, 'Small area coverage'
FROM panel_types WHERE code = 'ROCKER';

-- Mirror (1 sq ft - Very Small)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.02, 'Very small component'
FROM panel_types WHERE code = 'MIRROR'
UNION ALL
SELECT id, 'Base Coat', 0.02, 'Minimal paint needed'
FROM panel_types WHERE code = 'MIRROR'
UNION ALL
SELECT id, 'Clear Coat', 0.02, 'Small detail work'
FROM panel_types WHERE code = 'MIRROR';

-- Grille (2 sq ft - Very Small)
INSERT INTO panel_consumption_standards (panel_type_id, product_category, typical_quantity_gallons, notes)
SELECT id, 'Primer', 0.03, 'Small decorative panel'
FROM panel_types WHERE code = 'GRILLE'
UNION ALL
SELECT id, 'Base Coat', 0.03, 'Detail work with texture'
FROM panel_types WHERE code = 'GRILLE'
UNION ALL
SELECT id, 'Clear Coat', 0.03, 'Light coverage'
FROM panel_types WHERE code = 'GRILLE';

CREATE INDEX IF NOT EXISTS idx_panel_consumption_panel_type ON panel_consumption_standards(panel_type_id);
CREATE INDEX IF NOT EXISTS idx_panel_consumption_category ON panel_consumption_standards(product_category);

SELECT 'Created consumption standards for ' || COUNT(DISTINCT panel_type_id) || ' panel types' FROM panel_consumption_standards;