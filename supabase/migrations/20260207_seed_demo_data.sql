-- ============================================================
-- DEMO DATA: CHC Paint and Auto Body + TEST Co
-- Realistic auto body shop estimates & invoices (Jan-Feb 2026)
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. CREATE TEST Co COMPANY
-- ────────────────────────────────────────────────────────────
INSERT INTO companies (id, name, email, subscription_status)
VALUES (
  'aaaaaaaa-bbbb-cccc-dddd-000000000002',
  'TEST Co',
  'admin@testco.com',
  'trial'
)
ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name;

-- ────────────────────────────────────────────────────────────
-- 2. GET CHC COMPANY ID (dynamic lookup)
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_chc_id uuid;
  v_sf_id uuid;    -- State Farm
  v_geico_id uuid; -- GEICO
  v_prog_id uuid;  -- Progressive
  v_alls_id uuid;  -- Allstate
  v_lbmy_id uuid;  -- Liberty Mutual
  v_cust_id uuid;  -- Customer Pay
  v_usaa_id uuid;  -- USAA

  -- Vehicle IDs
  v_veh1 uuid; v_veh2 uuid; v_veh3 uuid; v_veh4 uuid; v_veh5 uuid;
  v_veh6 uuid; v_veh7 uuid; v_veh8 uuid; v_veh9 uuid; v_veh10 uuid;
  v_veh11 uuid; v_veh12 uuid; v_veh13 uuid; v_veh14 uuid; v_veh15 uuid;

  -- Estimate IDs
  v_est1 uuid; v_est2 uuid; v_est3 uuid; v_est4 uuid; v_est5 uuid;
  v_est6 uuid; v_est7 uuid; v_est8 uuid; v_est9 uuid; v_est10 uuid;
  v_est11 uuid; v_est12 uuid; v_est13 uuid; v_est14 uuid; v_est15 uuid;

  -- Invoice IDs
  v_inv1 uuid; v_inv2 uuid; v_inv3 uuid; v_inv4 uuid; v_inv5 uuid;
  v_inv6 uuid; v_inv7 uuid; v_inv8 uuid; v_inv9 uuid; v_inv10 uuid;
  v_inv11 uuid; v_inv12 uuid;

BEGIN
  -- Look up CHC company
  SELECT id INTO v_chc_id FROM companies WHERE name ILIKE '%CHC%' LIMIT 1;
  IF v_chc_id IS NULL THEN
    RAISE NOTICE 'CHC company not found — skipping demo data';
    RETURN;
  END IF;

  -- Look up insurance companies
  SELECT id INTO v_sf_id FROM insurance_companies WHERE code = 'STFM';
  SELECT id INTO v_geico_id FROM insurance_companies WHERE code = 'GECO';
  SELECT id INTO v_prog_id FROM insurance_companies WHERE code = 'PROG';
  SELECT id INTO v_alls_id FROM insurance_companies WHERE code = 'ALLS';
  SELECT id INTO v_lbmy_id FROM insurance_companies WHERE code = 'LBMY';
  SELECT id INTO v_cust_id FROM insurance_companies WHERE code = 'CUST';
  SELECT id INTO v_usaa_id FROM insurance_companies WHERE code = 'USAA';

  -- ────────────────────────────────────────────────────────
  -- 3. CREATE VEHICLES
  -- ────────────────────────────────────────────────────────
  INSERT INTO vehicles (id, vin, year, make, model, body_style, company_id) VALUES
    (gen_random_uuid(), '1HGCV1F34LA000101', 2020, 'Honda', 'Civic', 'Sedan', v_chc_id),
    (gen_random_uuid(), '2T1BURHE5JC000202', 2018, 'Toyota', 'Corolla', 'Sedan', v_chc_id),
    (gen_random_uuid(), '1FTEW1EP5LK000303', 2020, 'Ford', 'F-150', 'Crew Cab', v_chc_id),
    (gen_random_uuid(), '5YJ3E1EA7NF000404', 2022, 'Tesla', 'Model 3', 'Sedan', v_chc_id),
    (gen_random_uuid(), '1G1YY22G965000505', 2023, 'Chevrolet', 'Corvette', 'Coupe', v_chc_id),
    (gen_random_uuid(), 'WBAPH5C55BA000606', 2019, 'BMW', '328i', 'Sedan', v_chc_id),
    (gen_random_uuid(), '5YJSA1E26MF000707', 2021, 'Tesla', 'Model S', 'Sedan', v_chc_id),
    (gen_random_uuid(), '2HKRW2H54MH000808', 2021, 'Honda', 'CR-V', 'SUV', v_chc_id),
    (gen_random_uuid(), '4T1BF1FK8EU000909', 2014, 'Toyota', 'Camry', 'Sedan', v_chc_id),
    (gen_random_uuid(), '1N4AL3AP8EC001010', 2022, 'Nissan', 'Altima', 'Sedan', v_chc_id),
    (gen_random_uuid(), '3FA6P0HD5LR001111', 2020, 'Ford', 'Fusion', 'Sedan', v_chc_id),
    (gen_random_uuid(), 'JN8AS5MT9DW001212', 2023, 'Nissan', 'Rogue', 'SUV', v_chc_id),
    (gen_random_uuid(), '1C4RJFAG1FC001313', 2015, 'Jeep', 'Grand Cherokee', 'SUV', v_chc_id),
    (gen_random_uuid(), 'WA1LAAF77PD001414', 2023, 'Audi', 'Q5', 'SUV', v_chc_id),
    (gen_random_uuid(), 'WDDWJ8KB0KF001515', 2019, 'Mercedes-Benz', 'C300', 'Sedan', v_chc_id)
  ON CONFLICT (vin) DO NOTHING;

  -- Retrieve vehicle IDs
  SELECT id INTO v_veh1 FROM vehicles WHERE vin = '1HGCV1F34LA000101';
  SELECT id INTO v_veh2 FROM vehicles WHERE vin = '2T1BURHE5JC000202';
  SELECT id INTO v_veh3 FROM vehicles WHERE vin = '1FTEW1EP5LK000303';
  SELECT id INTO v_veh4 FROM vehicles WHERE vin = '5YJ3E1EA7NF000404';
  SELECT id INTO v_veh5 FROM vehicles WHERE vin = '1G1YY22G965000505';
  SELECT id INTO v_veh6 FROM vehicles WHERE vin = 'WBAPH5C55BA000606';
  SELECT id INTO v_veh7 FROM vehicles WHERE vin = '5YJSA1E26MF000707';
  SELECT id INTO v_veh8 FROM vehicles WHERE vin = '2HKRW2H54MH000808';
  SELECT id INTO v_veh9 FROM vehicles WHERE vin = '4T1BF1FK8EU000909';
  SELECT id INTO v_veh10 FROM vehicles WHERE vin = '1N4AL3AP8EC001010';
  SELECT id INTO v_veh11 FROM vehicles WHERE vin = '3FA6P0HD5LR001111';
  SELECT id INTO v_veh12 FROM vehicles WHERE vin = 'JN8AS5MT9DW001212';
  SELECT id INTO v_veh13 FROM vehicles WHERE vin = '1C4RJFAG1FC001313';
  SELECT id INTO v_veh14 FROM vehicles WHERE vin = 'WA1LAAF77PD001414';
  SELECT id INTO v_veh15 FROM vehicles WHERE vin = 'WDDWJ8KB0KF001515';

  -- ────────────────────────────────────────────────────────
  -- 4. CREATE 15 ESTIMATES (Jan & Feb 2026)
  --    Mix of statuses: Completed, In Progress, Approved, Quoted
  -- ────────────────────────────────────────────────────────

  -- EST-2026-001: 2020 Honda Civic rear-end collision (State Farm)
  v_est1 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, mechanical_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_est1, v_chc_id, 'EST-2026-001', '1HGCV1F34LA000101', v_veh1, 'Robert Martinez',
    '2026-01-03', '2026-01-06', 'Completed', 3847.50, 'Mitchell',
    v_sf_id, 'SF-2026-44821',
    8.5, 4.2, 0.5,
    1636.80, 1485.70, 475.00, 250.00, 500.00);

  -- EST-2026-002: 2018 Toyota Corolla front fender repair (GEICO)
  v_est2 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est2, v_chc_id, 'EST-2026-002', '2T1BURHE5JC000202', v_veh2, 'Sarah Johnson',
    '2026-01-06', '2026-01-08', 'Completed', 2156.30, 'Mitchell',
    v_geico_id, 'GK-2026-77103',
    4.0, 3.5,
    930.00, 842.30, 384.00, 500.00);

  -- EST-2026-003: 2020 Ford F-150 full bed side and tailgate (Progressive)
  v_est3 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, structural_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_est3, v_chc_id, 'EST-2026-003', '1FTEW1EP5LK000303', v_veh3, 'James Wilson',
    '2026-01-08', '2026-01-13', 'Completed', 6542.80, 'Mitchell',
    v_prog_id, 'PG-2026-00918',
    14.0, 6.5, 2.0,
    2790.00, 2340.80, 912.00, 500.00, 1000.00);

  -- EST-2026-004: 2022 Tesla Model 3 front bumper + hood (Allstate) — aluminum
  v_est4 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, aluminum_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est4, v_chc_id, 'EST-2026-004', '5YJ3E1EA7NF000404', v_veh4, 'Emily Chen',
    '2026-01-10', '2026-01-14', 'Completed', 5890.40, 'Mitchell',
    v_alls_id, 'AL-2026-33091',
    6.0, 5.0, 4.5,
    2092.50, 2680.90, 1117.00, 500.00);

  -- EST-2026-005: 2023 Corvette quarter panel blend (Customer Pay)
  v_est5 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est5, v_chc_id, 'EST-2026-005', '1G1YY22G965000505', v_veh5, 'Michael Davis',
    '2026-01-14', '2026-01-16', 'Completed', 4275.00, 'Manual',
    v_cust_id,
    5.0, 6.0,
    1485.00, 1890.00, 900.00, 0.00);

  -- EST-2026-006: 2019 BMW 328i door and fender (Liberty Mutual)
  v_est6 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est6, v_chc_id, 'EST-2026-006', 'WBAPH5C55BA000606', v_veh6, 'Amanda Thompson',
    '2026-01-17', '2026-01-20', 'Completed', 3410.60, 'Mitchell',
    v_lbmy_id, 'LM-2026-55620',
    6.5, 4.0,
    1302.00, 1476.60, 632.00, 500.00);

  -- EST-2026-007: 2021 Tesla Model S side collision (USAA)
  v_est7 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, aluminum_labor_hours, structural_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_est7, v_chc_id, 'EST-2026-007', '5YJSA1E26MF000707', v_veh7, 'David Park',
    '2026-01-21', '2026-01-27', 'Completed', 8920.50, 'Mitchell',
    v_usaa_id, 'US-2026-98412',
    10.0, 7.5, 5.0, 3.0,
    3442.50, 3650.00, 1328.00, 500.00, 1000.00);

  -- EST-2026-008: 2021 Honda CR-V rear bumper + liftgate (State Farm)
  v_est8 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est8, v_chc_id, 'EST-2026-008', '2HKRW2H54MH000808', v_veh8, 'Jennifer Lopez',
    '2026-01-24', '2026-01-28', 'Completed', 2965.80, 'Mitchell',
    v_sf_id, 'SF-2026-61204',
    5.5, 3.5,
    1116.00, 1287.80, 562.00, 500.00);

  -- EST-2026-009: 2014 Toyota Camry full repaint (Customer Pay)
  v_est9 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est9, v_chc_id, 'EST-2026-009', '4T1BF1FK8EU000909', v_veh9, 'William Brown',
    '2026-01-28', '2026-02-02', 'Completed', 5420.00, 'Manual',
    v_cust_id,
    8.0, 16.0,
    2880.00, 340.00, 2200.00, 0.00);

  -- EST-2026-010: 2022 Nissan Altima front-end collision (GEICO)
  v_est10 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, mechanical_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_est10, v_chc_id, 'EST-2026-010', '1N4AL3AP8EC001010', v_veh10, 'Lisa Nguyen',
    '2026-02-03', '2026-02-05', 'Completed', 4180.20, 'Mitchell',
    v_geico_id, 'GK-2026-88215',
    7.5, 4.5, 1.5,
    1674.00, 1680.20, 576.00, 250.00, 500.00);

  -- EST-2026-011: 2020 Ford Fusion door ding repair (Customer Pay)
  v_est11 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est11, v_chc_id, 'EST-2026-011', '3FA6P0HD5LR001111', v_veh11, 'Kevin O''Brien',
    '2026-02-05', '2026-02-07', 'Completed', 1285.00, 'Manual',
    v_cust_id,
    2.0, 2.5,
    540.00, 445.00, 300.00, 0.00);

  -- EST-2026-012: 2023 Nissan Rogue rear quarter + bumper (Progressive)
  v_est12 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est12, v_chc_id, 'EST-2026-012', 'JN8AS5MT9DW001212', v_veh12, 'Rachel Kim',
    '2026-02-07', '2026-02-10', 'In Progress', 3740.90, 'Mitchell',
    v_prog_id, 'PG-2026-12847',
    7.0, 4.5,
    1426.00, 1598.90, 716.00, 500.00);

  -- EST-2026-013: 2015 Jeep Grand Cherokee hood + grille (Allstate)
  v_est13 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, mechanical_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est13, v_chc_id, 'EST-2026-013', '1C4RJFAG1FC001313', v_veh13, 'Thomas Garcia',
    '2026-02-10', '2026-02-13', 'Approved', 2890.50, 'Mitchell',
    v_alls_id, 'AL-2026-47302',
    5.0, 3.0, 1.0,
    1116.00, 1224.50, 550.00, 500.00);

  -- EST-2026-014: 2023 Audi Q5 full side repair (Liberty Mutual)
  v_est14 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, aluminum_labor_hours, structural_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_est14, v_chc_id, 'EST-2026-014', 'WA1LAAF77PD001414', v_veh14, 'Stephanie White',
    '2026-02-12', '2026-02-17', 'Quoted', 7650.00, 'Mitchell',
    v_lbmy_id, 'LM-2026-73016',
    12.0, 8.0, 3.0, 2.0,
    3375.00, 2850.00, 1125.00, 300.00, 1000.00);

  -- EST-2026-015: 2019 Mercedes C300 bumper + blend (USAA)
  v_est15 := gen_random_uuid();
  INSERT INTO estimates (id, company_id, estimate_number, vin, vehicle_id, customer_name,
    estimate_date, expected_start_date, status, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_est15, v_chc_id, 'EST-2026-015', 'WDDWJ8KB0KF001515', v_veh15, 'Daniel Reed',
    '2026-02-14', NULL, 'Quoted', 3125.00, 'Mitchell',
    v_usaa_id, 'US-2026-15740',
    4.5, 4.0,
    1147.50, 1340.00, 637.50, 500.00);

  -- ────────────────────────────────────────────────────────
  -- 5. ESTIMATE LINE ITEMS (representative items per estimate)
  -- ────────────────────────────────────────────────────────

  -- EST-001: Rear bumper cover, trunk lid, refinish
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est1, 'R&I Rear Bumper Cover', 1, 185.00, 185.00, false),
    (v_est1, 'Repair Rear Bumper Cover', 1, 340.00, 340.00, false),
    (v_est1, 'R&I Trunk Lid', 1, 210.00, 210.00, false),
    (v_est1, 'Repair Trunk Lid', 1, 425.00, 425.00, false),
    (v_est1, 'Refinish Rear Bumper Cover — Basecoat/Clearcoat', 1, 520.00, 520.00, true),
    (v_est1, 'Refinish Trunk Lid — Basecoat/Clearcoat', 1, 480.00, 480.00, true),
    (v_est1, 'Blend Left Quarter Panel', 1, 310.00, 310.00, true),
    (v_est1, 'Paint Materials — Primer, Base, Clear', 1, 475.00, 475.00, true),
    (v_est1, 'Rear Bumper Reinforcement Bar', 1, 285.70, 285.70, false),
    (v_est1, 'Sublet — Wheel Alignment', 1, 250.00, 250.00, false),
    (v_est1, 'Hazardous Waste Disposal', 1, 42.50, 42.50, false),
    (v_est1, 'Color Tint / Match', 1, 85.00, 85.00, true);

  -- EST-002: Front fender repair
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est2, 'R&I Front Fender - Right', 1, 165.00, 165.00, false),
    (v_est2, 'Repair Front Fender - Right', 1, 380.00, 380.00, false),
    (v_est2, 'Refinish Front Fender — Basecoat/Clearcoat', 1, 445.00, 445.00, true),
    (v_est2, 'Blend Front Door - Right', 1, 285.00, 285.00, true),
    (v_est2, 'Paint Materials — Primer, Base, Clear', 1, 384.00, 384.00, true),
    (v_est2, 'Fender Liner (OEM)', 1, 142.30, 142.30, false),
    (v_est2, 'Color Tint / Match', 1, 75.00, 75.00, true),
    (v_est2, 'Corrosion Protection', 1, 45.00, 45.00, false);

  -- EST-003: F-150 bed side + tailgate
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est3, 'Replace Bed Side Panel - Right (OEM)', 1, 1240.80, 1240.80, false),
    (v_est3, 'Body Labor — Bed Side Install', 1, 840.00, 840.00, false),
    (v_est3, 'R&I Tailgate', 1, 220.00, 220.00, false),
    (v_est3, 'Repair Tailgate', 1, 560.00, 560.00, false),
    (v_est3, 'Structural — Frame Pull', 1, 480.00, 480.00, false),
    (v_est3, 'Refinish Bed Side — Basecoat/Clearcoat', 1, 680.00, 680.00, true),
    (v_est3, 'Refinish Tailgate — Basecoat/Clearcoat', 1, 520.00, 520.00, true),
    (v_est3, 'Blend Rear Bumper', 1, 310.00, 310.00, true),
    (v_est3, 'Paint Materials — Primer, Base, Clear', 1, 912.00, 912.00, true),
    (v_est3, 'Tailgate Handle Assembly', 1, 189.00, 189.00, false),
    (v_est3, 'Bed Liner Section Repair', 1, 125.00, 125.00, false),
    (v_est3, 'Sublet — Alignment', 1, 250.00, 250.00, false),
    (v_est3, 'Hazardous Waste Disposal', 1, 42.50, 42.50, false);

  -- EST-004: Tesla Model 3 front bumper + hood (aluminum)
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est4, 'Replace Front Bumper Cover (OEM Tesla)', 1, 1280.00, 1280.00, false),
    (v_est4, 'R&I Hood — Aluminum', 1, 285.00, 285.00, false),
    (v_est4, 'Repair Hood — Aluminum PDR', 1, 420.00, 420.00, false),
    (v_est4, 'Aluminum Labor — Hood Straighten', 1, 607.50, 607.50, false),
    (v_est4, 'Refinish Front Bumper — Multi-Stage', 1, 680.00, 680.00, true),
    (v_est4, 'Refinish Hood — Basecoat/Clearcoat', 1, 620.00, 620.00, true),
    (v_est4, 'Blend Front Fenders (L+R)', 1, 540.00, 540.00, true),
    (v_est4, 'Paint Materials — Primer, Base, Clear', 1, 1117.00, 1117.00, true),
    (v_est4, 'Front Bumper Brackets', 1, 165.90, 165.90, false),
    (v_est4, 'Parking Sensor Recalibration', 1, 175.00, 175.00, false);

  -- EST-005: Corvette quarter panel blend
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est5, 'Repair Quarter Panel - Left', 1, 680.00, 680.00, false),
    (v_est5, 'Refinish Quarter Panel — Tri-Coat', 1, 820.00, 820.00, true),
    (v_est5, 'Blend Rear Bumper — Tri-Coat', 1, 480.00, 480.00, true),
    (v_est5, 'Blend Door - Left — Tri-Coat', 1, 410.00, 410.00, true),
    (v_est5, 'Paint Materials — Primer, Base, Mid, Clear (Tri-Coat)', 1, 900.00, 900.00, true),
    (v_est5, 'Color Tint / Match — Specialty', 1, 150.00, 150.00, true),
    (v_est5, 'Corrosion Protection', 1, 55.00, 55.00, false),
    (v_est5, 'Detail / Clean-up', 1, 120.00, 120.00, false);

  -- EST-006: BMW door and fender
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est6, 'R&I Front Door - Left', 1, 195.00, 195.00, false),
    (v_est6, 'Repair Front Door - Left', 1, 420.00, 420.00, false),
    (v_est6, 'R&I Front Fender - Left', 1, 175.00, 175.00, false),
    (v_est6, 'Repair Front Fender - Left', 1, 345.00, 345.00, false),
    (v_est6, 'Refinish Door — Basecoat/Clearcoat', 1, 485.00, 485.00, true),
    (v_est6, 'Refinish Fender — Basecoat/Clearcoat', 1, 425.00, 425.00, true),
    (v_est6, 'Blend A-Pillar', 1, 185.00, 185.00, true),
    (v_est6, 'Paint Materials — Primer, Base, Clear', 1, 632.00, 632.00, true),
    (v_est6, 'Door Molding (OEM)', 1, 156.60, 156.60, false),
    (v_est6, 'Corrosion Protection', 1, 48.00, 48.00, false);

  -- EST-007: Tesla Model S side collision
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est7, 'Replace Rocker Panel - Left (OEM Tesla)', 1, 1420.00, 1420.00, false),
    (v_est7, 'Replace Front Door - Left (OEM Tesla)', 1, 1650.00, 1650.00, false),
    (v_est7, 'Body Labor — Door Hang & Fit', 1, 480.00, 480.00, false),
    (v_est7, 'Aluminum Labor — Rocker Section', 1, 675.00, 675.00, false),
    (v_est7, 'Structural — B-Pillar Reinforcement', 1, 720.00, 720.00, false),
    (v_est7, 'Refinish Door - Left — Basecoat/Clearcoat', 1, 580.00, 580.00, true),
    (v_est7, 'Refinish Rocker — Basecoat/Clearcoat', 1, 320.00, 320.00, true),
    (v_est7, 'Refinish Quarter Panel — Blend', 1, 480.00, 480.00, true),
    (v_est7, 'Paint Materials — Primer, Base, Clear', 1, 1328.00, 1328.00, true),
    (v_est7, 'Sublet — ADAS Recalibration', 1, 500.00, 500.00, false),
    (v_est7, 'Seam Sealer / Anti-Corrosion', 1, 125.00, 125.00, false),
    (v_est7, 'Hazardous Waste Disposal', 1, 42.50, 42.50, false);

  -- EST-008: Honda CR-V rear bumper + liftgate
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est8, 'R&I Rear Bumper Cover', 1, 175.00, 175.00, false),
    (v_est8, 'Replace Rear Bumper Cover (OEM)', 1, 487.80, 487.80, false),
    (v_est8, 'R&I Liftgate', 1, 195.00, 195.00, false),
    (v_est8, 'Repair Liftgate', 1, 380.00, 380.00, false),
    (v_est8, 'Refinish Rear Bumper — Basecoat/Clearcoat', 1, 420.00, 420.00, true),
    (v_est8, 'Refinish Liftgate — Basecoat/Clearcoat', 1, 480.00, 480.00, true),
    (v_est8, 'Paint Materials — Primer, Base, Clear', 1, 562.00, 562.00, true),
    (v_est8, 'Rear Bumper Energy Absorber', 1, 165.00, 165.00, false),
    (v_est8, 'Color Tint / Match', 1, 75.00, 75.00, true);

  -- EST-009: Camry full repaint
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est9, 'Full Body Prep — Sand & Scuff All Panels', 1, 960.00, 960.00, false),
    (v_est9, 'Mask Vehicle — Full Repaint', 1, 480.00, 480.00, false),
    (v_est9, 'R&I All Trim, Moldings, Handles', 1, 540.00, 540.00, false),
    (v_est9, 'Refinish All Panels — Basecoat/Clearcoat', 1, 1920.00, 1920.00, true),
    (v_est9, 'Paint Materials — Full Vehicle (Primer, Base, Clear)', 1, 2200.00, 2200.00, true),
    (v_est9, 'Jambs — Door, Hood, Trunk', 1, 480.00, 480.00, true),
    (v_est9, 'Door Edge Guards', 4, 15.00, 60.00, false),
    (v_est9, 'Detail / Final Buff & Polish', 1, 280.00, 280.00, false);

  -- EST-010: Nissan Altima front-end collision
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est10, 'Replace Front Bumper Cover (OEM)', 1, 520.20, 520.20, false),
    (v_est10, 'R&I Hood', 1, 185.00, 185.00, false),
    (v_est10, 'Repair Hood', 1, 480.00, 480.00, false),
    (v_est10, 'Repair Front Fender - Left', 1, 340.00, 340.00, false),
    (v_est10, 'Mechanical — Radiator Support Check', 1, 186.00, 186.00, false),
    (v_est10, 'Refinish Front Bumper — Basecoat/Clearcoat', 1, 445.00, 445.00, true),
    (v_est10, 'Refinish Hood — Basecoat/Clearcoat', 1, 520.00, 520.00, true),
    (v_est10, 'Refinish Fender — Blend', 1, 310.00, 310.00, true),
    (v_est10, 'Paint Materials — Primer, Base, Clear', 1, 576.00, 576.00, true),
    (v_est10, 'Headlamp Assembly - Left (Aftermarket)', 1, 210.00, 210.00, false),
    (v_est10, 'Sublet — Headlamp Aim', 1, 85.00, 85.00, false),
    (v_est10, 'Hazardous Waste Disposal', 1, 42.50, 42.50, false);

  -- EST-011: Ford Fusion door ding
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est11, 'Repair Door - Right (Minor Dent)', 1, 240.00, 240.00, false),
    (v_est11, 'Refinish Door - Right — Basecoat/Clearcoat', 1, 445.00, 445.00, true),
    (v_est11, 'Blend Front Fender - Right', 1, 260.00, 260.00, true),
    (v_est11, 'Paint Materials — Primer, Base, Clear', 1, 300.00, 300.00, true),
    (v_est11, 'Color Tint / Match', 1, 65.00, 65.00, true);

  -- EST-012: Nissan Rogue rear quarter + bumper
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est12, 'Repair Quarter Panel - Right', 1, 620.00, 620.00, false),
    (v_est12, 'R&I Rear Bumper Cover', 1, 175.00, 175.00, false),
    (v_est12, 'Repair Rear Bumper Cover', 1, 280.00, 280.00, false),
    (v_est12, 'Refinish Quarter Panel — Basecoat/Clearcoat', 1, 560.00, 560.00, true),
    (v_est12, 'Refinish Rear Bumper — Basecoat/Clearcoat', 1, 420.00, 420.00, true),
    (v_est12, 'Blend Rear Door - Right', 1, 285.00, 285.00, true),
    (v_est12, 'Paint Materials — Primer, Base, Clear', 1, 716.00, 716.00, true),
    (v_est12, 'Tail Lamp Assembly - Right', 1, 198.90, 198.90, false),
    (v_est12, 'Corrosion Protection', 1, 48.00, 48.00, false);

  -- EST-013: Jeep Grand Cherokee hood + grille
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est13, 'R&I Hood', 1, 195.00, 195.00, false),
    (v_est13, 'Repair Hood', 1, 460.00, 460.00, false),
    (v_est13, 'Replace Grille Assembly (OEM)', 1, 324.50, 324.50, false),
    (v_est13, 'Mechanical — Latch/Hinge Adjustment', 1, 124.00, 124.00, false),
    (v_est13, 'Refinish Hood — Basecoat/Clearcoat', 1, 540.00, 540.00, true),
    (v_est13, 'Blend Front Fenders (L+R)', 1, 420.00, 420.00, true),
    (v_est13, 'Paint Materials — Primer, Base, Clear', 1, 550.00, 550.00, true),
    (v_est13, 'Color Tint / Match', 1, 75.00, 75.00, true);

  -- EST-014: Audi Q5 full side repair
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est14, 'Replace Front Door - Left (OEM Audi)', 1, 1450.00, 1450.00, false),
    (v_est14, 'Repair Rear Door - Left', 1, 580.00, 580.00, false),
    (v_est14, 'Repair Quarter Panel - Left', 1, 720.00, 720.00, false),
    (v_est14, 'Aluminum Labor — Door Structure', 1, 405.00, 405.00, false),
    (v_est14, 'Structural — Hinge Pillar Check', 1, 480.00, 480.00, false),
    (v_est14, 'Refinish Front Door — Basecoat/Clearcoat', 1, 580.00, 580.00, true),
    (v_est14, 'Refinish Rear Door — Basecoat/Clearcoat', 1, 520.00, 520.00, true),
    (v_est14, 'Refinish Quarter Panel — Basecoat/Clearcoat', 1, 620.00, 620.00, true),
    (v_est14, 'Blend Rocker + Front Fender', 1, 450.00, 450.00, true),
    (v_est14, 'Paint Materials — Primer, Base, Clear', 1, 1125.00, 1125.00, true),
    (v_est14, 'Sublet — ADAS Recalibration', 1, 300.00, 300.00, false),
    (v_est14, 'Door Handle + Moldings (OEM)', 1, 285.00, 285.00, false),
    (v_est14, 'Seam Sealer / Anti-Corrosion', 1, 95.00, 95.00, false);

  -- EST-015: Mercedes C300 bumper + blend
  INSERT INTO estimate_line_items (estimate_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_est15, 'R&I Rear Bumper Cover', 1, 210.00, 210.00, false),
    (v_est15, 'Replace Rear Bumper Cover (OEM Mercedes)', 1, 780.00, 780.00, false),
    (v_est15, 'Refinish Rear Bumper — Basecoat/Clearcoat', 1, 520.00, 520.00, true),
    (v_est15, 'Blend Trunk Lid', 1, 340.00, 340.00, true),
    (v_est15, 'Blend Quarter Panels (L+R)', 1, 480.00, 480.00, true),
    (v_est15, 'Paint Materials — Primer, Base, Clear', 1, 637.50, 637.50, true),
    (v_est15, 'Parking Sensor — R&I', 1, 125.00, 125.00, false),
    (v_est15, 'Color Tint / Match', 1, 85.00, 85.00, true);

  -- ────────────────────────────────────────────────────────
  -- 6. CREATE INVOICES (for completed estimates)
  --    12 invoices matching the 12 completed estimates
  -- ────────────────────────────────────────────────────────

  v_inv1 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, mechanical_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_inv1, v_chc_id, 'INV-2026-001', v_est1, '1HGCV1F34LA000101', v_veh1, 'Robert Martinez',
    '2026-01-10', '2026-01-10', 3982.50, 'Mitchell',
    v_sf_id, 'SF-2026-44821',
    9.0, 4.5, 0.5,
    1737.00, 1485.70, 510.00, 250.00, 500.00);

  v_inv2 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_inv2, v_chc_id, 'INV-2026-002', v_est2, '2T1BURHE5JC000202', v_veh2, 'Sarah Johnson',
    '2026-01-11', '2026-01-11', 2156.30, 'Mitchell',
    v_geico_id, 'GK-2026-77103',
    4.0, 3.5,
    930.00, 842.30, 384.00, 500.00);

  v_inv3 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, structural_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_inv3, v_chc_id, 'INV-2026-003', v_est3, '1FTEW1EP5LK000303', v_veh3, 'James Wilson',
    '2026-01-20', '2026-01-20', 6892.30, 'Mitchell',
    v_prog_id, 'PG-2026-00918',
    15.0, 7.0, 2.0,
    2976.00, 2340.80, 1075.50, 500.00, 1000.00);

  v_inv4 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, aluminum_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_inv4, v_chc_id, 'INV-2026-004', v_est4, '5YJ3E1EA7NF000404', v_veh4, 'Emily Chen',
    '2026-01-21', '2026-01-21', 5890.40, 'Mitchell',
    v_alls_id, 'AL-2026-33091',
    6.0, 5.0, 4.5,
    2092.50, 2680.90, 1117.00, 500.00);

  v_inv5 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_inv5, v_chc_id, 'INV-2026-005', v_est5, '1G1YY22G965000505', v_veh5, 'Michael Davis',
    '2026-01-22', '2026-01-22', 4275.00, 'Manual',
    v_cust_id,
    5.0, 6.0,
    1485.00, 1890.00, 900.00, 0.00);

  v_inv6 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_inv6, v_chc_id, 'INV-2026-006', v_est6, 'WBAPH5C55BA000606', v_veh6, 'Amanda Thompson',
    '2026-01-24', '2026-01-24', 3410.60, 'Mitchell',
    v_lbmy_id, 'LM-2026-55620',
    6.5, 4.0,
    1302.00, 1476.60, 632.00, 500.00);

  v_inv7 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, aluminum_labor_hours, structural_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_inv7, v_chc_id, 'INV-2026-007', v_est7, '5YJSA1E26MF000707', v_veh7, 'David Park',
    '2026-02-03', '2026-02-03', 9245.00, 'Mitchell',
    v_usaa_id, 'US-2026-98412',
    10.5, 8.0, 5.0, 3.5,
    3645.00, 3650.00, 1450.00, 500.00, 1000.00);

  v_inv8 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_inv8, v_chc_id, 'INV-2026-008', v_est8, '2HKRW2H54MH000808', v_veh8, 'Jennifer Lopez',
    '2026-01-31', '2026-01-31', 2965.80, 'Mitchell',
    v_sf_id, 'SF-2026-61204',
    5.5, 3.5,
    1116.00, 1287.80, 562.00, 500.00);

  v_inv9 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_inv9, v_chc_id, 'INV-2026-009', v_est9, '4T1BF1FK8EU000909', v_veh9, 'William Brown',
    '2026-02-07', '2026-02-07', 5640.00, 'Manual',
    v_cust_id,
    8.5, 17.0,
    3060.00, 340.00, 2240.00, 0.00);

  v_inv10 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id, claim_number,
    body_labor_hours, refinish_labor_hours, mechanical_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, total_sublet_cost, deductible)
  VALUES (v_inv10, v_chc_id, 'INV-2026-010', v_est10, '1N4AL3AP8EC001010', v_veh10, 'Lisa Nguyen',
    '2026-02-10', '2026-02-10', 4310.20, 'Mitchell',
    v_geico_id, 'GK-2026-88215',
    8.0, 5.0, 1.5,
    1797.00, 1680.20, 583.00, 250.00, 500.00);

  v_inv11 := gen_random_uuid();
  INSERT INTO invoices (id, company_id, invoice_number, estimate_id, vin, vehicle_id, customer_name,
    invoice_date, completion_date, total_amount, source,
    insurance_company_id,
    body_labor_hours, refinish_labor_hours,
    total_labor_cost, total_parts_cost, total_materials_cost, deductible)
  VALUES (v_inv11, v_chc_id, 'INV-2026-011', v_est11, '3FA6P0HD5LR001111', v_veh11, 'Kevin O''Brien',
    '2026-02-08', '2026-02-08', 1285.00, 'Manual',
    v_cust_id,
    2.0, 2.5,
    540.00, 445.00, 300.00, 0.00);

  -- Invoice line items (matching estimate lines with slight actuals variance)
  -- INV-001 lines
  INSERT INTO invoice_line_items (invoice_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_inv1, 'R&I Rear Bumper Cover', 1, 185.00, 185.00, false),
    (v_inv1, 'Repair Rear Bumper Cover', 1, 380.00, 380.00, false),
    (v_inv1, 'R&I Trunk Lid', 1, 210.00, 210.00, false),
    (v_inv1, 'Repair Trunk Lid', 1, 425.00, 425.00, false),
    (v_inv1, 'Refinish Rear Bumper Cover — Basecoat/Clearcoat', 1, 540.00, 540.00, true),
    (v_inv1, 'Refinish Trunk Lid — Basecoat/Clearcoat', 1, 480.00, 480.00, true),
    (v_inv1, 'Blend Left Quarter Panel', 1, 310.00, 310.00, true),
    (v_inv1, 'Paint Materials — Primer, Base, Clear', 1, 510.00, 510.00, true),
    (v_inv1, 'Rear Bumper Reinforcement Bar', 1, 285.70, 285.70, false),
    (v_inv1, 'Sublet — Wheel Alignment', 1, 250.00, 250.00, false),
    (v_inv1, 'Additional Body Labor — Hidden Damage', 1, 125.00, 125.00, false),
    (v_inv1, 'Hazardous Waste Disposal', 1, 42.50, 42.50, false),
    (v_inv1, 'Color Tint / Match', 1, 85.00, 85.00, true);

  -- INV-002 lines
  INSERT INTO invoice_line_items (invoice_id, description, quantity, unit_price, line_total, is_refinish) VALUES
    (v_inv2, 'R&I Front Fender - Right', 1, 165.00, 165.00, false),
    (v_inv2, 'Repair Front Fender - Right', 1, 380.00, 380.00, false),
    (v_inv2, 'Refinish Front Fender — Basecoat/Clearcoat', 1, 445.00, 445.00, true),
    (v_inv2, 'Blend Front Door - Right', 1, 285.00, 285.00, true),
    (v_inv2, 'Paint Materials — Primer, Base, Clear', 1, 384.00, 384.00, true),
    (v_inv2, 'Fender Liner (OEM)', 1, 142.30, 142.30, false),
    (v_inv2, 'Color Tint / Match', 1, 75.00, 75.00, true),
    (v_inv2, 'Corrosion Protection', 1, 45.00, 45.00, false);

  RAISE NOTICE 'Demo data created successfully for CHC Paint and Auto Body';
  RAISE NOTICE 'Created: 15 vehicles, 15 estimates, 11 invoices with line items';
  RAISE NOTICE 'TEST Co company created — ready for trial data';

END $$;
