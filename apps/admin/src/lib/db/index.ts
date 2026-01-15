/**
 * Database connection for QFlow Pro Admin (Backoffice SaaS)
 * 
 * Re-exports shared database configuration from @qflow/database package.
 * Uses TypeORM with PostgreSQL and RLS support for multi-tenancy.
 */

export {
    AppDataSource,
    setTenantContext,
    setUserContext
} from '@qflow/database';

import { AppDataSource } from '@qflow/database';

let initialized = false;

/**
 * Initialize the database connection.
 * Safe to call multiple times - only initializes once.
 */
export async function initializeDatabase(): Promise<void> {
    if (initialized) return;

    if (!AppDataSource.isInitialized) {
        await AppDataSource.initialize();
        console.log('✅ Database connection initialized');
    }

    initialized = true;
}

/**
 * Get a database connection.
 * Initializes the connection if not already done.
 */
export async function getDatabase() {
    await initializeDatabase();
    return AppDataSource;
}
