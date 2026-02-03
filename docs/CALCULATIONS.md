# RefinishAI Calculation & Audit Documentation

## Overview

RefinishAI uses a **dual-layer calculation architecture** designed to be fully auditable, defensible, and trustworthy:

1. **Deterministic Calculations** - Fixed formulas that always produce the same output given the same input
2. **AI Forecasting** - Only used when achieving ≥97.8% consistency across 100 iterations

This architecture ensures that all business-critical calculations can be verified, reproduced, and defended in an audit.

---

## Core Principles

### 1. Deterministic First
All core business calculations (inventory levels, labor costs, order quantities, valuations) use fixed mathematical formulas. These calculations:
- **Same inputs → Same outputs**, every time
- Can be verified with a calculator
- Leave a complete audit trail

### 2. AI as Guidance Only
AI-powered features (demand forecasting, trend analysis) are only displayed when they meet strict reliability criteria:
- Must run **100 iterations** of the calculation
- Must achieve **≥97.8% consistency** (same result 98+ times out of 100)
- If below threshold → System falls back to deterministic calculation
- Always displays confidence score and disclaimer

### 3. Full Audit Trail
Every calculation logs:
- Timestamp
- Formula name and description
- All input values
- Calculated result
- User and company ID
- Exportable to CSV for external audit

---

## Deterministic Formulas

### Inventory Management

#### Reorder Point
```
Reorder Point = (Average Daily Usage × Lead Time Days) + Safety Stock
```
**Purpose:** The inventory level at which a new order should be placed.

**Example:**
- Average Daily Usage: 2.5 units
- Lead Time: 7 days
- Safety Stock: 5 units
- **Reorder Point = (2.5 × 7) + 5 = 22.5 → 23 units**

---

#### Par Level
```
Par Level = Reorder Point + (Average Daily Usage × Order Cycle Days)
```
**Purpose:** The target inventory level to maintain.

**Example:**
- Reorder Point: 23 units
- Average Daily Usage: 2.5 units
- Order Cycle: 14 days
- **Par Level = 23 + (2.5 × 14) = 58 units**

---

#### Suggested Order Quantity
```
Suggested Order Qty = CEILING((Par Level - Current Stock) / Order Multiple) × Order Multiple
```
**Purpose:** How many units to order, respecting minimum order quantities.

**Example:**
- Par Level: 58 units
- Current Stock: 12 units
- Order Multiple: 6 (must order in cases of 6)
- Raw need: 58 - 12 = 46
- **Suggested Order = CEILING(46 / 6) × 6 = 8 × 6 = 48 units**

---

#### Days of Stock Remaining
```
Days of Stock = Current Stock / Average Daily Usage
```
**Purpose:** How many days until stockout at current usage rate.

**Example:**
- Current Stock: 25 units
- Average Daily Usage: 2.5 units
- **Days of Stock = 25 / 2.5 = 10 days**

---

#### Average Daily Usage
```
Average Daily Usage = Total Units Used in Period / Number of Days in Period
```
**Purpose:** Calculate consumption rate from historical data.

**Example:**
- Total used in 30 days: 75 units
- **Average Daily Usage = 75 / 30 = 2.5 units/day**

---

### Labor Cost Calculations

#### Single Labor Type Cost
```
Labor Cost = Labor Hours × Hourly Rate
```
**Example:**
- Body Labor Hours: 8.5
- Body Labor Rate: $52.00/hr
- **Body Labor Cost = 8.5 × $52.00 = $442.00**

---

#### Total Labor Cost
```
Total Labor Cost = Σ(Labor Hours by Type × Hourly Rate by Type)
```
**Labor Types:**
| Type | Description |
|------|-------------|
| Body | Standard body repair, R&I, R&R |
| Refinish | Paint, prime, clear coat |
| Mechanical | Suspension, drivetrain |
| Structural | Frame, measuring, pulling |
| Aluminum | Specialized aluminum work |
| Glass | Windshield, window install |

**Example:**
| Type | Hours | Rate | Cost |
|------|-------|------|------|
| Body | 8.5 | $52 | $442.00 |
| Refinish | 6.0 | $54 | $324.00 |
| Mechanical | 2.0 | $65 | $130.00 |
| **Total** | | | **$896.00** |

---

### Inventory Valuation

#### Single Item Value
```
Inventory Value = Quantity On Hand × Unit Cost
```

#### Total Inventory Value
```
Total Value = Σ(Quantity × Unit Cost) for all items
```

---

### Order Calculations

#### Order Line Total
```
Line Total = Order Quantity × Unit Cost × (1 - Discount %)
```
**Example:**
- Quantity: 24 units
- Unit Cost: $15.50
- Discount: 10%
- **Line Total = 24 × $15.50 × (1 - 0.10) = $334.80**

---

### Estimate/Invoice Totals

#### Estimate Total
```
Estimate Total = Total Labor + Total Parts + Total Materials + Total Sublet - Deductible
```

---

## AI Forecasting System

### Reliability Requirements

AI forecasts are **only displayed** when they meet strict consistency requirements:

```typescript
const REQUIRED_CONSISTENCY = 97.8%  // Minimum consistency rate
const ITERATIONS = 100              // Number of test runs
```

### How It Works

1. **Run 100 iterations** of the forecast calculation
2. **Count results** - How many times did we get each answer?
3. **Calculate consistency** - What percentage matched the most common result?
4. **Decision:**
   - If consistency ≥ 97.8% → Display AI forecast with confidence score
   - If consistency < 97.8% → Fall back to deterministic calculation

### Example

**Demand Forecast for PPG Basecoat:**
- Ran 100 iterations
- 99 iterations returned "Order 24 units"
- 1 iteration returned "Order 25 units"
- **Consistency: 99%** ✓ Meets threshold

**Display:**
> AI Forecast: Order 24 units
> *Confidence: 99% consistency across 100 iterations*

### Fallback Behavior

When AI doesn't meet the threshold:

> AI forecast did not meet reliability threshold (87.3% < 97.8%).
> Showing deterministic calculation instead.
> **Suggested Order: 22 units** (based on Par Level formula)

---

## Audit Trail

### What Gets Logged

Every calculation creates an audit entry:

```json
{
  "id": "uuid-here",
  "timestamp": "2025-02-03T15:30:00.000Z",
  "calculationType": "Reorder Point",
  "formulaName": "Reorder Point",
  "formulaDescription": "(Average Daily Usage × Lead Time Days) + Safety Stock",
  "inputs": {
    "avgDailyUsage": 2.5,
    "leadTimeDays": 7,
    "safetyStock": 5
  },
  "result": 23,
  "userId": "user-uuid",
  "companyId": "company-uuid"
}
```

### Exporting for Audit

Audit trails can be exported to CSV:

```csv
ID,Timestamp,Calculation Type,Formula Name,Formula,Inputs,Result,User ID,Company ID
abc123,2025-02-03T15:30:00Z,Reorder Point,Reorder Point,"(Avg Daily × Lead Time) + Safety","{avgDaily:2.5,leadTime:7,safety:5}",23,user123,company456
```

### Verification

Any calculation can be verified by re-running with the same inputs:

```typescript
verifyCalculation('REORDER_POINT', [2.5, 7, 5], 23)
// Returns: { verified: true, calculatedResult: 23, difference: 0 }
```

---

## Defending Against Audits

### Scenario: Insurance Company Questions Reorder Recommendation

**Challenge:** "Why did your system recommend ordering 48 units?"

**Defense:**
1. **Pull audit trail** for that calculation
2. **Show formula:** `CEILING((Par Level - Current Stock) / Order Multiple) × Order Multiple`
3. **Show inputs:** Par Level: 58, Current Stock: 12, Order Multiple: 6
4. **Verify:** `CEILING((58 - 12) / 6) × 6 = CEILING(7.67) × 6 = 8 × 6 = 48` ✓

**Supporting Evidence:**
- Par Level calculated from: Reorder Point (23) + (Avg Daily (2.5) × Cycle Days (14))
- Reorder Point calculated from: (Avg Daily (2.5) × Lead Time (7)) + Safety (5)
- Average Daily Usage calculated from: 75 units used / 30 days

**Conclusion:** Each step is traceable, reproducible, and mathematically verifiable.

---

### Scenario: Questioning an AI Forecast

**Challenge:** "How can we trust the AI's demand prediction?"

**Defense:**
1. **Show consistency score:** "This forecast achieved 99% consistency across 100 iterations"
2. **Explain threshold:** "We only display AI forecasts when they achieve ≥97.8% consistency"
3. **Show fallback:** "If AI doesn't meet this threshold, we use deterministic calculations instead"
4. **Demonstrate:** Re-run the forecast to show consistent results

---

## Summary

| Calculation Type | Method | Auditability |
|-----------------|--------|--------------|
| Reorder Points | Deterministic | Full audit trail, reproducible |
| Par Levels | Deterministic | Full audit trail, reproducible |
| Order Quantities | Deterministic | Full audit trail, reproducible |
| Labor Costs | Deterministic | Full audit trail, reproducible |
| Inventory Values | Deterministic | Full audit trail, reproducible |
| Demand Forecasts | AI (≥97.8% consistency) | Confidence score, fallback available |
| Trend Analysis | AI (≥97.8% consistency) | Confidence score, fallback available |

**Key Guarantee:** Every number in RefinishAI can be traced back to its source data and the exact formula used to calculate it.

---

## Technical Implementation

See:
- `/lib/calculations/audit-trail.ts` - Formula definitions and audit logging
- `/lib/calculations/index.ts` - Calculation service with full audit support

---

*Document Version: 1.0*
*Last Updated: February 2025*
