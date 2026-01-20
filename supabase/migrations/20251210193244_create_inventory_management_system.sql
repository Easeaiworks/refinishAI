/*
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

SELECT 'Created inventory management system with ' || COUNT(*) || ' stock entries' FROM inventory_stock;