import {
  Body,
  Controller,
  Get,
  Patch,
  UseGuards,
  Request,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { UsersService } from './users.service';
import {
  UpdateProfileDto,
  ChangePasswordDto,
  UserResponseDto,
} from '@qflow/shared';
import { AuthenticatedRequest } from '../common/types';
import { Logger } from 'nestjs-pino';

@ApiTags('Users')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('users')
export class UsersController {
  constructor(
    private readonly usersService: UsersService,
    private readonly logger: Logger,
  ) {}

  @Get('profile')
  @ApiOperation({ summary: 'Get current user profile' })
  async getProfile(
    @Request() req: AuthenticatedRequest,
  ): Promise<UserResponseDto> {
    const userId = req.user?.userId;
    this.logger.debug({
      msg: 'GET /users/profile',
      userId,
      reqId: req.headers['x-request-id'],
    });
    return this.usersService.getProfile(userId);
  }

  @Patch('profile')
  @ApiOperation({ summary: 'Update current user profile' })
  async updateProfile(
    @Request() req: AuthenticatedRequest,
    @Body() dto: UpdateProfileDto,
  ): Promise<UserResponseDto> {
    const userId = req.user?.userId;
    this.logger.debug({
      msg: 'PATCH /users/profile',
      userId,
      dto,
      reqId: req.headers['x-request-id'],
    });
    const response = await this.usersService.updateProfile(userId, dto);
    this.logger.debug({
      msg: 'PATCH /users/profile: SUCCESS',
      userId,
      reqId: req.headers['x-request-id'],
    });
    return response;
  }

  @Patch('change-password')
  @ApiOperation({ summary: 'Change current user password' })
  @HttpCode(HttpStatus.OK)
  async changePassword(
    @Request() req: AuthenticatedRequest,
    @Body() dto: ChangePasswordDto,
  ): Promise<{ success: boolean }> {
    const userId = req.user?.userId;
    this.logger.debug({
      msg: 'PATCH /users/change-password',
      userId,
      reqId: req.headers['x-request-id'],
    });
    const response = await this.usersService.changePassword(userId, dto);
    this.logger.debug({
      msg: 'PATCH /users/change-password: SUCCESS',
      userId,
      reqId: req.headers['x-request-id'],
    });
    return response;
  }
}
