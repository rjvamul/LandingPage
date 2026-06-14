CREATE TABLE IF NOT EXISTS leads (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL,
  source TEXT DEFAULT 'landing-page',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;

-- Allow inserts from public (for lead capture form)
CREATE POLICY "allow_public_insert" ON leads FOR INSERT
  TO anon WITH CHECK (true);

-- Only authenticated users can read
CREATE POLICY "allow_authenticated_read" ON leads FOR SELECT
  TO authenticated USING (true);

-- Create index on email for quick lookups
CREATE INDEX IF NOT EXISTS idx_leads_email ON leads(email);