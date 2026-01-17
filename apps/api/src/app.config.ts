import { registerAs } from '@nestjs/config';

export const appConfig = registerAs('app', () => ({
    name: process.env.APP_NAME || 'QFlow Pro API',
    version: process.env.APP_VERSION || '1.0.0',
    environment: process.env.NODE_ENV || 'development',
    port: parseInt(process.env.PORT || '3000', 10),
    globalPrefix: 'api',
    swagger: {
        enabled: process.env.SWAGGER_ENABLED !== 'false',
        title: 'QFlow Pro API',
        description: 'API de QFlow Pro - ERP SaaS Multi-Tenant para gestión de inventario, ventas y operaciones.',
        version: process.env.APP_VERSION || '1.0.0',
        path: 'docs',
    },
    cors: {
        enabled: true,
        origins: (process.env.CORS_ORIGINS || 'http://localhost:3000,http://localhost:3001').split(','),
    },
}));

export const databaseConfig = registerAs('database', () => ({
    host: process.env.DATABASE_HOST || 'localhost',
    port: parseInt(process.env.DATABASE_PORT || '5432', 10),
    name: process.env.DATABASE_NAME || 'qflow_dev',
    user: process.env.DATABASE_USER || 'postgres',
    password: process.env.DATABASE_PASSWORD || 'postgres',
    url: process.env.DATABASE_URL,
    synchronize: process.env.NODE_ENV === 'development',
    logging: process.env.NODE_ENV === 'development',
}));

export const authConfig = registerAs('auth', () => ({
    jwtSecret: process.env.JWT_SECRET || 'dev-secret-change-in-production',
    jwtExpiresIn: process.env.JWT_EXPIRES_IN || '1d',
    bcryptRounds: parseInt(process.env.BCRYPT_ROUNDS || '10', 10),
}));

export const supabaseConfig = registerAs('supabase', () => ({
    url: process.env.SUPABASE_URL,
    anonKey: process.env.SUPABASE_ANON_KEY,
    serviceRoleKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
}));
