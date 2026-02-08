-- Populate manufacturer, brand, and product_line for all products
-- These fields were added in 20260206 but never populated for existing products

-- Set manufacturer from supplier field where manufacturer is NULL
UPDATE products
SET manufacturer = supplier
WHERE manufacturer IS NULL AND supplier IS NOT NULL;

-- Set brand from supplier where brand is NULL
UPDATE products
SET brand = supplier
WHERE brand IS NULL AND supplier IS NOT NULL;

-- Derive product_line from category for products where product_line is NULL
UPDATE products
SET product_line = CASE
  WHEN category IN ('Clear Coat', 'Clearcoat') THEN 'Clearcoats'
  WHEN category IN ('Base Coat', 'Basecoat') THEN 'Basecoats'
  WHEN category IN ('Primer', 'Primer Surfacer', 'Primer Sealer') THEN 'Primers'
  WHEN category IN ('Hardener', 'Activator') THEN 'Hardeners & Activators'
  WHEN category IN ('Reducer', 'Solvent', 'Thinner') THEN 'Reducers & Solvents'
  WHEN category IN ('Adhesion Promoter', 'Adhesion') THEN 'Specialty'
  WHEN category IN ('Sealer') THEN 'Sealers'
  WHEN category IN ('Topcoat', 'Single Stage') THEN 'Topcoats'
  WHEN category IN ('Abrasives', 'Sandpaper') THEN 'Abrasives'
  WHEN category IN ('Masking', 'Tape') THEN 'Masking Supplies'
  WHEN category IN ('Body Filler', 'Filler', 'Putty') THEN 'Body Fillers'
  WHEN category IN ('Polish', 'Compound', 'Buffing') THEN 'Finishing'
  WHEN category IN ('Safety', 'PPE') THEN 'Safety Equipment'
  WHEN category IN ('Consumables') THEN 'Consumables'
  ELSE 'General'
END
WHERE product_line IS NULL AND category IS NOT NULL;

-- Also set CHC Paint and Auto Body on a permanent Enterprise plan at $0
-- This makes them the demo company
DO $$
DECLARE
  v_chc_id uuid;
  v_plan_id uuid;
  v_sub_id uuid;
BEGIN
  -- Find CHC company
  SELECT id INTO v_chc_id FROM companies WHERE name ILIKE '%CHC%' LIMIT 1;
  IF v_chc_id IS NULL THEN
    RAISE NOTICE 'CHC company not found — skipping permanent plan assignment';
    RETURN;
  END IF;

  -- Find Enterprise annual plan
  SELECT id INTO v_plan_id FROM subscription_plans
  WHERE name = 'Enterprise' AND billing_period = 'annual' LIMIT 1;
  IF v_plan_id IS NULL THEN
    RAISE NOTICE 'Enterprise annual plan not found — skipping';
    RETURN;
  END IF;

  -- Delete any existing subscription for CHC
  DELETE FROM company_subscriptions WHERE company_id = v_chc_id;

  -- Insert permanent Enterprise subscription (expires in 100 years)
  INSERT INTO company_subscriptions (
    company_id, plan_id, billing_period, current_price,
    additional_users_purchased, status,
    started_at, current_period_start, current_period_end,
    auto_renew
  ) VALUES (
    v_chc_id, v_plan_id, 'annual', 0.00,
    0, 'active',
    NOW(), CURRENT_DATE, CURRENT_DATE + INTERVAL '100 years',
    false
  ) RETURNING id INTO v_sub_id;

  -- Update company status
  UPDATE companies
  SET subscription_status = 'active',
      subscription_ends_at = CURRENT_DATE + INTERVAL '100 years'
  WHERE id = v_chc_id;

  RAISE NOTICE 'CHC Paint set to permanent Enterprise plan (sub_id: %)', v_sub_id;
END $$;
