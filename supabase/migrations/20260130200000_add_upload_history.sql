-- Upload History Table
-- Tracks file upload history for audit and reference

CREATE TABLE IF NOT EXISTS upload_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid REFERENCES companies(id) ON DELETE CASCADE,
  filename text NOT NULL,
  data_type text NOT NULL, -- 'estimate', 'invoice', 'product'
  records_imported integer DEFAULT 0,
  records_failed integer DEFAULT 0,
  status text DEFAULT 'success', -- 'success', 'partial', 'failed'
  error_details jsonb,
  uploaded_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE upload_history ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view their company's upload history"
  ON upload_history FOR SELECT
  TO authenticated
  USING (
    company_id IN (
      SELECT company_id FROM user_profiles WHERE id = auth.uid()
    )
    OR
    EXISTS (
      SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'super_admin'
    )
  );

CREATE POLICY "Users can create upload history"
  ON upload_history FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_upload_history_company ON upload_history(company_id);
CREATE INDEX IF NOT EXISTS idx_upload_history_created ON upload_history(created_at DESC);
