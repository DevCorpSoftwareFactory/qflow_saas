/**
 * Date Utilities
 * Pure functions for date manipulation without external dependencies.
 */

/**
 * Format date to ISO 8601 string
 */
export function toISOString(date: Date): string {
    return date.toISOString();
}

/**
 * Format date to locale string (YYYY-MM-DD)
 */
export function formatDate(date: Date): string {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

/**
 * Format date with time (YYYY-MM-DD HH:mm:ss)
 */
export function formatDateTime(date: Date): string {
    const dateStr = formatDate(date);
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');
    return `${dateStr} ${hours}:${minutes}:${seconds}`;
}

/**
 * Format time only (HH:mm:ss)
 */
export function formatTime(date: Date): string {
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');
    return `${hours}:${minutes}:${seconds}`;
}

/**
 * Format date for display in Colombian format (DD/MM/YYYY)
 */
export function formatDateCO(date: Date): string {
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
}

/**
 * Parse date from string (ISO 8601 or YYYY-MM-DD)
 */
export function parseDate(dateString: string): Date | null {
    const date = new Date(dateString);
    return isNaN(date.getTime()) ? null : date;
}

/**
 * Parse date from Colombian format (DD/MM/YYYY)
 */
export function parseDateCO(dateString: string): Date | null {
    const parts = dateString.split('/');
    if (parts.length !== 3) return null;

    const day = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10) - 1;
    const year = parseInt(parts[2], 10);

    const date = new Date(year, month, day);
    return isNaN(date.getTime()) ? null : date;
}

/**
 * Check if date A is before date B
 */
export function isBefore(a: Date, b: Date): boolean {
    return a.getTime() < b.getTime();
}

/**
 * Check if date A is after date B
 */
export function isAfter(a: Date, b: Date): boolean {
    return a.getTime() > b.getTime();
}

/**
 * Check if two dates are on the same day
 */
export function isSameDay(a: Date, b: Date): boolean {
    return (
        a.getFullYear() === b.getFullYear() &&
        a.getMonth() === b.getMonth() &&
        a.getDate() === b.getDate()
    );
}

/**
 * Get difference in days between two dates
 */
export function differenceInDays(a: Date, b: Date): number {
    const msPerDay = 24 * 60 * 60 * 1000;
    return Math.floor((a.getTime() - b.getTime()) / msPerDay);
}

/**
 * Get difference in hours between two dates
 */
export function differenceInHours(a: Date, b: Date): number {
    const msPerHour = 60 * 60 * 1000;
    return Math.floor((a.getTime() - b.getTime()) / msPerHour);
}

/**
 * Get difference in minutes between two dates
 */
export function differenceInMinutes(a: Date, b: Date): number {
    const msPerMinute = 60 * 1000;
    return Math.floor((a.getTime() - b.getTime()) / msPerMinute);
}

/**
 * Add days to a date
 */
export function addDays(date: Date, days: number): Date {
    const result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}

/**
 * Add hours to a date
 */
export function addHours(date: Date, hours: number): Date {
    const result = new Date(date);
    result.setHours(result.getHours() + hours);
    return result;
}

/**
 * Add minutes to a date
 */
export function addMinutes(date: Date, minutes: number): Date {
    const result = new Date(date);
    result.setMinutes(result.getMinutes() + minutes);
    return result;
}

/**
 * Get start of day (00:00:00.000)
 */
export function startOfDay(date: Date): Date {
    const result = new Date(date);
    result.setHours(0, 0, 0, 0);
    return result;
}

/**
 * Get end of day (23:59:59.999)
 */
export function endOfDay(date: Date): Date {
    const result = new Date(date);
    result.setHours(23, 59, 59, 999);
    return result;
}

/**
 * Get start of month
 */
export function startOfMonth(date: Date): Date {
    const result = new Date(date);
    result.setDate(1);
    result.setHours(0, 0, 0, 0);
    return result;
}

/**
 * Get end of month
 */
export function endOfMonth(date: Date): Date {
    const result = new Date(date);
    result.setMonth(result.getMonth() + 1, 0);
    result.setHours(23, 59, 59, 999);
    return result;
}

/**
 * Check if date is today
 */
export function isToday(date: Date): boolean {
    return isSameDay(date, new Date());
}

/**
 * Convert to UTC
 */
export function toUTC(date: Date): Date {
    return new Date(
        Date.UTC(
            date.getFullYear(),
            date.getMonth(),
            date.getDate(),
            date.getHours(),
            date.getMinutes(),
            date.getSeconds(),
            date.getMilliseconds(),
        ),
    );
}

/**
 * Convert from UTC to local
 */
export function fromUTC(date: Date): Date {
    return new Date(date.getTime() - date.getTimezoneOffset() * 60000);
}

/**
 * Get timezone offset in hours for Colombia (UTC-5)
 */
export const COLOMBIA_TIMEZONE_OFFSET = -5;

/**
 * Convert date to Colombia timezone
 */
export function toColombiaTime(date: Date): Date {
    const utc = date.getTime() + date.getTimezoneOffset() * 60000;
    return new Date(utc + COLOMBIA_TIMEZONE_OFFSET * 60 * 60 * 1000);
}
