import 'reflect-metadata';
import { DataSource, DataSourceOptions } from 'typeorm';
import * as path from 'path';

/**
 * Database configuration for QFlow Pro.
 * Supports multi-tenant RLS via session variables.
 */
const isProduction = process.env.NODE_ENV === 'production';

const baseConfig: DataSourceOptions = {
    type: 'postgres',
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '5432', 10),
    username: process.env.DB_USERNAME || 'postgres',
    password: process.env.DB_PASSWORD || 'postgres',
    database: process.env.DB_NAME || 'qflow_pro',

    // Connection pool
    poolSize: parseInt(process.env.DB_POOL_SIZE || '20', 10),

    // SSL for production
    ssl: isProduction ? { rejectUnauthorized: false } : false,

    // Entities and migrations
    entities: [path.join(__dirname, './entities/**/*.{ts,js}')],
    migrations: [path.join(__dirname, './migrations/**/*.{ts,js}')],

    // Logging
    logging: process.env.DB_LOGGING === 'true' ? ['query', 'error'] : ['error'],

    // Schema sync - NEVER in production
    synchronize: false,

    // UUID extension for native UUID generation
    uuidExtension: 'uuid-ossp',

    // Connection options
    connectTimeoutMS: parseInt(process.env.DB_CONNECT_TIMEOUT || '10000', 10),

    // Extra connection parameters
    extra: {
        // Statement timeout (30 seconds default)
        statement_timeout: parseInt(process.env.DB_STATEMENT_TIMEOUT || '30000', 10),
        // Idle connection timeout
        idle_in_transaction_session_timeout: parseInt(process.env.DB_IDLE_TIMEOUT || '60000', 10),
    },
};

export const AppDataSource = new DataSource(baseConfig);

/**
 * Sets the tenant context for RLS.
 * Call this after acquiring a connection to set the tenant ID.
 * 
 * @param tenantId - UUID of the tenant
 */
export async function setTenantContext(tenantId: string): Promise<void> {
    await AppDataSource.query(
        `SELECT set_config('app.current_tenant_id', $1, false)`,
        [tenantId]
    );
}

/**
 * Sets the user context for audit logging.
 * 
 * @param userId - UUID of the current user
 * @param ipAddress - IP address of the request
 */
export async function setUserContext(
    userId: string,
    ipAddress?: string,
    userAgent?: string
): Promise<void> {
    await AppDataSource.query(
        `SELECT set_config('app.current_user_id', $1, false)`,
        [userId]
    );

    if (ipAddress) {
        await AppDataSource.query(
            `SELECT set_config('app.current_ip', $1, false)`,
            [ipAddress]
        );
    }

    if (userAgent) {
        await AppDataSource.query(
            `SELECT set_config('app.current_user_agent', $1, false)`,
            [userAgent]
        );
    }
}

export default AppDataSource;
