export interface PanelType {
  id: string;
  name: string;
  code: string;
  typical_area_sqft: number;
  created_at: string;
}

export interface Vehicle {
  id: string;
  vin: string;
  year: number;
  make: string;
  model: string;
  body_style: string;
  created_at: string;
  updated_at: string;
}

export interface VehiclePanel {
  id: string;
  vehicle_id: string;
  panel_type_id: string;
  area_sqft: number;
  created_at: string;
}

export interface Product {
  id: string;
  sku: string;
  name: string;
  category: string;
  unit_type: string;
  coverage_sqft_per_unit: number;
  waste_factor: number;
  unit_cost: number;
  supplier: string;
  lead_time_days: number;
  manufacturer?: string;
  // product_group removed — use 'category' instead
  product_line?: string;
  created_at: string;
  updated_at: string;
}

export interface Estimate {
  id: string;
  shop_id?: string;
  estimate_number: string;
  vin?: string;
  vehicle_id?: string;
  customer_name?: string;
  estimate_date: string;
  expected_start_date?: string;
  status: string;
  total_amount: number;
  source: string;
  raw_data?: any;
  created_at: string;
  updated_at: string;
}

export interface EstimateLineItem {
  id: string;
  estimate_id: string;
  panel_type_id?: string;
  product_id?: string;
  description: string;
  quantity: number;
  unit_price: number;
  line_total: number;
  is_refinish: boolean;
  created_at: string;
}

export interface Invoice {
  id: string;
  shop_id?: string;
  invoice_number: string;
  estimate_id?: string;
  vin?: string;
  vehicle_id?: string;
  customer_name?: string;
  invoice_date: string;
  completion_date: string;
  total_amount: number;
  source: string;
  raw_data?: any;
  created_at: string;
  updated_at: string;
}

export interface InvoiceLineItem {
  id: string;
  invoice_id: string;
  panel_type_id?: string;
  product_id?: string;
  description: string;
  quantity: number;
  unit_price: number;
  line_total: number;
  is_refinish: boolean;
  actual_product_used?: number;
  created_at: string;
}

export interface Prediction {
  id: string;
  shop_id?: string;
  prediction_date: string;
  forecast_start_date: string;
  forecast_end_date: string;
  status: string;
  confidence_score: number;
  notes?: string;
  created_at: string;
  updated_at: string;
}

export interface PredictionItem {
  id: string;
  prediction_id: string;
  product_id: string;
  predicted_quantity: number;
  adjusted_quantity?: number;
  current_stock: number;
  reasoning?: string;
  order_by_date?: string;
  is_overridden: boolean;
  created_at: string;
  updated_at: string;
  product?: Product;
}

export interface ConsumptionHistory {
  id: string;
  invoice_id: string;
  product_id: string;
  panel_type_id?: string;
  estimated_quantity?: number;
  actual_quantity: number;
  variance_pct?: number;
  vehicle_id?: string;
  completion_date: string;
  created_at: string;
}

// ── Inventory Reporting Types ──────────────────────────────────────

export interface InventoryReportFilters {
  startDate: string;
  endDate: string;
  itemSearch?: string;
  category?: string;
  manufacturer?: string;
  productLine?: string;
  enableYoY?: boolean;
}

export interface InventoryReportItem {
  productId: string;
  sku: string;
  name: string;
  category: string;
  manufacturer?: string;
  productLine?: string;
  quantityOnHand: number;
  unitCost: number;
  totalValue: number;
  reorderPoint: number;
  status: 'critical' | 'low' | 'adequate' | 'overstocked';
  transactionCount: number;
  lastTransactionDate?: string;
  // Year-on-year comparison
  priorYearQty?: number;
  priorYearValue?: number;
  qtyChange?: number;
  valueChange?: number;
  pctChange?: number;
}

export interface InventoryReportSummary {
  totalSKUs: number;
  totalQuantity: number;
  totalInventoryValue: number;
  criticalItems: number;
  lowStockItems: number;
  countsCompleted: number;
  netAdjustmentValue: number;
}

export interface CountHistoryEntry {
  id: string;
  countDate: string;
  countType: string;
  status: string;
  itemsCounted: number;
  varianceCount: number;
  totalVarianceValue: number;
  countedBy: string;
  countedByName?: string;
  verifiedBy?: string;
  verifiedByName?: string;
}

export interface AdjustmentEntry {
  id: string;
  countId?: string;
  productId: string;
  productName: string;
  productSku: string;
  adjustmentType: string;
  previousQuantity: number;
  newQuantity: number;
  adjustmentQuantity: number;
  unitCost: number;
  adjustmentValue: number;
  adjustedBy: string;
  adjustedByName?: string;
  reason?: string;
  createdAt: string;
}

export interface UserAdjustmentSummary {
  userId: string;
  userName: string;
  adjustmentCount: number;
  totalValue: number;
  adjustments: AdjustmentEntry[];
}

// ── Multi-Location / Company Hierarchy Types ─────────────────

export type CompanyType = 'single' | 'corporate' | 'location';

export interface CompanyWithHierarchy {
  id: string;
  name: string;
  email: string;
  phone?: string;
  address?: string;
  city?: string;
  state?: string;
  zip?: string;
  website?: string;
  subscription_status: string;
  created_at: string;
  updated_at?: string;
  // Hierarchy fields
  parent_company_id?: string | null;
  company_type: CompanyType;
  location_code?: string | null;
  is_headquarters: boolean;
  // Joined / computed
  childLocations?: CompanyWithHierarchy[];
  userCount?: number;
  parentCompany?: { id: string; name: string };
}

export interface CorporateSettingRow {
  id: string;
  parent_company_id: string;
  setting_key: string;
  setting_value: Record<string, any>;
  enforce_lock: boolean;
  created_at: string;
  updated_at: string;
}

export interface UserProfileExtended {
  id: string;
  email: string;
  full_name: string;
  role: 'super_admin' | 'admin' | 'manager' | 'staff';
  company_id: string;
  is_active: boolean;
  is_corporate_user: boolean;
  created_at: string;
  last_login_at?: string;
  // Joined
  company?: { id: string; name: string; company_type: CompanyType };
}

export interface NewCompanyData {
  name: string;
  email: string;
  phone?: string;
  address?: string;
  city?: string;
  state?: string;
  zip?: string;
  website?: string;
}

export interface NewLocationData {
  name: string;
  location_code: string;
  email?: string;
  phone?: string;
  address?: string;
  city?: string;
  state?: string;
  zip?: string;
  is_headquarters?: boolean;
}

// ── Purchase Order Types ──────────────────────────────────────

export interface PurchaseOrder {
  id: string;
  company_id: string;
  po_number: string;
  status: 'draft' | 'submitted' | 'received' | 'partial' | 'cancelled';
  vendor_code?: string;
  vendor_name?: string;
  created_by?: string;
  submitted_date?: string;
  received_date?: string;
  total_items: number;
  total_cost: number;
  notes?: string;
  created_at: string;
  updated_at: string;
  // Joined fields
  items?: PurchaseOrderItem[];
}

export interface PurchaseOrderItem {
  id: string;
  purchase_order_id: string;
  product_id?: string;
  sku: string;
  product_name: string;
  category: string;
  manufacturer: string;
  unit?: string;
  quantity_ordered: number;
  unit_cost: number;
  extended_cost: number;
  quantity_received: number;
  priority?: string;
  notes?: string;
  created_at: string;
}

export interface PurchaseOrderFilters {
  search?: string;
  status?: string;
  manufacturer?: string;
  category?: string;
  startDate?: string;
  endDate?: string;
}
