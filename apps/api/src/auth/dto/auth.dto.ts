import {
  IsEmail,
  IsString,
  MinLength,
  MaxLength,
  IsOptional,
  IsUUID,
  IsArray,
  IsNotEmpty,
} from 'class-validator';

export class RegisterDto {
  @IsEmail()
  @IsNotEmpty()
  @MaxLength(100)
  email: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(8)
  @MaxLength(100)
  password: string;

  @IsString()
  @IsNotEmpty()
  @MaxLength(200)
  fullName: string;

  @IsOptional()
  @IsString()
  @MaxLength(20)
  phone?: string;

  @IsUUID()
  @IsNotEmpty()
  tenantId: string;

  @IsUUID()
  @IsNotEmpty()
  roleId: string;

  @IsOptional()
  @IsArray()
  @IsUUID('4', { each: true })
  branchIds?: string[];
}

export class LoginDto {
  @IsEmail()
  @IsNotEmpty()
  @MaxLength(100)
  email: string;

  @IsString()
  @IsNotEmpty()
  password: string;

  @IsOptional()
  @IsString()
  mfaCode?: string;
}

export interface LoginResponse {
  accessToken: string;
  refreshToken?: string;
  requiresMfa?: boolean;
  user: {
    id: string;
    email: string;
    fullName: string;
    tenantId: string;
    roleId?: string;
  };
}

export class MfaSetupDto {
  @IsUUID()
  @IsNotEmpty()
  userId: string;
}

export interface MfaSetupResponse {
  secret: string;
  qrCodeUrl: string;
}

export class MfaVerifyDto {
  @IsUUID()
  @IsNotEmpty()
  userId: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  @MaxLength(6)
  code: string;
}

export class LogoutDto {
  @IsUUID()
  @IsNotEmpty()
  userId: string;
}

export class RefreshTokenDto {
  @IsString()
  @IsNotEmpty()
  refreshToken: string;
}

export class ForgotPasswordDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;
}

export class ResetPasswordDto {
  @IsString()
  @IsNotEmpty()
  token: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(8)
  @MaxLength(100)
  newPassword: string;
}

export interface RefreshResponse {
  accessToken: string;
  refreshToken: string; // Rotating refresh token
}
