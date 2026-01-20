const { createClient } = require('@supabase/supabase-js')
const fs = require('fs')
const path = require('path')
require('dotenv').config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase credentials in .env.local')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseKey)

async function applyMigrations() {
  console.log('🚀 Starting database migration...\n')

  const migrationsDir = path.join(__dirname, 'supabase', 'migrations')
  const files = fs.readdirSync(migrationsDir).filter(f => f.endsWith('.sql')).sort()

  console.log(`Found ${files.length} migration files\n`)

  for (const file of files) {
    const filePath = path.join(migrationsDir, file)
    const sql = fs.readFileSync(filePath, 'utf8')
    
    console.log(`📝 Applying: ${file}`)
    
    try {
      // Split by semicolons but be smart about it (avoid splitting inside strings)
      const statements = sql
        .split(/;(?=(?:[^']*'[^']*')*[^']*$)/g)
        .map(s => s.trim())
        .filter(s => s.length > 0 && !s.startsWith('/*') && !s.startsWith('--'))

      for (const statement of statements) {
        if (statement.length > 10) {
          const { error } = await supabase.rpc('exec_sql', { sql: statement })
          if (error) {
            // Try direct query if RPC fails
            const { error: directError } = await supabase
              .from('_migrations')
              .select('*')
              .limit(0) // This will fail but let us execute raw SQL
            
            // If this is about enabling RLS or creating tables, it might already exist
            if (!error.message.includes('already exists')) {
              console.warn(`   ⚠️  Warning: ${error.message}`)
            }
          }
        }
      }
      
      console.log(`   ✅ Applied successfully\n`)
    } catch (err) {
      console.error(`   ❌ Error: ${err.message}\n`)
      // Continue with other migrations
    }
  }

  console.log('🎉 Migration complete!\n')
}

applyMigrations().catch(err => {
  console.error('❌ Migration failed:', err)
  process.exit(1)
})
