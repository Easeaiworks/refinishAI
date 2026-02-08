'use client'

import { useState } from 'react'
import {
  BookOpen, ChevronDown, ChevronRight, MessageCircle, Mail,
  Zap, Box, FileText, BarChart3, Settings, CreditCard,
  Search, AlertCircle, CheckCircle2
} from 'lucide-react'

type FAQItem = {
  question: string
  answer: string
}

type Category = {
  id: string
  title: string
  description: string
  icon: React.ReactNode
  faqs: FAQItem[]
}

export default function HelpPage() {
  const [expandedCategories, setExpandedCategories] = useState<Set<string>>(new Set(['getting-started']))
  const [expandedFAQs, setExpandedFAQs] = useState<Set<string>>(new Set())
  const [searchQuery, setSearchQuery] = useState('')

  const toggleCategory = (id: string) => {
    const newSet = new Set(expandedCategories)
    if (newSet.has(id)) {
      newSet.delete(id)
    } else {
      newSet.add(id)
    }
    setExpandedCategories(newSet)
  }

  const toggleFAQ = (id: string) => {
    const newSet = new Set(expandedFAQs)
    if (newSet.has(id)) {
      newSet.delete(id)
    } else {
      newSet.add(id)
    }
    setExpandedFAQs(newSet)
  }

  const categories: Category[] = [
    {
      id: 'getting-started',
      title: 'Getting Started',
      description: 'Quick start guide and fundamental concepts',
      icon: <Zap className="w-6 h-6" />,
      faqs: [
        {
          question: 'What is RefinishAI?',
          answer: 'RefinishAI is a comprehensive auto body shop management SaaS platform designed to streamline your operations. It helps you manage inventory, create estimates and invoices, track physical counts, analyze sales trends, and automate reordering—all from one intuitive dashboard.'
        },
        {
          question: 'How do I get started with my first estimate?',
          answer: 'Navigate to the Estimates section and click "Create New Estimate". Fill in the customer information, add line items for parts and labor, select your labor rates (configured per insurance company), and include paint products from your inventory. You can save as draft or finalize to send to the customer.'
        },
        {
          question: 'What are the minimum requirements to set up my shop?',
          answer: 'You will need to: (1) Complete your Company Profile in Settings, (2) Set up at least one Insurance Labor Rate tier, (3) Add paint products to your Inventory, and (4) Configure Reorder levels for inventory management. Once complete, you can begin creating estimates immediately.'
        },
        {
          question: 'Can I manage multiple locations?',
          answer: 'Yes! If you have a corporate account, you can manage multiple shop locations from one dashboard. Visit Settings → Corporate to add and manage locations, assign users to specific locations, and view consolidated or location-specific analytics.'
        },
        {
          question: 'How do I invite team members?',
          answer: 'Go to Settings, then User Management, and click "Invite User". Enter their email address and assign a role (Admin, Manager, or Technician). They will receive an invitation email with a link to set up their account. Admins can manage all features, Managers have operational access, and Technicians have limited view-only access.'
        },
        {
          question: 'Where can I see an overview of my shop operations?',
          answer: 'The Dashboard provides a complete overview showing: Inventory Value (total worth of current stock), Low Stock Alerts (items below minimum levels), Recent Estimates (pending and completed), and Recent Invoices (payment status). This is your command center for daily operations.'
        }
      ]
    },
    {
      id: 'inventory',
      title: 'Inventory Management',
      description: 'Track paint products, quantities, and values',
      icon: <Box className="w-6 h-6" />,
      faqs: [
        {
          question: 'How do I add products to inventory?',
          answer: 'Navigate to Inventory and click "Add Product". Enter the product name, SKU, category (e.g., Base Coats, Clear Coats, Primers), unit cost, quantity on hand, and reorder settings. You can also upload products in bulk via CSV. Products are immediately searchable and available for use in estimates.'
        },
        {
          question: 'What do the reorder settings mean?',
          answer: 'Reorder Settings control automated suggestions: Minimum Stock Level is when the system suggests reordering, Lead Time (days) is how long supplier delivery takes, and Safety Stock is extra buffer to maintain. The system calculates your Reorder Point automatically based on average daily usage and these parameters.'
        },
        {
          question: 'How do I find and filter products?',
          answer: 'Use the Search bar to find products by name or SKU. Click Filter by Category to narrow results (Base Coats, Clear Coats, Primers, etc.). You can also sort by quantity on hand, value, or reorder status. The Inventory view shows color-coded alerts for low stock items.'
        },
        {
          question: 'What happens during physical inventory counts?',
          answer: 'Go to Counts and start a new count cycle. Your team scans or manually enters quantities for each product. The system compares entered quantities to system records and flags discrepancies. Once verified, you can reconcile the differences and update your system inventory to match actual stock.'
        },
        {
          question: 'How is inventory value calculated?',
          answer: 'Total Inventory Value = Sum of (Quantity On Hand × Unit Cost) for all products. This appears on your Dashboard and is updated in real-time as you add/remove items or complete estimates. This helps you understand your cash tied up in inventory.'
        },
        {
          question: 'Can I adjust inventory quantities manually?',
          answer: 'Yes. In the Inventory view, you can manually adjust quantities for damage, loss, or correction. Each adjustment is logged with a timestamp and user who made the change, providing full traceability for audit purposes.'
        }
      ]
    },
    {
      id: 'estimates-invoices',
      title: 'Estimates & Invoices',
      description: 'Create repair estimates and generate invoices',
      icon: <FileText className="w-6 h-6" />,
      faqs: [
        {
          question: 'What should I include in an estimate?',
          answer: 'An estimate includes: Customer information (name, contact), Vehicle details (year, make, model), Line Items (parts with quantities and prices), Labor (by type: body, refinish, mechanical, structural, aluminum, glass—each with hours and insurance-specific rates), and Paint products (with quantities and costs). The system calculates total automatically.'
        },
        {
          question: 'How are labor rates determined?',
          answer: 'Labor rates are configured per insurance company in Settings → Insurance (Labor Rates). You set hourly rates for each labor type (Body, Refinish, Mechanical, Structural, Aluminum, Glass) per insurer. When creating an estimate, select the relevant insurance, and labor rates auto-populate, ensuring accuracy and consistency.'
        },
        {
          question: 'Can I save estimates as drafts?',
          answer: 'Yes! Create an estimate and save it as Draft. You can edit it anytime before finalizing. Once finalized, you can generate a PDF for customer review, email it directly, or convert it to an invoice once the customer approves the work.'
        },
        {
          question: 'How do I convert an estimate to an invoice?',
          answer: 'Open a finalized estimate and click "Convert to Invoice". The system copies all details (customer, items, labor, parts, paint) into an invoice. You can then mark tasks as completed, adjust quantities if actual usage differs, and track payment status (Unpaid, Partial, Paid).'
        },
        {
          question: 'What payment statuses are available?',
          answer: 'Invoices track payment in three states: Unpaid (no payment received), Partial (partial amount paid—useful for insurance splits), and Paid (fully paid). Click "Mark as Paid" or "Record Payment" to update status. Payment history is maintained for your records.'
        },
        {
          question: 'Can I generate reports from estimates and invoices?',
          answer: 'Yes. Navigate to Analytics to view Sales Trends (revenue over time), Popular Products (most-used items), Inventory Turnover (how quickly items sell), and AI-powered Recommendations based on your usage patterns. You can also export estimate/invoice data to CSV for external analysis.'
        }
      ]
    },
    {
      id: 'analytics',
      title: 'Analytics & Insights',
      description: 'Sales trends, inventory analysis, and AI recommendations',
      icon: <BarChart3 className="w-6 h-6" />,
      faqs: [
        {
          question: 'What analytics are available?',
          answer: 'RefinishAI provides: Sales Trends (revenue and job volume over time), Inventory Turnover (how quickly each product sells), Popular Products (top 10 products by quantity used), and AI-powered Recommendations (suggesting products to reorder based on usage patterns and seasonal trends).'
        },
        {
          question: 'How does AI power recommendations?',
          answer: 'The AI analyzes your historical usage data, seasonal patterns, current stock levels, and lead times. It suggests reorder quantities that optimize your cash flow while preventing stockouts. These recommendations are guidance only—you always review and approve before ordering.'
        },
        {
          question: 'What do Sales Trends tell me?',
          answer: 'Sales Trends show total revenue and job volume over selectable time periods (weekly, monthly, quarterly). Identify your busiest seasons, track growth, and compare performance month-to-month. This helps with budgeting, staffing, and inventory planning.'
        },
        {
          question: 'How can I use Inventory Turnover data?',
          answer: 'Inventory Turnover shows how many times each product sells annually. Fast-moving items (high turnover) might benefit from higher stock levels. Slow-moving items might indicate overstocking. This helps you optimize inventory investment and reduce waste.'
        },
        {
          question: 'Can I export analytics data?',
          answer: 'Yes. From each Analytics section, click "Export" to download data as CSV. You can also customize date ranges and filters before exporting. This is useful for presentations, external analysis, or integration with other business tools.'
        },
        {
          question: 'How often is analytics data updated?',
          answer: 'Analytics refresh in real-time as estimates and invoices are created and marked as paid. Dashboard widgets update every few hours. For the most current data, manually refresh your browser or revisit the Analytics section.'
        }
      ]
    },
    {
      id: 'reorder',
      title: 'Automated Reordering',
      description: 'Inventory reorder suggestions and supplier management',
      icon: <AlertCircle className="w-6 h-6" />,
      faqs: [
        {
          question: 'How does automated reordering work?',
          answer: 'The Reorder module monitors your inventory levels against configured minimums. When stock falls below your Reorder Point, the system flags the product and suggests an order quantity based on your Par Level and lead time. Review suggestions daily to stay ahead of stockouts.'
        },
        {
          question: 'What are Reorder Points and Par Levels?',
          answer: 'Reorder Point: The level at which you should order more stock (typically: average daily usage × lead time + safety stock). Par Level: The target maximum you want to maintain (typically: reorder point + average daily usage × order cycle). The system calculates both automatically from your settings.'
        },
        {
          question: 'Can I manage suppliers in RefinishAI?',
          answer: 'Yes. Go to Reorder → Supplier Management to add and track suppliers. Store supplier names, contact info, typical lead times, and pricing. When creating reorder suggestions, select the appropriate supplier, and the system can help you generate purchase orders.'
        },
        {
          question: 'How do I act on reorder suggestions?',
          answer: 'In the Reorder dashboard, review flagged items. Click on a product to see the suggested quantity, cost estimate, and supplier. Approve the suggestion (or adjust quantity if needed) and generate a purchase order, then mark as ordered. Track order status until delivery.'
        },
        {
          question: 'What if I want custom reorder rules for certain products?',
          answer: 'Each product has customizable Reorder Settings. For critical items, increase Safety Stock. For seasonal products, adjust Lead Time expectations. For items you buy in bulk, set Order Multiple (e.g., "only buy in cases of 6"). These settings fine-tune automatic suggestions to fit your business.'
        },
        {
          question: 'How do I prevent stockouts?',
          answer: 'Use the Low Stock Alerts on your Dashboard to monitor items approaching minimum levels. Review the Reorder section daily. Set Safety Stock appropriately for critical items. Integrate supplier lead times accurately. When in doubt, reorder earlier rather than risk a stockout during a busy period.'
        }
      ]
    },
    {
      id: 'admin',
      title: 'Admin & Settings',
      description: 'Company profile, users, insurance rates, and preferences',
      icon: <Settings className="w-6 h-6" />,
      faqs: [
        {
          question: 'How do I configure insurance labor rates?',
          answer: 'Go to Settings → Insurance (Labor Rates). Add or edit insurance companies. For each insurer, set hourly rates for all labor types: Body, Refinish, Mechanical, Structural, Aluminum, and Glass. These rates auto-populate in estimates when you select an insurance company, ensuring customers are billed correctly.'
        },
        {
          question: 'What does the Company Profile section include?',
          answer: 'Company Profile stores your shop name, address, phone, email, logo, tax ID, and default labor rates. This information appears on generated estimates and invoices. Keep it current to maintain professional documents and accurate tax/billing records.'
        },
        {
          question: 'How do I manage user roles and permissions?',
          answer: 'Go to Settings → User Management. Assign roles: Admin (full access to all features), Manager (operational access, cannot modify company settings), Technician (limited view-only access to estimates/invoices). Track who did what with activity logs for compliance and accountability.'
        },
        {
          question: 'Can I set preferences for my account?',
          answer: 'Yes. In Settings → Preferences, customize: currency/units, date format, default invoice terms, email notification settings, and dashboard layout. These apply to your user account. Admins can also set company-wide defaults that apply to all team members.'
        },
        {
          question: 'How does the corporate multi-location feature work?',
          answer: 'If you are on a corporate plan, go to Settings, then Corporate to add and manage multiple shop locations. Assign staff to locations, view location-specific analytics, and consolidate or segment data as needed. Each location maintains its own inventory and can have different labor rates.'
        },
        {
          question: 'How do I manage data security and backups?',
          answer: 'RefinishAI automatically encrypts all data and maintains daily backups. Your data is never shared. You can download a backup of your data anytime from Settings → Data Export. For advanced security needs (IP whitelisting, SSO), contact our support team.'
        }
      ]
    },
    {
      id: 'billing',
      title: 'Billing & Subscription',
      description: 'Plans, invoices, and payment management',
      icon: <CreditCard className="w-6 h-6" />,
      faqs: [
        {
          question: 'What subscription plans does RefinishAI offer?',
          answer: 'We offer tiered plans: Starter (single location, basic features), Professional (multi-user, all core features), and Enterprise (unlimited locations, advanced features, dedicated support). Visit the Billing section to see current plan details, pricing, and usage limits.'
        },
        {
          question: 'How is my subscription billed?',
          answer: 'Subscriptions are billed monthly or annually (annual saves 20%). Billing occurs on the first of the month for the next month of service. You can change your plan anytime; changes take effect on your next billing cycle.'
        },
        {
          question: 'Where can I view my billing history?',
          answer: 'Go to Billing → Invoices to view and download all past invoices. Each invoice shows the plan, billing period, amount charged, and payment status. Invoices are generated automatically and available immediately after payment.'
        },
        {
          question: 'How do I update my payment method?',
          answer: 'In Billing → Payment Method, update your credit card or banking information. Your payment method is encrypted and secured. Failed payments trigger email notifications so you can update immediately.'
        },
        {
          question: 'What happens if a payment fails?',
          answer: 'We will send you email notifications. You have 3 days to update your payment method before access restrictions apply. If you need help, contact support@refinishai.com immediately. We want to help you resolve payment issues quickly.'
        },
        {
          question: 'Can I cancel my subscription?',
          answer: 'Yes. Go to Billing, then Plan, and click "Cancel Subscription". Your access continues through the end of the current billing period. All your data remains available for export. If you cancel mid-month on an annual plan, we will prorate a refund.'
        }
      ]
    }
  ]

  const filteredCategories = categories.map(cat => ({
    ...cat,
    faqs: cat.faqs.filter(faq =>
      faq.question.toLowerCase().includes(searchQuery.toLowerCase()) ||
      faq.answer.toLowerCase().includes(searchQuery.toLowerCase())
    )
  })).filter(cat => cat.faqs.length > 0 || searchQuery === '')

  const hasSearchResults = filteredCategories.some(cat => cat.faqs.length > 0)

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 to-white">
      {/* Enterprise Dark Header */}
      <div className="bg-gradient-to-r from-slate-900 via-slate-800 to-slate-900 text-white">
        <div className="max-w-5xl mx-auto px-6 py-12">
          <div className="flex items-center gap-4 mb-6">
            <div className="w-12 h-12 bg-white/10 rounded-xl flex items-center justify-center border border-white/20">
              <BookOpen className="w-6 h-6" />
            </div>
            <div>
              <h1 className="text-4xl font-bold">Help & Knowledge Base</h1>
              <p className="text-slate-300 mt-2">Complete guide to RefinishAI features and operations</p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-6 py-12 space-y-8">
        {/* Quick Start Guide */}
        <section className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
          <div className="bg-gradient-to-r from-amber-50 to-orange-50 px-6 py-6 border-b border-slate-200">
            <h2 className="text-2xl font-bold text-slate-900 flex items-center gap-3">
              <Zap className="w-7 h-7 text-amber-600" />
              Quick Start Guide
            </h2>
            <p className="text-slate-600 mt-2">Get up and running in 5 minutes</p>
          </div>
          <div className="p-6 space-y-4">
            <div className="grid md:grid-cols-5 gap-4">
              {[
                { num: 1, title: 'Complete Profile', desc: 'Settings → Company Profile' },
                { num: 2, title: 'Add Products', desc: 'Inventory → Add Paint Products' },
                { num: 3, title: 'Set Labor Rates', desc: 'Settings → Insurance Rates' },
                { num: 4, title: 'Invite Team', desc: 'Settings → User Management' },
                { num: 5, title: 'Create Estimate', desc: 'Estimates → New Estimate' }
              ].map(step => (
                <div key={step.num} className="bg-gradient-to-br from-slate-50 to-slate-100 rounded-lg p-4 text-center border border-slate-200">
                  <div className="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold mx-auto mb-3">
                    {step.num}
                  </div>
                  <p className="font-semibold text-slate-900 text-sm">{step.title}</p>
                  <p className="text-xs text-slate-500 mt-2">{step.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Search Bar */}
        <div className="relative">
          <Search className="absolute left-3 top-3.5 w-5 h-5 text-slate-400" />
          <input
            type="text"
            placeholder="Search articles, questions, and features..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-10 pr-4 py-3 bg-white border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-slate-900 placeholder-slate-500"
          />
        </div>

        {/* No Results Message */}
        {searchQuery && !hasSearchResults && (
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-6 text-center">
            <AlertCircle className="w-8 h-8 text-amber-600 mx-auto mb-2" />
            <p className="text-slate-700">No articles found matching "{searchQuery}". Try a different search term.</p>
          </div>
        )}

        {/* FAQ Categories */}
        <div className="space-y-4">
          {filteredCategories.map(category => (
            <div key={category.id} className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
              {/* Category Header */}
              <button
                onClick={() => toggleCategory(category.id)}
                className="w-full flex items-center justify-between p-6 text-left hover:bg-slate-50 transition-colors"
              >
                <div className="flex items-center gap-4">
                  <div className="w-10 h-10 bg-slate-100 rounded-lg flex items-center justify-center text-slate-600">
                    {category.icon}
                  </div>
                  <div>
                    <h3 className="text-lg font-semibold text-slate-900">{category.title}</h3>
                    <p className="text-sm text-slate-500">{category.description}</p>
                  </div>
                </div>
                {expandedCategories.has(category.id) ? (
                  <ChevronDown className="w-5 h-5 text-slate-400 flex-shrink-0" />
                ) : (
                  <ChevronRight className="w-5 h-5 text-slate-400 flex-shrink-0" />
                )}
              </button>

              {/* FAQs */}
              {expandedCategories.has(category.id) && (
                <div className="border-t border-slate-200 divide-y divide-slate-200">
                  {category.faqs.map((faq, index) => {
                    const faqId = `${category.id}-${index}`
                    const isExpanded = expandedFAQs.has(faqId)

                    return (
                      <div key={faqId} className="bg-slate-50">
                        <button
                          onClick={() => toggleFAQ(faqId)}
                          className="w-full flex items-start justify-between p-6 text-left hover:bg-slate-100 transition-colors"
                        >
                          <div className="flex items-start gap-4 flex-1">
                            <CheckCircle2 className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
                            <p className="font-medium text-slate-900">{faq.question}</p>
                          </div>
                          {isExpanded ? (
                            <ChevronDown className="w-5 h-5 text-slate-400 flex-shrink-0 ml-4" />
                          ) : (
                            <ChevronRight className="w-5 h-5 text-slate-400 flex-shrink-0 ml-4" />
                          )}
                        </button>

                        {isExpanded && (
                          <div className="px-6 pb-6 text-slate-700 leading-relaxed bg-white">
                            {faq.answer}
                          </div>
                        )}
                      </div>
                    )
                  })}
                </div>
              )}
            </div>
          ))}
        </div>

        {/* Contact Support Section */}
        <section className="bg-gradient-to-r from-blue-600 to-blue-700 rounded-xl shadow-lg overflow-hidden">
          <div className="px-8 py-12">
            <div className="max-w-2xl">
              <h2 className="text-3xl font-bold text-white mb-4">Still Have Questions?</h2>
              <p className="text-blue-100 mb-8 text-lg">
                Our support team is here to help. We typically respond within 2 hours during business hours.
              </p>
              <div className="flex flex-col sm:flex-row gap-4">
                <a
                  href="mailto:support@refinishai.com"
                  className="flex items-center justify-center gap-2 bg-white text-blue-600 font-semibold py-3 px-6 rounded-lg hover:bg-blue-50 transition-colors"
                >
                  <Mail className="w-5 h-5" />
                  Email Support
                </a>
                <a
                  href="https://refinishai.com/contact"
                  className="flex items-center justify-center gap-2 bg-blue-500 text-white font-semibold py-3 px-6 rounded-lg hover:bg-blue-400 transition-colors"
                >
                  <MessageCircle className="w-5 h-5" />
                  Contact Form
                </a>
              </div>
              <p className="text-blue-200 text-sm mt-6">
                Email: <a href="mailto:support@refinishai.com" className="underline">support@refinishai.com</a>
              </p>
            </div>
          </div>
        </section>

        {/* Footer */}
        <div className="text-center py-8 text-slate-600 border-t border-slate-200">
          <p className="text-sm">
            RefinishAI Knowledge Base • Last updated February 2025
          </p>
        </div>
      </div>
    </div>
  )
}
