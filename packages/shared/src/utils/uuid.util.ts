/**
 * UUID Utilities
 * Pure functions for UUID generation and validation.
 */

/**
 * Generate a UUID v4
 * Uses crypto.randomUUID() if available, otherwise fallback implementation
 */
export function generateUUID(): string {
    // Use native crypto.randomUUID if available (Node 14.17+, modern browsers)
    if (typeof crypto !== 'undefined' && crypto.randomUUID) {
        return crypto.randomUUID();
    }

    // Fallback implementation
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
        const r = (Math.random() * 16) | 0;
        const v = c === 'x' ? r : (r & 0x3) | 0x8;
        return v.toString(16);
    });
}

/**
 * UUID v4 regex pattern
 */
const UUID_V4_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

/**
 * Any UUID regex pattern (v1-v5)
 */
const UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

/**
 * Validate if a string is a valid UUID v4
 */
export function isValidUUID(value: string): boolean {
    if (!value || typeof value !== 'string') {
        return false;
    }
    return UUID_V4_REGEX.test(value);
}

/**
 * Validate if a string is a valid UUID (any version)
 */
export function isUUID(value: string): boolean {
    if (!value || typeof value !== 'string') {
        return false;
    }
    return UUID_REGEX.test(value);
}

/**
 * Parse UUID components
 */
export interface UUIDComponents {
    timeLow: string;
    timeMid: string;
    timeHiAndVersion: string;
    clockSeq: string;
    node: string;
    version: number;
}

/**
 * Parse a UUID string into its components
 */
export function parseUUID(uuid: string): UUIDComponents | null {
    if (!isUUID(uuid)) {
        return null;
    }

    const parts = uuid.toLowerCase().split('-');
    const version = parseInt(parts[2].charAt(0), 16);

    return {
        timeLow: parts[0],
        timeMid: parts[1],
        timeHiAndVersion: parts[2],
        clockSeq: parts[3],
        node: parts[4],
        version,
    };
}

/**
 * Generate a short ID from UUID (first 8 chars)
 */
export function shortUUID(uuid: string): string {
    return uuid.split('-')[0];
}

/**
 * Normalize UUID (lowercase, trimmed)
 */
export function normalizeUUID(uuid: string): string {
    return uuid.trim().toLowerCase();
}

/**
 * Compare two UUIDs for equality (case-insensitive)
 */
export function uuidEquals(a: string, b: string): boolean {
    if (!a || !b) return false;
    return normalizeUUID(a) === normalizeUUID(b);
}
