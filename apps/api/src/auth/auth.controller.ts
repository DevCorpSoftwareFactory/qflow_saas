import {
    Body,
    Controller,
    Post,
    HttpCode,
    HttpStatus,
    UseGuards,
    Req,
} from '@nestjs/common';
import { Request } from 'express';
import { AuthService } from './auth.service';
import {
    RegisterDto,
    LoginDto,
    MfaVerifyDto,
    LoginResponse,
} from './dto/auth.dto';
import { JwtAuthGuard } from './guards/jwt-auth.guard';

interface AuthenticatedRequest extends Request {
    user?: { userId: string; tenantId: string };
}

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) { }

    /**
     * Register a new user.
     * POST /auth/register
     */
    @Post('register')
    @HttpCode(HttpStatus.CREATED)
    async register(
        @Body() dto: RegisterDto,
    ): Promise<{ id: string; email: string }> {
        return this.authService.register(dto);
    }

    /**
     * Login with email/password. Returns JWT token.
     * If MFA is enabled, requires mfaCode in second request.
     * POST /auth/login
     */
    @Post('login')
    @HttpCode(HttpStatus.OK)
    async login(@Body() dto: LoginDto): Promise<LoginResponse> {
        return this.authService.login(dto);
    }

    /**
     * Logout and invalidate session.
     * POST /auth/logout
     */
    @Post('logout')
    @UseGuards(JwtAuthGuard)
    @HttpCode(HttpStatus.OK)
    async logout(@Req() req: AuthenticatedRequest): Promise<{ success: boolean }> {
        const userId = req.user?.userId;
        if (!userId) {
            return { success: false };
        }
        return this.authService.logout(userId);
    }

    /**
     * Setup MFA for authenticated user.
     * POST /auth/mfa/setup
     */
    @Post('mfa/setup')
    @UseGuards(JwtAuthGuard)
    @HttpCode(HttpStatus.OK)
    async setupMfa(
        @Req() req: AuthenticatedRequest,
    ): Promise<{ secret: string; qrCodeUrl: string }> {
        const userId = req.user?.userId;
        if (!userId) {
            throw new Error('User not authenticated');
        }
        return this.authService.setupMfa(userId);
    }

    /**
     * Verify MFA code and enable 2FA.
     * POST /auth/mfa/verify
     */
    @Post('mfa/verify')
    @UseGuards(JwtAuthGuard)
    @HttpCode(HttpStatus.OK)
    async verifyMfa(@Body() dto: MfaVerifyDto): Promise<{ success: boolean }> {
        return this.authService.verifyMfa(dto.userId, dto.code);
    }
}
