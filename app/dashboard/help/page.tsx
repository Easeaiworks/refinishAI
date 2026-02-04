'use client'

import { useState } from 'react'
import {
  BookOpen, Calculator, Shield, FileText, ChevronDown, ChevronRight,
  CheckCircle, Brain, Download, HelpCircle
} from 'lucide-react'

export default function HelpPage() {
  const [expandedSection, setExpandedSection] = useState<string | null>('calculations')

  const toggleSection = (section: string) => {
    setExpandedSection(expandedSection === section ? null : section)
  }

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
          <BookOpen className="w-6 h-6 text-blue-600" />
        </div>
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Help & Documentation</h1>
          <p className="text-gray-600">Understanding how RefinishAI works</p>
        </div>
      </div>

      {/* Trust Banner */}
      <div className="bg-gradient-to-r from-blue-600 to-blue-700 rounded-xl p-6 text-white">
        <div className="flex items-start gap-4">
          <Shield className="w-8 h-8 flex-shrink-0 mt-1" />
          <div>
            <h2 className="text-xl font-bold mb-2">Trustworthy & Audit-Ready</h2>
            <p className="text-blue-100">
              RefinishAI uses deterministic calculations that produce consistent, verifiable results.
              Every number can be traced back to its source data and the exact formula used.
            </p>
          </div>
        </div>
      </div>

      {/* Calculation Methodology */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <button
          onClick={() => toggleSection('calculations')}
          className="w-full flex items-center justify-between p-6 text-left hover:bg-gray-50"
        >
          <div className="flex items-center gap-3">
            <Calculator className="w-6 h-6 text-blue-600" />
            <div>
              <h3 className="font-semibold text-gray-900">Calculation Methodology</h3>
              <p className="text-sm text-gray-500">How we calculate inventory, labor, and estimates</p>
            </div>
          </div>
          {expandedSection === 'calculations' ? (
            <ChevronDown className="w-5 h-5 text-gray-400" />
          ) : (
            <ChevronRight className="w-5 h-5 text-gray-400" />
          )}
        </button>

        {expandedSection === 'calculations' && (
          <div className="px-6 pb-6 space-y-6">
            <div className="bg-blue-50 rounded-lg p-4">
              <p className="text-blue-800 text-sm">
                <strong>Key Principle:</strong> All core calculations use deterministic formulas.
                Same inputs always produce the same outputs, making results fully auditable.
              </p>
            </div>

            {/* Inventory Formulas */}
            <div>
              <h4 className="font-semibold text-gray-900 mb-3 flex items-center gap-2">
                <span className="w-6 h-6 bg-green-100 rounded flex items-center justify-center text-green-700 text-xs font-bold">1</span>
                Inventory Management Formulas
              </h4>
              <div className="space-y-3">
                <FormulaCard
                  name="Reorder Point"
                  formula="(Average Daily Usage × Lead Time Days) + Safety Stock"
                  example="(2.5 × 7) + 5 = 22.5 → 23 units"
                />
                <FormulaCard
                  name="Par Level"
                  formula="Reorder Point + (Average Daily Usage × Order Cycle Days)"
                  example="23 + (2.5 × 14) = 58 units"
                />
                <FormulaCard
                  name="Suggested Order Quantity"
                  formula="CEILING((Par Level - Current Stock) / Order Multiple) × Order Multiple"
                  example="CEILING((58 - 12) / 6) × 6 = 48 units"
                />
                <FormulaCard
                  name="Days of Stock Remaining"
                  formula="Current Stock / Average Daily Usage"
                  example="25 / 2.5 = 10 days"
                />
              </div>
            </div>

            {/* Labor Formulas */}
            <div>
              <h4 className="font-semibold text-gray-900 mb-3 flex items-center gap-2">
                <span className="w-6 h-6 bg-green-100 rounded flex items-center justify-center text-green-700 text-xs font-bold">2</span>
                Labor Cost Formulas
              </h4>
              <div className="space-y-3">
                <FormulaCard
                  name="Labor Cost by Type"
                  formula="Labor Hours × Hourly Rate"
                  example="8.5 hours × $52/hr = $442.00"
                />
                <FormulaCard
                  name="Total Labor Cost"
                  formula="Σ(Labor Hours by Type × Hourly Rate by Type)"
                  example="Body + Refinish + Mechanical + Structural + Aluminum + Glass"
                />
              </div>
              <div className="mt-3 bg-gray-50 rounded-lg p-3">
                <p className="text-sm text-gray-600 font-medium mb-2">Labor Types:</p>
                <div className="grid grid-cols-2 md:grid-cols-3 gap-2 text-sm text-gray-600">
                  <span>• Body Labor</span>
                  <span>• Refinish Labor</span>
                  <span>• Mechanical Labor</span>
                  <span>• Structural/Frame</span>
                  <span>• Aluminum Labor</span>
                  <span>• Glass Labor</span>
                </div>
              </div>
            </div>

            {/* Valuation Formulas */}
            <div>
              <h4 className="font-semibold text-gray-900 mb-3 flex items-center gap-2">
                <span className="w-6 h-6 bg-green-100 rounded flex items-center justify-center text-green-700 text-xs font-bold">3</span>
                Inventory Valuation
              </h4>
              <div className="space-y-3">
                <FormulaCard
                  name="Item Value"
                  formula="Quantity On Hand × Unit Cost"
                  example="24 units × $15.50 = $372.00"
                />
                <FormulaCard
                  name="Total Inventory Value"
                  formula="Σ(Quantity × Unit Cost) for all items"
                  example="Sum of all item values"
                />
              </div>
            </div>
          </div>
        )}
      </div>

      {/* AI Forecasting */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <button
          onClick={() => toggleSection('ai')}
          className="w-full flex items-center justify-between p-6 text-left hover:bg-gray-50"
        >
          <div className="flex items-center gap-3">
            <Brain className="w-6 h-6 text-purple-600" />
            <div>
              <h3 className="font-semibold text-gray-900">AI Forecasting</h3>
              <p className="text-sm text-gray-500">When and how AI predictions are used</p>
            </div>
          </div>
          {expandedSection === 'ai' ? (
            <ChevronDown className="w-5 h-5 text-gray-400" />
          ) : (
            <ChevronRight className="w-5 h-5 text-gray-400" />
          )}
        </button>

        {expandedSection === 'ai' && (
          <div className="px-6 pb-6 space-y-4">
            <div className="bg-purple-50 rounded-lg p-4">
              <p className="text-purple-800 text-sm">
                <strong>AI as Guidance Only:</strong> AI-powered forecasts are only displayed when they
                achieve ≥97.8% consistency across 100 iterations. Otherwise, we fall back to deterministic calculations.
              </p>
            </div>

            <div className="grid md:grid-cols-2 gap-4">
              <div className="border border-gray-200 rounded-lg p-4">
                <h4 className="font-medium text-gray-900 mb-2 flex items-center gap-2">
                  <CheckCircle className="w-4 h-4 text-green-600" />
                  When AI is Used
                </h4>
                <ul className="text-sm text-gray-600 space-y-1">
                  <li>• Demand trend forecasting</li>
                  <li>• Seasonal adjustment suggestions</li>
                  <li>• Usage pattern analysis</li>
                </ul>
              </div>
              <div className="border border-gray-200 rounded-lg p-4">
                <h4 className="font-medium text-gray-900 mb-2 flex items-center gap-2">
                  <Shield className="w-4 h-4 text-blue-600" />
                  Reliability Requirements
                </h4>
                <ul className="text-sm text-gray-600 space-y-1">
                  <li>• Must run 100 iterations</li>
                  <li>• Must achieve ≥97.8% consistency</li>
                  <li>• Always shows confidence score</li>
                </ul>
              </div>
            </div>

            <div className="bg-gray-50 rounded-lg p-4">
              <h4 className="font-medium text-gray-900 mb-2">Fallback Behavior</h4>
              <p className="text-sm text-gray-600">
                When AI forecasts don't meet the reliability threshold, the system automatically
                uses deterministic calculations based on historical data and configured parameters.
                You'll always see a clear indication of which method was used.
              </p>
            </div>
          </div>
        )}
      </div>

      {/* Audit Trail */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <button
          onClick={() => toggleSection('audit')}
          className="w-full flex items-center justify-between p-6 text-left hover:bg-gray-50"
        >
          <div className="flex items-center gap-3">
            <FileText className="w-6 h-6 text-orange-600" />
            <div>
              <h3 className="font-semibold text-gray-900">Audit Trail</h3>
              <p className="text-sm text-gray-500">How calculations are logged and verified</p>
            </div>
          </div>
          {expandedSection === 'audit' ? (
            <ChevronDown className="w-5 h-5 text-gray-400" />
          ) : (
            <ChevronRight className="w-5 h-5 text-gray-400" />
          )}
        </button>

        {expandedSection === 'audit' && (
          <div className="px-6 pb-6 space-y-4">
            <div className="bg-orange-50 rounded-lg p-4">
              <p className="text-orange-800 text-sm">
                <strong>Full Traceability:</strong> Every calculation creates an audit entry that can be
                exported for external review. This ensures complete transparency and accountability.
              </p>
            </div>

            <div>
              <h4 className="font-medium text-gray-900 mb-3">What Gets Logged</h4>
              <div className="bg-gray-900 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
                <pre>{`{
  "timestamp": "2025-02-03T15:30:00.000Z",
  "calculationType": "Reorder Point",
  "formula": "(Avg Daily × Lead Time) + Safety",
  "inputs": {
    "avgDailyUsage": 2.5,
    "leadTimeDays": 7,
    "safetyStock": 5
  },
  "result": 23,
  "userId": "user-uuid",
  "companyId": "company-uuid"
}`}</pre>
              </div>
            </div>

            <div className="grid md:grid-cols-2 gap-4">
              <div className="border border-gray-200 rounded-lg p-4">
                <h4 className="font-medium text-gray-900 mb-2">Audit Defense</h4>
                <p className="text-sm text-gray-600">
                  If questioned about any calculation, you can pull the audit trail showing
                  the exact formula, inputs, and result. Every step is reproducible.
                </p>
              </div>
              <div className="border border-gray-200 rounded-lg p-4">
                <h4 className="font-medium text-gray-900 mb-2">Export Options</h4>
                <p className="text-sm text-gray-600">
                  Audit trails can be exported to CSV for external review by auditors,
                  insurance companies, or other stakeholders.
                </p>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Quick Reference */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <button
          onClick={() => toggleSection('reference')}
          className="w-full flex items-center justify-between p-6 text-left hover:bg-gray-50"
        >
          <div className="flex items-center gap-3">
            <HelpCircle className="w-6 h-6 text-gray-600" />
            <div>
              <h3 className="font-semibold text-gray-900">Quick Reference</h3>
              <p className="text-sm text-gray-500">Summary of all calculation types</p>
            </div>
          </div>
          {expandedSection === 'reference' ? (
            <ChevronDown className="w-5 h-5 text-gray-400" />
          ) : (
            <ChevronRight className="w-5 h-5 text-gray-400" />
          )}
        </button>

        {expandedSection === 'reference' && (
          <div className="px-6 pb-6">
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-gray-200">
                    <th className="text-left py-3 pr-4 font-semibold text-gray-900">Calculation</th>
                    <th className="text-left py-3 pr-4 font-semibold text-gray-900">Method</th>
                    <th className="text-left py-3 font-semibold text-gray-900">Auditability</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  <ReferenceRow name="Reorder Points" method="Deterministic" audit="Full audit trail" />
                  <ReferenceRow name="Par Levels" method="Deterministic" audit="Full audit trail" />
                  <ReferenceRow name="Order Quantities" method="Deterministic" audit="Full audit trail" />
                  <ReferenceRow name="Labor Costs" method="Deterministic" audit="Full audit trail" />
                  <ReferenceRow name="Inventory Values" method="Deterministic" audit="Full audit trail" />
                  <ReferenceRow name="Demand Forecasts" method="AI (≥97.8%)" audit="Confidence score + fallback" />
                  <ReferenceRow name="Trend Analysis" method="AI (≥97.8%)" audit="Confidence score + fallback" />
                </tbody>
              </table>
            </div>
          </div>
        )}
      </div>

      {/* Footer */}
      <div className="text-center text-sm text-gray-500 py-4">
        <p>
          <strong>Key Guarantee:</strong> Every number in RefinishAI can be traced back to its
          source data and the exact formula used to calculate it.
        </p>
      </div>
    </div>
  )
}

function FormulaCard({ name, formula, example }: { name: string; formula: string; example: string }) {
  return (
    <div className="bg-gray-50 rounded-lg p-3">
      <div className="flex items-start justify-between gap-4">
        <div>
          <p className="font-medium text-gray-900 text-sm">{name}</p>
          <p className="text-blue-600 font-mono text-sm mt-1">{formula}</p>
        </div>
      </div>
      <p className="text-gray-500 text-xs mt-2">
        <span className="font-medium">Example:</span> {example}
      </p>
    </div>
  )
}

function ReferenceRow({ name, method, audit }: { name: string; method: string; audit: string }) {
  const isAI = method.includes('AI')
  return (
    <tr>
      <td className="py-3 pr-4 text-gray-900">{name}</td>
      <td className="py-3 pr-4">
        <span className={`px-2 py-1 rounded text-xs font-medium ${
          isAI ? 'bg-purple-100 text-purple-700' : 'bg-green-100 text-green-700'
        }`}>
          {method}
        </span>
      </td>
      <td className="py-3 text-gray-600">{audit}</td>
    </tr>
  )
}
