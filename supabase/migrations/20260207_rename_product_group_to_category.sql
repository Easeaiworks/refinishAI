-- Migration: Consolidate product_group into category
-- The app now uses "category" consistently everywhere instead of "product_group"

-- Step 1: Copy any product_group values into category where category is empty/null
UPDATE products
SET category = product_group
WHERE (category IS NULL OR category = '')
  AND product_group IS NOT NULL
  AND product_group != '';

-- Step 2: Drop the index on product_group
DROP INDEX IF EXISTS idx_products_group;

-- Step 3: Remove the product_group column
ALTER TABLE products DROP COLUMN IF EXISTS product_group;

-- Step 4: Ensure category column has an index for filter performance
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);

-- Step 5: Update column comment
COMMENT ON COLUMN products.category IS 'Product category (e.g., Paint, Primer, Clear Coat, Reducer, Hardener, Basecoat, Base Coat, Supplies, Abrasives, Consumables, Safety)';
