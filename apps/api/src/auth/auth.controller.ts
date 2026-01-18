import {
  Body,
  Controller,
  Post,
  HttpCode,
  HttpStatus,
  UseGuards,
  Req,
  Get,
  UnauthorizedException,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import {
  RegisterDto,
  LoginDto,
  MfaVerifyDto,
  LoginResponse,
  RefreshTokenDto,
  RefreshResponse,
  ForgotPasswordDto,
  ResetPasswordDto,
} from './dto/auth.dto';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { AuthenticatedRequest } from '../common/types';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

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
   * Get current user profile.
   * GET /auth/profile
   */
  @Get('profile')
  @UseGuards(JwtAuthGuard)
  async getProfile(@Req() req: AuthenticatedRequest) {
    const userId = req.user?.userId;
    if (!userId) {
      throw new UnauthorizedException();
    }
    return this.authService.getProfile(userId);
  }

  /**
   * Logout and invalidate session.
   * POST /auth/logout
   */
  @Post('logout')
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  async logout(
    @Req() req: AuthenticatedRequest,
  ): Promise<{ success: boolean }> {
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

  /**
   * Refresh access token.
   * POST /auth/refresh
   */
  @Post('refresh')
  @HttpCode(HttpStatus.OK)
  async refresh(@Body() dto: RefreshTokenDto): Promise<RefreshResponse> {
    return this.authService.refreshToken(dto);
  }

  /**
   * Request password reset.
   * POST /auth/forgot-password
   */
  @Post('forgot-password')
  @HttpCode(HttpStatus.OK)
  async forgotPassword(
    @Body() dto: ForgotPasswordDto,
  ): Promise<{ message: string }> {
    await this.authService.forgotPassword(dto);
    return { message: 'Si el correo existe, se enviarán las instrucciones.' };
  }

  /**
   * Reset password with token.
   * POST /auth/reset-password
   */
  @Post('reset-password')
  @HttpCode(HttpStatus.OK)
  async resetPassword(
    @Body() dto: ResetPasswordDto,
  ): Promise<{ success: boolean }> {
    await this.authService.resetPassword(dto);
    return { success: true };
  }
}
