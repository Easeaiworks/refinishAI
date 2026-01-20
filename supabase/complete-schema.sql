/*
  # Automotive Refinish Inventory Prediction Platform - Core Schema

  1. New Tables
    
    ## Vehicle Reference Data
    - `panel_types`
      - `id` (uuid, primary key)
      - `name` (text) - e.g., "Hood", "Front Fender", "Door"
      - `code` (text) - Standardized code for panel type
      - `typical_area_sqft` (numeric) - Average surface area
      - `created_at` (timestamp)
    
    - `vehicles`
      - `id` (uuid, primary key)
      - `vin` (text, unique) - Vehicle identification number
      - `year` (integer)
      - `make` (text)
      - `model` (text)
      - `body_style` (text) - Sedan, SUV, Truck, etc.
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `vehicle_panels`
      - `id` (uuid, primary key)
      - `vehicle_id` (uuid, foreign key)
      - `panel_type_id` (uuid, foreign key)
      - `area_sqft` (numeric) - Actual area for this vehicle's panel
      - `created_at` (timestamp)
    
    ## Product Catalog
    - `products`
      - `id` (uuid, primary key)
      - `sku` (text, unique)
      - `name` (text)
      - `category` (text) - Paint, Primer, Clear Coat, etc.
      - `unit_type` (text) - Gallon, Quart, Liter, etc.
      - `coverage_sqft_per_unit` (numeric) - Coverage per unit
      - `waste_factor` (numeric) - Expected waste percentage (0.15 = 15%)
      - `unit_cost` (numeric)
      - `supplier` (text)
      - `lead_time_days` (integer)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    ## Estimates (Future Work Pipeline)
    - `estimates`
      - `id` (uuid, primary key)
      - `shop_id` (uuid) - Future: link to shop/user
      - `estimate_number` (text)
      - `vin` (text)
      - `vehicle_id` (uuid, foreign key, nullable)
      - `customer_name` (text)
      - `estimate_date` (date)
      - `expected_start_date` (date, nullable)
      - `status` (text) - Quoted, Approved, In Progress, Completed, Declined
      - `total_amount` (numeric)
      - `source` (text) - CSV, API, Manual
      - `raw_data` (jsonb) - Store original upload data
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `estimate_line_items`
      - `id` (uuid, primary key)
      - `estimate_id` (uuid, foreign key)
      - `panel_type_id` (uuid, foreign key, nullable)
      - `product_id` (uuid, foreign key, nullable)
      - `description` (text)
      - `quantity` (numeric)
      - `unit_price` (numeric)
      - `line_total` (numeric)
      - `is_refinish` (boolean) - Flag refinish vs parts/labor
      - `created_at` (timestamp)
    
    ## Invoices (Completed Work History)
    - `invoices`
      - `id` (uuid, primary key)
      - `shop_id` (uuid) - Future: link to shop/user
      - `invoice_number` (text)
      - `estimate_id` (uuid, foreign key, nullable)
      - `vin` (text)
      - `vehicle_id` (uuid, foreign key, nullable)
      - `customer_name` (text)
      - `invoice_date` (date)
      - `completion_date` (date)
      - `total_amount` (numeric)
      - `source` (text) - CSV, API, Manual
      - `raw_data` (jsonb)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `invoice_line_items`
      - `id` (uuid, primary key)
      - `invoice_id` (uuid, foreign key)
      - `panel_type_id` (uuid, foreign key, nullable)
      - `product_id` (uuid, foreign key, nullable)
      - `description` (text)
      - `quantity` (numeric)
      - `unit_price` (numeric)
      - `line_total` (numeric)
      - `is_refinish` (boolean)
      - `actual_product_used` (numeric, nullable) - Actual consumption for ML
      - `created_at` (timestamp)
    
    ## Predictions & Inventory Management
    - `predictions`
      - `id` (uuid, primary key)
      - `shop_id` (uuid) - Future: link to shop/user
      - `prediction_date` (date)
      - `forecast_start_date` (date) - Start of prediction window
      - `forecast_end_date` (date) - End of prediction window (2-4 weeks)
      - `status` (text) - Generated, Reviewed, Ordered, Completed
      - `confidence_score` (numeric) - 0-1 scale
      - `notes` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `prediction_items`
      - `id` (uuid, primary key)
      - `prediction_id` (uuid, foreign key)
      - `product_id` (uuid, foreign key)
      - `predicted_quantity` (numeric) - AI suggestion
      - `adjusted_quantity` (numeric, nullable) - User override
      - `current_stock` (numeric)
      - `reasoning` (text) - Why this amount was predicted
      - `order_by_date` (date)
      - `is_overridden` (boolean) - Track if user changed it
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    ## Learning & Analytics
    - `consumption_history`
      - `id` (uuid, primary key)
      - `invoice_id` (uuid, foreign key)
      - `product_id` (uuid, foreign key)
      - `panel_type_id` (uuid, foreign key, nullable)
      - `estimated_quantity` (numeric)
      - `actual_quantity` (numeric)
      - `variance_pct` (numeric)
      - `vehicle_id` (uuid, foreign key, nullable)
      - `completion_date` (date)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users to manage their own shop data
    - Public read access to reference data (vehicles, panels, products)
*/

-- Panel Types Reference
CREATE TABLE IF NOT EXISTS panel_types (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  code text UNIQUE NOT NULL,
  typical_area_sqft numeric NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Vehicles Reference
CREATE TABLE IF NOT EXISTS vehicles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  vin text UNIQUE NOT NULL,
  year integer,
  make text,
  model text,
  body_style text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Vehicle Panels (linking vehicles to their specific panel sizes)
CREATE TABLE IF NOT EXISTS vehicle_panels (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  vehicle_id uuid REFERENCES vehicles(id) ON DELETE CASCADE NOT NULL,
  panel_type_id uuid REFERENCES panel_types(id) ON DELETE CASCADE NOT NULL,
  area_sqft numeric NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(vehicle_id, panel_type_id)
);

-- Products Catalog
CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sku text UNIQUE NOT NULL,
  name text NOT NULL,
  category text NOT NULL,
  unit_type text NOT NULL DEFAULT 'gallon',
  coverage_sqft_per_unit numeric DEFAULT 0,
  waste_factor numeric DEFAULT 0.15,
  unit_cost numeric DEFAULT 0,
  supplier text,
  lead_time_days integer DEFAULT 7,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Estimates
CREATE TABLE IF NOT EXISTS estimates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_id uuid,
  estimate_number text NOT NULL,
  vin text,
  vehicle_id uuid REFERENCES vehicles(id) ON DELETE SET NULL,
  customer_name text,
  estimate_date date NOT NULL,
  expected_start_date date,
  status text DEFAULT 'Quoted',
  total_amount numeric DEFAULT 0,
  source text DEFAULT 'Manual',
  raw_data jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Estimate Line Items
CREATE TABLE IF NOT EXISTS estimate_line_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  estimate_id uuid REFERENCES estimates(id) ON DELETE CASCADE NOT NULL,
  panel_type_id uuid REFERENCES panel_types(id) ON DELETE SET NULL,
  product_id uuid REFERENCES products(id) ON DELETE SET NULL,
  description text NOT NULL,
  quantity numeric DEFAULT 0,
  unit_price numeric DEFAULT 0,
  line_total numeric DEFAULT 0,
  is_refinish boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

-- Invoices
CREATE TABLE IF NOT EXISTS invoices (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_id uuid,
  invoice_number text NOT NULL,
  estimate_id uuid REFERENCES estimates(id) ON DELETE SET NULL,
  vin text,
  vehicle_id uuid REFERENCES vehicles(id) ON DELETE SET NULL,
  customer_name text,
  invoice_date date NOT NULL,
  completion_date date NOT NULL,
  total_amount numeric DEFAULT 0,
  source text DEFAULT 'Manual',
  raw_data jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Invoice Line Items
CREATE TABLE IF NOT EXISTS invoice_line_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id uuid REFERENCES invoices(id) ON DELETE CASCADE NOT NULL,
  panel_type_id uuid REFERENCES panel_types(id) ON DELETE SET NULL,
  product_id uuid REFERENCES products(id) ON DELETE SET NULL,
  description text NOT NULL,
  quantity numeric DEFAULT 0,
  unit_price numeric DEFAULT 0,
  line_total numeric DEFAULT 0,
  is_refinish boolean DEFAULT false,
  actual_product_used numeric,
  created_at timestamptz DEFAULT now()
);

-- Predictions
CREATE TABLE IF NOT EXISTS predictions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_id uuid,
  prediction_date date NOT NULL DEFAULT CURRENT_DATE,
  forecast_start_date date NOT NULL,
  forecast_end_date date NOT NULL,
  status text DEFAULT 'Generated',
  confidence_score numeric DEFAULT 0.5,
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Prediction Items
CREATE TABLE IF NOT EXISTS prediction_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prediction_id uuid REFERENCES predictions(id) ON DELETE CASCADE NOT NULL,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  predicted_quantity numeric NOT NULL,
  adjusted_quantity numeric,
  current_stock numeric DEFAULT 0,
  reasoning text,
  order_by_date date,
  is_overridden boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Consumption History
CREATE TABLE IF NOT EXISTS consumption_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id uuid REFERENCES invoices(id) ON DELETE CASCADE NOT NULL,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  panel_type_id uuid REFERENCES panel_types(id) ON DELETE SET NULL,
  estimated_quantity numeric,
  actual_quantity numeric NOT NULL,
  variance_pct numeric,
  vehicle_id uuid REFERENCES vehicles(id) ON DELETE SET NULL,
  completion_date date NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE panel_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicles ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicle_panels ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE estimates ENABLE ROW LEVEL SECURITY;
ALTER TABLE estimate_line_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoice_line_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE predictions ENABLE ROW LEVEL SECURITY;
ALTER TABLE prediction_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE consumption_history ENABLE ROW LEVEL SECURITY;

-- RLS Policies for Reference Data (Public Read)
CREATE POLICY "Public read access to panel types"
  ON panel_types FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access to vehicles"
  ON vehicles FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access to vehicle panels"
  ON vehicle_panels FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access to products"
  ON products FOR SELECT
  TO public
  USING (true);

-- RLS Policies for Operational Data (Allow all for now, will restrict by shop_id later)
CREATE POLICY "Allow all operations on estimates"
  ON estimates FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on estimate line items"
  ON estimate_line_items FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on invoices"
  ON invoices FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on invoice line items"
  ON invoice_line_items FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on predictions"
  ON predictions FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on prediction items"
  ON prediction_items FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on consumption history"
  ON consumption_history FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_vehicles_vin ON vehicles(vin);
CREATE INDEX IF NOT EXISTS idx_estimates_vin ON estimates(vin);
CREATE INDEX IF NOT EXISTS idx_estimates_status ON estimates(status);
CREATE INDEX IF NOT EXISTS idx_estimates_expected_start ON estimates(expected_start_date);
CREATE INDEX IF NOT EXISTS idx_invoices_vin ON invoices(vin);
CREATE INDEX IF NOT EXISTS idx_invoices_completion ON invoices(completion_date);
CREATE INDEX IF NOT EXISTS idx_predictions_forecast_dates ON predictions(forecast_start_date, forecast_end_date);
CREATE INDEX IF NOT EXISTS idx_consumption_history_product ON consumption_history(product_id);
CREATE INDEX IF NOT EXISTS idx_consumption_history_date ON consumption_history(completion_date);/*
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

SELECT 'Product catalog expanded with ' || COUNT(*) || ' total products' FROM products;/*
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

SELECT 'Created consumption standards for ' || COUNT(DISTINCT panel_type_id) || ' panel types' FROM panel_consumption_standards;/*
  # Inventory Management System

  Adds comprehensive inventory tracking and management capabilities.

  1. New Tables
    
    ## inventory_stock
    - `id` (uuid, primary key)
    - `shop_id` (uuid) - Future: link to specific shops
    - `product_id` (uuid, foreign key) - Links to products table
    - `quantity_on_hand` (numeric) - Current stock level
    - `reorder_point` (numeric) - Minimum level before reorder
    - `reorder_quantity` (numeric) - How much to order when restocking
    - `last_updated` (timestamp)
    - `notes` (text)
    
    ## inventory_transactions
    - `id` (uuid, primary key)
    - `shop_id` (uuid)
    - `product_id` (uuid, foreign key)
    - `transaction_type` (text) - 'purchase', 'consumption', 'adjustment', 'waste'
    - `quantity_change` (numeric) - Positive for additions, negative for usage
    - `quantity_after` (numeric) - Stock level after transaction
    - `reference_id` (uuid) - Link to invoice/estimate if applicable
    - `reference_type` (text) - 'invoice', 'estimate', 'manual'
    - `cost_per_unit` (numeric) - Cost at time of transaction
    - `transaction_date` (date)
    - `notes` (text)
    - `created_at` (timestamp)
    - `created_by` (uuid) - Future: user tracking

  2. Product Updates
    - Add columns to track product history
    - Enable price/cost updates without losing data

  3. Security
    - Enable RLS on all new tables
    - Allow public access for now (will be shop-specific later)
*/

-- Inventory Stock Levels
CREATE TABLE IF NOT EXISTS inventory_stock (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_id uuid,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  quantity_on_hand numeric DEFAULT 0 NOT NULL,
  reorder_point numeric DEFAULT 5,
  reorder_quantity numeric DEFAULT 10,
  last_updated timestamptz DEFAULT now(),
  notes text,
  created_at timestamptz DEFAULT now(),
  UNIQUE(shop_id, product_id)
);

-- Inventory Transactions (audit trail)
CREATE TABLE IF NOT EXISTS inventory_transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_id uuid,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  transaction_type text NOT NULL,
  quantity_change numeric NOT NULL,
  quantity_after numeric NOT NULL,
  reference_id uuid,
  reference_type text,
  cost_per_unit numeric DEFAULT 0,
  transaction_date date DEFAULT CURRENT_DATE,
  notes text,
  created_at timestamptz DEFAULT now(),
  created_by uuid
);

-- Enable RLS
ALTER TABLE inventory_stock ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_transactions ENABLE ROW LEVEL SECURITY;

-- RLS Policies (open for now, will restrict by shop later)
CREATE POLICY "Allow all operations on inventory stock"
  ON inventory_stock FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on inventory transactions"
  ON inventory_transactions FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_inventory_stock_product ON inventory_stock(product_id);
CREATE INDEX IF NOT EXISTS idx_inventory_stock_shop ON inventory_stock(shop_id);
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_product ON inventory_transactions(product_id);
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_date ON inventory_transactions(transaction_date);
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_type ON inventory_transactions(transaction_type);

-- Function to update inventory stock after transaction
CREATE OR REPLACE FUNCTION update_inventory_after_transaction()
RETURNS TRIGGER AS $$
BEGIN
  -- Update or insert inventory stock
  INSERT INTO inventory_stock (shop_id, product_id, quantity_on_hand, last_updated)
  VALUES (NEW.shop_id, NEW.product_id, NEW.quantity_after, now())
  ON CONFLICT (shop_id, product_id) 
  DO UPDATE SET 
    quantity_on_hand = NEW.quantity_after,
    last_updated = now();
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update stock levels
CREATE TRIGGER trigger_update_inventory_stock
  AFTER INSERT ON inventory_transactions
  FOR EACH ROW
  EXECUTE FUNCTION update_inventory_after_transaction();

-- Initialize inventory stock for existing products (with zero quantity)
INSERT INTO inventory_stock (shop_id, product_id, quantity_on_hand, reorder_point, reorder_quantity)
SELECT 
  NULL as shop_id,
  id as product_id,
  0 as quantity_on_hand,
  CASE 
    WHEN category IN ('Base Coat', 'Clear Coat', 'Primer') THEN 5
    WHEN category IN ('Abrasives', 'Consumables', 'Safety') THEN 20
    ELSE 10
  END as reorder_point,
  CASE 
    WHEN category IN ('Base Coat', 'Clear Coat', 'Primer') THEN 10
    WHEN category IN ('Abrasives', 'Consumables', 'Safety') THEN 50
    ELSE 20
  END as reorder_quantity
FROM products
ON CONFLICT DO NOTHING;

SELECT 'Created inventory management system with ' || COUNT(*) || ' stock entries' FROM inventory_stock;/*
  # Inventory Count System

  Comprehensive physical inventory counting with variance analysis and approval workflow.

  1. New Tables
    
    ## inventory_counts
    - `id` (uuid, primary key)
    - `shop_id` (uuid) - Future: shop-specific counts
    - `count_number` (text) - Human-readable count identifier
    - `status` (text) - 'draft', 'in_progress', 'pending_approval', 'approved', 'rejected'
    - `count_date` (date) - When physical count was performed
    - `started_by` (uuid) - User who initiated count
    - `counted_by` (text) - Name of person doing physical count
    - `approved_by` (uuid) - Admin who approved/rejected
    - `approved_at` (timestamptz) - When approved/rejected
    - `approval_notes` (text) - Approval/rejection reason
    - `total_variance_quantity` (numeric) - Total units difference
    - `total_variance_value` (numeric) - Total dollar difference
    - `created_at` (timestamptz)
    - `updated_at` (timestamptz)
    
    ## inventory_count_items
    - `id` (uuid, primary key)
    - `count_id` (uuid, foreign key) - Links to inventory_counts
    - `product_id` (uuid, foreign key) - Product being counted
    - `expected_quantity` (numeric) - System quantity at count time
    - `counted_quantity` (numeric) - Physical count result
    - `variance_quantity` (numeric) - Difference (counted - expected)
    - `unit_cost` (numeric) - Cost per unit at count time
    - `variance_value` (numeric) - Dollar impact of variance
    - `notes` (text) - Count notes
    - `created_at` (timestamptz)
    
    ## product_substitutes
    - `id` (uuid, primary key)
    - `product_id` (uuid, foreign key) - Primary product
    - `substitute_id` (uuid, foreign key) - Can be swapped with
    - `compatibility_notes` (text)
    - `created_at` (timestamptz)
    
    ## inventory_sync_log
    - `id` (uuid, primary key)
    - `sync_type` (text) - 'import', 'export', 'api_sync'
    - `source_system` (text) - 'quickbooks', 'csv', 'api', etc.
    - `status` (text) - 'success', 'error', 'partial'
    - `records_processed` (integer)
    - `records_failed` (integer)
    - `error_details` (jsonb)
    - `sync_data` (jsonb) - Import/export payload
    - `created_at` (timestamptz)
    - `created_by` (uuid)

  2. Security
    - Enable RLS on all tables
    - Allow public access for now (will be role-based later)

  3. Indexes
    - Performance indexes for common queries
*/

-- Inventory count sessions
CREATE TABLE IF NOT EXISTS inventory_counts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_id uuid,
  count_number text UNIQUE NOT NULL,
  status text DEFAULT 'draft' NOT NULL,
  count_date date DEFAULT CURRENT_DATE,
  started_by uuid,
  counted_by text,
  approved_by uuid,
  approved_at timestamptz,
  approval_notes text,
  total_variance_quantity numeric DEFAULT 0,
  total_variance_value numeric DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Individual count line items
CREATE TABLE IF NOT EXISTS inventory_count_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  count_id uuid REFERENCES inventory_counts(id) ON DELETE CASCADE NOT NULL,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  expected_quantity numeric DEFAULT 0 NOT NULL,
  counted_quantity numeric,
  variance_quantity numeric DEFAULT 0,
  unit_cost numeric DEFAULT 0,
  variance_value numeric DEFAULT 0,
  notes text,
  created_at timestamptz DEFAULT now(),
  UNIQUE(count_id, product_id)
);

-- Product substitution mapping
CREATE TABLE IF NOT EXISTS product_substitutes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  substitute_id uuid REFERENCES products(id) ON DELETE CASCADE NOT NULL,
  compatibility_notes text,
  created_at timestamptz DEFAULT now(),
  UNIQUE(product_id, substitute_id),
  CHECK (product_id != substitute_id)
);

-- Sync and import/export log
CREATE TABLE IF NOT EXISTS inventory_sync_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sync_type text NOT NULL,
  source_system text,
  status text DEFAULT 'success',
  records_processed integer DEFAULT 0,
  records_failed integer DEFAULT 0,
  error_details jsonb,
  sync_data jsonb,
  created_at timestamptz DEFAULT now(),
  created_by uuid
);

-- Enable RLS
ALTER TABLE inventory_counts ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_count_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_substitutes ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_sync_log ENABLE ROW LEVEL SECURITY;

-- RLS Policies (open for now)
CREATE POLICY "Allow all operations on inventory counts"
  ON inventory_counts FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on count items"
  ON inventory_count_items FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on product substitutes"
  ON product_substitutes FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on sync log"
  ON inventory_sync_log FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_counts_status ON inventory_counts(status);
CREATE INDEX IF NOT EXISTS idx_counts_date ON inventory_counts(count_date);
CREATE INDEX IF NOT EXISTS idx_count_items_count ON inventory_count_items(count_id);
CREATE INDEX IF NOT EXISTS idx_count_items_product ON inventory_count_items(product_id);
CREATE INDEX IF NOT EXISTS idx_substitutes_product ON product_substitutes(product_id);
CREATE INDEX IF NOT EXISTS idx_sync_log_date ON inventory_sync_log(created_at);

-- Function to auto-generate count number
CREATE OR REPLACE FUNCTION generate_count_number()
RETURNS text AS $$
DECLARE
  next_num integer;
  count_num text;
BEGIN
  SELECT COALESCE(MAX(CAST(SUBSTRING(count_number FROM 'CNT-(\d+)') AS integer)), 0) + 1
  INTO next_num
  FROM inventory_counts;
  
  count_num := 'CNT-' || LPAD(next_num::text, 6, '0');
  RETURN count_num;
END;
$$ LANGUAGE plpgsql;

-- Function to update count totals
CREATE OR REPLACE FUNCTION update_count_totals()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE inventory_counts
  SET 
    total_variance_quantity = (
      SELECT COALESCE(SUM(ABS(variance_quantity)), 0)
      FROM inventory_count_items
      WHERE count_id = NEW.count_id
    ),
    total_variance_value = (
      SELECT COALESCE(SUM(variance_value), 0)
      FROM inventory_count_items
      WHERE count_id = NEW.count_id
    ),
    updated_at = now()
  WHERE id = NEW.count_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update totals when items change
CREATE TRIGGER trigger_update_count_totals
  AFTER INSERT OR UPDATE ON inventory_count_items
  FOR EACH ROW
  EXECUTE FUNCTION update_count_totals();

-- Function to apply approved count to inventory
CREATE OR REPLACE FUNCTION apply_approved_count()
RETURNS TRIGGER AS $$
BEGIN
  -- Only process when status changes to 'approved'
  IF NEW.status = 'approved' AND OLD.status != 'approved' THEN
    -- Create transactions for each variance
    INSERT INTO inventory_transactions (
      shop_id,
      product_id,
      transaction_type,
      quantity_change,
      quantity_after,
      cost_per_unit,
      transaction_date,
      reference_id,
      reference_type,
      notes
    )
    SELECT
      NEW.shop_id,
      ici.product_id,
      'adjustment',
      ici.variance_quantity,
      ici.counted_quantity,
      ici.unit_cost,
      NEW.count_date,
      NEW.id,
      'inventory_count',
      'Physical count adjustment - ' || NEW.count_number
    FROM inventory_count_items ici
    WHERE ici.count_id = NEW.id
      AND ici.variance_quantity != 0;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to apply count when approved
CREATE TRIGGER trigger_apply_approved_count
  AFTER UPDATE ON inventory_counts
  FOR EACH ROW
  EXECUTE FUNCTION apply_approved_count();

-- Add some common product substitutes for clear coats and primers
INSERT INTO product_substitutes (product_id, substitute_id, compatibility_notes)
SELECT 
  p1.id as product_id,
  p2.id as substitute_id,
  'Same category products are often interchangeable' as compatibility_notes
FROM products p1
CROSS JOIN products p2
WHERE p1.category = p2.category
  AND p1.category IN ('Clear Coat', 'Primer', 'Base Coat')
  AND p1.id != p2.id
  AND p1.supplier = p2.supplier
ON CONFLICT DO NOTHING;

SELECT 'Created inventory count system with ' || COUNT(*) || ' product substitution mappings' FROM product_substitutes;/*
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

SELECT 'Authentication system created with multi-tenant role-based access control' as result;/*
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

SELECT 'RLS policies updated for multi-tenant isolation' as result;/*
  # Fix Security and Performance Issues

  1. Add Missing Foreign Key Indexes
    - Add indexes for all unindexed foreign keys to improve query performance
    
  2. Optimize RLS Policies
    - Replace auth.uid() with (select auth.uid()) to prevent re-evaluation per row
    - Consolidate multiple permissive policies into single policies
    
  3. Fix Function Security
    - Set explicit search_path on all security definer functions
    
  4. Clean Up Redundant Policies
    - Remove duplicate or overlapping policies
*/

-- ============================================================================
-- PART 1: Add Missing Foreign Key Indexes
-- ============================================================================

-- Consumption history indexes
CREATE INDEX IF NOT EXISTS idx_consumption_history_invoice ON consumption_history(invoice_id);
CREATE INDEX IF NOT EXISTS idx_consumption_history_panel_type ON consumption_history(panel_type_id);
CREATE INDEX IF NOT EXISTS idx_consumption_history_vehicle ON consumption_history(vehicle_id);

-- Estimate line items indexes
CREATE INDEX IF NOT EXISTS idx_estimate_line_items_estimate ON estimate_line_items(estimate_id);
CREATE INDEX IF NOT EXISTS idx_estimate_line_items_panel_type ON estimate_line_items(panel_type_id);
CREATE INDEX IF NOT EXISTS idx_estimate_line_items_product ON estimate_line_items(product_id);

-- Estimates indexes
CREATE INDEX IF NOT EXISTS idx_estimates_created_by ON estimates(created_by);
CREATE INDEX IF NOT EXISTS idx_estimates_vehicle ON estimates(vehicle_id);

-- Invoice line items indexes
CREATE INDEX IF NOT EXISTS idx_invoice_line_items_invoice ON invoice_line_items(invoice_id);
CREATE INDEX IF NOT EXISTS idx_invoice_line_items_panel_type ON invoice_line_items(panel_type_id);
CREATE INDEX IF NOT EXISTS idx_invoice_line_items_product ON invoice_line_items(product_id);

-- Invoices indexes
CREATE INDEX IF NOT EXISTS idx_invoices_created_by ON invoices(created_by);
CREATE INDEX IF NOT EXISTS idx_invoices_estimate ON invoices(estimate_id);
CREATE INDEX IF NOT EXISTS idx_invoices_vehicle ON invoices(vehicle_id);

-- Prediction items indexes
CREATE INDEX IF NOT EXISTS idx_prediction_items_prediction ON prediction_items(prediction_id);
CREATE INDEX IF NOT EXISTS idx_prediction_items_product ON prediction_items(product_id);

-- Predictions indexes
CREATE INDEX IF NOT EXISTS idx_predictions_created_by ON predictions(created_by);

-- Product substitutes indexes
CREATE INDEX IF NOT EXISTS idx_product_substitutes_substitute ON product_substitutes(substitute_id);

-- Products indexes
CREATE INDEX IF NOT EXISTS idx_products_created_by ON products(created_by);

-- Vehicle panels indexes
CREATE INDEX IF NOT EXISTS idx_vehicle_panels_panel_type ON vehicle_panels(panel_type_id);

-- ============================================================================
-- PART 2: Fix Function Security with Explicit Search Path
-- ============================================================================

-- Recreate is_super_admin with explicit search_path
CREATE OR REPLACE FUNCTION is_super_admin()
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth.uid()
    AND role = 'super_admin'
    AND is_active = true
  );
END;
$$;

-- Recreate get_user_company with explicit search_path
CREATE OR REPLACE FUNCTION get_user_company()
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  RETURN (
    SELECT company_id FROM user_profiles
    WHERE id = auth.uid()
  );
END;
$$;

-- Recreate get_user_role with explicit search_path
CREATE OR REPLACE FUNCTION get_user_role()
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  RETURN (
    SELECT role FROM user_profiles
    WHERE id = auth.uid()
  );
END;
$$;

-- Recreate has_role with explicit search_path
CREATE OR REPLACE FUNCTION has_role(required_role text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
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
$$;

-- Recreate update_last_login with explicit search_path
CREATE OR REPLACE FUNCTION update_last_login()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  UPDATE user_profiles
  SET last_login_at = now()
  WHERE id = auth.uid();
END;
$$;

-- Fix other existing functions
CREATE OR REPLACE FUNCTION update_inventory_after_transaction()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  UPDATE inventory_stock
  SET 
    quantity_on_hand = NEW.quantity_after,
    last_updated = now()
  WHERE product_id = NEW.product_id
    AND (shop_id = NEW.shop_id OR (shop_id IS NULL AND NEW.shop_id IS NULL));
  
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION generate_count_number()
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  next_number integer;
BEGIN
  SELECT COALESCE(MAX(CAST(SUBSTRING(count_number FROM '[0-9]+$') AS integer)), 0) + 1
  INTO next_number
  FROM inventory_counts
  WHERE count_number LIKE 'CNT-%';
  
  RETURN 'CNT-' || LPAD(next_number::text, 6, '0');
END;
$$;

CREATE OR REPLACE FUNCTION update_count_totals()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  total_var_qty numeric;
  total_var_val numeric;
BEGIN
  SELECT 
    COALESCE(SUM(variance_quantity), 0),
    COALESCE(SUM(variance_value), 0)
  INTO total_var_qty, total_var_val
  FROM inventory_count_items
  WHERE count_id = COALESCE(NEW.count_id, OLD.count_id);
  
  UPDATE inventory_counts
  SET 
    total_variance_quantity = total_var_qty,
    total_variance_value = total_var_val,
    updated_at = now()
  WHERE id = COALESCE(NEW.count_id, OLD.count_id);
  
  RETURN COALESCE(NEW, OLD);
END;
$$;

CREATE OR REPLACE FUNCTION apply_approved_count(count_id_param uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  INSERT INTO inventory_transactions (
    shop_id,
    product_id,
    transaction_type,
    quantity_change,
    quantity_after,
    reference_id,
    reference_type,
    transaction_date,
    notes,
    created_by
  )
  SELECT 
    ic.shop_id,
    ici.product_id,
    'count_adjustment',
    ici.variance_quantity,
    ici.counted_quantity,
    ic.id,
    'inventory_count',
    ic.count_date,
    'Approved count adjustment',
    ic.approved_by
  FROM inventory_counts ic
  JOIN inventory_count_items ici ON ici.count_id = ic.id
  WHERE ic.id = count_id_param
    AND ic.status = 'approved'
    AND ici.variance_quantity != 0;
END;
$$;

-- ============================================================================
-- PART 3: Drop Redundant Policies and Create Consolidated Policies
-- ============================================================================

-- Clean up inventory_stock policies
DROP POLICY IF EXISTS "Allow all operations on inventory stock" ON inventory_stock;

-- Drop redundant products policies
DROP POLICY IF EXISTS "Public read access to products" ON products;

-- Drop redundant vehicles policies
DROP POLICY IF EXISTS "Public read access to vehicles" ON vehicles;

-- Drop specific super admin view policies (covered by full access policies)
DROP POLICY IF EXISTS "Super admin can view all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Super admin can view all companies" ON companies;

-- ============================================================================
-- PART 4: Optimize RLS Policies - Replace auth.uid() with (select auth.uid())
-- ============================================================================

-- User Profiles Policies
DROP POLICY IF EXISTS "Users can view own profile" ON user_profiles;
CREATE POLICY "Users can view own profile"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can update own profile" ON user_profiles;
CREATE POLICY "Users can update own profile"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (id = (select auth.uid()))
  WITH CHECK (id = (select auth.uid()) AND role = get_user_role());

-- Inventory Counts Policies
DROP POLICY IF EXISTS "Users can update their own counts" ON inventory_counts;
CREATE POLICY "Users can update their own counts"
  ON inventory_counts FOR UPDATE
  TO authenticated
  USING (
    (company_id = get_user_company() OR company_id IS NULL) AND
    (started_by = (select auth.uid()) OR has_role('admin'))
  )
  WITH CHECK (
    (company_id = get_user_company() OR company_id IS NULL) AND
    (started_by = (select auth.uid()) OR has_role('admin'))
  );

-- ============================================================================
-- PART 5: Grant Proper Permissions
-- ============================================================================

-- Ensure authenticated users can execute helper functions
GRANT EXECUTE ON FUNCTION is_super_admin() TO authenticated;
GRANT EXECUTE ON FUNCTION get_user_company() TO authenticated;
GRANT EXECUTE ON FUNCTION get_user_role() TO authenticated;
GRANT EXECUTE ON FUNCTION has_role(text) TO authenticated;
GRANT EXECUTE ON FUNCTION update_last_login() TO authenticated;

SELECT 'Security and performance issues resolved' as result;/*
  # Consolidate Multiple Permissive Policies - Corrected

  1. Security Improvements
    - Replace multiple permissive policies with single consolidated policies
    - Maintain clear access control with simplified logic
    - Only handle tables that actually have necessary columns
    
  2. Tables Updated
    - audit_log
    - companies
    - estimates
    - inventory_counts
    - inventory_count_items
    - inventory_stock
    - inventory_transactions (uses shop_id)
    - invoices
    - predictions
    - products
    - user_profiles
    - vehicles
    
  3. Policy Pattern
    - Each table gets ONE permissive policy per action
    - Super admin access included within main policy
    - Clear, maintainable access control rules
    
  Note: Line item tables and some reference tables don't have company_id,
  so they rely on parent table relationships for access control.
*/

-- ============================================================================
-- AUDIT LOG - Consolidate SELECT policies
-- ============================================================================

DROP POLICY IF EXISTS "Admin can view company audit logs" ON audit_log;
DROP POLICY IF EXISTS "Super admin can view all audit logs" ON audit_log;

CREATE POLICY "View audit logs"
  ON audit_log FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() AND has_role('admin'))
  );

-- ============================================================================
-- COMPANIES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Super admin can view all companies" ON companies;
DROP POLICY IF EXISTS "Super admin can manage all companies" ON companies;
DROP POLICY IF EXISTS "Users can view their own company" ON companies;
DROP POLICY IF EXISTS "Company admin can update own company" ON companies;

CREATE POLICY "View companies"
  ON companies FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    id = get_user_company()
  );

CREATE POLICY "Update companies"
  ON companies FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    (id = get_user_company() AND has_role('admin'))
  )
  WITH CHECK (
    is_super_admin() OR
    (id = get_user_company() AND has_role('admin'))
  );

-- ============================================================================
-- ESTIMATES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company estimates" ON estimates;
DROP POLICY IF EXISTS "Super admin full access to estimates" ON estimates;
DROP POLICY IF EXISTS "Users can create estimates" ON estimates;
DROP POLICY IF EXISTS "Admin and Manager can manage estimates" ON estimates;
DROP POLICY IF EXISTS "Admin can delete estimates" ON estimates;

CREATE POLICY "View estimates"
  ON estimates FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Create estimates"
  ON estimates FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND created_by = (select auth.uid()))
  );

CREATE POLICY "Update estimates"
  ON estimates FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

CREATE POLICY "Delete estimates"
  ON estimates FOR DELETE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('admin'))
  );

-- ============================================================================
-- ESTIMATE LINE ITEMS - Keep existing policies (they rely on parent relationship)
-- ============================================================================

-- No changes needed - existing policies use JOIN to estimates table

-- ============================================================================
-- INVENTORY COUNTS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company counts" ON inventory_counts;
DROP POLICY IF EXISTS "Super admin full access to counts" ON inventory_counts;
DROP POLICY IF EXISTS "Staff can create counts" ON inventory_counts;
DROP POLICY IF EXISTS "Users can update their own counts" ON inventory_counts;
DROP POLICY IF EXISTS "Admin can delete counts" ON inventory_counts;

CREATE POLICY "View inventory counts"
  ON inventory_counts FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Create inventory counts"
  ON inventory_counts FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND started_by = (select auth.uid()))
  );

CREATE POLICY "Update inventory counts"
  ON inventory_counts FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND (started_by = (select auth.uid()) OR has_role('admin')))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND (started_by = (select auth.uid()) OR has_role('admin')))
  );

CREATE POLICY "Delete inventory counts"
  ON inventory_counts FOR DELETE
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('admin'))
  );

-- ============================================================================
-- INVENTORY COUNT ITEMS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can manage count items" ON inventory_count_items;
DROP POLICY IF EXISTS "Super admin full access to count items" ON inventory_count_items;

CREATE POLICY "Manage count items"
  ON inventory_count_items FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    EXISTS (
      SELECT 1 FROM inventory_counts ic
      WHERE ic.id = inventory_count_items.count_id
      AND (ic.company_id = get_user_company() OR ic.company_id IS NULL)
      AND (ic.started_by = (select auth.uid()) OR has_role('admin'))
    )
  )
  WITH CHECK (
    is_super_admin() OR
    EXISTS (
      SELECT 1 FROM inventory_counts ic
      WHERE ic.id = inventory_count_items.count_id
      AND (ic.company_id = get_user_company() OR ic.company_id IS NULL)
      AND (ic.started_by = (select auth.uid()) OR has_role('admin'))
    )
  );

-- ============================================================================
-- INVENTORY STOCK - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company inventory" ON inventory_stock;
DROP POLICY IF EXISTS "Admin and Manager can manage company inventory" ON inventory_stock;
DROP POLICY IF EXISTS "Super admin full access to inventory stock" ON inventory_stock;

CREATE POLICY "View inventory stock"
  ON inventory_stock FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage inventory stock"
  ON inventory_stock FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- INVENTORY TRANSACTIONS - Consolidate policies (uses shop_id not company_id)
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company transactions" ON inventory_transactions;
DROP POLICY IF EXISTS "Super admin full access to transactions" ON inventory_transactions;
DROP POLICY IF EXISTS "Admin and Manager can create transactions" ON inventory_transactions;

CREATE POLICY "View inventory transactions"
  ON inventory_transactions FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (shop_id = get_user_company() OR shop_id IS NULL)
  );

CREATE POLICY "Create inventory transactions"
  ON inventory_transactions FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    ((shop_id = get_user_company() OR shop_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- INVOICES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company invoices" ON invoices;
DROP POLICY IF EXISTS "Super admin full access to invoices" ON invoices;
DROP POLICY IF EXISTS "Admin and Manager can manage invoices" ON invoices;

CREATE POLICY "View invoices"
  ON invoices FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage invoices"
  ON invoices FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- INVOICE LINE ITEMS - Keep existing policies (they rely on parent relationship)
-- ============================================================================

-- No changes needed - existing policies use JOIN to invoices table if they exist

-- ============================================================================
-- PREDICTIONS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company predictions" ON predictions;
DROP POLICY IF EXISTS "Super admin full access to predictions" ON predictions;
DROP POLICY IF EXISTS "Admin and Manager can manage predictions" ON predictions;

CREATE POLICY "View predictions"
  ON predictions FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage predictions"
  ON predictions FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- PRODUCTS - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company products" ON products;
DROP POLICY IF EXISTS "Super admin full access to products" ON products;
DROP POLICY IF EXISTS "Admin and Manager can manage company products" ON products;

CREATE POLICY "View products"
  ON products FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage products"
  ON products FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  )
  WITH CHECK (
    is_super_admin() OR
    ((company_id = get_user_company() OR company_id IS NULL) AND has_role('manager'))
  );

-- ============================================================================
-- USER PROFILES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own profile" ON user_profiles;
DROP POLICY IF EXISTS "Users can view profiles in their company" ON user_profiles;
DROP POLICY IF EXISTS "Admin can manage users in their company" ON user_profiles;
DROP POLICY IF EXISTS "Super admin can manage all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON user_profiles;

CREATE POLICY "View user profiles"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    id = (select auth.uid()) OR
    (company_id = get_user_company() AND has_role('admin'))
  );

CREATE POLICY "Update user profiles"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (
    is_super_admin() OR
    id = (select auth.uid()) OR
    (company_id = get_user_company() AND has_role('admin'))
  )
  WITH CHECK (
    is_super_admin() OR
    (id = (select auth.uid()) AND role = get_user_role()) OR
    (company_id = get_user_company() AND has_role('admin'))
  );

CREATE POLICY "Create user profiles"
  ON user_profiles FOR INSERT
  TO authenticated
  WITH CHECK (
    is_super_admin() OR
    (company_id = get_user_company() AND has_role('admin'))
  );

CREATE POLICY "Delete user profiles"
  ON user_profiles FOR DELETE
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() AND has_role('admin') AND id != (select auth.uid()))
  );

-- ============================================================================
-- VEHICLES - Consolidate policies
-- ============================================================================

DROP POLICY IF EXISTS "Users can view company vehicles" ON vehicles;
DROP POLICY IF EXISTS "Super admin full access to vehicles" ON vehicles;
DROP POLICY IF EXISTS "Users can manage company vehicles" ON vehicles;

CREATE POLICY "View vehicles"
  ON vehicles FOR SELECT
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

CREATE POLICY "Manage vehicles"
  ON vehicles FOR ALL
  TO authenticated
  USING (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  )
  WITH CHECK (
    is_super_admin() OR
    (company_id = get_user_company() OR company_id IS NULL)
  );

SELECT 'All permissive policies consolidated successfully' as result;/*
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

SELECT 'Company insert policy added successfully' as result;/*
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
