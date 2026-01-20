# ⚡ Quick Start Checklist

## 🎯 Get RefinishAI Running in 30 Minutes

### ✅ Step 1: Database Setup (10 min)

1. [ ] Go to Supabase dashboard: https://supabase.com/dashboard/project/pbialuntcgyaiqogbdif
2. [ ] Click **SQL Editor** in sidebar
3. [ ] Open file: `supabase/complete-schema.sql`
4. [ ] Copy entire contents → Paste in SQL Editor → Click **Run**
5. [ ] Verify tables created (check table list)

---

### ✅ Step 2: Create Super Admin (5 min)

1. [ ] Supabase → **Authentication** → **Users** → **Add User**
2. [ ] Enter your email & password → Create
3. [ ] Go back to **SQL Editor**, run this (replace with your info):

```sql
-- Create company
INSERT INTO companies (name, email, subscription_status)
VALUES ('Your Company Name', 'your@email.com', 'active')
RETURNING id;

-- Note the returned ID, then create profile (replace IDs below):
INSERT INTO user_profiles (
  id,                           -- User ID from auth.users
  company_id,                   -- Company ID from above
  role,
  email,
  full_name,
  is_active
) VALUES (
  'paste-user-id-here',         -- Get from auth.users table
  'paste-company-id-here',      -- From step above
  'super_admin',
  'your@email.com',
  'Your Full Name',
  true
);
```

4. [ ] Verify: Can you see the user in user_profiles table?

---

### ✅ Step 3: Local Development (5 min)

1. [ ] Open terminal in project folder
2. [ ] Run: `npm install`
3. [ ] Verify `.env.local` has your Supabase credentials
4. [ ] Run: `npm run dev`
5. [ ] Visit: http://localhost:3000
6. [ ] Log in with super admin email/password
7. [ ] 🎉 You should see the dashboard!

---

### ✅ Step 4: Deploy to Railway (10 min)

**Option A: GitHub (Recommended)**

1. [ ] Push to GitHub:
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/your-username/refinish-ai.git
git push -u origin main
```

2. [ ] Go to Railway dashboard: https://railway.app
3. [ ] New Project → Deploy from GitHub → Select repo
4. [ ] Add environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL` = https://pbialuntcgyaiqogbdif.supabase.co
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = your-anon-key
   - `SUPABASE_SERVICE_ROLE_KEY` = your-service-key
   - `NEXT_PUBLIC_APP_URL` = (will show after first deploy)
5. [ ] Railway auto-deploys → Get your URL
6. [ ] Update `NEXT_PUBLIC_APP_URL` with your Railway URL
7. [ ] Test: Visit your live URL and log in!

**Option B: Railway CLI**

1. [ ] Install: `npm install -g @railway/cli`
2. [ ] Login: `railway login`
3. [ ] Link: `railway link`
4. [ ] Set variables: `railway variables set KEY=VALUE` (see above)
5. [ ] Deploy: `railway up`

---

### ✅ Step 5: Deploy VIN Decoder (Optional - can do later)

1. [ ] Install Supabase CLI: `npm install -g supabase`
2. [ ] Login: `supabase login`
3. [ ] Link: `supabase link --project-ref pbialuntcgyaiqogbdif`
4. [ ] Deploy: `supabase functions deploy decode-vin`
5. [ ] Test VIN lookup in your app

---

## 🎊 You're Done!

Your production-ready multi-tenant SaaS is now live!

### What You Have Now:
✅ Secure multi-tenant database
✅ User authentication & roles
✅ Dashboard interface
✅ Production deployment

### What's Next:
1. Port remaining features from Bolt (upload, predictions, etc.)
2. Add paint supplier integrations
3. Build AI forecasting engine

---

## 🆘 Troubleshooting

**Can't log in?**
- Check user exists in Supabase Auth
- Verify user_profiles entry matches
- Confirm is_active = true

**Database errors?**
- Re-run migrations
- Check Supabase project is active
- Verify environment variables

**Railway deploy fails?**
- Check build logs
- Verify all env variables set
- Try manual deploy via CLI

---

## 📞 Next Steps

Once you're up and running:

1. **Read:** `PROJECT_STATUS.md` - See what's built vs what's needed
2. **Plan:** Decide on timeline for remaining features
3. **Build:** Start porting Bolt components or tackle paint APIs

**Questions?** Let's keep building together! 🚀
