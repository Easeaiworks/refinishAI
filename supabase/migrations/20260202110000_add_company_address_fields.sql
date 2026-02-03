-- Add address fields to companies table for company profile management

ALTER TABLE companies
ADD COLUMN IF NOT EXISTS phone text,
ADD COLUMN IF NOT EXISTS address text,
ADD COLUMN IF NOT EXISTS city text,
ADD COLUMN IF NOT EXISTS state text,
ADD COLUMN IF NOT EXISTS zip text,
ADD COLUMN IF NOT EXISTS website text;

-- Create index for company lookups
CREATE INDEX IF NOT EXISTS idx_companies_name ON companies(name);
