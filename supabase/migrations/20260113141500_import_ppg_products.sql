-- PPG Product Catalog Import
-- Generated automatically from PPG price lists
-- Total products: 1016

-- Clear existing PPG products (optional - comment out if you want to keep existing)
-- DELETE FROM products WHERE supplier = 'PPG';

-- Insert new products
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DC412504',
  'CERAMICLEAR® / Ceramiclear',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  134.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DCH412608',
  'Ceramiclear Hardener / Durcisseur Ceramiclear',
  'Clear Coat',
  'PPG',
  'pint',
  37.50,
  0.15,
  74.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LV04',
  '2.1 Epoxy Hardener / Durcisseur pour apprêt époxy 2,1 COV',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  100.44,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LV08',
  '2.1 Epoxy Hardener / Durcisseur pour apprêt époxy 2,1 COV',
  'Primer',
  'PPG',
  'pint',
  50.00,
  0.15,
  60.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP48LV01',
  '2.1 Epoxy Primer-White / Apprêt époxy 2,1 -blanc',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  347.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP48LV04',
  '2.1 Epoxy Primer-White / Apprêt époxy 2,1 -blanc',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  97.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP50LV01',
  '2.1 Epoxy Primer-Gray / Apprêt époxy 2,1 -gris',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  347.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP50LV04',
  '2.1 Epoxy Primer-Gray / Apprêt époxy 2,1 -gris',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  97.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP90LV01',
  '2.1 Epoxy Primer-Black / Apprêt époxy 2,1 -noir',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  347.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP90LV04',
  '2.1 Epoxy Primer-Black / Apprêt époxy 2,1 -noir',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  97.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DT184501',
  'Compliant Reducer Normal / Réducteur conforme normal',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  92.25,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DT185001',
  'Compliant Reducer Medium / Réducteur conforme moyen',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  118.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DT185501',
  'Compliant Reducer Slow / Réducteur conforme lent',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  154.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'NCP28001',
  '2.1 VOC Primer Surfacer / Apprêt surfaçant 2,1 COV',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  413.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'NCP45001',
  'ISO-Free Primer Surfacer / Surfaçants sans isocyanates',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  420.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'NCP28001',
  '2.1 VOC Primer Surfacer / Apprêt surfaçant 2,1 COV',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  413.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'NCX45504',
  'ISO-Free Catalyst / Catalyseur sans isocyanates',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  146.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'National Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DBC50001',
  'Color Blender / Agent de dégradation de couleurs',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  368.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DBC50004',
  'Color Blender / Agent de cégradation de couleurs',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  101.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DBX168901',
  'Basecoat Converter / Convertisseur pour couche de base',
  'Basecoat',
  'PPG',
  'gallon',
  350.00,
  0.15,
  624.58,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DCU202101',
  'Urethane Clear / Incolore uréthane',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  434.57,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DCX6104',
  'High Solids Hardener / Durcisseur à forte teneur en matières solides',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  219.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DFX1104',
  'Low VOC Hardener / Durcisseur à faible COV',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  159.42,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD1602HQ',
  'Green Shade Yellow / Jaune ton vert',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  149.34,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD160304',
  'Red Shade Yellow / Rouge ton jaune',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  419.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD160504',
  'Magenta / Magenta',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  399.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD160604',
  'Perylene Maroon / Marron pérylène',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  399.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD160704',
  'Phthalo Blue (Mid Shade) / Bleu phtalo mi-ton',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  399.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD160804',
  'Organic Orange / Orange organique',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  419.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD160904',
  'Quindo Violet / Violet quindo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  419.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD161004',
  'Transparent Red Oxide / Rouge oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  399.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD161104',
  'Bright Orange / Orange éclatant',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  293.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD1612HQ',
  'Trace Gold / Trace or',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD161304',
  'Trace Blue / Trace bleu',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  232.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD1614HQ',
  'Trace Yellow Oxide / Trace jaune d''oxyde',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD161504',
  'Trace Green / Trace vert',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  232.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD1616HQ',
  'Trace Red / Trace rouge',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD162104',
  'Fine Titanium White / Blanc titane fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  452.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD162504',
  'Bright Yellow / Jaune éclatant',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  293.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD162704',
  'Indo Blue / Bleu indo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  251.57,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD162804',
  'Perylene Violet / Violet pérylène',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  332.83,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD163004',
  'Carmine / Carmine',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  315.19,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD163204',
  'Olive / Olive',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  292.49,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD163404',
  'Organic Brown / Brun organique',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  269.55,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD164704',
  'Carbon Black / Noir de carbone',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  140.32,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'National Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD167504',
  'Phthalo Blue (Red Shade) / Bleu phthalo (rougeâtre)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  203.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD167604',
  'Phthalo Blue (Green Shade) / Bleu phtalo (teinte verte)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  216.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD167701',
  'Scarlet Red / Rouge écarlate',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  1388.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD167704',
  'Scarlet Red / Rouge écarlate',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  388.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD167804',
  'Phthalo Green (Yellow Shade) / Vert phtalo (ton de jaune)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD167904',
  'Quindo Red / Rouge quindo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  294.23,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168004',
  'Fine Aluminum / Aluminium fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168104',
  'Medium Aluminum / Aluminium moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168204',
  'Coarse Aluminum / Aluminuim grossier',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168301',
  'Black / Noir',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  633.44,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168401',
  'White / Blanc',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  685.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168504',
  'Super Fine Bright Aluminum / Aluminium brillant super fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  236.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168604',
  'Fine Satin Aluminum / Aluminium fin satiné',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168701',
  'Medium Satin Aluminum / Aluminium moyen satiné',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  614.88,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD168704',
  'Medium Satin Aluminum / Aluminium moyen satiné',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD169001',
  'Coarse Satin Aluminum / Aluminium grossier satiné',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  854.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD169004',
  'Coarse Satin Aluminum / Aluminium grossier satiné',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD169204',
  'Bright Red / Rouge vif',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  294.23,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD169304',
  'Phthalo Green (Blue Shade) / Vert phtalo à ton bleu',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  216.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD169404',
  'Yellow Shade Maroon / Marron à ton jaune',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  346.16,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD169604',
  'Coarse Silver Dollar Aluminum / Aluminium dollar d''argent gros',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  239.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD169804',
  'Medium Aluminum Gold / Aluminium or moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  388.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD17701L',
  'Fine Liquid Metal / Métal liquide fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  681.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD1781AZ',
  'Silver Glass / Verre argenté',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  318.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD61404',
  'Permanent Blue / Bleu permanent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  251.57,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD61904',
  'Blue Shade Violet / Violet ton bleu',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  280.70,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD62204',
  'Red Oxide / Rouge d''oxyde',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  159.70,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD64104',
  'Transparent Yellow Oxide / Jaune d''oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  162.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD64204',
  'Yellow Oxide / Jaune d''oxyde',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  157.16,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD64604',
  'Trace White / Trace blanc',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  140.81,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD64804',
  'Trace Black / Trace noir',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  157.91,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD64901',
  'Mixing Clear / Incolore de mélange',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  381.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD66504',
  'Red Shade Organic Yellow / Jaune organique ton de rouge',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  497.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD66604',
  'Organic Yellow (Green Shade) / Jaune organique (teinte verte)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  497.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMD69104',
  'Graphite Black / Noir graphite',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  295.52,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LF01',
  'Epoxy Primer Catalyst / Catalyseur pour apprêt époxie',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  305.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LF04',
  'Epoxy Primer Catalyst / Catalyseur pour apprêt époxie',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  95.91,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP402LF04',
  'Epoxy Primer Catalyst (Lead Free) / Catalyseur pour apprêt époxie (sans plomb)',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  102.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP90LF04',
  'Non Sanding Epoxy Primer Black (Lead Free) / Couche de fond époxy noire sans ponçage (sans plomb)',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  67.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DTL1601',
  'Acrylic Lacquer Thinner / Diluant de vernis acrylique',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  81.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DX578Z',
  'Basecoat Activator / Activateur pour couche de base',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  80.20,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DX68504',
  'Flatting Agent / Agent de matage',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  98.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DX82104',
  'Flop Adjuster / Correcteur de biais',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  248.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DX99504',
  'Flatting Agent / Agent ee matage',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  109.55,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'National Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'NCP27101',
  'Corrosion Resistant Primer-Gray / Apprêt résistant à la corrosion-gris',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  409.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'NCX27504',
  'Corrosion Resistant Primer Catalyst / Catalyseur pour l''apprêt de protection contre la corrosion',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  149.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL806Z',
  'Red-Green Pearl / Rouge-vert perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL876Z',
  'Fine Blue Pearl / Bleu perle fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL886Z',
  'Orange Pearl / Orange perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL896Z',
  'Violet Pearl / Violet perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL906Z',
  'Sunset Red Pearl / Rouge coucher de soleil perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL916Z',
  'Green Pearl / Vert perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL926Z',
  'Frost Blue Pearl / Bleu givre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL936Z',
  'Tincture Gold Pearl / Teinture d''or perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL956Z',
  'Bright White Pearl / Blanc vif perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL966Z',
  'Russet Pearl / Brun roux perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL976Z',
  'Copper Pearl / Cuivre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL986Z',
  'Fine White Pearl / Blanc perle fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL996Z',
  'Fine Russet Pearl / Brun roux perle fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX14Z',
  'CRYSTAL PEARL® Red Pearl / Rouge perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX24Z',
  'Crystal Pearl Silver Pearl / Argent perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX34Z',
  'Crystal Pearl Gold Pearl / Or perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX44Z',
  'Crystal Pearl Blue Pearl / Bleu perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX54Z',
  'Crystal Pearl Green Pearl / Vert perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX64Z',
  'Crystal Pearl Frost Red Pearl / Rouge givre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX74Z',
  'Crystal Pearl Copper Pearl / Cuivre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX84Z',
  'Crystal Pearl Cosmic Turquoise / Turquoise cosmique',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX94Z',
  'Crystal Pearl Amethyst Dream / Rêve d’améthyste',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESB80004',
  'Basecoat Converter / Convertisseur pour couche de base',
  'Basecoat',
  'PPG',
  'quart',
  87.50,
  0.15,
  54.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESB81001',
  'Matte Binder / Liant mat',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  217.75,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESC62101',
  '2.1 VOC Clear / Incolore COV 2,1',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  149.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESH20001',
  'Single Stage Hardener / Durcisseur à une étape',
  'Hardener',
  'PPG',
  'gallon',
  0.00,
  0.15,
  214.61,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESH20004',
  'Single Stage Hardener / Durcisseur à une étape',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  53.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESH20008',
  'Single Stage Hardener / Durcisseur à une étape',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  27.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESH21004',
  'Basecoat Hardener / Durcisseur pour couche de base',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  48.47,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10101',
  'Amethyst Blue / Bleu améthyste',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  362.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10201',
  'Rubellite Red / Rouge rubellite',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  324.61,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10301',
  'Amber / Ambre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  323.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10401',
  'Agate Purple / Violet agate',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  336.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10501',
  'Beryl Red / Rouge béryl',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  334.04,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10601',
  'Topaz Blue / Bleu topaze',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  282.20,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10701',
  'Pyrope Red / Rouge pyrope',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  398.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10801',
  'Citrine Yellow / Jaune citrine',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  482.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM10901',
  'Zircon Yellow / Jaune zircon',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  523.30,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM11001',
  'Aquamarine / Aigue-marine',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  304.76,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM11101',
  'Garnet Red / Rouge grenat',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  519.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM11201',
  'Sunstone Yellow / Jaune héliolite',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  504.13,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM11301',
  'Tiger Eye Orange / Orange oeil-de-tigre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  423.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM11401',
  'Coral / Corail',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  321.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM11501',
  'Tanzanite / Tanzanite',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  303.49,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM11901',
  'Peridot Green / Vert péridot',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  237.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12001',
  'Emerald / Émeraude',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  246.14,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12101',
  'Beryl Yellow / Jaune béryl',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  285.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12201',
  'Spinel Red / Rouge spinelle',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  257.19,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12301',
  'Lapis Blue / Bleu lapis lazuli',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  248.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12401',
  'Sapphire Blue / Bleu saphir',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  307.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12501',
  'Opal Black / Noir opale',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  155.82,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12601',
  'Diamond White / Blanc diamant',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  201.35,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12701',
  'Sardonyx Red / Rouge sardonyx',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  257.03,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12801',
  'Alexandrite Yellow / Jaune alexandrite',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  323.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM12901',
  'Sparkle / Éclat',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  270.61,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM13001',
  'Twinkle / Scintillement',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  253.44,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM13201',
  'Ultra White / Ultra blanc',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  219.51,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESM13301',
  'Jet Black / Noir jet',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  179.51,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESR30001',
  'Exempt Reducer / Réducteur exempté',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  104.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESR31001',
  'Exempt Reducer-Warm Weather / Réducteur exempté–température chaude',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  104.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESSS3800SF01',
  'GM50 Olympic White / Blanc olympique GM 50 (3/4 gal)',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  135.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESSS900001',
  'Factory Package-Black / Noir préparé en usine (3/4 gal)',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  120.14,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESSS90365301',
  'Factory Package-White / Blanc préparé en usine  (3/4 gal)',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  138.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESSS91167801',
  'Factory Package-Flat Black / Noir très mat préparé en usine (3/4 gal)',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  122.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESSS97939201',
  'Factory Package-Jet Black / Noir jet très mat préparé en usine',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  144.51,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EST90001',
  'DTM Chassis Black / Noir châssis DTM',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  165.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU41001',
  '2.1 Polyurethane Primer / Apprêt polyuréthane 2,1',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  162.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU41904',
  '2.1  Primer Hardener / Durcisseur pour apprêt 2,1',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  100.35,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU47001',
  '2.1 Epoxy Primer / Apprêt époxy 2,1',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  168.83,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU47904',
  '2.1 Epoxy Hardener / Durcisseur pour époxy à 2,1 COV',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  44.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU48001',
  '2.1 VOC Epoxy Primer - Gray / Apprêt époxy 2,1 COV - gris',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  167.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU48101',
  '2.1 VOC Epoxy Primer - White / Apprêt époxy 2,1 COV - blanc',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  167.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU48201',
  '2.1 VOC Epoxy Primer - Black / Apprêt époxy 2,1 COV - noir',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  167.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU48904',
  '2.1 Epoxy Primer Hardener / Durcisseur pour apprêt époxy 2,1',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  42.28,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX50008',
  'Fast Activator / Activateur rapide',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  20.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX51008',
  'Standard Activator / Activateur standard',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  20.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX52008',
  'Slow Activator / Activateur lent',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  20.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX53008',
  'Very Slow Activator / Activateur très lent',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  20.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX54008',
  'Extra Slow Activator / Activateur extrêmement lent',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  20.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX59008',
  'Primer Accelerator / Accélérateur pour apprêt',
  'Primer',
  'PPG',
  'pint',
  50.00,
  0.15,
  61.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX71104',
  'Activator-Cold Weather / Activateur pour temps froid',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  37.42,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESX72104',
  'Activator -Standard / Activateur standard',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  37.42,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESC60001',
  'Urethane Clear  / Incolore uréthane (3/4 gal)',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  109.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU40001',
  'Wash Primer / Apprêt réactif',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  118.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU40901',
  'Wash Primer Hardener / Durcisseur pour apprêt réactif',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  92.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU43001',
  'Epoxy Primer / Apprêt époxy',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  101.47,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU43901',
  'Epoxy Primer Hardener / Durcisseur pour apprêt époxy',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  54.91,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU44001',
  '3.5 Primer Surfacer / Apprêt surfaçant à 3,5 (3/4 gal)',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  101.40,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU44908',
  '3.5 Primer Surfacer Hardener / Durcisseur pour apprêt surfaçant à 3,5',
  'Primer',
  'PPG',
  'pint',
  50.00,
  0.15,
  30.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU46001',
  '4.6 Epoxy Primer-Gray / Apprêt époxy 4,6-gris',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  105.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU46101',
  '4.6 Epoxy Primer-White / Apprêt époxy 4,6-blanc',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  105.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU46201',
  '4.6 Epoxy Primer-Black / Apprêt époxy 4,6-noir',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  105.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ESU46904',
  '4.6 Epoxy Primer Hardener / Durcisseur pour apprêt époxy 4,6',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  23.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EC53001',
  '2',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  399.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EC55001',
  '2',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  399.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EC80001',
  '2',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  378.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECA8304',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  79.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECH507504',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  116.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECH807504',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  116.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECH809504',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  116.02,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECP3501',
  '2',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  340.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECR6501',
  '4',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  107.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECR7501',
  '4',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  107.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECR8501',
  '4',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  107.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECR9804',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  28.55,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECS2104',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  335.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECS2504',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  335.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ECS2704',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  335.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EH39104',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  145.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EH39204',
  '6',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  145.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPW1152L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  169.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4002L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  427.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T402HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  127.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T403HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  111.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T404HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  86.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T405HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4061L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  173.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4072L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  346.75,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4092L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  377.76,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4111L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  173.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4121L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  169.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4131L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  173.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4142L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  496.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T415HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  86.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T421HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T422HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  84.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T423HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  127.24,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T425HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T426HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4271L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T429HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  84.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4301L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  208.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4311L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  188.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4321L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  169.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T433HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4351L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T436HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  84.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4381L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T440HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  86.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T441HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  84.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T442HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4431L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  208.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4441L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4451L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4471L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4482L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  417.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T451HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T452HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4531L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  208.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4541L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T455HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4561L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  208.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T457HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T458HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  107.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4591L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4601L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T461HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4621L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  248.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T465HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T466HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T468HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4712L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  417.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4722L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  417.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4732L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  417.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4741L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  208.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4752L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  417.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4762L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  417.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4771L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  208.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4791L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  208.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T489HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4902L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  346.32,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4911L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  209.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4922L',
  '2',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  37.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4931L',
  '6',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  115.99,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T493HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  59.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T49401',
  '2',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  28.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T5101L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  120.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T58108',
  '12',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  141.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T59501',
  '4',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  49.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4000HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4001HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4002HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4003HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4004HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4005HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4006HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4007QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  233.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4008HL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4018QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  403.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4020QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  612.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4021QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  612.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4022QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  612.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4023QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  612.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4024QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  612.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4025QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  612.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4026QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  612.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4032HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4033HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  479.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4034QL',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  233.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4035QL',
  '6',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  205.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4037QL',
  '6',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  205.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4040HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4042HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4281HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  124.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4311HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  100.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4341HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  100.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4342HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  119.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4343HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  119.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T4705HL',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  427.14,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T48002L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  412.47,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'T48501L',
  '3',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  284.28,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM43508Z',
  '12',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  233.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EHPMOBILEKT',
  '1',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  5279.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX403EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  1284.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX412EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  6.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX610EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  27.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX620EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  19.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX640EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  75.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX125PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  20.14,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX446EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  9.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX468EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  3.47,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX526PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  118.73,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX530EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  12.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EHPMCDECALEA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  1.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G1PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G3PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G5PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G6PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G7PK',
  'PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG1BX',
  'BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG3BX',
  'BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG5BX',
  'BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG6BX',
  'BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG7BX',
  'BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX312EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  100.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX371-13EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  14.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX371-14EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  17.30,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX371-15EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  19.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX371-16EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  20.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX371-17EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  25.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX371-18EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  25.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX383-13EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  22.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX383-14EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  22.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX383-15EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  22.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX383-16EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  23.44,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX383-17EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  27.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX383-18EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  27.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOXPCBEA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  82.63,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EHPTT2EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  4.98,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EHPTT2FEA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  4.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'R3342EA',
  'EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  26.70,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10401',
  'Organic Red / Rouge organique',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  363.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10404',
  'Organic Red / Rouge organique',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  101.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10501',
  'High Strength Red / Rouge très concentré',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  383.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10504',
  'High Strength Red / Rouge très concentré',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  106.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10601',
  'Red Oxide / Rouge d''oxyde',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10604',
  'Red Oxide / Rouge d''oxyde',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10801',
  'Transparent Red Oxide / Rouge d''oxyde transparent',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10804',
  'Transparent Red Oxide / Rouge d''oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1094Z',
  'Fine Russet Pearl / Roux fin perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1104Z',
  'Violet Pearl / Violet perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11101',
  'Transparent Yellow Oxide / Jaune d''oxyde transparent',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  201.25,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11104',
  'Transparent Yellow Oxide / Jaune d''oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  56.82,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M112NF01',
  'Gold / Or',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  274.14,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M112NF04',
  'Gold / Or',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  77.63,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11501',
  'Yellow Oxide / Jaune d''oxyde',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11504',
  'Yellow Oxide / Jaune d''oxyde',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M116NF01',
  'Red Shade Yellow / Jaune rougeâtre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M116NF04',
  'Red Shade Yellow / Jaune rougeâtre',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11701',
  'Jet Black / Noir de jais',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11801',
  'Tinting Black / Noir à teinter',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11804',
  'Tinting Black / Noir à teinter',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M11901',
  'Hi-Hiding White / Blanc à haut pouvoir couvrant',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12001',
  'Tinting White / Blanc à teinter',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12004',
  'Tinting White / Blanc à teinter',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12101',
  'Green Shade Blue / Bleu verdâtre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12104',
  'Green Shade Blue / Bleu verdâtre',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12201',
  'Red Shade Blue / Bleu rougeâtre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12204',
  'Red Shade Blue / Bleu rougeâtre',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12301',
  'Indo Blue / Bleu indo',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12304',
  'Indo Blue / Bleu indo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12401',
  'Medium Blue / Bleu moyen',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12404',
  'Medium Blue / Bleu moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12501',
  'Medium Aluminum / Aluminium moyen',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12504',
  'Medium Aluminum / Aluminium moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12601',
  'Coarse Aluminum / Aluminium grossier',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12604',
  'Coarse Aluminum / Aluminium grossier',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12701',
  'Medium Bright Aluminium / Aluminium vif moyen',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  307.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12704',
  'Medium Bright Aluminium / Aluminium vif moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  85.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12801',
  'Blue Shade Green / Vert bleuâtre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12804',
  'Blue Shade Green / Vert bleuâtre',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12901',
  'Yellow Shade Green / Vert jaunâtre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M12904',
  'Yellow Shade Green / Vert jaunâtre',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M13201',
  'Perylene Maroon / Marron pérylène',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  363.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M13204',
  'Perylene Maroon / Marron pérylène',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  101.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M13301',
  'Violet / Violet',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M13304',
  'Violet / Violet',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M134NF01',
  'Quindo Violet / Violet quindo',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M134NF04',
  'Quindo Violet / Violet quindo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M13501',
  'Fine Grey Aluminum / Aluminium gris fin',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M13504',
  'Fine Grey Aluminum / Aluminium gris fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1414Z',
  'Red Pearl / Rouge perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1424Z',
  'White Pearl / Blanc perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1434Z',
  'Blue Pearl / Bleu perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1444Z',
  'Green Pearl / Vert perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1454Z',
  'Red Pearl / Rouge perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1464Z',
  'Copper Pearl / Cuivre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M1474Z',
  'Gold Pearl / Or perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M14804',
  'Flatting Agent / Agent de matage',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  64.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M14901',
  'Mixing Clear / Incolore de mélange',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  147.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M15201',
  'Organic Yellow (Lead free) / Jaune organique (sans plomb)',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  397.52,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M15204',
  'Organic Yellow (Lead free) / Jaune organique (sans plomb)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  99.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M15304',
  'Red Shade Yellow (Lead free) / Jaune rougeâtre (sans plomb)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  99.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M15701',
  'Coarse Silver Dollar Aluminum / Aluminium dollar d’argent-grossier',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  267.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M15704',
  'Coarse Silver Dollar Aluminum / Aluminium dollar d’argent-grossier',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  77.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M15804',
  'Micronized White / Blanc microfin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.58,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M551AZ',
  'Silver Diamonds / Diamants argentés',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M552AZ',
  'Gold Diamonds / Diamants dorés',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M553AZ',
  'Russet Diamonds / Diamants roux',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M554AZ',
  'Blue Diamonds / Diamants bleus',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M555AZ',
  'Red Diamonds / Diamants rouges',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M556AZ',
  'Green Diamonds / Diamants verts',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M557AZ',
  'Copper Diamonds / Diamants cuivrés',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M558AZ',
  'Violet Diamonds / Diamants violets',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M56104',
  'Fine White Mica / Mica blanc fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  140.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M57004',
  'Fine Blue Pearl / Bleu fin perle',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M57104',
  'Violet / Violet',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M57304',
  'Maroon / Marron',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  181.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M57504',
  'Blue (Green Shade) / Bleu (ton vert)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M57604',
  'Magenta / Magenta',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  181.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M57704',
  'Transparent Red Oxide / Rouge d''oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M57804',
  'Green (Yellow Shade) / Vert (ton jaune)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M58104',
  'Inorganic Yellow (Green Shade) / Jaune inorganique (ton vert)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  181.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M58204',
  'Red (Blue Shade) / Rouge (ton bleu)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M58304',
  'Blue Aluminum / Aluminium blue',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  233.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M58901',
  'Deep Basecoat Black / Couche de base noire foncé',
  'Basecoat',
  'PPG',
  'gallon',
  350.00,
  0.15,
  360.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59004',
  'Flattening Base / Base à mater',
  'Basecoat',
  'PPG',
  'quart',
  87.50,
  0.15,
  199.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59104',
  'Fine Satin Aluminum / Aluminium fin satiné',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.48,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59204',
  'Fine Bright Aluminum / Aluminium vif fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.48,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59304',
  'Extra Fine Aluminum / Aluminium extrafin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  192.59,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59401',
  'Very Coarse Aluminum / Aluminium très grossier',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  422.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59404',
  'Very Coarse Aluminum / Aluminium très grossier',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59604',
  'Gold Aluminum / Aluminium doré',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  171.96,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59704',
  'Orange Aluminum / Aluminium orange',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  211.19,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59801',
  'Mixing Clear / Incolore de mélange',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  187.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M72801',
  'MTX Converter / Convertisseur  MTX',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  276.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M73601',
  'Compliant Basecoat Converter / Convertisseur de couches de base conforme',
  'Basecoat',
  'PPG',
  'gallon',
  350.00,
  0.15,
  276.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M79901',
  'MBPX Converter / Convertisseur pour MBPX',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  331.34,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MC298001',
  '2.1 VOC EUROPLUS® Clear / Incolore EuroPlus à 2,1 COV',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  117.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MC73001',
  '2.1 VOC Production Clear / Incolore de production à 2,1 COV',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  105.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MC73004',
  '2.1 VOC Production Clear / Incolore de production à 2,1 COV',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  29.45,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MEKP2Z',
  'Polyester Primer Hardener / Durcisseur pour apprêt polyester',
  'Primer',
  'PPG',
  'unit',
  400.00,
  0.15,
  10.30,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH23804',
  'Low VOC Hardener / Durcisseur à faible COV',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  93.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH2388Z',
  'Low VOC Hardener / Durcisseur à faible COV',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  27.83,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH26704',
  'Overall Hardener / Durcisseur de recouvrement',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  79.88,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH2678Z',
  'Overall Hardener / Durcisseur de recouvrement',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  28.25,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH26804',
  '2.1 VOC High Temperature Hardener / Durcisseur à 2,1 COV, pour température élevée',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  75.04,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH298104',
  '2.1 VOC EuroPlus Activator Fast / Activateur EuroPlus à 2,1 COV – rapide',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  54.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH29812L',
  '2.1 VOC EuroPlus Activator Fast / Activateur EuroPlus à 2,1 COV – rapide',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  129.79,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH298204',
  '2.1 VOC EuroPlus Activator Medium / Activateur EuroPlus à 2,1 COV – moyen',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  54.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH298304',
  '2.1 VOC EuroPlus Activator Slow / Activateur EuroPlus à 2,1 COV – lent',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  54.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH73704',
  '2.1 VOC Production Clear Hardener-Low Temperature / 
Durcisseur pour incolore de production à 2,1 COV-pour basse température',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  47.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH73804',
  '2.1 VOC Production Clear Hardener-Medium Temperature / 
Durcisseur pour incolore de production à 2,1 COV-pour température moyenne',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  47.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH7388Z',
  '2.1 VOC Production Clear Hardener-Medium Temperature / 
Durcisseur pour incolore de production à 2,1 COV-pour température moyenne',
  'Clear Coat',
  'PPG',
  'unit',
  300.00,
  0.15,
  17.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH73904',
  '2.1 VOC Production Clear Hardener – High Temperature / Durcisseur pour vernis de production à 2,1 COV - pour température élevée',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  47.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH81004',
  'Multi-Purpose Primer Hardener / Durcisseur à usages multiples',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  59.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH8108Z',
  'Multi-Purpose Primer Hardener / Durcisseur à usages multiples',
  'Primer',
  'PPG',
  'unit',
  400.00,
  0.15,
  21.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP24601',
  'Polyester Primer / Apprêt polyester',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  137.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP80201',
  '2.1 VOC Multi-Purpose Primer / Apprêt à usages multiples 2,1 COV',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  110.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP80204',
  '2.1 VOC Multi-Purpose Primer / Apprêt à usages multiples 2,1 COV',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  31.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP80304',
  '2.1 VOC Multi-Purpose Primer-Black / Apprêt à usages multiples 2,1 COV-noir',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  31.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP87104',
  '2.1 VOC Epoxy Primer-Gray / Apprêt époxy 2,1 COV-gris',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  34.99,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP87508',
  '2.1 VOC Epoxy Hardener / Durcisseur pour époxy 2,1 COV',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  18.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP89104',
  '2.1 VOC Urethane Sealer – White / Produit de scellement 2,1 COV – blanc',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  41.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP89501',
  '2.1 VOC Urethane Sealer – Gray / Produit de scellement 2,1 COV – gris',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  149.81,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP89504',
  '2.1 VOC Urethane Sealer – Gray / Produit de scellement 2,1 COV – gris',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  41.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP89704',
  '2.1 VOC Urethane Sealer – Dark Gray / Produit de scellement 2,1 COV- gris  foncé',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  41.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR29401',
  'Compliant Reducer-Fast / Réducteur conforme-rapide',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  60.82,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR29404',
  'Compliant Reducer-Fast / Réducteur conforme-rapide',
  'Reducer',
  'PPG',
  'quart',
  0.00,
  0.15,
  18.91,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR29501',
  'Compliant Reducer-Medium / Réducteur conforme-moyen',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  83.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR29504',
  'Compliant Reducer-Medium / Réducteur conforme-moyen',
  'Reducer',
  'PPG',
  'quart',
  0.00,
  0.15,
  23.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR29601',
  'Compliant Reducer-Slow / Réducteur conforme-lent',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  85.49,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR29604',
  'Compliant Reducer-Slow / Réducteur conforme-lent',
  'Reducer',
  'PPG',
  'quart',
  0.00,
  0.15,
  23.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR29704',
  'Compliant Retarder / Retardateur conforme',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  38.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MS151PL',
  '0.21 VOC General Purpose Solvent / Solvant universel de 0,21 COV',
  'Reducer',
  'PPG',
  'unit',
  0.00,
  0.15,
  100.13,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MS25001',
  'Compliant Solvent / Solvant conforme au règlement sur les COV',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  43.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MS25101',
  'Multi-Purpose Solvent / Solvant à usages multiples',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  23.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MS251PL',
  'Multi-Purpose Solvent / Solvant à usages multiples',
  'Reducer',
  'PPG',
  'unit',
  0.00,
  0.15,
  79.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MS251DR',
  'Multi-Purpose Solvent / Solvant à usages multiples',
  'Reducer',
  'PPG',
  'unit',
  0.00,
  0.15,
  769.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MX19001',
  'Cleaner / Nettoyant',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  37.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MX190PL',
  'Cleaner / Nettoyant',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  170.31,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MX19201',
  'Plastic Cleaner / Nettoyant pour plastiques',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  53.42,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10204',
  'Drier / Siccatif',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  93.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M10301',
  'Mixing Clear / Incolore de mélange',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  98.04,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'M59901',
  'Basecoat Converter / Convertisseur pour couches de base',
  'Basecoat',
  'PPG',
  'gallon',
  350.00,
  0.15,
  301.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MC27001',
  '4.2 VOC Production Clear / Incolore à haute productivité de 4,2 COV',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  105.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH27604',
  'Production Clear Hardener-Fast / Durcisseur pour incolore de haute productivité-Rapide',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  58.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH27704',
  'Production Clear Hardener-Medium / Durcisseur pour incolore de haute productivité-moyen',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  58.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH27804',
  'Production Clear Hardener-Slow / Durcisseur pour incolore de haute productivité-lent',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  58.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MH28304',
  'Undercoat Hardener / Durcisseur pour apprêt surfaçant',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  49.48,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP17001',
  'Epoxy Primer / Apprêt époxy',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  141.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP17201',
  'Epoxy Primer-Black / Apprêt époxy-noir',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  141.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP17504',
  'Epoxy Primer Catalyst / Catalyseur pour apprêt époxy',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  26.46,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MP28201',
  'SV Hi-Build 2K Primer Surfacer / Apprêt surfaçant 2K à haut pouvoir garnissant SV',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  111.53,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR18601',
  'Medium Reducer / Réducteur moyen',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  47.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MR187PL',
  'Slow Reducer / Réducteur lent',
  'Reducer',
  'PPG',
  'unit',
  0.00,
  0.15,
  232.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'OBTT1002EA',
  'Omni Tint Guide Poster / Guide des colorants Omni',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  5.91,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LV04',
  '100.44',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  169.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LV08',
  '60.24',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  101.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP48LV01',
  '347.02',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  584.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP48LV04',
  '97.09',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  163.45,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP50LV01',
  '347.02',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  584.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP50LV04',
  '97.09',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  163.45,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP90LV01',
  '347.02',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  584.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP90LV04',
  '97.09',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  163.45,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SCA400DZ',
  '27.56',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  46.40,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SL19996Z',
  '53.28',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  89.70,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SL93LV08',
  '78.52',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  132.19,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SLV498504',
  '144.02',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  242.46,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SLV7308',
  '66.07',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  111.23,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SLV81408',
  '109.04',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  183.57,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SLV84004',
  '61.1',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  102.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU128004',
  '268.16',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  451.45,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU470LV01',
  '226.82',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  381.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU470LV04',
  '63.06',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  106.16,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU481LV04',
  '112.7',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  189.73,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU485LV04',
  '112.7',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  189.73,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU487LV04',
  '112.7',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  189.73,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU49016Z',
  '17.66',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU49022Z',
  '18.7',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SU490304',
  '95.53',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  160.82,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SUA1045EZ',
  '33.72',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  56.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SUA1280DZ',
  '102.53',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  172.61,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SUA470LVDZ',
  '40.58',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  68.32,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SUA4903DZ',
  '57.97',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  97.59,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SWX100PL',
  '63.02',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  106.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SWX35001',
  '65.25',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  109.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX10301',
  '91.3',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  153.70,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX10021P',
  '34.07',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  57.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX2070PK',
  '31.86',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX107104',
  '94.37',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  158.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX107204',
  '81.77',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  137.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX32001',
  '75.99',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  127.93,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX33001',
  '80.07',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  134.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX33004',
  '28.16',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  47.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX330PL',
  '391.91',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  659.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX44001',
  '81.57',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  137.32,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX440PL',
  '399.62',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  672.76,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX50104',
  '35.34',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  59.49,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX50301',
  '75.49',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  127.09,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX50304',
  '37.66',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  63.40,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX52004',
  '31.2',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  52.53,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX53301',
  '77.51',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  130.49,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX53304',
  '32.53',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  54.76,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA103DZ',
  '15.69',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  26.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA330EZ',
  '16.95',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  28.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA840DZ',
  '23.93',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  40.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA1030DZ',
  '12.77',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  21.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA1031DZ',
  '28.42',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  47.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA1044DZ',
  '25.43',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  42.81,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA1050DZ',
  '46.32',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  77.98,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SXA9000EZ',
  '18.9',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  31.82,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'OneChoice Not Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Non conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LF01',
  '305.8',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  514.81,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP401LF04',
  '95.91',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  161.46,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DP90LF04',
  '67.27',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  113.25,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX84001',
  '116.76',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  196.57,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Shop-Line Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J01AZ',
  'Silver Diamonds / Diamants argentés',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J02AZ',
  'Gold Diamonds / Diamants dorés',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J03AZ',
  'Russet Diamonds / Diamants roux',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J04AZ',
  'Blue Diamonds / Diamants bleus',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J05AZ',
  'Red Diamonds / Diamants rouges',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J06AZ',
  'Green Diamonds / Diamants verts',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J07AZ',
  'Copper Diamonds / Diamants cuivrés',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J08AZ',
  'Violet Diamonds / Diamants violets',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  81.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J114Z',
  'Fine Russet Mica / Mica roux fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J124Z',
  'Violet Mica / Mica violet',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J134Z',
  'Super Red Mica / Mica super rouge',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J144Z',
  'White Mica / Mica blanc',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J154Z',
  'Blue Mica / Mica bleu',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J164Z',
  'Green Mica / Mica vert',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J174Z',
  'Red Mica / Mica rouge',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J184Z',
  'Copper Mica / Mica cuivre',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J194Z',
  'Gold Mica / Mica or',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  137.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2004',
  'Fine White Pearl / Blanc perle fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  140.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2101',
  'Transparent Yellow Oxide / Jaune d''oxyde transparent',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  201.25,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2104',
  'Transparent Yellow Oxide / Jaune d''oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  56.82,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2201',
  'Gold / Or',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  274.14,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2204',
  'Gold / Or',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  77.63,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2501',
  'Yellow Oxide / Jaune oxyde',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2504',
  'Yellow Oxide / Jaune oxyde',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2601',
  'Red Shade Yellow / Jaune rougeâtre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2604',
  'Red Shade Yellow / Jaune rougeâtre',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2704',
  'Organic Yellow Lead free / Jaune organique sans plomb',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  99.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2804',
  'Red Shade Yellow Lead free / Jaune à ton rouge sans plomb',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  99.89,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J2904',
  'Inorganic Yellow (Green Shade) / Jaune inorganique (ton vert)',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  181.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J3301',
  'Blue Shade Green / Vert bleuâtre',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J3304',
  'Blue Shade Green / Vert bleuâtre',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J3401',
  'Yellow Shade Green / Vert à ton jaune',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J3404',
  'Yellow Shade Green / Vert à ton jaune',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J3504',
  'Phthalo Green Yellow / Vert phtalo jaune',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4101',
  'Green Shade Blue / Bleu à ton vert',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4104',
  'Green Shade Blue / Bleu à ton vert',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4201',
  'Red Shade Blue / Bleu à ton rouge',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4204',
  'Red Shade Blue / Bleu à ton rouge',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4301',
  'Indo Blue / Bleu indo',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4304',
  'Indo Blue / Bleu indo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4401',
  'Medium Blue / Bleu moyen',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4404',
  'Medium Blue / Bleu moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4504',
  'Phthalo Blue (Green Shade) / Bleu phtalo à ton vert',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4704',
  'Blue Aluminum / Aluminium blue',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  233.64,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4901',
  'High Strength Red / Rouge très concentré',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  383.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J4904',
  'High Strength Red / Rouge très concentré',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  106.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5001',
  'Organic Red / Rouge organique',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  363.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5004',
  'Organic Red / Rouge organique',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  101.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5101',
  'Red Oxide / Rouge oxyde',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5104',
  'Red Oxide / Rouge oxyde',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5301',
  'Transparent Red Oxide / Rouge oxyde transparent',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5304',
  'Transparent Red Oxide / Rouge oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Shop-Line Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5601',
  'Perylene Maroon / Marron pérylène',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  363.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5604',
  'Perylene Maroon / Marron pérylène',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  101.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5701',
  'Violet / Violet',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5704',
  'Violet / Violet',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5801',
  'Quindo Violet / Violet quindo',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J5804',
  'Quindo Violet / Violet quindo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J6004',
  'Violet / Violet',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J6204',
  'Perrindo Maroon / Marron perrindo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  181.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J6404',
  'Quindo Magenta / Magenta quindo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  181.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J6504',
  'Transparent Red Oxide / Rouge d''oxyde transparent',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J6604',
  'Quindo Red / Rouge quindo',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J6704',
  'Fine Blue Pearl / Bleu perle fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  148.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J6904',
  'Extra Fine Aluminum / Aluminium extrafin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  192.59,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7001',
  'Medium Aluminum / Aluminium moyen',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7004',
  'Medium Aluminum / Aluminium moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7101',
  'Coarse Aluminum / Aluminium grossier',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7104',
  'Coarse Aluminum / Aluminium grossier',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7201',
  'Medium Bright Aluminium / Aluminium brillant moyen',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  307.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7204',
  'Medium Bright Aluminium / Aluminium brillant moyen',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  85.21,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7301',
  'Fine Gray Aluminum / Gris aluminium fin',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7304',
  'Fine Gray Aluminum / Gris aluminium fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7404',
  'Fine Aluminum / Aluminium fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.48,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7504',
  'Fine Bright Aluminum / Aluminium vif fin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.48,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7601',
  'Very Coarse Aluminum / Aluminium très grossier',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  422.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7604',
  'Very Coarse Aluminum / Aluminium très grossier',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7701',
  'Coarse Silver Dollar Aluminum / Aluminium dollar d’argent grossier',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  267.43,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7704',
  'Coarse Silver Dollar Aluminum / Aluminium dollar d’argent-grossier',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  77.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7804',
  'Gold Aluminum / Aluminium doré',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  171.96,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J7904',
  'Orange Aluminum / Aluminium orange',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  211.19,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8004',
  'Micronized White / Blanc microfin',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  117.58,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8104',
  'Flatting Agent / Agent de matage',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  64.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8204',
  'Flattening Base / Base de matage',
  'Basecoat',
  'PPG',
  'quart',
  87.50,
  0.15,
  199.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8301',
  'Tinting White / Blanc de nuançage',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8304',
  'Tinting White / Blanc de nuançage',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8401',
  'Hi-Hiding White / Blanc à haut pouvoir couvrant',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  183.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8601',
  'Jet Black / Noir de jais',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8701',
  'Tinting Black / Noir de nuançage',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  178.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8704',
  'Tinting Black / Noir de nuançage',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  50.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J8901',
  'Deep Basecoat Black / Couche de base noir profond',
  'Basecoat',
  'PPG',
  'gallon',
  350.00,
  0.15,
  360.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J9401',
  'Mixing Clear / Incolore de mélange',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  147.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J9801',
  'Mixing Clear / Incolore de mélange',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  187.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J10504',
  'Low VOC Basecoat Blender / Fusionneur de couche de base à faible COV',
  'Basecoat',
  'PPG',
  'quart',
  87.50,
  0.15,
  41.33,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J12801',
  'JTX Converter / Convertisseur  JTX',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  276.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J13601',
  'JBX Converter / Convertisseur JBX',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  276.15,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J17901',
  'SHOP-LINE® Plus JBPX Converter / Convertisseur JBPX Shop-Line Plus',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  331.34,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JC720001',
  '2.1 VOC HS European Clearcoat / Incolore Europeén HS à 2,1 COV',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  112.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JC83001',
  '2.1 VOC Production Clearcoat / Incolore de production à 2,1 COV',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  105.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JC83004',
  '2.1 VOC Production Clearcoat / Incolore de production à 2,1 COV',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  29.45,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH35804',
  'Multi-Purpose Primer Hardener / Durcisseur pour apprêt à usages multiples',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  59.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH3588Z',
  'Multi-Purpose Primer Hardener / Durcisseur pour apprêt à usages multiples',
  'Primer',
  'PPG',
  'unit',
  400.00,
  0.15,
  21.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH39708',
  '2.1 VOC Epoxy Hardener / Durcisseur pour époxy 2,1 COV',
  'Hardener',
  'PPG',
  'pint',
  0.00,
  0.15,
  18.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH602804',
  'Low VOC Hardener / Durcisseur à faible COV',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  93.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH60288Z',
  'Low VOC Hardener / Durcisseur à faible COV',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  27.83,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Shop-Line Compliant with VOC Concentration Limits for Automotive Refinishing Product Regulations
Conforme avec le règlement limitant la concentration en composés organiques volatils (COV) des produits de finition automobile',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH71212L',
  '2.1 VOC HS European Multi-Panel Activator / Activateur Européen HS à 2,1 COV, pour panneaux multiples',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  86.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH71312L',
  '2.1 VOC HS European Multi-Panel Activator-High temperature / Activateur Européen HS à 2,1 COV, pour panneaux multiples et température élevée',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  97.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH721004',
  '2.1 VOC European Activator-Fast / Activateur Europeén 2,1 COV-rapide',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  54.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH722004',
  '2.1 VOC European Activator-Slow / Activateur Europeén 2,1 COV-lent',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  54.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH723004',
  '2.1 VOC European Activator-Extra Slow / Activateur Européen à 2,1 COV-ultra‐lent',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  54.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH72302L',
  '2.1 VOC European Activator-Extra Slow / Activateur Européen à 2,1 COV-ultra‐lent',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  129.79,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH787004',
  '2.1 VOC Fast Clear Hardener / Durcisseur pour incolore de 2,1 COV - rapide',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  64.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH788004',
  '2.1 VOC Slow Clear Hardener / Durcisseur pour incolore de 2,1 COV - lent',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  64.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH837004',
  '2.1 VOC Production Clear Hardener – Low Temperature / Durcisseur pour vernis de production à 2,1 COV - pour basse température',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  47.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH838004',
  '2.1 VOC Production Clear Hardener – Medium Temperature / Durcisseur pour vernis de production à 2,1 COV - pour température moyenne',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  47.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH83808Z',
  '2.1 VOC Production Clear Hardener – Medium Temperature / Durcisseur pour vernis de production à 2,1 COV - pour température moyenne',
  'Clear Coat',
  'PPG',
  'unit',
  300.00,
  0.15,
  17.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JH839004',
  '2.1 VOC Production Clear Hardener – High Temperature / Durcisseur pour vernis de production à 2,1 COV - pour température élevée',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  47.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP20901',
  'Gray Polyester Primer-Filler / Apprêt garnissant polyester gris',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  137.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP35404',
  '2.1 VOC Multi-Purpose Primer-White / Apprêt à usages multiples 2,1 COV-blanc',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  31.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP35501',
  '2.1 VOC Multi-Purpose Primer / Apprêt à usages multiples 2,1 COV',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  110.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP35504',
  '2.1 VOC Multi-Purpose Primer / Apprêt à usages multiples 2,1 COV',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  31.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP35604',
  '2.1 VOC Multi-Purpose Primer-Black / Apprêt à usages multiples 2,1 COV-noir',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  31.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP36104',
  '2.1 VOC Urethane Sealer-White / Produit de scellement 2,1 COV-blanc',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  41.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP36501',
  '2.1 VOC Urethane Sealer-Gray / Produit de scellement 2,1 COV-gris',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  149.81,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP36504',
  '2.1 VOC Urethane Sealer-Gray / Produit de scellement 2,1 COV-gris',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  41.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP36704',
  '2.1 VOC Urethane Sealer-Dark Gray / Produit de scellement 2,1 COV-gris foncé',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  41.56,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JP39004',
  '2.1 VOC Epoxy Primer Gray / Apprêt époxy 2,1 COV gris',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  34.99,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JR55401',
  'Low VOC Compliant Reducer-Fast / Réducteur conforme à faible COV - rapide',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  60.82,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JR55404',
  'Low VOC Compliant Reducer-Fast / Réducteur conforme à faible COV - rapide',
  'Reducer',
  'PPG',
  'quart',
  0.00,
  0.15,
  18.91,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JR55501',
  'Low VOC Compliant Reducer-Medium / Réducteur conforme à faible COV - moyen',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  83.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JR55504',
  'Low VOC Compliant Reducer-Medium / Réducteur conforme à faible COV - moyen',
  'Reducer',
  'PPG',
  'quart',
  0.00,
  0.15,
  23.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JR55601',
  'Low VOC Compliant Reducer-Slow / Réducteur conforme à faible COV - lent',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  85.49,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JR55604',
  'Low VOC Compliant Reducer-Slow / Réducteur conforme à faible COV - lent',
  'Reducer',
  'PPG',
  'quart',
  0.00,
  0.15,
  23.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JR55704',
  'Low VOC Compliant Retarder / Retardateur conforme à faible teneur en COV',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  38.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JT50101',
  'General Purpose Solvent / Solvant tout usage',
  'Reducer',
  'PPG',
  'gallon',
  0.00,
  0.15,
  23.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JT501PL',
  'General Purpose Solvent / Solvant tout usage',
  'Reducer',
  'PPG',
  'unit',
  0.00,
  0.15,
  79.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JT51001',
  'Acetone / Acétone',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  23.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JT510PL',
  'Acetone / Acétone',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  90.19,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JX10101',
  'Wax and Grease Remover / Décapant pour cire et graisse',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  37.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JX101PL',
  'Wax and Grease Remover / Décapant pour cire et graisse',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  170.31,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MEKP2Z',
  'Polyester Primer Hardener / Durcisseur pour apprêt polyester',
  'Primer',
  'PPG',
  'unit',
  400.00,
  0.15,
  10.30,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J9204',
  'Enamel Drier / Siccatif émail',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  93.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'J9301',
  'Enamel Mixing Clear / Incolore de mélange',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  98.04,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JMIX65KT',
  'Dedoes 1.7M Alliance (White) for JBPX System (Includes Base, Motor, 1-Gal and 3 Qt Shelves, Header / Pearl Rack, 6-Gal and 36-Qt Lids) / Machine Alliance de 1,7 m Dedoes de couleur blanche pour le système JBPX. Comprend  moteur de base, 1 étagère pour gal',
  'Basecoat',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JMIX88KT',
  'Dedoes 2.4M Alliance (White) for all Intermix qualities (Includes Base, Motor, 4-Gal and 1-Qt Shelves, Header / Pearl Rack, 36-Gal and 8-Qt Lids) / Machine Alliance de 2,4 m Dedoes de couleur blanche pour toutes les qualités de produits composés. Comprend',
  'Basecoat',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JMIX88QKT',
  'Dedoes 2.4M Alliance (White) for all Intermix Qualities / Machine Alliance 2,4 m de couleur blanche pour toutes les qualités de produits composés',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SLTT1002EA',
  'Shop-Line Tint Guide Poster / Guide des colorants Shop-Line',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110A/01',
  '70.29',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110B/01',
  '97.46',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110C/01',
  '138.14',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110A/PL',
  '337.04',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110B/PL',
  '472.99',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110C/PL',
  '676.42',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110A/DR',
  '3424.07',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110B/DR',
  '4610.22',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-110C/DR',
  '6654.85',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200A/01',
  '68.45',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200B/01',
  '94.34',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200C/01',
  '134.09',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200A/PL',
  '327.35',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200B/PL',
  '457.24',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200C/PL',
  '653.92',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200A/DR',
  '3122.47',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200B/DR',
  '4420.12',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-200C/DR',
  '6373.22',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EA/01',
  '89.95',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EB/01',
  '102.81',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EC/01',
  '131.24',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EA/PL',
  '436.34',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EB/PL',
  '496.27',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EC/PL',
  '638.68',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EA/DR',
  '4229.42',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EB/DR',
  '4833.76',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ALK-300EC/DR',
  '6263.36',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100ASF/01',
  '74.88',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100BSF/01',
  '94.99',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100CSF/01',
  '119.94',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100ASF/PL',
  '287.14',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100BSF/PL',
  '367.11',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100CSF/PL',
  '466.91',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100A/01',
  '85.58',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100B/01',
  '108.56',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100C/01',
  '137.08',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100A/PL',
  '410.15',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100B/PL',
  '524.47',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100C/PL',
  '666.99',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100A/DR',
  '3974.53',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100B/DR',
  '5128.69',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-100C/DR',
  '6550.34',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300ASF/01',
  '71.03',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300BSF/01',
  '91.57',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300CSF/01',
  '111.81',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300ASF/PL',
  '275.94',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300BSF/PL',
  '358',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300CSF/PL',
  '439.66',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300A/01',
  '101.02',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300B/01',
  '130.24',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300C/01',
  '159.03',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300A/PL',
  '491.02',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300B/PL',
  '636.72',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300C/PL',
  '781.66',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300A/DR',
  '4765.21',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300B/DR',
  '6218.71',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-300C/DR',
  '7672.19',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360A/01',
  '129.92',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360B/01',
  '144.09',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360C/01',
  '171.62',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360A/PL',
  '636.47',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360B/PL',
  '708.38',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360C/PL',
  '845.26',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360A/DR',
  '6239.22',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360B/DR',
  '6962.46',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360C/DR',
  '8326.09',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDA/01',
  '161.29',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDB/01',
  '176.08',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDC/01',
  '204.62',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDA/PL',
  '796.51',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDB/PL',
  '870.55',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDC/PL',
  '1011',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDA/DR',
  '7839.99',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDB/DR',
  '8582.2',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-360UDC/DR',
  '9987.04',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370A/01',
  '141.35',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370B/01',
  '157.31',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370C/01',
  '187.07',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370A/PL',
  '694.23',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370B/PL',
  '773.21',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370C/PL',
  '922.19',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370A/DR',
  '6826.46',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370B/DR',
  '7617.23',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-370C/DR',
  '9109.09',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370A/01',
  '92.33',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370B/01',
  '113.05',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370C/01',
  '124.99',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370A/PL',
  '447.95',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370B/PL',
  '551.13',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370C/PL',
  '612.24',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370A/DR',
  '4340.85',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370B/DR',
  '5376.31',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'EPE-370C/DR',
  '5991.43',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380A/01',
  '127.55',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380B/01',
  '142.84',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380C/01',
  '170.21',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380A/PL',
  '626.48',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380B/PL',
  '702.09',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380C/PL',
  '839.09',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380A/DR',
  '6160.02',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380B/DR',
  '6916.65',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AUE-380C/DR',
  '8288.23',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  0.00,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21008',
  'RADIANCE® II Yellow / Jaune',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  199.98,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21108',
  'Radiance II Orange / Orange',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  197.96,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21208',
  'Radiance II Red (yellow shade) / Rouge (ton jaune)',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  237.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21308',
  'Radiance II Red (blue shade) / Rouge (ton bleu)',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  252.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21408',
  'Radiance II Red Violet / Rouge violet',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  209.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21508',
  'Radiance II Violet / Violet',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  147.41,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21608',
  'Radiance II Blue (green shade) / Bleu (ton-vert)',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  180.75,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21708',
  'Radiance II Green / Vert',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  192.73,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21808',
  'Radiance II Brown / Brun',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  163.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX21908',
  'Radiance II Black / Noir',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  141.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DMX22008',
  'Radiance II Blue (red shade) / Bleu (rougeâtre)',
  'Paint',
  'PPG',
  'pint',
  43.75,
  0.15,
  254.23,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DSC5250KT',
  'DITZLER® Satin Clear Kit  /  Trousse d''incolore satiné Ditzler',
  'Clear Coat',
  'PPG',
  'unit',
  300.00,
  0.15,
  185.34,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DX578Z',
  'Basecoat Activator / Activateur pour couche de base',
  'Hardener',
  'PPG',
  'unit',
  0.00,
  0.15,
  80.20,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DX784Z',
  'PRIZMATIQUE® / Prizmatique',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  182.59,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'HRB9700KT',
  'Ditzler Hot Rod Black Kit / Noir hot rod-trousse Ditzler',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  122.70,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL876Z',
  'Fine Blue Pearl / Bleu perle fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL886Z',
  'Orange Pearl / Orange perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL896Z',
  'Violet Pearl / Violet perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL906Z',
  'Sunset Red Pearl / Rouge coucher de soleil perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL916Z',
  'Green Pearl / Vert perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL926Z',
  'Frost Blue Pearl / Bleu givre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL936Z',
  'Tincture Gold Pearl / Teinture d''or perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL956Z',
  'Bright White Pearl / Blanc fif perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL966Z',
  'Russet Pearl / Brun roux perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL976Z',
  'Copper Pearl / Cuivre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL986Z',
  'Fine White Pearl / Blanc perle fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRL996Z',
  'Fine Russet Pearl / Brun roux perle fin',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  256.62,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX14Z',
  'CRYSTAL PEARL® Red Pearl / Rouge perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX24Z',
  'Crystal Pearl Silver Pearl / Argent perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX34Z',
  'Crystal Pearl Gold Pearl / Or perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX44Z',
  'Crystal Pearl Blue Pearl / Bleu perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX54Z',
  'Crystal Pearl Green Pearl / Vert perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX64Z',
  'Crystal Pearl Frost Red Pearl / Rouge givre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX74Z',
  'Crystal Pearl Copper Pearl / Cuivre perle',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX84Z',
  'Crystal Pearl Cosmic Turquoise / Turquoise cosmique',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PRLX94Z',
  'Crystal Pearl Amethyst Dream / Rêve d’améthyste',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  389.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VC570001',
  'Ditzler Custom Clear / Incolore personnalisé Ditzler',
  'Clear Coat',
  'PPG',
  'gallon',
  300.00,
  0.15,
  333.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VH705004',
  'DTM High Build Primer Catalyst / Catalyseur pour apprêt à haut pouvoir garnissant DTM',
  'Primer',
  'PPG',
  'quart',
  100.00,
  0.15,
  69.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VH778004',
  'Ditzler Custom Clear Hardener / Durcisseur pour incolore personnalisé  Ditzler',
  'Clear Coat',
  'PPG',
  'quart',
  75.00,
  0.15,
  136.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VH779504',
  'High Temperature Hardener / Durcisseur à haute température',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  136.36,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41414Z',
  'FLAMBOYANCE® White / Blanc',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  372.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41424Z',
  'Flamboyance Gold / Or',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  372.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41434Z',
  'Flamboyance Red / Rouge',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  372.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41444Z',
  'Flamboyance Violet / Violet',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  372.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41454Z',
  'Flamboyance Blue / Bleu',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  372.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41464Z',
  'Flamboyance Green / Vert',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  372.07,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41624Z',
  'Viola Fantasy / Fantaisie viola',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  489.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41644Z',
  'Arctic Fire / Feu arctique',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  489.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM41654Z',
  'Tropic Sunrise / Lever de soleil tropical',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  489.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM43508Z',
  'Vivid Ruby Tinter / Colorant rubis vif (4oz fill / rempli)',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  233.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44014Z',
  'Ditzler BIG FLAKE™ Gold / Or',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  58.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44024Z',
  'Ditzler Big Flake Silver / Argent',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  58.12,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44204Z',
  'Ditzler Big Flake Mini Gold / Minipaillettes or',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.71,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44214Z',
  'Ditzler Big Flake Mini Silver / Minipaillettes argent',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.71,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44224Z',
  'Ditzler Big Flake Red / Paillettes rouges',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.71,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44234Z',
  'Ditzler Big Flake Orange / Paillettes orange',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.71,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44244Z',
  'Ditzler Big Flake Blue / Paillettes bleues',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.71,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44254Z',
  'Ditzler Big Flake Purple / Paillettes violettes',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.71,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM44264Z',
  'Ditzler Big Flake Green / Paillettes vertes',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.71,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM45012Z',
  'CRYSTALLANCE® Silver / Argent',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  144.23,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM45022Z',
  'Crystallance Sapphire / Saphir',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  127.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM45032Z',
  'Crystallance Jade / Jade',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  127.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM45042Z',
  'Crystallance Garnet / Grenat',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  127.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM45052Z',
  'Crystallance Topaz / Topaze',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  127.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VM45062Z',
  'Crystallance Opal / Opale',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  127.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VP205001',
  'DTM High Build Primer / Apprêt à haut pouvoir garnissant DTM',
  'Primer',
  'PPG',
  'gallon',
  400.00,
  0.15,
  182.55,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VWM50004',
  'Custom Midcoat / Couche intermédiaire personnalisé',
  'Paint',
  'PPG',
  'quart',
  87.50,
  0.15,
  129.08,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VWM55561L',
  'Waterborne Midcoat / Couche intermédiaire',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  157.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464PK',
  'Associated Products ARMC464PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G1PK',
  'Associated Products ARMC464G1PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G3PK',
  'Associated Products ARMC464G3PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G5PK',
  'Associated Products ARMC464G5PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G6PK',
  'Associated Products ARMC464G6PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'ARMC464G7PK',
  'Associated Products ARMC464G7PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.22,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX510EA',
  'Associated Products DEX510EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  503.38,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG1BX',
  'Associated Products DEXG1BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG3BX',
  'Associated Products DEXG3BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG5BX',
  'Associated Products DEXG5BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG6BX',
  'Associated Products DEXG6BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEXG7BX',
  'Associated Products DEXG7BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  30.05,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1448EA',
  'Associated Products DEX1448EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  28.90,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX109BX',
  'Associated Products DOX109BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  116.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX113PK',
  'Associated Products DOX113PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  18.61,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX125PK',
  'Associated Products DOX125PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  20.14,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX257EA',
  'Associated Products DOX257EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  24.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX384PK',
  'Associated Products DOX384PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  104.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX526PK',
  'Associated Products DOX526PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  118.73,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOXWFGEA',
  'Associated Products DOXWFGEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  2.85,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX2070PK',
  'Associated Products SX2070PK',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  31.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX137EA',
  'Associated Products DOX137EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  0.28,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX244BX',
  'Associated Products DOX244BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  59.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX249BX',
  'Associated Products DOX249BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  37.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX249LBX',
  'Associated Products DOX249LBX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  14.61,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX251BX',
  'Associated Products DOX251BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  44.96,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX251LBX',
  'Associated Products DOX251LBX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  29.99,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX252BX',
  'Associated Products DOX252BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  55.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX273BX',
  'Associated Products DOX273BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.34,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX273LBX',
  'Associated Products DOX273LBX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  16.65,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX318EA',
  'Associated Products DOX318EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  3.20,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX337EA',
  'Associated Products DOX337EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  1.81,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX339EA',
  'Associated Products DOX339EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  1.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX382EA',
  'Associated Products DOX382EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  3.17,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX345EA',
  'Associated Products DOX345EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  4.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '920-121BX',
  '30',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  116.61,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '920-2202BX',
  '32',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  110.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '920-2475BX',
  '15',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  133.75,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '935EA',
  '84',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  9.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '935LEA',
  '84',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  4.38,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '945EA',
  '84',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  9.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '945LEA',
  '84',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  4.57,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX468EA',
  'Associated Products DOX468EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  3.47,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX530EA',
  'Associated Products DOX530EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  12.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX540EA',
  'Associated Products DOX540EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  12.97,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOXPAILBX',
  'Associated Products DOXPAILBX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  54.75,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'KPAKGALBX',
  '12',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  138.69,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'KPAKQTBX',
  '30',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  112.77,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'KPAKPTBX',
  '30',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  70.70,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX326EA',
  'Associated Products DEX326EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  632.46,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX333EA',
  'Associated Products DEX333EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  916.20,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX374EA',
  'Associated Products DEX374EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  390.63,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX403EA',
  'Associated Products DEX403EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  1284.11,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX406EA',
  'Associated Products DEX406EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  244.48,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX412EA',
  'Associated Products DEX412EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  6.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX602EA',
  'Associated Products DEX602EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  85.23,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX603EA',
  'Associated Products DEX603EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  255.68,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX610EA',
  'Associated Products DEX610EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  27.92,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX620EA',
  'Associated Products DEX620EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  19.72,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX640EA',
  'Associated Products DEX640EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  75.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1701EA',
  'Associated Products DEX1701EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  333.80,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1702EA',
  'Associated Products DEX1702EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  1207.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1703EA',
  'Associated Products DEX1703EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  14.58,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1704EA',
  'Associated Products DEX1704EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  376.44,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1706EA',
  'Associated Products DEX1706EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  68.39,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1707EA',
  'Associated Products DEX1707EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  91.27,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1811EA',
  'Associated Products DEX1811EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  14.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1814EA',
  'Associated Products DEX1814EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  11.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1901EA',
  'Associated Products DEX1901EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  276.98,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1904EA',
  'Associated Products DEX1904EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  319.60,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1905EA',
  'Associated Products DEX1905EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  56.83,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1906EA',
  'Associated Products DEX1906EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  61.59,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1907EA',
  'Associated Products DEX1907EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  85.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX1911EA',
  'Associated Products DEX1911EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  14.66,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JMIX65KT',
  'Associated Products JMIX65KT',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  2678.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JMIX88KT',
  'Associated Products JMIX88KT',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  3743.51,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'JMIX88QKT',
  'Associated Products JMIX88QKT',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  3352.87,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '8812-414EA',
  'Associated Products 8812-414EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  11.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX1066BX',
  'Associated Products SX1066BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  267.49,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX1068BX',
  'Associated Products SX1068BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  40.16,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SX1069BX',
  'Associated Products SX1069BX',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  34.10,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX258EA',
  'Associated Products DOX258EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  816.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX259EA',
  'Associated Products DOX259EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  116.67,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX272EA',
  'Associated Products DEX272EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  191.74,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DEX273EA',
  'Associated Products DEX273EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  595.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX446EA',
  'Associated Products DOX446EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  9.54,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX5566EA',
  'Associated Products DOX5566EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  37.34,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'DOX313EA',
  'Associated Products DOX313EA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  14.40,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '2PCPS2XEA',
  'Associated Products 2PCPS2XEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  54.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '2PCPS3XEA',
  'Associated Products 2PCPS3XEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  54.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '2PCPSLEA',
  'Associated Products 2PCPSLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  54.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '2PCPSMEA',
  'Associated Products 2PCPSMEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  54.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '2PCPSSEA',
  'Associated Products 2PCPSSEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  54.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  '2PCPSXLEA',
  'Associated Products 2PCPSXLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  54.50,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'BLUEPSLEA',
  'Associated Products BLUEPSLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'BLUEPSMEA',
  'Associated Products BLUEPSMEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'BLUEPSSEA',
  'Associated Products BLUEPSSEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'BLUEPSXSEA',
  'Associated Products BLUEPSXSEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'BLUEPSXLEA',
  'Associated Products BLUEPSXLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'BLUEPSXXLEA',
  'Associated Products BLUEPSXXLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'BLUEPSXXXLEA',
  'Associated Products BLUEPSXXXLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WHITEPSXSEA',
  'Associated Products WHITEPSXSEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WHITEPSSEA',
  'Associated Products WHITEPSSEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WHITEPSMEA',
  'Associated Products WHITEPSMEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WHITEPSLEA',
  'Associated Products WHITEPSLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WHITEPSXLEA',
  'Associated Products WHITEPSXLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WHITEPSXXLEA',
  'Associated Products WHITEPSXXLEA',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  45.29,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MD13-250CS',
  'Associated Products MD13-250CS',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  44.86,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MD15-250CS',
  'Associated Products MD15-250CS',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  46.26,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'MD33-300CS',
  'Associated Products MD33-300CS',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  35.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'AL84-0314CS',
  'Associated Products AL84-0314CS',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  269.01,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP3012BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  47.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP3018BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  47.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP3036BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  47.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP306BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  47.84,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP3512BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  43.38,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP3518BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  43.38,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP3536BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  42.18,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP4012BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  42.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP4018BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  42.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP4036BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  42.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'GMP406BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  42.95,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PM12400RL',
  '42',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  32.52,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PM16350RL',
  '42',
  'Paint',
  'PPG',
  'pint',
  21.88,
  0.15,
  40.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'PM16350BRL',
  '42',
  'Paint',
  'PPG',
  'pint',
  21.88,
  0.15,
  56.52,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'VRW100BX',
  '110',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  79.37,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WMP2412BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  71.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WMP2418BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  71.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WMP2436BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  71.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'WMP246BX',
  '54',
  'Paint',
  'PPG',
  'unit',
  350.00,
  0.15,
  71.94,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SC31001',
  '2.1 VOC Polyurethane High Gloss / polyuréthane très brillant de 2,1 COV',
  'Paint',
  'PPG',
  'gallon',
  350.00,
  0.15,
  61.83,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SH31104',
  '2.1 Fast Hardener / durcisseur rapide 2,1',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  39.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SH31204',
  '2.1 Slow Hardener / durcisseur lent 2,1',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  39.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();
INSERT INTO products (
  sku, name, category, supplier, unit_type, 
  coverage_sqft_per_unit, waste_factor, unit_cost, 
  lead_time_days, created_at, updated_at
) VALUES (
  'SH31304',
  '2.1 Extra Slow Hardener / durcisseur ultra lent 2,1',
  'Hardener',
  'PPG',
  'quart',
  0.00,
  0.15,
  39.78,
  7,
  NOW(),
  NOW()
) ON CONFLICT (sku) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  unit_cost = EXCLUDED.unit_cost,
  updated_at = NOW();