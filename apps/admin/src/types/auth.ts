export interface User {
    id: string;
    email: string;
    firstName?: string;
    lastName?: string;
    role: string;
    tenantId: string;
}

export interface AuthResponse {
    user: User;
    accessToken: string;
    refreshToken: string;
}
