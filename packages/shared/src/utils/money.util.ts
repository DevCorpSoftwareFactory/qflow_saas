/**
 * Money Utilities
 * Pure functions for Colombian Peso (COP) money operations.
 */

/**
 * Colombian Peso currency configuration
 */
export const COP_CONFIG = {
    code: 'COP',
    symbol: '$',
    decimalSeparator: ',',
    thousandsSeparator: '.',
    decimals: 0, // COP typically doesn't use decimals
    taxRate: 0.19, // IVA 19%
};

/**
 * Format number as Colombian Peso (COP)
 * @param amount Amount in pesos
 * @param includeSymbol Whether to include $ symbol
 */
export function formatMoneyCOP(amount: number, includeSymbol = true): string {
    const rounded = Math.round(amount);
    const formatted = rounded
        .toString()
        .replace(/\B(?=(\d{3})+(?!\d))/g, COP_CONFIG.thousandsSeparator);

    return includeSymbol ? `${COP_CONFIG.symbol}${formatted}` : formatted;
}

/**
 * Format money with decimals (for internal calculations display)
 */
export function formatMoneyWithDecimals(amount: number, decimals = 2): string {
    const fixed = amount.toFixed(decimals);
    const [intPart, decPart] = fixed.split('.');
    const formattedInt = intPart.replace(/\B(?=(\d{3})+(?!\d))/g, COP_CONFIG.thousandsSeparator);
    return `${COP_CONFIG.symbol}${formattedInt}${COP_CONFIG.decimalSeparator}${decPart}`;
}

/**
 * Parse money string to number
 * Handles Colombian format: $1.234.567 or 1.234.567
 */
export function parseMoneyCOP(value: string): number {
    if (!value) return 0;

    // Remove currency symbol and whitespace
    let cleaned = value.replace(/[$\s]/g, '');

    // Replace Colombian thousands separator with nothing
    cleaned = cleaned.replace(/\./g, '');

    // Replace Colombian decimal separator with decimal point
    cleaned = cleaned.replace(/,/g, '.');

    const parsed = parseFloat(cleaned);
    return isNaN(parsed) ? 0 : parsed;
}

/**
 * Round to nearest peso (no decimals for COP)
 */
export function roundCOP(amount: number): number {
    return Math.round(amount);
}

/**
 * Round to nearest 100 pesos (common for cash transactions)
 */
export function roundToHundred(amount: number): number {
    return Math.round(amount / 100) * 100;
}

/**
 * Round to nearest 1000 pesos
 */
export function roundToThousand(amount: number): number {
    return Math.round(amount / 1000) * 1000;
}

/**
 * Calculate percentage of amount
 */
export function calculatePercentage(amount: number, percentage: number): number {
    return amount * (percentage / 100);
}

/**
 * Apply percentage discount
 */
export function applyDiscount(amount: number, discountPercentage: number): number {
    return amount * (1 - discountPercentage / 100);
}

/**
 * Calculate IVA (19% tax)
 */
export function calculateIVA(baseAmount: number): number {
    return baseAmount * COP_CONFIG.taxRate;
}

/**
 * Calculate base amount from total with IVA
 */
export function extractBaseFromIVA(totalWithIVA: number): number {
    return totalWithIVA / (1 + COP_CONFIG.taxRate);
}

/**
 * Calculate IVA from total with IVA
 */
export function extractIVAFromTotal(totalWithIVA: number): number {
    const base = extractBaseFromIVA(totalWithIVA);
    return totalWithIVA - base;
}

/**
 * Add IVA to base amount
 */
export function addIVA(baseAmount: number): number {
    return baseAmount * (1 + COP_CONFIG.taxRate);
}

/**
 * Calculate subtotal, IVA, and total
 */
export interface TaxBreakdown {
    subtotal: number;
    iva: number;
    total: number;
    formattedSubtotal: string;
    formattedIva: string;
    formattedTotal: string;
}

/**
 * Get full tax breakdown from base amount
 */
export function calculateTaxBreakdown(baseAmount: number): TaxBreakdown {
    const subtotal = roundCOP(baseAmount);
    const iva = roundCOP(calculateIVA(baseAmount));
    const total = subtotal + iva;

    return {
        subtotal,
        iva,
        total,
        formattedSubtotal: formatMoneyCOP(subtotal),
        formattedIva: formatMoneyCOP(iva),
        formattedTotal: formatMoneyCOP(total),
    };
}

/**
 * Calculate change for cash payment
 */
export function calculateChange(total: number, amountPaid: number): number {
    return Math.max(0, amountPaid - total);
}

/**
 * Split amount into equal parts
 */
export function splitAmount(amount: number, parts: number): number[] {
    if (parts <= 0) return [];

    const baseAmount = Math.floor(amount / parts);
    const remainder = amount - baseAmount * parts;

    const result: number[] = [];
    for (let i = 0; i < parts; i++) {
        // Distribute remainder across first parts
        result.push(i < remainder ? baseAmount + 1 : baseAmount);
    }

    return result;
}

/**
 * Sum array of money amounts
 */
export function sumAmounts(amounts: number[]): number {
    return amounts.reduce((sum, amount) => sum + amount, 0);
}

/**
 * Check if amount is positive
 */
export function isPositive(amount: number): boolean {
    return amount > 0;
}

/**
 * Check if amount is negative
 */
export function isNegative(amount: number): boolean {
    return amount < 0;
}

/**
 * Get absolute value
 */
export function absoluteAmount(amount: number): number {
    return Math.abs(amount);
}
