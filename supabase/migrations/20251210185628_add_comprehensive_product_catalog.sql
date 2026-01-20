/*
  # Comprehensive Auto Body Shop Product Catalog

  Expands product inventory to include all major categories for auto body repair:
  
  1. Paint and Refinishing Materials
    - Base coats, clear coats, primers in various colors
    - Thinners, reducers, hardeners
    - Sandpaper and abrasives
    - Masking supplies
    - Polishing compounds
  
  2. Body Repair Materials
    - Body fillers (Bondo, etc.)
    - Fiberglass kits
    - Adhesives, sealers
    - Rust treatment
  
  3. Replacement Parts
    - Body panels, lights, glass
    - Trim and hardware
  
  4. Tools and Equipment Supplies
    - Consumable tool supplies
    - Safety equipment
  
  5. Fasteners and Hardware
    - Clips, bolts, rivets
  
  6. Shop Consumables
    - Cleaning supplies
    - Shop towels
    - Mixing supplies
*/

-- Paint and Refinishing Materials (expanded)
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  -- Additional base coat colors
  ('PPG-BASE-GRY-01', 'PPG Base Coat - Gray', 'Base Coat', 'gallon', 400, 0.15, 130.00, 'PPG', 5),
  ('PPG-BASE-BRN-01', 'PPG Base Coat - Brown', 'Base Coat', 'gallon', 400, 0.15, 135.00, 'PPG', 5),
  ('PPG-BASE-GRN-01', 'PPG Base Coat - Green', 'Base Coat', 'gallon', 400, 0.15, 135.00, 'PPG', 5),
  ('PPG-BASE-YEL-01', 'PPG Base Coat - Yellow', 'Base Coat', 'gallon', 400, 0.16, 140.00, 'PPG', 5),
  ('PPG-BASE-GLD-01', 'PPG Base Coat - Gold Metallic', 'Base Coat', 'gallon', 380, 0.18, 150.00, 'PPG', 5),
  ('SW-BASE-BLK-01', 'Sherwin Williams Base - Black', 'Base Coat', 'gallon', 390, 0.16, 125.00, 'Sherwin Williams', 7),
  ('SW-BASE-SIL-01', 'Sherwin Williams Base - Silver', 'Base Coat', 'gallon', 380, 0.18, 140.00, 'Sherwin Williams', 7),
  ('AXL-BASE-WHT-01', 'Axalta Base Coat - White', 'Base Coat', 'gallon', 395, 0.15, 128.00, 'Axalta', 6),
  ('AXL-BASE-RED-01', 'Axalta Base Coat - Red', 'Base Coat', 'gallon', 395, 0.15, 138.00, 'Axalta', 6),
  
  -- Primers (expanded)
  ('PPG-PRIMER-03', 'PPG High-Build Primer', 'Primer', 'gallon', 280, 0.12, 72.00, 'PPG', 5),
  ('SW-PRIMER-01', 'Sherwin Williams Epoxy Primer', 'Primer', 'gallon', 340, 0.11, 78.00, 'Sherwin Williams', 7),
  ('AXL-PRIMER-01', 'Axalta Sealer Primer', 'Primer', 'gallon', 330, 0.10, 68.00, 'Axalta', 6),
  
  -- Clear coats (expanded)
  ('SW-CLEAR-02', 'Sherwin Williams Clear Coat - High Gloss', 'Clear Coat', 'gallon', 460, 0.12, 98.00, 'Sherwin Williams', 7),
  ('AXL-CLEAR-01', 'Axalta Clear Coat - Premium', 'Clear Coat', 'gallon', 445, 0.13, 92.00, 'Axalta', 6),
  ('PPG-CLEAR-02', 'PPG Clear Coat - Matte Finish', 'Clear Coat', 'gallon', 420, 0.14, 102.00, 'PPG', 5)
ON CONFLICT (sku) DO NOTHING;

-- Thinners, Reducers, Hardeners
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('UNIV-HARDENER-02', 'Fast-Dry Hardener', 'Hardener', 'quart', 200, 0.05, 38.00, 'Various', 3),
  ('UNIV-HARDENER-03', 'Slow-Dry Hardener', 'Hardener', 'quart', 200, 0.05, 36.00, 'Various', 3),
  ('UNIV-REDUCER-02', 'Fast Reducer', 'Reducer', 'gallon', 500, 0.08, 28.00, 'Various', 3),
  ('UNIV-REDUCER-03', 'Slow Reducer', 'Reducer', 'gallon', 500, 0.08, 27.00, 'Various', 3),
  ('PPG-REDUCER-01', 'PPG Universal Reducer', 'Reducer', 'gallon', 500, 0.07, 32.00, 'PPG', 5)
ON CONFLICT (sku) DO NOTHING;

-- Sandpaper and Abrasives
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('SAND-80-SHEET', 'Sandpaper 80 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.50, 'Various', 2),
  ('SAND-120-SHEET', 'Sandpaper 120 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.50, 'Various', 2),
  ('SAND-180-SHEET', 'Sandpaper 180 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.50, 'Various', 2),
  ('SAND-220-SHEET', 'Sandpaper 220 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.55, 'Various', 2),
  ('SAND-320-SHEET', 'Sandpaper 320 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.55, 'Various', 2),
  ('SAND-400-SHEET', 'Sandpaper 400 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.60, 'Various', 2),
  ('SAND-600-SHEET', 'Sandpaper 600 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.60, 'Various', 2),
  ('SAND-800-SHEET', 'Sandpaper 800 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.65, 'Various', 2),
  ('SAND-1000-SHEET', 'Sandpaper 1000 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.70, 'Various', 2),
  ('SAND-1500-SHEET', 'Sandpaper 1500 Grit', 'Abrasives', 'sheet', 0, 0.20, 0.75, 'Various', 2),
  ('SAND-DISC-80', 'Sanding Disc 80 Grit - 6in', 'Abrasives', 'disc', 0, 0.25, 1.20, 'Various', 2),
  ('SAND-DISC-120', 'Sanding Disc 120 Grit - 6in', 'Abrasives', 'disc', 0, 0.25, 1.20, 'Various', 2),
  ('SAND-DISC-220', 'Sanding Disc 220 Grit - 6in', 'Abrasives', 'disc', 0, 0.25, 1.25, 'Various', 2)
ON CONFLICT (sku) DO NOTHING;

-- Masking Supplies
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('MASK-TAPE-1IN', 'Masking Tape 1 inch', 'Masking Supplies', 'roll', 0, 0.15, 4.50, 'Various', 2),
  ('MASK-TAPE-2IN', 'Masking Tape 2 inch', 'Masking Supplies', 'roll', 0, 0.15, 6.00, 'Various', 2),
  ('MASK-PAPER-12IN', 'Masking Paper 12 inch', 'Masking Supplies', 'roll', 0, 0.10, 12.00, 'Various', 2),
  ('MASK-PAPER-18IN', 'Masking Paper 18 inch', 'Masking Supplies', 'roll', 0, 0.10, 16.00, 'Various', 2),
  ('MASK-PLASTIC-9FT', 'Masking Plastic 9ft', 'Masking Supplies', 'roll', 0, 0.10, 18.00, 'Various', 2),
  ('FINE-LINE-TAPE', 'Fine Line Tape', 'Masking Supplies', 'roll', 0, 0.12, 8.00, 'Various', 2)
ON CONFLICT (sku) DO NOTHING;

-- Polishing and Buffing
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('POLISH-CUT', 'Cutting Compound', 'Polishing', 'quart', 0, 0.10, 15.00, 'Various', 3),
  ('POLISH-FINISH', 'Finishing Polish', 'Polishing', 'quart', 0, 0.10, 16.00, 'Various', 3),
  ('BUFF-PAD-CUT', 'Cutting Buffing Pad', 'Polishing', 'pad', 0, 0.05, 12.00, 'Various', 3),
  ('BUFF-PAD-POLISH', 'Polishing Buffing Pad', 'Polishing', 'pad', 0, 0.05, 12.00, 'Various', 3),
  ('BUFF-PAD-FINISH', 'Finishing Buffing Pad', 'Polishing', 'pad', 0, 0.05, 12.00, 'Various', 3)
ON CONFLICT (sku) DO NOTHING;

-- Body Repair Materials
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('BONDO-REG', 'Bondo Body Filler - Regular', 'Body Filler', 'gallon', 0, 0.15, 35.00, 'Bondo', 5),
  ('BONDO-LITE', 'Bondo Body Filler - Lightweight', 'Body Filler', 'quart', 0, 0.15, 22.00, 'Bondo', 5),
  ('BONDO-GLASS', 'Bondo Fiberglass Resin', 'Body Filler', 'quart', 0, 0.15, 28.00, 'Bondo', 5),
  ('FIBER-CLOTH', 'Fiberglass Cloth', 'Body Filler', 'yard', 0, 0.10, 8.00, 'Various', 5),
  ('FIBER-MAT', 'Fiberglass Mat', 'Body Filler', 'yard', 0, 0.10, 6.00, 'Various', 5),
  ('PANEL-ADHESIVE', 'Panel Bonding Adhesive', 'Adhesives', 'tube', 0, 0.08, 45.00, 'Various', 5),
  ('SEAM-SEALER', 'Seam Sealer', 'Sealers', 'tube', 0, 0.10, 12.00, 'Various', 3),
  ('UNDERCOAT-BLACK', 'Rubberized Undercoating', 'Undercoating', 'can', 0, 0.12, 18.00, 'Various', 5),
  ('RUST-CONV', 'Rust Converter', 'Rust Treatment', 'quart', 0, 0.10, 22.00, 'Various', 5),
  ('RUST-PRIMER', 'Rust Inhibiting Primer', 'Rust Treatment', 'quart', 0, 0.12, 24.00, 'Various', 5)
ON CONFLICT (sku) DO NOTHING;

-- Replacement Parts (sample inventory items)
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('BUMPER-F-UNI', 'Front Bumper Cover - Universal', 'Body Panels', 'piece', 0, 0, 250.00, 'Various', 14),
  ('BUMPER-R-UNI', 'Rear Bumper Cover - Universal', 'Body Panels', 'piece', 0, 0, 220.00, 'Various', 14),
  ('FENDER-F-UNI', 'Front Fender - Universal', 'Body Panels', 'piece', 0, 0, 180.00, 'Various', 14),
  ('HOOD-UNI', 'Hood - Universal', 'Body Panels', 'piece', 0, 0, 300.00, 'Various', 14),
  ('DOOR-F-UNI', 'Front Door Shell - Universal', 'Body Panels', 'piece', 0, 0, 350.00, 'Various', 14),
  ('HEADLIGHT-UNI', 'Headlight Assembly - Universal', 'Lights', 'piece', 0, 0, 120.00, 'Various', 7),
  ('TAILLIGHT-UNI', 'Taillight Assembly - Universal', 'Lights', 'piece', 0, 0, 95.00, 'Various', 7),
  ('MIRROR-SIDE', 'Side Mirror Assembly - Universal', 'Mirrors', 'piece', 0, 0, 75.00, 'Various', 7),
  ('WINDSHIELD-UNI', 'Windshield Glass - Universal', 'Glass', 'piece', 0, 0, 250.00, 'Glass Supplier', 7),
  ('GRILLE-UNI', 'Front Grille - Universal', 'Trim', 'piece', 0, 0, 85.00, 'Various', 10)
ON CONFLICT (sku) DO NOTHING;

-- Fasteners and Hardware
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('CLIP-BODY-ASST', 'Body Panel Clips - Assorted', 'Fasteners', 'pack', 0, 0.10, 15.00, 'Various', 5),
  ('CLIP-TRIM-ASST', 'Trim Clips - Assorted', 'Fasteners', 'pack', 0, 0.10, 12.00, 'Various', 5),
  ('BOLT-ASST', 'Bolts Assortment Kit', 'Fasteners', 'kit', 0, 0.05, 35.00, 'Various', 5),
  ('NUT-ASST', 'Nuts Assortment Kit', 'Fasteners', 'kit', 0, 0.05, 25.00, 'Various', 5),
  ('RIVET-ASST', 'Pop Rivets - Assorted', 'Fasteners', 'pack', 0, 0.15, 18.00, 'Various', 5),
  ('WIRE-CONN', 'Wire Connectors - Assorted', 'Fasteners', 'pack', 0, 0.10, 12.00, 'Various', 3)
ON CONFLICT (sku) DO NOTHING;

-- Shop Consumables
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('SOLVENT-CLEAN', 'Panel Cleaning Solvent', 'Cleaning', 'gallon', 0, 0.15, 22.00, 'Various', 3),
  ('DEGREASER', 'Heavy Duty Degreaser', 'Cleaning', 'gallon', 0, 0.15, 18.00, 'Various', 3),
  ('TOWEL-SHOP', 'Shop Towels - Blue', 'Consumables', 'roll', 0, 0.20, 15.00, 'Various', 2),
  ('RAG-TACK', 'Tack Cloths', 'Consumables', 'pack', 0, 0.10, 8.00, 'Various', 2),
  ('CUP-MIX-16OZ', 'Mixing Cups 16oz', 'Consumables', 'pack', 0, 0.05, 12.00, 'Various', 2),
  ('CUP-MIX-32OZ', 'Mixing Cups 32oz', 'Consumables', 'pack', 0, 0.05, 15.00, 'Various', 2),
  ('STICK-MIX', 'Mixing Sticks', 'Consumables', 'pack', 0, 0.05, 5.00, 'Various', 2),
  ('FILTER-SPRAY', 'Spray Booth Filters', 'Consumables', 'pack', 0, 0, 45.00, 'Various', 7),
  ('FILTER-PAINT', 'Paint Strainers', 'Consumables', 'pack', 0, 0.10, 8.00, 'Various', 3)
ON CONFLICT (sku) DO NOTHING;

-- Safety Equipment (consumable safety supplies)
INSERT INTO products (sku, name, category, unit_type, coverage_sqft_per_unit, waste_factor, unit_cost, supplier, lead_time_days) VALUES
  ('MASK-RESP', 'Respirator Filters', 'Safety', 'pair', 0, 0, 18.00, 'Various', 5),
  ('GLOVE-NITRILE', 'Nitrile Gloves - Large', 'Safety', 'box', 0, 0.15, 12.00, 'Various', 3),
  ('GLOVE-LATEX', 'Latex Gloves - Large', 'Safety', 'box', 0, 0.15, 10.00, 'Various', 3),
  ('SUIT-PAINT', 'Disposable Paint Suit', 'Safety', 'suit', 0, 0, 8.00, 'Various', 5),
  ('GLASSES-SAFETY', 'Safety Glasses', 'Safety', 'pair', 0, 0, 5.00, 'Various', 3)
ON CONFLICT (sku) DO NOTHING;

SELECT 'Product catalog expanded with ' || COUNT(*) || ' total products' FROM products;