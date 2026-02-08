import Link from 'next/link'
import { Shield, ArrowLeft } from 'lucide-react'

export const metadata = {
  title: 'Privacy Policy | RefinishAI',
  description: 'Privacy policy and data protection information for RefinishAI SaaS platform',
}

export default function PrivacyPolicy() {
  return (
    <div className="min-h-screen bg-gray-50">
      {/* Dark Banner Header */}
      <div className="bg-slate-900 text-white">
        <div className="max-w-4xl mx-auto px-6 py-12">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center">
              <Shield className="w-6 h-6" />
            </div>
            <h1 className="text-4xl font-bold">Privacy Policy</h1>
          </div>
          <p className="text-slate-300 text-lg">How we collect, use, and protect your data</p>
          <p className="text-slate-400 text-sm mt-4">Last updated: February 2026</p>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-4xl mx-auto px-6 py-12">
        {/* Back Link */}
        <Link href="/dashboard" className="flex items-center gap-2 text-blue-600 hover:text-blue-700 font-medium mb-8">
          <ArrowLeft className="w-4 h-4" />
          Back to Dashboard
        </Link>

        {/* Introduction */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">Introduction & Scope</h2>
          <p className="text-gray-700 leading-relaxed mb-4">
            RefinishAI Inc. ("we," "us," "our," or "Company"), based in Canada, operates the refinishAI SaaS platform
            ("Platform"). This Privacy Policy explains how we collect, use, disclose, and otherwise process personal information
            in connection with our Platform, which provides auto body shop management, inventory forecasting, and business analytics services.
          </p>
          <p className="text-gray-700 leading-relaxed">
            This Privacy Policy applies to all users of our Platform, including shop managers, technicians, administrators, and
            any other individuals whose information we collect. We are committed to transparency and compliance with all applicable
            privacy laws, including Canada's Personal Information Protection and Electronic Documents Act (PIPEDA), the General Data
            Protection Regulation (GDPR) for EU users, and the California Consumer Privacy Act (CCPA) for California residents.
          </p>
        </section>

        {/* Information We Collect */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Information We Collect</h2>

          <div className="space-y-6">
            {/* Account Information */}
            <div className="border-l-4 border-blue-500 pl-4">
              <h3 className="text-xl font-semibold text-gray-900 mb-3">Account Information</h3>
              <p className="text-gray-700 mb-3">When you create an account or profile, we collect:</p>
              <ul className="list-disc list-inside space-y-2 text-gray-700 ml-2">
                <li>Full name and email address</li>
                <li>Company name and business type</li>
                <li>Phone number and physical address</li>
                <li>Job title and role within the organization</li>
                <li>User preferences and account settings</li>
                <li>Username and password (encrypted)</li>
              </ul>
            </div>

            {/* Business Data */}
            <div className="border-l-4 border-green-500 pl-4">
              <h3 className="text-xl font-semibold text-gray-900 mb-3">Business Data</h3>
              <p className="text-gray-700 mb-3">To provide our services, we collect and process:</p>
              <ul className="list-disc list-inside space-y-2 text-gray-700 ml-2">
                <li>Inventory information (parts, materials, quantities, unit costs)</li>
                <li>Repair estimates and pricing data</li>
                <li>Invoice records and transaction history</li>
                <li>Vehicle information (VIN, make, model, year, customer owner details)</li>
                <li>Labor rates, hours, and technician assignments</li>
                <li>Customer information related to repairs and estimates</li>
                <li>Supplier and vendor information</li>
              </ul>
            </div>

            {/* Usage Data */}
            <div className="border-l-4 border-purple-500 pl-4">
              <h3 className="text-xl font-semibold text-gray-900 mb-3">Usage Data</h3>
              <p className="text-gray-700 mb-3">We automatically collect information about how you interact with our Platform:</p>
              <ul className="list-disc list-inside space-y-2 text-gray-700 ml-2">
                <li>Login timestamps and session duration</li>
                <li>Pages visited and features used</li>
                <li>Click patterns and user interactions</li>
                <li>Browser type and version</li>
                <li>Operating system and device information</li>
                <li>IP address and general location (country/city level)</li>
                <li>Search queries and filters applied</li>
              </ul>
            </div>

            {/* Payment Information */}
            <div className="border-l-4 border-amber-500 pl-4">
              <h3 className="text-xl font-semibold text-gray-900 mb-3">Payment Information</h3>
              <p className="text-gray-700 mb-3">
                Payment processing is handled by Stripe, a secure third-party payment processor. We do not collect or store
                complete credit card numbers, CVV codes, or expiration dates. Stripe collects and securely processes:
              </p>
              <ul className="list-disc list-inside space-y-2 text-gray-700 ml-2">
                <li>Last four digits of payment methods</li>
                <li>Payment method type (card, bank account, etc.)</li>
                <li>Billing address and cardholder name</li>
                <li>Transaction amounts and dates</li>
                <li>Billing history and subscription details</li>
              </ul>
              <p className="text-gray-700 mt-3 text-sm bg-amber-50 p-3 rounded">
                We never have access to your complete payment credentials. All sensitive payment data is encrypted and managed
                exclusively by Stripe's PCI-compliant infrastructure.
              </p>
            </div>
          </div>
        </section>

        {/* How We Use Information */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">How We Use Information</h2>

          <div className="space-y-4">
            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Service Delivery</h4>
              <p className="text-gray-700">To provide, maintain, and improve the Platform, including processing your requests and supporting customer service.</p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Account Management</h4>
              <p className="text-gray-700">To create and manage your account, verify your identity, and authenticate you for security purposes.</p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Billing & Payments</h4>
              <p className="text-gray-700">To process payments, send invoices, manage subscriptions, and handle billing inquiries.</p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Analytics & Forecasting</h4>
              <p className="text-gray-700">To generate inventory forecasts, demand predictions, and business analytics specific to your shop operations.</p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Communications</h4>
              <p className="text-gray-700">To send you service updates, security alerts, billing notices, and technical information about the Platform.</p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Legal Compliance</h4>
              <p className="text-gray-700">To comply with applicable laws, regulations, court orders, and government requests.</p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Security & Fraud Prevention</h4>
              <p className="text-gray-700">To detect, prevent, and address technical issues, security threats, fraud, and abuse.</p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-2">Product Improvement</h4>
              <p className="text-gray-700">To analyze usage patterns, conduct research, and develop new features and enhancements based on user behavior and feedback.</p>
            </div>
          </div>
        </section>

        {/* Data Storage & Security */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Data Storage & Security</h2>

          <div className="space-y-4 mb-6">
            <p className="text-gray-700">
              We take data security seriously and implement comprehensive technical and organizational measures to protect your information:
            </p>

            <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Infrastructure</h4>
              <p className="text-gray-700">
                Your data is hosted on Supabase's cloud infrastructure, built on AWS (Amazon Web Services) with enterprise-grade
                security, automatic backups, and disaster recovery capabilities. Infrastructure is located in secure data centers
                with multiple redundancy layers.
              </p>
            </div>

            <div className="bg-green-50 border border-green-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Encryption</h4>
              <ul className="list-disc list-inside space-y-2 text-gray-700 ml-2">
                <li><strong>In Transit:</strong> All data transmitted between your device and our servers is encrypted using TLS 1.2+ (HTTPS)</li>
                <li><strong>At Rest:</strong> Sensitive data in our database is encrypted using industry-standard encryption algorithms</li>
                <li><strong>Password Storage:</strong> User passwords are hashed using bcrypt, never stored in plain text</li>
              </ul>
            </div>

            <div className="bg-purple-50 border border-purple-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Row-Level Security (RLS)</h4>
              <p className="text-gray-700">
                We implement PostgreSQL Row-Level Security policies to ensure users can only access their own company's data.
                Each user has granular permissions enforced at the database level, preventing unauthorized data access even if
                application security is compromised.
              </p>
            </div>

            <div className="bg-amber-50 border border-amber-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Access Controls</h4>
              <ul className="list-disc list-inside space-y-2 text-gray-700 ml-2">
                <li>Multi-factor authentication (MFA) available for account security</li>
                <li>Role-based access control (RBAC) with admin, manager, and user roles</li>
                <li>API key management with rotation and revocation capabilities</li>
                <li>Session management with automatic timeout for inactive users</li>
                <li>Limited employee access to production data with audit logging</li>
              </ul>
            </div>

            <div className="bg-rose-50 border border-rose-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Security Monitoring</h4>
              <p className="text-gray-700">
                We continuously monitor our systems for unauthorized access attempts, suspicious activity, and vulnerabilities.
                Security logs are retained for a minimum of 12 months to support incident investigation and forensic analysis.
              </p>
            </div>
          </div>

          <div className="bg-yellow-50 border border-yellow-300 rounded-lg p-4">
            <p className="text-gray-700">
              <strong>Important:</strong> While we implement strong security measures, no system is completely immune to security risks.
              We cannot guarantee absolute security. If you believe your account has been compromised, please contact us immediately
              at privacy@refinishai.com.
            </p>
          </div>
        </section>

        {/* Data Sharing & Third Parties */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Data Sharing & Third Parties</h2>

          <p className="text-gray-700 mb-6">
            We do not sell, rent, or lease your personal information to third parties. We only share data with trusted service
            providers who process it on our behalf under strict confidentiality agreements.
          </p>

          <div className="space-y-4">
            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2 flex items-center gap-2">
                <span className="w-2 h-2 bg-blue-500 rounded-full"></span>
                Stripe (Payment Processing)
              </h4>
              <p className="text-gray-700 text-sm">
                Stripe processes all payment transactions and manages subscription billing. We share billing address, company name,
                and transaction data with Stripe. Stripe maintains its own privacy policy at stripe.com/privacy.
              </p>
            </div>

            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2 flex items-center gap-2">
                <span className="w-2 h-2 bg-green-500 rounded-full"></span>
                Supabase (Database Hosting)
              </h4>
              <p className="text-gray-700 text-sm">
                Supabase hosts our database and provides infrastructure, authentication, and security services. Your encrypted data
                is stored on Supabase's servers. Supabase maintains strict data protection practices; see their privacy policy at supabase.com/privacy.
              </p>
            </div>

            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2 flex items-center gap-2">
                <span className="w-2 h-2 bg-purple-500 rounded-full"></span>
                AWS (Infrastructure Provider)
              </h4>
              <p className="text-gray-700 text-sm">
                AWS provides underlying cloud infrastructure, storage, and CDN services. Data is processed according to AWS's
                Data Processing Agreement and subject to their privacy controls.
              </p>
            </div>

            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2 flex items-center gap-2">
                <span className="w-2 h-2 bg-amber-500 rounded-full"></span>
                Customer Support & Analytics Tools
              </h4>
              <p className="text-gray-700 text-sm">
                We may use third-party tools for customer support, email communications, and analytics. These providers are
                contractually bound to maintain confidentiality and only use data for specified purposes.
              </p>
            </div>

            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2 flex items-center gap-2">
                <span className="w-2 h-2 bg-red-500 rounded-full"></span>
                Legal Requirements & Business Transfers
              </h4>
              <p className="text-gray-700 text-sm">
                We may disclose information if required by law, court order, or government request. In the event of merger,
                acquisition, or bankruptcy, your data may be transferred as part of the business transaction. We will notify you
                of any such change.
              </p>
            </div>
          </div>

          <div className="mt-6 bg-gray-50 p-4 rounded-lg border border-gray-200">
            <p className="text-gray-700 text-sm">
              <strong>Data Processing Agreements:</strong> All third-party service providers are required to sign Data Processing
              Agreements that mandate appropriate security measures and limit use of data to our specified purposes.
            </p>
          </div>
        </section>

        {/* PIPEDA Compliance */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">PIPEDA Compliance (Canadian Privacy Law)</h2>

          <p className="text-gray-700 mb-6">
            As a Canadian company, RefinishAI Inc. complies with the Personal Information Protection and Electronic Documents Act
            (PIPEDA). We adhere to the following PIPEDA principles:
          </p>

          <div className="space-y-4">
            <div className="bg-gradient-to-r from-blue-50 to-transparent border-l-4 border-blue-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">1. Accountability</h4>
              <p className="text-gray-700 text-sm">
                We are responsible for personal information under our control and have designated a Privacy Officer to oversee
                compliance and handle privacy inquiries.
              </p>
            </div>

            <div className="bg-gradient-to-r from-green-50 to-transparent border-l-4 border-green-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">2. Identifying Purposes</h4>
              <p className="text-gray-700 text-sm">
                We identify the purposes for collection before or at the time of collection. This Privacy Policy outlines our
                purposes explicitly.
              </p>
            </div>

            <div className="bg-gradient-to-r from-purple-50 to-transparent border-l-4 border-purple-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">3. Consent</h4>
              <p className="text-gray-700 text-sm">
                We obtain your meaningful consent before collecting or using personal information, except where permitted by law.
                You may withdraw consent at any time, subject to legal or contractual restrictions.
              </p>
            </div>

            <div className="bg-gradient-to-r from-amber-50 to-transparent border-l-4 border-amber-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">4. Limiting Collection</h4>
              <p className="text-gray-700 text-sm">
                We collect only the personal information necessary for our identified purposes and do not collect information
                indiscriminately.
              </p>
            </div>

            <div className="bg-gradient-to-r from-red-50 to-transparent border-l-4 border-red-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">5. Limiting Use, Disclosure, and Retention</h4>
              <p className="text-gray-700 text-sm">
                We use and disclose personal information only for the purposes identified. We retain information only as long as
                necessary, then securely delete it unless legal obligations require retention.
              </p>
            </div>

            <div className="bg-gradient-to-r from-cyan-50 to-transparent border-l-4 border-cyan-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">6. Accuracy</h4>
              <p className="text-gray-700 text-sm">
                We maintain personal information in as accurate, complete, and up-to-date form as possible. You can request
                corrections to your information at any time.
              </p>
            </div>

            <div className="bg-gradient-to-r from-orange-50 to-transparent border-l-4 border-orange-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">7. Safeguards</h4>
              <p className="text-gray-700 text-sm">
                We implement appropriate security safeguards to protect personal information against loss, theft, unauthorized
                access, disclosure, copying, use, or modification.
              </p>
            </div>

            <div className="bg-gradient-to-r from-pink-50 to-transparent border-l-4 border-pink-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">8. Openness</h4>
              <p className="text-gray-700 text-sm">
                We maintain transparent policies and practices regarding personal information management. This Privacy Policy
                is accessible to the public.
              </p>
            </div>

            <div className="bg-gradient-to-r from-teal-50 to-transparent border-l-4 border-teal-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">9. Individual Access</h4>
              <p className="text-gray-700 text-sm">
                You have the right to access your personal information and request amendments. We respond to access requests
                within 30 days or as required by PIPEDA.
              </p>
            </div>

            <div className="bg-gradient-to-r from-indigo-50 to-transparent border-l-4 border-indigo-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-1">10. Challenging Compliance</h4>
              <p className="text-gray-700 text-sm">
                You may challenge our compliance with PIPEDA principles. We provide accessible complaint procedures and respond
                to inquiries promptly.
              </p>
            </div>
          </div>
        </section>

        {/* GDPR Rights */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">GDPR Rights (for EU Users)</h2>

          <p className="text-gray-700 mb-6">
            For users in the European Union, we comply with the General Data Protection Regulation (GDPR). You have the following rights:
          </p>

          <div className="grid md:grid-cols-2 gap-4">
            <div className="border border-gray-300 rounded-lg p-4 bg-gray-50">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Access</h4>
              <p className="text-gray-700 text-sm">
                You can request a copy of all personal data we hold about you in a structured, commonly-used format.
              </p>
            </div>

            <div className="border border-gray-300 rounded-lg p-4 bg-gray-50">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Rectification</h4>
              <p className="text-gray-700 text-sm">
                You can request correction of inaccurate or incomplete information we hold about you.
              </p>
            </div>

            <div className="border border-gray-300 rounded-lg p-4 bg-gray-50">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Erasure</h4>
              <p className="text-gray-700 text-sm">
                You can request deletion of your personal data, subject to legal retention obligations.
              </p>
            </div>

            <div className="border border-gray-300 rounded-lg p-4 bg-gray-50">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Data Portability</h4>
              <p className="text-gray-700 text-sm">
                You can request your data in a portable format to transfer to another service provider.
              </p>
            </div>

            <div className="border border-gray-300 rounded-lg p-4 bg-gray-50">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Restrict Processing</h4>
              <p className="text-gray-700 text-sm">
                You can request we limit processing of your data in certain circumstances while we verify accuracy.
              </p>
            </div>

            <div className="border border-gray-300 rounded-lg p-4 bg-gray-50">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Object</h4>
              <p className="text-gray-700 text-sm">
                You can object to processing for marketing, profiling, or other legitimate interests.
              </p>
            </div>
          </div>

          <div className="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-4">
            <h4 className="font-semibold text-gray-900 mb-2">Data Protection Officer</h4>
            <p className="text-gray-700 text-sm">
              For GDPR-related inquiries, you may contact our Data Protection Officer at privacy@refinishai.com or submit a request
              through our account settings. You also have the right to lodge a complaint with your local data protection authority.
            </p>
          </div>
        </section>

        {/* CCPA Rights */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">CCPA Rights (for California Users)</h2>

          <p className="text-gray-700 mb-6">
            For residents of California, the California Consumer Privacy Act (CCPA) grants you additional rights:
          </p>

          <div className="space-y-4">
            <div className="bg-gradient-to-r from-orange-50 to-transparent border-l-4 border-orange-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Know</h4>
              <p className="text-gray-700 text-sm">
                You can request what personal information we collect, use, and share about you.
              </p>
            </div>

            <div className="bg-gradient-to-r from-orange-50 to-transparent border-l-4 border-orange-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Delete</h4>
              <p className="text-gray-700 text-sm">
                You can request deletion of personal information we have collected from you, with certain legal exceptions.
              </p>
            </div>

            <div className="bg-gradient-to-r from-orange-50 to-transparent border-l-4 border-orange-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Opt-Out of Sale or Sharing</h4>
              <p className="text-gray-700 text-sm">
                We do not sell or share personal information. However, you have the right to opt-out if this changes.
              </p>
            </div>

            <div className="bg-gradient-to-r from-orange-50 to-transparent border-l-4 border-orange-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Correct</h4>
              <p className="text-gray-700 text-sm">
                You can request correction of inaccurate personal information we maintain about you.
              </p>
            </div>

            <div className="bg-gradient-to-r from-orange-50 to-transparent border-l-4 border-orange-500 p-4 rounded">
              <h4 className="font-semibold text-gray-900 mb-2">Right to Limit Use</h4>
              <p className="text-gray-700 text-sm">
                You can limit our use of your personal information to purposes necessary to provide services you requested.
              </p>
            </div>
          </div>

          <div className="mt-6 bg-gray-50 border border-gray-200 rounded-lg p-4">
            <p className="text-gray-700 text-sm">
              To exercise CCPA rights, contact privacy@refinishai.com with "CCPA Request" in the subject line. We will verify
              your identity and respond within 45 days.
            </p>
          </div>
        </section>

        {/* Cookies & Tracking */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Cookies & Tracking</h2>

          <p className="text-gray-700 mb-6">
            We use cookies and similar tracking technologies to enhance your user experience, remember your preferences, and
            analyze usage patterns.
          </p>

          <div className="space-y-4">
            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Essential Cookies</h4>
              <p className="text-gray-700 text-sm">
                Required for basic functionality (authentication, session management, security). These cannot be disabled.
              </p>
            </div>

            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Functional Cookies</h4>
              <p className="text-gray-700 text-sm">
                Remember user preferences, language settings, and customizations to improve user experience.
              </p>
            </div>

            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Analytics Cookies</h4>
              <p className="text-gray-700 text-sm">
                Help us understand how users interact with the Platform, which features are popular, and where improvements are needed.
              </p>
            </div>

            <div className="bg-white border border-gray-300 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Marketing Cookies</h4>
              <p className="text-gray-700 text-sm">
                Track interactions across websites for targeted advertising. You can disable these in your browser settings.
              </p>
            </div>
          </div>

          <div className="mt-6 bg-gray-50 p-4 rounded-lg border border-gray-200">
            <p className="text-gray-700 text-sm">
              <strong>Browser Controls:</strong> Most browsers allow you to control or delete cookies through settings.
              Disabling cookies may affect Platform functionality. We respect "Do Not Track" signals when available.
            </p>
          </div>
        </section>

        {/* Data Retention */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Data Retention</h2>

          <p className="text-gray-700 mb-6">
            We retain personal information for as long as necessary to provide services and fulfill the purposes outlined in
            this Privacy Policy. Retention periods vary based on data type:
          </p>

          <div className="space-y-3">
            <div className="bg-gray-50 p-4 rounded-lg border-l-4 border-blue-500">
              <div className="flex justify-between items-start">
                <div>
                  <h4 className="font-semibold text-gray-900">Account Information</h4>
                  <p className="text-gray-700 text-sm">Active account + 1 year after account deletion</p>
                </div>
              </div>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border-l-4 border-green-500">
              <div className="flex justify-between items-start">
                <div>
                  <h4 className="font-semibold text-gray-900">Business Data (Invoices, Estimates)</h4>
                  <p className="text-gray-700 text-sm">7 years (for tax/legal compliance)</p>
                </div>
              </div>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border-l-4 border-purple-500">
              <div className="flex justify-between items-start">
                <div>
                  <h4 className="font-semibold text-gray-900">Usage & Analytics Data</h4>
                  <p className="text-gray-700 text-sm">13 months (aggregated after 6 months)</p>
                </div>
              </div>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border-l-4 border-amber-500">
              <div className="flex justify-between items-start">
                <div>
                  <h4 className="font-semibold text-gray-900">Security & Audit Logs</h4>
                  <p className="text-gray-700 text-sm">12 months minimum</p>
                </div>
              </div>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border-l-4 border-red-500">
              <div className="flex justify-between items-start">
                <div>
                  <h4 className="font-semibold text-gray-900">Cookies</h4>
                  <p className="text-gray-700 text-sm">Variable (typically 1-24 months)</p>
                </div>
              </div>
            </div>
          </div>

          <div className="mt-6 bg-yellow-50 border border-yellow-300 rounded-lg p-4">
            <p className="text-gray-700 text-sm">
              <strong>Legal Hold:</strong> If there is a legal dispute or investigation, we may retain relevant data beyond standard
              retention periods as required by law.
            </p>
          </div>
        </section>

        {/* Children's Privacy */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Children's Privacy</h2>

          <p className="text-gray-700 mb-4">
            The Platform is not intended for children under 13 years of age (or the applicable age of digital consent in your jurisdiction).
            We do not knowingly collect personal information from children under these ages.
          </p>

          <p className="text-gray-700 mb-4">
            If you become aware that a child has provided us with personal information, please contact privacy@refinishai.com immediately,
            and we will take steps to delete such information and terminate the child's account.
          </p>

          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <p className="text-gray-700 text-sm">
              Parents or guardians who believe their child's information has been collected can request its deletion by contacting
              our Privacy Officer.
            </p>
          </div>
        </section>

        {/* International Data Transfers */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">International Data Transfers</h2>

          <p className="text-gray-700 mb-6">
            RefinishAI operates from Canada, and your data may be transferred to, stored in, and processed in Canada and other countries
            where our service providers operate, including the United States.
          </p>

          <div className="space-y-4">
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Cross-Border Data Transfers</h4>
              <p className="text-gray-700 text-sm">
                When transferring data internationally, we implement appropriate safeguards including Standard Contractual Clauses
                (SCCs), Binding Corporate Rules (BCRs), or other GDPR-compliant mechanisms.
              </p>
            </div>

            <div className="bg-green-50 border border-green-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">Data Adequacy Agreements</h4>
              <p className="text-gray-700 text-sm">
                We rely on adequacy decisions where available (e.g., Canada-EU adequacy) and execute supplementary measures to
                ensure data protection levels equivalent to the original jurisdiction.
              </p>
            </div>

            <div className="bg-purple-50 border border-purple-200 rounded-lg p-4">
              <h4 className="font-semibold text-gray-900 mb-2">User Consent</h4>
              <p className="text-gray-700 text-sm">
                By using the Platform, you acknowledge and consent to the transfer of your information to countries outside your
                country of residence, which may have different data protection regulations.
              </p>
            </div>
          </div>
        </section>

        {/* Changes to This Policy */}
        <section className="mb-12 bg-white rounded-lg p-8 border border-gray-200">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Changes to This Policy</h2>

          <p className="text-gray-700 mb-4">
            We may update this Privacy Policy to reflect changes in our practices, technology, legal requirements, or other factors.
            We will notify you of material changes by:
          </p>

          <ul className="list-disc list-inside space-y-2 text-gray-700 ml-2 mb-6">
            <li>Posting the updated policy on our website with a new "Last updated" date</li>
            <li>Sending an email notification to your registered email address</li>
            <li>Displaying a prominent notice on the Platform before changes take effect</li>
            <li>Requesting your explicit consent if required by applicable law</li>
          </ul>

          <div className="bg-gray-50 border border-gray-200 rounded-lg p-4">
            <p className="text-gray-700 text-sm">
              Your continued use of the Platform after changes become effective constitutes your acceptance of the updated Privacy Policy.
              If you do not agree with changes, you may discontinue using the Platform.
            </p>
          </div>
        </section>

        {/* Contact Information */}
        <section className="mb-12 bg-gradient-to-r from-blue-600 to-blue-700 rounded-lg p-8 text-white">
          <h2 className="text-2xl font-bold mb-6">Contact Information</h2>

          <p className="mb-6">
            If you have questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us:
          </p>

          <div className="grid md:grid-cols-2 gap-6 mb-6">
            <div className="bg-white bg-opacity-10 rounded-lg p-4">
              <h4 className="font-semibold mb-2">Privacy Officer</h4>
              <p className="text-blue-100 text-sm">
                Email: <a href="mailto:privacy@refinishai.com" className="underline hover:text-white">privacy@refinishai.com</a>
              </p>
              <p className="text-blue-100 text-sm mt-2">
                Response time: Within 30 days of receipt
              </p>
            </div>

            <div className="bg-white bg-opacity-10 rounded-lg p-4">
              <h4 className="font-semibold mb-2">Mailing Address</h4>
              <p className="text-blue-100 text-sm">
                RefinishAI Inc.<br />
                Privacy Department<br />
                Canada
              </p>
            </div>
          </div>

          <div className="bg-white bg-opacity-10 rounded-lg p-4">
            <h4 className="font-semibold mb-2">What to Include in Your Request</h4>
            <ul className="list-disc list-inside space-y-1 text-blue-100 text-sm ml-2">
              <li>Your full name and email address</li>
              <li>Company name and account details (if applicable)</li>
              <li>Clear description of your request</li>
              <li>Any supporting documentation</li>
              <li>Proof of identity for verification</li>
            </ul>
          </div>
        </section>

        {/* Footer Note */}
        <div className="text-center text-gray-600 text-sm py-8">
          <p>
            This Privacy Policy is effective as of February 2026 and is subject to change.
            Please review this page regularly for updates.
          </p>
        </div>
      </div>
    </div>
  )
}
