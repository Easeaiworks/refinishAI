-- ============================================================
-- Purchase Orders System
-- Tracks finalized reorder reports as purchase orders
-- with full line item detail and status workflow
-- ============================================================

-- Purchase Orders (header)
CREATE TABLE IF NOT EXISTS purchase_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  po_number VARCHAR(50) NOT NULL,
  status VARCHAR(20) DEFAULT 'draft' CHECK (status IN ('draft','submitted','received','partial','cancelled')),
  vendor_code VARCHAR(50),
  vendor_name VARCHAR(100),
  created_by UUID REFERENCES auth.users(id),
  submitted_date TIMESTAMPTZ,
  received_date TIMESTAMPTZ,
  total_items INTEGER DEFAULT 0,
  total_cost DECIMAL(12,2) DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(company_id, po_number)
);

-- Purchase Order Line Items
CREATE TABLE IF NOT EXISTS purchase_order_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_order_id UUID NOT NULL REFERENCES purchase_orders(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id),
  sku VARCHAR(100),
  product_name VARCHAR(255) NOT NULL,
  category VARCHAR(100),
  manufacturer VARCHAR(100),
  unit VARCHAR(50),
  quantity_ordered INTEGER NOT NULL DEFAULT 0,
  unit_cost DECIMAL(10,2) NOT NULL DEFAULT 0,
  extended_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  quantity_received INTEGER DEFAULT 0,
  priority VARCHAR(20),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ─── INDEXES ───
CREATE INDEX IF NOT EXISTS idx_purchase_orders_company ON purchase_orders(company_id);
CREATE INDEX IF NOT EXISTS idx_purchase_orders_status ON purchase_orders(company_id, status);
CREATE INDEX IF NOT EXISTS idx_purchase_orders_date ON purchase_orders(company_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_purchase_orders_vendor ON purchase_orders(company_id, vendor_code);
CREATE INDEX IF NOT EXISTS idx_po_items_order ON purchase_order_items(purchase_order_id);
CREATE INDEX IF NOT EXISTS idx_po_items_product ON purchase_order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_po_items_manufacturer ON purchase_order_items(manufacturer);
CREATE INDEX IF NOT EXISTS idx_po_items_category ON purchase_order_items(category);

-- ─── ROW LEVEL SECURITY ───
ALTER TABLE purchase_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchase_order_items ENABLE ROW LEVEL SECURITY;

-- Users can view their company's purchase orders
CREATE POLICY "Users can view company purchase orders"
  ON purchase_orders FOR SELECT
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles WHERE id = auth.uid()
    )
  );

-- Managers+ can create purchase orders
CREATE POLICY "Managers can create purchase orders"
  ON purchase_orders FOR INSERT
  WITH CHECK (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid()
      AND role IN ('manager', 'admin', 'super_admin')
    )
  );

-- Managers+ can update purchase orders
CREATE POLICY "Managers can update purchase orders"
  ON purchase_orders FOR UPDATE
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid()
      AND role IN ('manager', 'admin', 'super_admin')
    )
  );

-- PO items inherit access from parent PO
CREATE POLICY "Users can view company PO items"
  ON purchase_order_items FOR SELECT
  USING (
    purchase_order_id IN (
      SELECT id FROM purchase_orders
      WHERE company_id IN (
        SELECT company_id FROM user_profiles WHERE id = auth.uid()
      )
    )
  );

CREATE POLICY "Managers can create PO items"
  ON purchase_order_items FOR INSERT
  WITH CHECK (
    purchase_order_id IN (
      SELECT id FROM purchase_orders
      WHERE company_id IN (
        SELECT company_id FROM user_profiles
        WHERE id = auth.uid()
        AND role IN ('manager', 'admin', 'super_admin')
      )
    )
  );

CREATE POLICY "Managers can update PO items"
  ON purchase_order_items FOR UPDATE
  USING (
    purchase_order_id IN (
      SELECT id FROM purchase_orders
      WHERE company_id IN (
        SELECT company_id FROM user_profiles
        WHERE id = auth.uid()
        AND role IN ('manager', 'admin', 'super_admin')
      )
    )
  );

-- ─── AUTO-UPDATE TIMESTAMP ───
CREATE OR REPLACE FUNCTION update_purchase_order_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER purchase_orders_updated_at
  BEFORE UPDATE ON purchase_orders
  FOR EACH ROW
  EXECUTE FUNCTION update_purchase_order_timestamp();
