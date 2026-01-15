import {
    IsEmail,
    IsString,
    MinLength,
    MaxLength,
    IsOptional,
    IsUUID,
    IsArray,
} from 'class-validator';

export class RegisterDto {
    @IsEmail()
    email: string;

    @IsString()
    @MinLength(8)
    @MaxLength(100)
    password: string;

    @IsString()
    @MaxLength(200)
    fullName: string;

    @IsOptional()
    @IsString()
    @MaxLength(20)
    phone?: string;

    @IsUUID()
    tenantId: string;

    @IsUUID()
    roleId: string;

    @IsOptional()
    @IsArray()
    @IsUUID('4', { each: true })
    branchIds?: string[];
}

export class LoginDto {
    @IsEmail()
    email: string;

    @IsString()
    password: string;

    @IsOptional()
    @IsString()
    mfaCode?: string;
}

export interface LoginResponse {
    accessToken: string;
    requiresMfa?: boolean;
    user: {
        id: string;
        email: string;
        fullName: string;
        tenantId: string;
    };
}

export class MfaSetupDto {
    @IsUUID()
    userId: string;
}

export interface MfaSetupResponse {
    secret: string;
    qrCodeUrl: string;
}

export class MfaVerifyDto {
    @IsUUID()
    userId: string;

    @IsString()
    @MinLength(6)
    @MaxLength(6)
    code: string;
}

export class LogoutDto {
    @IsUUID()
    userId: string;
}
