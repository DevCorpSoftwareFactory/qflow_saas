import { DataSource, QueryRunner, EntityManager } from 'typeorm';
import { AppDataSource, setTenantContext } from './data-source';

/**
 * Database error types for proper error handling
 */
export enum DatabaseErrorType {
    CONNECTION_TIMEOUT = 'CONNECTION_TIMEOUT',
    CONNECTION_REFUSED = 'CONNECTION_REFUSED',
    QUERY_ERROR = 'QUERY_ERROR',
    TRANSACTION_ERROR = 'TRANSACTION_ERROR',
    CONSTRAINT_VIOLATION = 'CONSTRAINT_VIOLATION',
    DEADLOCK = 'DEADLOCK',
    RLS_VIOLATION = 'RLS_VIOLATION',
    UNKNOWN = 'UNKNOWN',
}

/**
 * Custom database exception with typed errors
 */
export class DatabaseException extends Error {
    constructor(
        public readonly type: DatabaseErrorType,
        message: string,
        public readonly originalError?: Error,
        public readonly query?: string,
    ) {
        super(message);
        this.name = 'DatabaseException';
    }

    static fromError(error: unknown, query?: string): DatabaseException {
        if (error instanceof DatabaseException) {
            return error;
        }

        const err = error as Error & { code?: string; detail?: string };
        const message = err.message || 'Unknown database error';
        const code = err.code || '';

        // PostgreSQL error codes
        if (code === 'ECONNREFUSED' || message.includes('ECONNREFUSED')) {
            return new DatabaseException(DatabaseErrorType.CONNECTION_REFUSED, 'Database connection refused', err, query);
        }

        if (code === 'ETIMEDOUT' || message.includes('timeout')) {
            return new DatabaseException(DatabaseErrorType.CONNECTION_TIMEOUT, 'Database connection timeout', err, query);
        }

        if (code === '23505') {
            // unique_violation
            return new DatabaseException(
                DatabaseErrorType.CONSTRAINT_VIOLATION,
                `Unique constraint violation: ${err.detail || message}`,
                err,
                query,
            );
        }

        if (code === '23503') {
            // foreign_key_violation
            return new DatabaseException(
                DatabaseErrorType.CONSTRAINT_VIOLATION,
                `Foreign key constraint violation: ${err.detail || message}`,
                err,
                query,
            );
        }

        if (code === '40P01') {
            // deadlock_detected
            return new DatabaseException(DatabaseErrorType.DEADLOCK, 'Deadlock detected', err, query);
        }

        if (code === '42501' || message.includes('RLS')) {
            // insufficient_privilege (RLS)
            return new DatabaseException(DatabaseErrorType.RLS_VIOLATION, 'Row-level security violation', err, query);
        }

        if (code.startsWith('42') || code.startsWith('22')) {
            // Syntax or data errors
            return new DatabaseException(DatabaseErrorType.QUERY_ERROR, message, err, query);
        }

        return new DatabaseException(DatabaseErrorType.UNKNOWN, message, err, query);
    }
}

/**
 * Retry configuration options
 */
export interface RetryOptions {
    maxRetries?: number;
    initialDelayMs?: number;
    maxDelayMs?: number;
    backoffMultiplier?: number;
    retryableErrors?: DatabaseErrorType[];
}

const DEFAULT_RETRY_OPTIONS: Required<RetryOptions> = {
    maxRetries: 3,
    initialDelayMs: 1000,
    maxDelayMs: 30000,
    backoffMultiplier: 2,
    retryableErrors: [
        DatabaseErrorType.CONNECTION_TIMEOUT,
        DatabaseErrorType.CONNECTION_REFUSED,
        DatabaseErrorType.DEADLOCK,
    ],
};

/**
 * Sleep helper for retry delays
 */
function sleep(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
}

/**
 * Execute a database operation with retry logic
 */
export async function withRetry<T>(
    operation: () => Promise<T>,
    options: RetryOptions = {},
): Promise<T> {
    const opts = { ...DEFAULT_RETRY_OPTIONS, ...options };
    let lastError: DatabaseException | null = null;
    let delay = opts.initialDelayMs;

    for (let attempt = 1; attempt <= opts.maxRetries + 1; attempt++) {
        try {
            return await operation();
        } catch (error) {
            lastError = DatabaseException.fromError(error);

            // Check if this error type is retryable
            if (!opts.retryableErrors.includes(lastError.type)) {
                throw lastError;
            }

            // Don't retry on last attempt
            if (attempt > opts.maxRetries) {
                throw lastError;
            }

            console.warn(`Database operation failed (attempt ${attempt}/${opts.maxRetries + 1}): ${lastError.message}`);
            console.warn(`Retrying in ${delay}ms...`);

            await sleep(delay);
            delay = Math.min(delay * opts.backoffMultiplier, opts.maxDelayMs);
        }
    }

    throw lastError || new DatabaseException(DatabaseErrorType.UNKNOWN, 'Retry exhausted');
}

/**
 * Transaction callback type
 */
export type TransactionCallback<T> = (manager: EntityManager) => Promise<T>;

/**
 * Transaction options
 */
export interface TransactionOptions {
    tenantId?: string;
    isolationLevel?: 'READ UNCOMMITTED' | 'READ COMMITTED' | 'REPEATABLE READ' | 'SERIALIZABLE';
    timeout?: number;
}

/**
 * Execute a database operation within a transaction with proper error handling.
 * Automatically handles tenant context, rollback on error, and connection cleanup.
 */
export async function withTransaction<T>(
    callback: TransactionCallback<T>,
    options: TransactionOptions = {},
    dataSource: DataSource = AppDataSource,
): Promise<T> {
    const queryRunner: QueryRunner = dataSource.createQueryRunner();

    try {
        await queryRunner.connect();

        // Set transaction isolation level if specified
        if (options.isolationLevel) {
            await queryRunner.query(`SET TRANSACTION ISOLATION LEVEL ${options.isolationLevel}`);
        }

        // Set statement timeout if specified
        if (options.timeout) {
            await queryRunner.query(`SET statement_timeout = ${options.timeout}`);
        }

        await queryRunner.startTransaction();

        // Set tenant context within transaction
        if (options.tenantId) {
            await queryRunner.query(`SELECT set_config('app.current_tenant_id', $1, true)`, [options.tenantId]);
        }

        const result = await callback(queryRunner.manager);

        await queryRunner.commitTransaction();
        return result;
    } catch (error) {
        await queryRunner.rollbackTransaction();
        throw DatabaseException.fromError(error);
    } finally {
        await queryRunner.release();
    }
}

/**
 * Execute a database operation with retry and transaction support combined
 */
export async function withRetryTransaction<T>(
    callback: TransactionCallback<T>,
    transactionOptions: TransactionOptions = {},
    retryOptions: RetryOptions = {},
    dataSource: DataSource = AppDataSource,
): Promise<T> {
    return withRetry(() => withTransaction(callback, transactionOptions, dataSource), retryOptions);
}

/**
 * Connection health check with timeout
 */
export async function checkConnection(timeoutMs: number = 5000): Promise<boolean> {
    const timeoutPromise = new Promise<never>((_, reject) => {
        setTimeout(() => reject(new Error('Connection check timeout')), timeoutMs);
    });

    try {
        await Promise.race([AppDataSource.query('SELECT 1'), timeoutPromise]);
        return true;
    } catch {
        return false;
    }
}

/**
 * Reconnect to database with retry logic
 */
export async function reconnect(options: RetryOptions = {}): Promise<void> {
    const opts = { ...DEFAULT_RETRY_OPTIONS, ...options };

    await withRetry(async () => {
        if (AppDataSource.isInitialized) {
            await AppDataSource.destroy();
        }
        await AppDataSource.initialize();
    }, opts);
}
