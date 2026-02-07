-- Populate PPG product inventory for CHC Paint and Auto Body
-- Assigns company_id to PPG products and creates inventory_stock records

DO $$
DECLARE
  v_chc_id uuid;
  v_count integer;
BEGIN
  -- Find CHC company
  SELECT id INTO v_chc_id FROM companies WHERE name ILIKE '%CHC%' LIMIT 1;
  IF v_chc_id IS NULL THEN
    RAISE NOTICE 'CHC company not found — skipping inventory population';
    RETURN;
  END IF;

  -- Assign PPG products to CHC (where company_id is NULL)
  UPDATE products
  SET company_id = v_chc_id
  WHERE supplier = 'PPG'
    AND (company_id IS NULL);

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Assigned % PPG products to CHC', v_count;

  -- Create inventory_stock records with qty 1-2 for products that don't have one
  INSERT INTO inventory_stock (product_id, quantity_on_hand, reorder_point, reorder_quantity)
  SELECT
    p.id,
    CASE WHEN random() > 0.5 THEN 2 ELSE 1 END,
    CASE
      WHEN p.category IN ('Clear Coat', 'Primer', 'Base Coat', 'Basecoat') THEN 5
      WHEN p.category IN ('Abrasives', 'Consumables', 'Safety') THEN 20
      ELSE 10
    END,
    CASE
      WHEN p.category IN ('Clear Coat', 'Primer', 'Base Coat', 'Basecoat') THEN 10
      WHEN p.category IN ('Abrasives', 'Consumables', 'Safety') THEN 50
      ELSE 20
    END
  FROM products p
  LEFT JOIN inventory_stock s ON p.id = s.product_id
  WHERE p.company_id = v_chc_id
    AND s.id IS NULL;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Created % inventory_stock records', v_count;

  -- Update existing zero-quantity stock records to 1-2
  UPDATE inventory_stock
  SET quantity_on_hand = CASE WHEN random() > 0.5 THEN 2 ELSE 1 END,
      last_updated = now()
  WHERE product_id IN (SELECT id FROM products WHERE company_id = v_chc_id)
    AND quantity_on_hand = 0;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Updated % zero-quantity stock records to 1-2', v_count;

END $$;
