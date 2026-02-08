-- ============================================
-- Licensing, Billing & Subscription System
-- ============================================

-- 1. Subscription Plans (master list controlled by super admin)
CREATE TABLE IF NOT EXISTS subscription_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  billing_period VARCHAR(20) NOT NULL CHECK (billing_period IN ('monthly', 'annual')),
  base_price NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  included_users INTEGER NOT NULL DEFAULT 5,
  price_per_additional_user NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  features JSONB DEFAULT '{}',
  stripe_price_id TEXT,
  is_active BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Company Subscriptions (one active per company)
CREATE TABLE IF NOT EXISTS company_subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  plan_id UUID NOT NULL REFERENCES subscription_plans(id),
  billing_period VARCHAR(20) NOT NULL CHECK (billing_period IN ('monthly', 'annual')),
  current_price NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  additional_users_purchased INTEGER NOT NULL DEFAULT 0,
  status VARCHAR(20) NOT NULL DEFAULT 'trial' CHECK (status IN ('trial', 'active', 'past_due', 'cancelled', 'suspended')),
  started_at TIMESTAMPTZ DEFAULT NOW(),
  current_period_start DATE DEFAULT CURRENT_DATE,
  current_period_end DATE DEFAULT (CURRENT_DATE + INTERVAL '30 days'),
  auto_renew BOOLEAN DEFAULT true,
  stripe_subscription_id TEXT,
  stripe_customer_id TEXT,
  cancelled_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Billing Invoices (super admin sends to companies)
CREATE TABLE IF NOT EXISTS billing_invoices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  subscription_id UUID REFERENCES company_subscriptions(id),
  invoice_number TEXT NOT NULL UNIQUE,
  invoice_date DATE NOT NULL DEFAULT CURRENT_DATE,
  due_date DATE NOT NULL,
  subtotal NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  tax NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  total NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  description TEXT,
  line_items JSONB DEFAULT '[]',
  status VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'sent', 'paid', 'overdue', 'cancelled')),
  issued_by UUID REFERENCES user_profiles(id),
  notes TEXT,
  stripe_invoice_id TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Payment History
CREATE TABLE IF NOT EXISTS payment_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id UUID REFERENCES billing_invoices(id) ON DELETE SET NULL,
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  amount NUMERIC(10,2) NOT NULL,
  payment_method VARCHAR(20) NOT NULL DEFAULT 'manual' CHECK (payment_method IN ('stripe', 'manual', 'check', 'wire')),
  status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed', 'refunded')),
  stripe_payment_intent_id TEXT,
  transaction_ref TEXT,
  notes TEXT,
  recorded_by UUID REFERENCES user_profiles(id),
  paid_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- Indexes
-- ============================================
CREATE INDEX IF NOT EXISTS idx_company_subscriptions_company ON company_subscriptions(company_id);
CREATE INDEX IF NOT EXISTS idx_company_subscriptions_status ON company_subscriptions(status);
CREATE INDEX IF NOT EXISTS idx_billing_invoices_company ON billing_invoices(company_id);
CREATE INDEX IF NOT EXISTS idx_billing_invoices_status ON billing_invoices(status);
CREATE INDEX IF NOT EXISTS idx_payment_history_company ON payment_history(company_id);
CREATE INDEX IF NOT EXISTS idx_payment_history_invoice ON payment_history(invoice_id);

-- ============================================
-- Auto-update timestamps
-- ============================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_subscription_plans_updated_at ON subscription_plans;
CREATE TRIGGER update_subscription_plans_updated_at
  BEFORE UPDATE ON subscription_plans
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_company_subscriptions_updated_at ON company_subscriptions;
CREATE TRIGGER update_company_subscriptions_updated_at
  BEFORE UPDATE ON company_subscriptions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_billing_invoices_updated_at ON billing_invoices;
CREATE TRIGGER update_billing_invoices_updated_at
  BEFORE UPDATE ON billing_invoices
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- RLS Policies
-- ============================================

-- subscription_plans: everyone can read, only super_admin can mutate
ALTER TABLE subscription_plans ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view active plans"
  ON subscription_plans FOR SELECT
  USING (true);

CREATE POLICY "Super admin manages plans"
  ON subscription_plans FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'super_admin')
  );

-- company_subscriptions: company admins see own, super_admin sees all
ALTER TABLE company_subscriptions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Super admin full access to subscriptions"
  ON company_subscriptions FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'super_admin')
  );

CREATE POLICY "Company admins view own subscription"
  ON company_subscriptions FOR SELECT
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
    )
  );

-- billing_invoices: company admins see own, super_admin full access
ALTER TABLE billing_invoices ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Super admin full access to invoices"
  ON billing_invoices FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'super_admin')
  );

CREATE POLICY "Company admins view own invoices"
  ON billing_invoices FOR SELECT
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
    )
  );

-- payment_history: same pattern
ALTER TABLE payment_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Super admin full access to payments"
  ON payment_history FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'super_admin')
  );

CREATE POLICY "Company admins view own payments"
  ON payment_history FOR SELECT
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles
      WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
    )
  );

-- ============================================
-- Seed: Starter Plans
-- ============================================
INSERT INTO subscription_plans (name, description, billing_period, base_price, included_users, price_per_additional_user, features, sort_order)
VALUES
  ('Starter', 'Essential features for small shops', 'monthly', 0.00, 5, 0.00, '{"inventory": true, "estimates": true, "invoices": true, "counts": true, "analytics": false, "reorder": false}', 1),
  ('Starter', 'Essential features for small shops (annual)', 'annual', 0.00, 5, 0.00, '{"inventory": true, "estimates": true, "invoices": true, "counts": true, "analytics": false, "reorder": false}', 2),
  ('Professional', 'Full features with analytics & reorder', 'monthly', 0.00, 5, 0.00, '{"inventory": true, "estimates": true, "invoices": true, "counts": true, "analytics": true, "reorder": true}', 3),
  ('Professional', 'Full features with analytics & reorder (annual)', 'annual', 0.00, 5, 0.00, '{"inventory": true, "estimates": true, "invoices": true, "counts": true, "analytics": true, "reorder": true}', 4),
  ('Enterprise', 'Multi-location with corporate admin', 'monthly', 0.00, 5, 0.00, '{"inventory": true, "estimates": true, "invoices": true, "counts": true, "analytics": true, "reorder": true, "corporate": true, "multi_location": true}', 5),
  ('Enterprise', 'Multi-location with corporate admin (annual)', 'annual', 0.00, 5, 0.00, '{"inventory": true, "estimates": true, "invoices": true, "counts": true, "analytics": true, "reorder": true, "corporate": true, "multi_location": true}', 6);

-- Assign all existing companies a trial subscription using the Starter monthly plan
INSERT INTO company_subscriptions (company_id, plan_id, billing_period, current_price, status, current_period_end)
SELECT
  c.id,
  (SELECT id FROM subscription_plans WHERE name = 'Starter' AND billing_period = 'monthly' LIMIT 1),
  'monthly',
  0.00,
  'trial',
  CURRENT_DATE + INTERVAL '30 days'
FROM companies c
WHERE NOT EXISTS (
  SELECT 1 FROM company_subscriptions cs WHERE cs.company_id = c.id
);
