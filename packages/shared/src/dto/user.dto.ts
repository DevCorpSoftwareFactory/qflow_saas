/**
 * User DTOs
 * Data transfer objects for user and authentication operations.
 */

/**
 * Login request DTO
 */
export interface LoginDto {
    email: string;
    password: string;
    tenantSlug?: string;
    rememberMe?: boolean;
}

/**
 * Login response DTO
 */
export interface LoginResponseDto {
    accessToken: string;
    refreshToken: string;
    expiresIn: number;
    tokenType: 'Bearer';
    user: UserResponseDto;
}

/**
 * Refresh token request DTO
 */
export interface RefreshTokenDto {
    refreshToken: string;
}

/**
 * Create user request DTO
 */
export interface CreateUserDto {
    email: string;
    password: string;
    fullName: string;
    phone?: string;
    roleId: string;
    branchIds?: string[];
    pinSecurity?: string;
}

/**
 * Update user request DTO
 */
export interface UpdateUserDto {
    email?: string;
    fullName?: string;
    phone?: string;
    roleId?: string;
    branchIds?: string[];
    pinSecurity?: string;
    isActive?: boolean;
    avatarUrl?: string;
}

/**
 * User response DTO
 */
export interface UserResponseDto {
    id: string;
    tenantId: string;
    email: string;
    fullName: string;
    phone?: string;
    roleId: string;
    roleName?: string;
    branchIds: string[];
    isActive: boolean;
    isBlocked: boolean;
    twoFactorEnabled: boolean;
    lastLoginAt?: string;
    avatarUrl?: string;
    createdAt: string;
    updatedAt: string;
}

/**
 * Change password request DTO
 */
export interface ChangePasswordDto {
    currentPassword: string;
    newPassword: string;
    confirmPassword: string;
}

/**
 * Reset password request DTO
 */
export interface ResetPasswordRequestDto {
    email: string;
    tenantSlug?: string;
}

/**
 * Reset password confirm DTO
 */
export interface ResetPasswordConfirmDto {
    token: string;
    newPassword: string;
    confirmPassword: string;
}

/**
 * Enable 2FA request DTO
 */
export interface Enable2FADto {
    password: string;
}

/**
 * Enable 2FA response DTO
 */
export interface Enable2FAResponseDto {
    secret: string;
    qrCodeUrl: string;
}

/**
 * Verify 2FA request DTO
 */
export interface Verify2FADto {
    code: string;
}

/**
 * User profile update DTO
 */
export interface UpdateProfileDto {
    fullName?: string;
    phone?: string;
    avatarUrl?: string;
    language?: string;
    timezone?: string;
}
