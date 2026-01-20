# RefinishAI - Production Setup Guide

## 🎯 Overview

RefinishAI is an AI-powered inventory management and forecasting system for auto body shops, focusing on panel prep, painting, and clear coating operations.

### Key Features
- **Multi-tenant architecture** with company isolation
- **VIN decoding** via NHTSA API integration
- **Inventory management** with predictive forecasting
- **Estimate & invoice tracking**
- **Cost projection & waste analysis**
- **Role-based access control** (Super Admin, Admin, Manager, Staff)

---

## 📋 Prerequisites

- Node.js 18+ installed
- Supabase account (already configured)
- Railway account
- GitHub account

---

## 🚀 Step 1: Database Setup

### Apply Database Migrations

1. Go to your Supabase dashboard: https://supabase.com/dashboard/project/pbialuntcgyaiqogbdif

2. Navigate to **SQL Editor** in the left sidebar

3. Open the file: `supabase/complete-schema.sql`

4. Copy the entire contents and paste into the Supabase SQL Editor

5. Click **Run** to execute all migrations

**What this does:**
- Creates all tables (companies, users, vehicles, products, estimates, invoices, etc.)
- Sets up Row Level Security (RLS) policies
- Creates helper functions for role checking
- Seeds initial panel types and vehicle data

### Verify Setup

Run this query in SQL Editor to verify:

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;
```

You should see tables like:
- `companies`
- `user_profiles`
- `vehicles`
- `vehicle_panels`
- `panel_types`
- `products`
- `estimates`
- `invoices`
- `predictions`
- `consumption_history`
- `inventory_transactions`
- `inventory_counts`

---

## 🔧 Step 2: Create First Super Admin

After migrations are applied, create your first super admin account:

1. In Supabase Dashboard, go to **Authentication** → **Users**

2. Click **Add User** → **Create new user**

3. Enter email and password

4. After user is created, go to **SQL Editor** and run:

```sql
-- Replace with your actual user email
INSERT INTO companies (name, email, subscription_status)
VALUES ('RefinishAI Admin', 'your-email@company.com', 'active')
RETURNING id;

-- Take note of the company ID, then run:
-- Replace USER_ID with the UUID from the auth.users table
-- Replace COMPANY_ID with the UUID from the company just created

INSERT INTO user_profiles (id, company_id, role, email, full_name, is_active)
VALUES (
  'USER_ID_HERE',
  'COMPANY_ID_HERE', 
  'super_admin',
  'your-email@company.com',
  'Your Name',
  true
);
```

---

## 💻 Step 3: Local Development

### Install Dependencies

```bash
cd refinish-ai
npm install
```

### Environment Variables

Your `.env.local` is already configured with:
- Supabase URL
- Anon Key
- Service Role Key

### Run Development Server

```bash
npm run dev
```

Visit `http://localhost:3000` and sign in with your super admin credentials.

---

## 🌐 Step 4: Deploy to Railway

### Option A: Via Railway CLI

1. Install Railway CLI:
```bash
npm install -g @railway/cli
```

2. Login to Railway:
```bash
railway login
```

3. Initialize project:
```bash
railway init
```

4. Link to your Railway project:
```bash
railway link
```

5. Add environment variables:
```bash
railway variables set NEXT_PUBLIC_SUPABASE_URL=https://pbialuntcgyaiqogbdif.supabase.co
railway variables set NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
railway variables set SUPABASE_SERVICE_ROLE_KEY=your-service-key
railway variables set NEXT_PUBLIC_APP_URL=https://your-app.railway.app
```

6. Deploy:
```bash
railway up
```

### Option B: Via GitHub Integration

1. Push code to GitHub:
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/your-username/refinish-ai.git
git push -u origin main
```

2. In Railway Dashboard:
   - Click **New Project**
   - Select **Deploy from GitHub repo**
   - Choose your repository
   - Railway will auto-detect Next.js

3. Add environment variables in Railway dashboard:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`
   - `NEXT_PUBLIC_APP_URL` (your Railway app URL)

4. Deploy automatically happens on push to main

---

## 🔐 Step 5: Deploy VIN Decoder Edge Function

1. Install Supabase CLI:
```bash
npm install -g supabase
```

2. Login to Supabase:
```bash
supabase login
```

3. Link to your project:
```bash
supabase link --project-ref pbialuntcgyaiqogbdif
```

4. Deploy the VIN decoder function:
```bash
supabase functions deploy decode-vin
```

The function is already in: `supabase/functions/decode-vin/index.ts`

---

## 🎨 Step 6: Add Company Logo (Optional)

1. Upload your company logo to `public/logo.png`

2. Update the navigation component to use your logo

3. Logo should be transparent PNG, recommended size: 200x200px

---

## 📱 Step 7: First Login & Setup

1. Visit your deployed app (or localhost:3000)

2. Sign in with your super admin account

3. Go to **Super Admin** panel

4. Create your first company (auto body shop)

5. Add users and assign roles

6. Start uploading historical data (estimates/invoices)

---

## 🔄 Next Steps: Phase 2 & 3

### Phase 2: Paint Supplier Integration (Week 2)

**Tasks:**
- [ ] Research PPG API documentation
- [ ] Research Axalta API documentation  
- [ ] Research Sherwin Williams API documentation
- [ ] Create `supplier_products` table
- [ ] Build product sync functions
- [ ] Add supplier configuration UI

### Phase 3: AI & Analytics (Weeks 3-4)

**Tasks:**
- [ ] Build cost projection engine
- [ ] Implement waste analysis algorithms
- [ ] Create efficiency recommendation system
- [ ] Develop inventory forecasting model
- [ ] Add AI-powered insights dashboard

---

## 🛠️ Development Commands

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Start production server
npm start

# Run type checking
npm run type-check

# Run linting
npm run lint
```

---

## 📊 Database Schema Overview

### Core Tables

**Companies** - Multi-tenant isolation
- Each shop is a company
- Subscription management
- Company-wide settings

**User Profiles** - Extended auth
- Links to Supabase Auth
- Role-based permissions
- Company membership

**Vehicles** - VIN database
- Decoded from NHTSA
- Cached vehicle info
- Panel specifications

**Products** - Material catalog
- Paint, primer, clear coat
- Supplier info
- Waste factors & coverage

**Estimates** - Future work
- Customer quotes
- Expected start dates
- Panel-by-panel breakdown

**Invoices** - Completed work
- Actual costs
- Product consumption
- Historical analysis data

**Predictions** - AI forecasts
- Inventory recommendations
- Order suggestions
- Confidence scores

---

## 🔒 Security Features

- **Row Level Security (RLS)** - All tables protected
- **Company Isolation** - Users only see their data
- **Role-Based Access** - 4-tier permission system
- **Audit Logging** - Track all changes
- **Secure Auth** - Supabase Auth integration

---

## 📝 Support & Maintenance

### Backup Strategy

Supabase automatically backs up your database. To create manual backups:

1. Go to Supabase Dashboard → Database → Backups
2. Click "Create backup"
3. Export and store securely

### Monitoring

Monitor your app:
- Railway: Check logs and metrics in dashboard
- Supabase: Monitor API usage and database performance
- Set up alerts for errors and high usage

---

## 🐛 Troubleshooting

### Can't sign in
- Verify user exists in Supabase Auth
- Check user_profiles table has matching entry
- Ensure is_active = true

### RLS errors
- Verify policies are enabled
- Check user has correct role
- Review company_id matches

### Migration errors
- Apply migrations in order
- Check for duplicate table names
- Verify Supabase project is active

---

## 📞 Next Actions

1. ✅ **DONE**: Database schema applied
2. ✅ **DONE**: First super admin created
3. ⏳ **TODO**: Deploy to Railway
4. ⏳ **TODO**: Deploy VIN decoder function
5. ⏳ **TODO**: Add first auto body shop company
6. ⏳ **TODO**: Upload historical estimates/invoices
7. ⏳ **TODO**: Begin Phase 2 (Paint suppliers)

---

**Built with:** Next.js 14, React 18, TypeScript, Tailwind CSS, Supabase, Railway

**Repository:** Ready for GitHub deployment

**Production Ready:** Yes - Multi-tenant SaaS architecture
