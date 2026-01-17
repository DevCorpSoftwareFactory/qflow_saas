import { plainToInstance } from 'class-transformer';
import { IsEnum, IsNumber, IsOptional, IsString, IsUrl, Max, Min, validateSync } from 'class-validator';

export enum Environment {
    Development = 'development',
    Production = 'production',
    Test = 'test',
}

export class EnvironmentVariables {
    @IsEnum(Environment)
    NODE_ENV: Environment = Environment.Development;

    @IsNumber()
    @Min(1)
    @Max(65535)
    PORT: number = 3000;

    // Database
    @IsString()
    DATABASE_HOST: string = 'localhost';

    @IsNumber()
    @Min(1)
    @Max(65535)
    DATABASE_PORT: number = 5432;

    @IsString()
    DATABASE_NAME: string = 'qflow_dev';

    @IsString()
    DATABASE_USER: string = 'postgres';

    @IsString()
    DATABASE_PASSWORD: string = 'postgres';

    @IsOptional()
    @IsUrl({ require_tld: false })
    DATABASE_URL?: string;

    // JWT
    @IsString()
    JWT_SECRET: string = 'dev-secret-change-in-production';

    @IsString()
    @IsOptional()
    JWT_EXPIRES_IN?: string = '1d';

    // CORS
    @IsString()
    @IsOptional()
    CORS_ORIGINS?: string = 'http://localhost:3000,http://localhost:3001';

    // Supabase (optional)
    @IsString()
    @IsOptional()
    SUPABASE_URL?: string;

    @IsString()
    @IsOptional()
    SUPABASE_ANON_KEY?: string;

    @IsString()
    @IsOptional()
    SUPABASE_SERVICE_ROLE_KEY?: string;
}

export function validate(config: Record<string, unknown>): EnvironmentVariables {
    const validatedConfig = plainToInstance(EnvironmentVariables, config, {
        enableImplicitConversion: true,
    });

    const errors = validateSync(validatedConfig, {
        skipMissingProperties: false,
    });

    if (errors.length > 0) {
        const errorMessages = errors.map((err) => {
            const constraints = err.constraints ? Object.values(err.constraints).join(', ') : 'Unknown error';
            return `${err.property}: ${constraints}`;
        });
        throw new Error(`Environment validation failed:\n${errorMessages.join('\n')}`);
    }

    return validatedConfig;
}
