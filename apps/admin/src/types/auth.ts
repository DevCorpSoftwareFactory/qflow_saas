import { UserResponseDto } from '@qflow/shared';

export type User = UserResponseDto;

export interface Role {
    id: string;
    name: string;
    description?: string;
    permissions: Record<string, Record<string, boolean>>;
    isSystemRole: boolean;
    isActive: boolean;
}

export interface AuthResponse {
    accessToken: string;
    refreshToken?: string;
    requiresMfa?: boolean;
    user: UserResponseDto;
}

export interface AuthErrorResponse {
    message: string;
    error: string;
    statusCode: number;
}
