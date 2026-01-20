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
CREATE INDEX IF NOT EXISTS idx_consumption_history_date ON consumption_history(completion_date);