# 🎨 RefinishAI

**AI-Powered Inventory Management & Forecasting for Auto Body Shops**

RefinishAI helps auto body shops optimize their paint and material inventory through intelligent forecasting, waste analysis, and cost projections. Built for panel prep, painting, and clear coating operations.

---

## ✨ Features

### Current (MVP - Phase 1)
- ✅ **Multi-tenant SaaS architecture** with company isolation
- ✅ **Role-based access control** (Super Admin, Admin, Manager, Staff)
- ✅ **VIN decoder** with NHTSA API integration
- ✅ **Vehicle & panel library** with body-style specific measurements
- ✅ **Estimate tracking** - Import and manage future work pipeline
- ✅ **Invoice tracking** - Analyze completed jobs
- ✅ **Inventory management** - Track product stock levels
- ✅ **Physical count system** - Reconcile actual vs system inventory
- ✅ **User management** - Add staff, assign roles
- ✅ **File parsing** - Import Excel, CSV, PDF, Word documents
- ✅ **Secure authentication** - Supabase Auth integration
- ✅ **Production-ready** - Deployed on Railway + Supabase

### Coming Soon (Phase 2-3)
- 🔜 **Paint supplier integrations** - PPG, Axalta, Sherwin Williams APIs
- 🔜 **AI cost projections** - Predict material costs for estimates
- 🔜 **Waste analysis** - Identify inefficiencies and losses
- 🔜 **Efficiency recommendations** - AI-powered process improvements
- 🔜 **Predictive forecasting** - Auto-generate purchase orders
- 🔜 **Real-time analytics** - Interactive dashboards
- 🔜 **Mobile app** - iOS & Android inventory management

---

## 🏗️ Tech Stack

- **Framework:** Next.js 14 (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS
- **Database:** PostgreSQL (Supabase)
- **Auth:** Supabase Auth
- **File Storage:** Supabase Storage
- **Edge Functions:** Deno (VIN Decoder)
- **Hosting:** Railway
- **Icons:** Lucide React

---

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Supabase account
- Railway account (for deployment)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/your-username/refinish-ai.git
cd refinish-ai
```

2. **Install dependencies**
```bash
npm install
```

3. **Set up environment variables**

Your `.env.local` is already configured. Verify it contains:
```env
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-key
```

4. **Apply database migrations**

See `SETUP.md` for detailed instructions on applying migrations via Supabase SQL Editor.

5. **Run development server**
```bash
npm run dev
```

Visit `http://localhost:3000` 🎉

---

## 📖 Documentation

- **[Setup Guide](SETUP.md)** - Complete deployment instructions
- **[API Documentation](#)** - Coming soon
- **[User Guide](#)** - Coming soon

---

## 🗂️ Project Structure

```
refinish-ai/
├── app/                    # Next.js App Router pages
│   ├── api/               # API routes
│   ├── auth/              # Authentication pages
│   ├── dashboard/         # Main application
│   └── layout.tsx         # Root layout
├── components/            # React components
├── lib/                   # Utilities and helpers
│   ├── supabase/         # Supabase clients
│   └── types.ts          # TypeScript types
├── supabase/
│   ├── migrations/       # Database migrations
│   ├── functions/        # Edge functions
│   └── complete-schema.sql
├── public/               # Static assets
└── [config files]
```

---

## 🔐 Security

- **Row Level Security (RLS)** enforced on all tables
- **Company-level data isolation** - Users only access their shop's data
- **Role-based permissions** - Granular access control
- **Audit logging** - Track all data changes
- **Encrypted connections** - SSL/TLS everywhere
- **Service role key** - Never exposed to client

---

## 🎯 Roadmap

### Phase 1: Foundation ✅ (Complete)
- [x] Multi-tenant architecture
- [x] User authentication & roles
- [x] Basic inventory tracking
- [x] Estimate & invoice management
- [x] VIN decoder integration
- [x] Production deployment

### Phase 2: Supplier Integration 🚧 (In Progress)
- [ ] PPG API integration
- [ ] Axalta API integration
- [ ] Sherwin Williams API integration
- [ ] Product sync & matching
- [ ] Pricing updates
- [ ] Availability tracking

### Phase 3: AI & Analytics 📅 (Planned)
- [ ] Cost projection engine
- [ ] Waste analysis algorithm
- [ ] Efficiency recommendations
- [ ] Predictive inventory model
- [ ] Auto-generated purchase orders
- [ ] Custom reporting

### Phase 4: Advanced Features 💡 (Future)
- [ ] Mobile applications
- [ ] Barcode scanning
- [ ] Vendor integrations
- [ ] Advanced analytics
- [ ] Custom dashboards
- [ ] API for third-party integrations

---

## 🤝 Contributing

This is a private commercial project. If you have access and want to contribute:

1. Create a feature branch
2. Make your changes
3. Submit a pull request
4. Await review

---

## 📊 Database Schema

### Core Tables
- `companies` - Shop/tenant info
- `user_profiles` - Extended user data
- `vehicles` - VIN database
- `vehicle_panels` - Panel specifications
- `panel_types` - Standard panel library
- `products` - Material catalog
- `estimates` - Future work pipeline
- `estimate_line_items` - Estimate details
- `invoices` - Completed jobs
- `invoice_line_items` - Invoice details
- `predictions` - AI forecasts
- `prediction_items` - Forecast details
- `consumption_history` - Usage analytics
- `inventory_transactions` - Stock movements
- `inventory_counts` - Physical counts
- `audit_log` - Change tracking

---

## 🐛 Known Issues

None at this time. Report issues via GitHub Issues.

---

## 📝 License

Proprietary - All Rights Reserved

---

## 👥 Team

Built for auto body shops by developers who understand the industry.

---

## 📞 Support

For support, contact: support@refinish-ai.com

---

**Version:** 1.0.0
**Status:** Production
**Last Updated:** January 2026
