// =============================================================================
// QFLOW POS - ENUMS (Matching DDL)
// =============================================================================
// Este archivo contiene todos los enums usados en las tablas Drift
// Basado en: qflow-pro/supabase/qflow_pro_ddl_complete.sql
// =============================================================================

// --- Sales ---
enum SaleStatus { draft, completed, cancelled, returned }

enum SaleType { retail, wholesale, order }

enum PaymentMethod { cash, card, transfer, nequi, credit }

// --- Cash ---
enum SessionStatus { open, closed, pendingApproval }

enum CashMovementType { income, expense, withdrawal, transferIn, transferOut }

enum CashMovementCategory {
  creditGranted,
  creditPayment,
  onlinePaymentReceived,
  salesCash,
  expense,
  purchase,
  withdrawal,
  transferToBank,
  other,
}

// --- Inventory ---
enum MovementType {
  purchase,
  sale,
  transferOut,
  transferIn,
  adjustment,
  returnCustomer,
  returnSupplier,
  waste,
  internalConsumption,
}

enum LotStatus { active, depleted, expired, returned, waste }

// --- Customer ---
enum CustomerType { retail, wholesale, vip }

enum CustomerStatus { active, suspended, blocked }

enum ApprovalStatus { pending, approved, rejected }

// --- Order ---
enum OrderStatus {
  requested,
  confirmed,
  preparing,
  ready,
  inTransit,
  delivered,
  cancelled,
}

enum PaymentStatus { pending, partial, paid }

// --- Purchase ---
enum PurchaseOrderStatus {
  draft,
  sent,
  confirmed,
  partial,
  received,
  cancelled,
}

enum PurchaseInvoiceStatus { pending, partial, paid }

// --- Accounting ---
enum AccountType { asset, liability, equity, income, expense }

enum AccountNature { debit, credit }

enum AccountingEntryStatus { draft, posted }

// --- Employee ---
enum EmployeeStatus { active, onLeave, terminated }

enum PaymentFrequency { biweekly, monthly }

enum PayrollStatus { draft, approved, paid }

// --- Support ---
enum TicketCategory { technical, billing, featureRequest, bug, general }

enum TicketPriority { low, medium, high, critical }

enum TicketStatus { open, inProgress, waitingCustomer, resolved, closed }

enum TicketAuthorType { customer, agent, system }

// --- License ---
enum LicenseType { trial, commercial, demo, internal, partner }

enum LicenseStatus { pending, active, expired, suspended, cancelled, revoked }
