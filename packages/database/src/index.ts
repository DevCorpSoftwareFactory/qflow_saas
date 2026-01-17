export { AppDataSource, setTenantContext, setUserContext } from './data-source';

// Database utilities
export {
    DatabaseException,
    DatabaseErrorType,
    withRetry,
    withTransaction,
    withRetryTransaction,
    checkConnection,
    reconnect,
    type RetryOptions,
    type TransactionOptions,
    type TransactionCallback,
} from './database.utils';

// Re-export entities when created
export * from './entities';
