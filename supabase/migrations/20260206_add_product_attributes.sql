-- Add product classification fields to support advanced reporting filters
ALTER TABLE products ADD COLUMN IF NOT EXISTS brand text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS manufacturer text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS product_group text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS product_line text;

-- Create indexes for filtering performance
CREATE INDEX IF NOT EXISTS idx_products_brand ON products(brand);
CREATE INDEX IF NOT EXISTS idx_products_manufacturer ON products(manufacturer);
CREATE INDEX IF NOT EXISTS idx_products_group ON products(product_group);
CREATE INDEX IF NOT EXISTS idx_products_line ON products(product_line);

-- Documentation
COMMENT ON COLUMN products.brand IS 'Brand/Label of the product (e.g., PPG, BASF)';
COMMENT ON COLUMN products.manufacturer IS 'Manufacturer of the product (e.g., DuPont, Sherwin-Williams)';
COMMENT ON COLUMN products.product_group IS 'Product classification group (e.g., Coating, Abrasive, Safety)';
COMMENT ON COLUMN products.product_line IS 'Product line within group (e.g., Standard, Premium, Pro Grade)';
