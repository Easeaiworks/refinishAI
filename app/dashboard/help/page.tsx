'use client'

import { useState } from 'react'
import {
  BookOpen, ChevronDown, ChevronRight, MessageCircle, Mail,
  Zap, Box, FileText, BarChart3, Settings, CreditCard,
  Search, AlertCircle, CheckCircle2, ShoppingCart, ClipboardList,
  Upload, Car, Building2, Users, Brain
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
      description: 'What refinishAI does and how to set up your shop',
      icon: <Zap className="w-6 h-6" />,
      faqs: [
        {
          question: 'What is refinishAI?',
          answer: 'refinishAI is an inventory forecasting and management platform built for auto body and collision repair shops. It learns your inventory patterns by analyzing your historical estimates, invoices, and inventory data. Over time it builds a picture of what you use, how fast you use it, and what you need to order. Every calculation uses straightforward math you can verify with a calculator. The AI layer runs 100 iterations of these formulas to confirm accuracy and only offers forecasting guidance when it achieves 97.8% or higher accuracy against the manual calculation. If it falls below that threshold, it reverts to manual mode and will not display AI-generated forecasts.'
        },
        {
          question: 'How does the AI forecasting work?',
          answer: 'The system collects data from three sources: estimates (upcoming work), invoices (completed jobs), and inventory uploads (current stock). It calculates average consumption rates, lead times, reorder points, and cost projections using standard formulas. The AI engine then runs 100 iterations of these calculations to cross-check accuracy. If the result matches the manual calculation at 97.8% or better, the forecast is displayed with a confidence score. If not, the system falls back to manual calculations only. This means every number you see is grounded in verifiable math, not a black box.'
        },
        {
          question: 'What are the first steps to set up my shop?',
          answer: 'Start by completing your Company Profile in Settings with your shop name, address, and contact details. Next, upload your historical data (estimates, invoices, and product catalog) through the Upload page using CSV or Excel files. Then set up your Insurance Labor Rates for each insurer you work with. Finally, invite your team members and assign roles. The more historical data you upload, the faster the system learns your consumption patterns and the more accurate forecasts become.'
        },
        {
          question: 'What does the Dashboard show me?',
          answer: 'The Dashboard is your daily overview. It shows four key metrics at a glance: Active Estimates (pending work), Completed Jobs, Products Tracked, and Total Inventory Value. Below that you will find Quick Actions to upload data, look up a vehicle, view predictions, or manage inventory. If you are new, a Getting Started section guides you through the initial setup steps.'
        },
        {
          question: 'Can I manage multiple shop locations?',
          answer: 'Yes. Corporate accounts can manage multiple locations from one dashboard. Go to Corporate under the More menu to add locations with a name and code. You can assign staff to specific locations, enforce a paint line contract across all shops, and view users across the entire organization. Each location maintains its own inventory and labor rate configurations.'
        },
        {
          question: 'How do I invite my team?',
          answer: 'Navigate to the Users page through your profile menu. Click Invite User and enter their email with a role assignment. There are four roles: Staff has view-only access, Manager can view and make adjustments, Admin has full management capabilities, and Super Admin has system-wide control. Each person receives an email invitation to set up their account.'
        }
      ]
    },
    {
      id: 'upload',
      title: 'Uploading Your Data',
      description: 'Import estimates, invoices, and products to train the system',
      icon: <Upload className="w-6 h-6" />,
      faqs: [
        {
          question: 'What data can I upload?',
          answer: 'You can upload three types of data: Estimates (repair quotes with customer, vehicle, and line item details), Invoices (completed job records with costs and labor breakdown), and Products (your product catalog with SKUs, categories, costs, and quantities). Accepted file formats are CSV, Excel (.xlsx/.xls), and PDF.'
        },
        {
          question: 'How does the upload process work?',
          answer: 'Select the data type you want to import, then drag and drop your file or click to browse. The system reads your columns and auto-detects field mappings based on column names. You can adjust any mapping manually using the dropdown selectors. Preview the first five rows to confirm everything looks correct, then click Import. The system reports how many records were imported successfully and lists any errors.'
        },
        {
          question: 'Why is uploading historical data important?',
          answer: 'The forecasting engine learns from your history. The more estimates, invoices, and inventory records you upload, the better it understands your consumption patterns, seasonal trends, and reorder timing. With enough data the AI can generate accurate projections for material costs, labor costs, and stock requirements weeks in advance.'
        },
        {
          question: 'Can I see my upload history?',
          answer: 'Yes. The Upload page shows a history table at the bottom listing every file you have imported, including the filename, data type, date, number of records imported, and status. This makes it easy to track what data has already been loaded.'
        }
      ]
    },
    {
      id: 'inventory',
      title: 'Inventory Management',
      description: 'Track products, stock levels, and adjustments',
      icon: <Box className="w-6 h-6" />,
      faqs: [
        {
          question: 'How do I add products to inventory?',
          answer: 'Go to the Inventory page and click Add Product. Enter the SKU, product name, category (Base Coat, Clear Coat, Primer, Hardener, Reducer, etc.), unit type, unit cost, supplier, coverage per unit, waste factor, and lead time. You can also set a reorder point and minimum quantity. For bulk imports, use the Upload page with a CSV or Excel file of your product catalog.'
        },
        {
          question: 'What do the inventory stat cards show?',
          answer: 'The top of the Inventory page shows five cards: Total Products (how many SKUs you track), Inventory Value (sum of quantity on hand times unit cost for all products), Low Stock (items at or below their reorder point), Out of Stock (items with zero quantity), and Total Categories (how many product categories you have). Click the Low Stock or Out of Stock cards to filter the list to just those items.'
        },
        {
          question: 'How do I adjust stock quantities?',
          answer: 'Click the adjustment icon on any product row. Choose the adjustment type: Add (receiving new stock), Remove (damage, loss, or usage), or Set (correct to an exact count). Enter the quantity and the system calculates the new total with a live preview. Every adjustment is logged with your name, the timestamp, and the type of change for full audit traceability.'
        },
        {
          question: 'How is inventory value calculated?',
          answer: 'Total Inventory Value is the sum of Quantity On Hand multiplied by Unit Cost for every product. This updates in real time as you add products, adjust quantities, or complete estimates. It appears on both the Inventory page and the main Dashboard so you always know how much cash is tied up in stock.'
        },
        {
          question: 'What do the stock status colors mean?',
          answer: 'Red (Critical) means the product is at zero quantity. Amber (Low) means the quantity is at or below the reorder point. Green (Adequate) means stock is healthy. Blue (Overstocked) means the quantity is more than three times the reorder point, which may indicate excess inventory tying up cash.'
        },
        {
          question: 'Can I search and filter my inventory?',
          answer: 'Yes. Use the search bar to find products by name or SKU. Filter by category using the dropdown, or filter by stock status (All, In Stock, Low, Out of Stock). You can combine search with filters to narrow results quickly.'
        }
      ]
    },
    {
      id: 'counts',
      title: 'Physical Inventory Counts',
      description: 'Reconcile actual stock with system records',
      icon: <ClipboardList className="w-6 h-6" />,
      faqs: [
        {
          question: 'How do I start a physical count?',
          answer: 'Go to the Counts page and click New Count. A three-step wizard guides you through: Step 1 is selecting the count type (Full Count, Spot Check, Cycle Count, or Category Count). Step 2 is choosing which items to count (all items, by category, or specific products). Step 3 is reviewing your selections and adding optional notes. Click Start Count to begin.'
        },
        {
          question: 'How do I record counts?',
          answer: 'Once a count is started, you see a table of products with their expected system quantity. Enter the actual quantity you physically counted for each item. The system automatically calculates the variance (difference between expected and actual) and color-codes it green for overages and red for shortages. A progress bar shows how many items you have counted.'
        },
        {
          question: 'Can I scan count sheets instead of typing?',
          answer: 'Yes. Print a count sheet using the Print button, have your team fill it in by hand on the shop floor, then use the Scan button to upload the completed sheet as a JPG, PNG, or PDF. The OCR engine reads the handwritten quantities and presents the results with confidence percentages for each item. Review and apply the scanned values to your count.'
        },
        {
          question: 'What happens after a count is completed?',
          answer: 'Completed counts go into a Pending Review status. A manager or admin reviews the variances, approves or rejects the count, and the system reconciles the differences by updating inventory quantities to match the physical count. The variance history is stored permanently for audit and reporting purposes.'
        },
        {
          question: 'What count types are available?',
          answer: 'Full Count covers every product in your inventory. Spot Check lets you quickly verify a handful of specific items. Cycle Count is a rolling approach where you count a subset of products on a regular schedule. Category Count lets you count all products within specific categories like Clear Coats or Primers.'
        }
      ]
    },
    {
      id: 'estimates-invoices',
      title: 'Estimates & Invoices',
      description: 'Track repair quotes and completed job history',
      icon: <FileText className="w-6 h-6" />,
      faqs: [
        {
          question: 'How do estimates work in refinishAI?',
          answer: 'The Estimates page shows all your repair quotes. Each estimate includes the estimate number, customer name, vehicle details (year, make, model), insurance company, status, and total amount. Expand any estimate to see the full line item breakdown with descriptions, quantities, unit prices, and totals. Line items are tagged by type such as Refinish, Parts, or Labor.'
        },
        {
          question: 'What estimate statuses are available?',
          answer: 'Estimates move through four stages: Quoted (initial quote created), Approved (customer approved the work), In Progress (repair is underway), and Completed (job finished). You can filter by status using the dropdown, and each status has a distinct color badge for quick visual scanning.'
        },
        {
          question: 'How are labor rates handled?',
          answer: 'Labor rates are configured per insurance company in the Insurance (Labor Rates) page. You set hourly rates for six labor categories: Body, Refinish, Mechanical, Structural, Aluminum, and Glass. You can also flag each insurer as a DRP (Direct Repair Program) partner and store their contact information. When creating estimates, these rates automatically apply based on the selected insurance company.'
        },
        {
          question: 'What does the Invoices page show?',
          answer: 'The Invoices page tracks completed jobs. Summary cards show Total Invoices, Total Revenue, Average Job Value, and Jobs This Month. Expand any invoice to see a full breakdown including labor hours and costs by type (Body, Refinish, Mechanical, Structural, Aluminum), parts cost, materials cost, sublet cost, deductible, and individual line items. This data feeds into the analytics and forecasting engine.'
        },
        {
          question: 'How do estimates and invoices feed the AI?',
          answer: 'Every estimate tells the system about upcoming work and expected material needs. Every invoice tells it what was actually used and at what cost. Over time this builds a consumption profile for your shop. The AI uses this history to project future material costs, identify waste patterns, suggest reorder quantities, and forecast how many jobs and how much material you will need in the coming weeks.'
        }
      ]
    },
    {
      id: 'analytics',
      title: 'Analytics & Reports',
      description: 'AI-powered projections, waste analysis, and inventory reports',
      icon: <BarChart3 className="w-6 h-6" />,
      faqs: [
        {
          question: 'What does the Analytics tab show?',
          answer: 'The Analytics tab provides AI-powered projections with a selectable forecast period (2, 4, 8, or 12 weeks). It shows a Confidence Score indicating how reliable the forecast is based on your data volume. Key metrics include Projected Jobs, Material Cost, Labor Cost, and Total Projected Cost. Below that you see a Cost Breakdown by Category with trend indicators, a Waste Analysis section, AI Recommendations, and Top Products by Consumption patterns.'
        },
        {
          question: 'How does the confidence score work?',
          answer: 'The confidence score ranges from 0 to 100 percent. It is calculated from three factors: how many invoices you have (up to 40 points for 50+ invoices), how much consumption history exists (up to 40 points for 200+ records), and a base score of 20 points. At 70% or above the system considers it high confidence. Between 40-70% is moderate, meaning more data will improve accuracy. Below 40% is low confidence and the system recommends uploading more historical data.'
        },
        {
          question: 'What is the Waste Analysis?',
          answer: 'Waste Analysis compares actual product consumption against expected usage based on each product waste factor. It shows your overall waste rate as a percentage, the total dollar cost of waste, and a breakdown by category showing which product types have the highest waste. A six-month trend chart shows whether waste is improving or worsening over time. The system also generates specific waste reduction tips based on your data.'
        },
        {
          question: 'What are AI Recommendations?',
          answer: 'These are actionable suggestions generated from your data. They include cost warnings when a category shows a spending increase over 10%, order recommendations when you have multiple scheduled jobs coming up, optimization opportunities for categories making up more than 25% of your material costs, and general insights about usage patterns. Each recommendation shows a priority level (high, medium, low) and potential savings where applicable.'
        },
        {
          question: 'What does the Inventory Reports tab provide?',
          answer: 'The Reports tab generates detailed inventory reports with filters for date range, item search, manufacturer, category, and product line. It shows summary cards for Total SKUs, Inventory Value, Critical Items, Low Stock, Counts Completed, and Net Adjustments. Four report sub-tabs are available: Inventory Detail (full product list with quantities and values), Year-on-Year Comparison (current vs prior year with change calculations), Count History (all physical counts with variance data), and Adjustments by User (who made what changes and when).'
        },
        {
          question: 'Can I export and print reports?',
          answer: 'Yes. Reports can be exported to CSV for use in spreadsheets or other tools. You can also print reports using the Print button which generates a formatted print-ready document with your company name, date range, summary metrics, inventory detail table, count history, adjustments by user, and signature lines for management review.'
        }
      ]
    },
    {
      id: 'reorder',
      title: 'Reorder & Purchase Planning',
      description: 'Smart reorder suggestions and purchase order generation by manufacturer',
      icon: <ShoppingCart className="w-6 h-6" />,
      faqs: [
        {
          question: 'How does purchase planning work?',
          answer: 'The Reorder page analyzes your current stock levels against reorder points and generates prioritized suggestions. Items are classified as Critical (out of stock or nearly out), Urgent (below reorder point), or Normal (approaching reorder level). The system calculates a suggested order quantity for each item based on your average usage, lead time, and safety stock settings. Summary cards show how many items need attention and the estimated total order cost.'
        },
        {
          question: 'Can I create purchase orders?',
          answer: 'Yes. Review the reorder suggestions, adjust any quantities in the editable order column, then click Create Purchase Order. The system generates a PO grouped by manufacturer/supplier, showing item count, total cost, and primary vendor. You can add notes and save the PO for tracking. This means you get a ready-to-send purchase order organized by manufacturer without having to build it manually.'
        },
        {
          question: 'Can I export purchase orders?',
          answer: 'Yes. The Reorder page supports exporting to PDF, Excel, and CSV formats. You can also print the reorder list directly. These exports are organized by supplier/manufacturer so you can send each vendor their specific order.'
        },
        {
          question: 'How do I see details for a reorder suggestion?',
          answer: 'Expand any row to see four detail sections: Inventory Details (unit type, minimum order, order multiple, days of stock remaining), Supplier Info (supplier name, manufacturer, supplier SKU, lead time in days), Usage Analysis (average daily and weekly usage, last count date, last order date), and Order Calculation (a breakdown showing how the suggested quantity was determined).'
        },
        {
          question: 'Can I filter reorder suggestions?',
          answer: 'Yes. Filter by priority (Critical, Urgent, Normal), by category, or by supplier. You can also search by SKU, product name, or supplier name. This helps you focus on the most important items first or prepare orders for a specific vendor.'
        },
        {
          question: 'Is there an order history?',
          answer: 'Yes. The Order History tab shows all previously created purchase orders with their dates, item counts, total values, and status. This gives you a record of what was ordered and when.'
        }
      ]
    },
    {
      id: 'predictions',
      title: 'AI Predictions & Forecasting',
      description: 'How the AI engine generates and validates inventory forecasts',
      icon: <Brain className="w-6 h-6" />,
      faqs: [
        {
          question: 'How does the prediction engine work?',
          answer: 'The Predictions page generates AI-powered reorder recommendations. Click Generate Prediction and the system analyzes your current stock levels, reorder points, lead times, and consumption patterns to produce a two-week forecast. It shows which products need to be ordered, how many to order, estimated cost, and the date you should order by to avoid a stockout. Each prediction includes an AI Reasoning section explaining why each item was selected.'
        },
        {
          question: 'What does the 100-iteration validation mean?',
          answer: 'When generating a forecast, the AI engine runs the same set of calculations 100 times using standard consumption rate formulas, lead time planning, and reorder point math. It compares each iteration against the manual (straight calculator) result. If the AI result matches the manual calculation at 97.8% accuracy or higher across all iterations, the forecast is approved and displayed. If accuracy falls below 97.8%, the system discards the AI forecast and falls back to showing only the manual calculation. This ensures you never see an unreliable prediction.'
        },
        {
          question: 'Can I edit the suggested order quantities?',
          answer: 'Yes. The prediction table has an editable Order Quantity column. If you know you need more or less of something, change the number directly. Edited quantities show an "edited" badge so you can tell which items were manually adjusted versus system-suggested. The total order value updates automatically as you make changes.'
        },
        {
          question: 'What is the prediction workflow?',
          answer: 'Predictions move through three stages: Generated (the system has created the forecast), Reviewed (you have looked at it and confirmed the numbers), and Ordered (you have placed the order with your suppliers). Update the status as you work through the process. Previous predictions are listed in a sidebar so you can reference past forecasts.'
        },
        {
          question: 'How does the system explain its reasoning?',
          answer: 'Each prediction item includes an AI Reasoning section that explains in plain language why the item was flagged. For example: "Current stock is 2 units, average weekly usage is 4.5 units, lead time is 7 days. At current consumption this product will be depleted in approximately 3 days." This transparency lets you verify every recommendation against your own knowledge of the shop.'
        }
      ]
    },
    {
      id: 'vehicles',
      title: 'Vehicle Lookup',
      description: 'VIN decoding and panel dimension reference',
      icon: <Car className="w-6 h-6" />,
      faqs: [
        {
          question: 'How does VIN lookup work?',
          answer: 'Enter a VIN (11 to 17 characters) on the Vehicles page and click Decode VIN. The system decodes the VIN and returns the vehicle year, make, model, body style, and engine details (cylinder count and displacement). It also shows panel dimensions with surface area in square feet for each body panel. This data helps with accurate material estimation for refinish work.'
        },
        {
          question: 'What are the panel dimension multipliers?',
          answer: 'Panel areas are adjusted by body style to reflect real-world size differences. Trucks use a 1.3x multiplier, SUVs use 1.2x, Sedans use 1.0x (baseline), and Coupes use 0.9x. This means a hood on a truck will show a larger area than the same panel on a coupe, giving you more accurate material calculations for coverage estimation.'
        }
      ]
    },
    {
      id: 'admin',
      title: 'Settings & Administration',
      description: 'Company profile, insurance rates, users, and corporate management',
      icon: <Settings className="w-6 h-6" />,
      faqs: [
        {
          question: 'What is in Company Settings?',
          answer: 'The Company Settings page has two tabs. Company Profile lets you edit your shop name, email, phone, website, and full address. It also shows your subscription status and member-since date. The Paint Line Contract section lets you select your contracted manufacturer (such as PPG, Axalta, or Sherwin-Williams), which can be enforced across all locations in a corporate setup.'
        },
        {
          question: 'How do I configure insurance labor rates?',
          answer: 'Go to Insurance (Labor Rates) under the More menu. Click New Insurer to add an insurance company, or Configure Rates to edit existing ones. For each insurer, set hourly rates for Body, Refinish, Mechanical, Structural, Aluminum, and Glass labor. You can also flag the insurer as a DRP partner and store their account number and contact details. These rates automatically apply when that insurer is selected on an estimate.'
        },
        {
          question: 'What user roles are available?',
          answer: 'Four roles control access: Staff has view-only access to estimates and invoices. Manager can view everything and make inventory adjustments, run counts, and generate predictions. Admin has full management access including settings, user management, and billing. Super Admin has system-wide control across all companies and the licensing administration panel.'
        },
        {
          question: 'How does Corporate multi-location management work?',
          answer: 'The Corporate page (under More) is available to corporate admin and super admin users. It has three tabs: Locations (add and manage shop locations with codes), Group Settings (set a paint line contract manufacturer that applies to all locations), and Users (view and manage all team members across every location with their roles and status).'
        }
      ]
    },
    {
      id: 'billing',
      title: 'Billing & Subscription',
      description: 'Plans, payment, and subscription management',
      icon: <CreditCard className="w-6 h-6" />,
      faqs: [
        {
          question: 'What subscription plans are available?',
          answer: 'refinishAI offers three plans: Starter (single location, core features, 5 users included), Professional (all core features plus analytics, reorder planning, and priority support, 5 users included), and Enterprise (everything in Professional plus multi-location corporate management, dedicated support, and 5 users included). Additional users can be purchased on any plan. Plans are available on monthly or annual billing.'
        },
        {
          question: 'Where do I manage my subscription?',
          answer: 'Go to Billing through the user menu. The page shows your current plan, billing period, status, renewal date, and user limit with a progress bar. Below that you can browse available plans and subscribe through Stripe checkout. Invoice history and payment history tables show all past charges and payments with their status.'
        },
        {
          question: 'What happens when my subscription is expiring?',
          answer: 'A yellow banner appears at the top of every page when your subscription is within 14 days of expiring, showing how many days remain. If your subscription expires, the banner turns red with a link to the Billing page. Admin users see a Manage Billing link directly in the banner.'
        },
        {
          question: 'How are payments processed?',
          answer: 'Payments are processed securely through Stripe. refinishAI never stores your credit card details. When you subscribe or renew, you are redirected to a Stripe checkout page where you enter payment information. Stripe handles all payment processing, and you receive confirmation when the transaction completes.'
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
              <h1 className="text-4xl font-bold">How to Use refinishAI</h1>
              <p className="text-slate-300 mt-2">Complete guide to every feature in the platform</p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-6 py-12 space-y-8">
        {/* How It Works Overview */}
        <section className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
          <div className="bg-gradient-to-r from-blue-50 to-indigo-50 px-6 py-6 border-b border-slate-200">
            <h2 className="text-2xl font-bold text-slate-900 flex items-center gap-3">
              <Brain className="w-7 h-7 text-blue-600" />
              How refinishAI Works
            </h2>
            <p className="text-slate-600 mt-2">A forecasting inventory tool that learns your shop</p>
          </div>
          <div className="p-6 space-y-4">
            <p className="text-slate-700 leading-relaxed">
              refinishAI is built on a simple principle: analyze what your shop has used in the past to predict what it will need in the future. Upload your historical estimates, invoices, and product inventory. The system calculates consumption rates, lead times, waste factors, and reorder points using standard formulas that you can verify with a calculator.
            </p>
            <p className="text-slate-700 leading-relaxed">
              The AI layer takes these same formulas and runs 100 iterations to confirm accuracy. If the AI result matches the manual calculation at 97.8% accuracy or higher, the forecast is approved and displayed with a confidence score. If it falls below that threshold, the system reverts to manual calculations only. You never see an unverified number.
            </p>
            <div className="grid md:grid-cols-4 gap-4 mt-6">
              {[
                { num: 1, title: 'Upload Data', desc: 'Import your estimates, invoices, and product catalog' },
                { num: 2, title: 'System Learns', desc: 'Calculates usage rates, patterns, and reorder timing' },
                { num: 3, title: 'AI Validates', desc: '100 iterations at 97.8% accuracy or falls back to manual' },
                { num: 4, title: 'You Decide', desc: 'Review forecasts, create POs by manufacturer, and order' }
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

        {/* Quick Start */}
        <section className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
          <div className="bg-gradient-to-r from-amber-50 to-orange-50 px-6 py-6 border-b border-slate-200">
            <h2 className="text-2xl font-bold text-slate-900 flex items-center gap-3">
              <Zap className="w-7 h-7 text-amber-600" />
              Quick Start Guide
            </h2>
            <p className="text-slate-600 mt-2">Set up your shop in five steps</p>
          </div>
          <div className="p-6 space-y-4">
            <div className="grid md:grid-cols-5 gap-4">
              {[
                { num: 1, title: 'Company Profile', desc: 'Settings: name, address, contact info' },
                { num: 2, title: 'Upload History', desc: 'Upload: estimates, invoices, products' },
                { num: 3, title: 'Labor Rates', desc: 'Insurance: rates per insurer' },
                { num: 4, title: 'Invite Team', desc: 'Users: add staff with roles' },
                { num: 5, title: 'Start Using', desc: 'Dashboard: forecasts and reorders' }
              ].map(step => (
                <div key={step.num} className="bg-gradient-to-br from-slate-50 to-slate-100 rounded-lg p-4 text-center border border-slate-200">
                  <div className="w-8 h-8 bg-amber-600 text-white rounded-full flex items-center justify-center font-bold mx-auto mb-3">
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
            <p className="text-slate-700">No articles found matching &ldquo;{searchQuery}&rdquo;. Try a different search term.</p>
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
                          <div className="px-6 pb-6 text-slate-700 leading-relaxed bg-white ml-9">
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
              <h2 className="text-3xl font-bold text-white mb-4">Need Help?</h2>
              <p className="text-blue-100 mb-8 text-lg">
                Our support team typically responds within 2 hours during business hours.
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
            refinishAI Knowledge Base &bull; Last updated February 2026
          </p>
        </div>
      </div>
    </div>
  )
}
