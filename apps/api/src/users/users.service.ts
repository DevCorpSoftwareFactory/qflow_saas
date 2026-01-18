import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '@qflow/database';
import * as bcrypt from 'bcrypt';
import {
  UpdateProfileDto,
  ChangePasswordDto,
  UserResponseDto,
} from '@qflow/shared';
import { Logger } from 'nestjs-pino';
import { AuditLogsService } from '../audit/audit-logs.service';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private readonly logger: Logger,
    private readonly auditLogsService: AuditLogsService,
  ) {}

  async getProfile(userId: string): Promise<UserResponseDto> {
    if (!userId || userId === 'undefined' || userId === 'null') {
      this.logger.error({ msg: 'getProfile: INVALID_USER_ID', userId });
      throw new BadRequestException('Invalid user ID');
    }

    this.logger.debug({ msg: 'getProfile: INPUT', userId });

    const user = await this.userRepository.findOne({
      where: { id: userId },
      relations: ['role'],
    });

    if (!user) {
      this.logger.warn({ msg: 'getProfile: USER_NOT_FOUND', userId });
      throw new NotFoundException('Usuario no encontrado');
    }

    const response = this.mapToResponse(user);
    this.logger.debug({ msg: 'getProfile: OUTPUT', userId, response });

    return response;
  }

  async updateProfile(
    userId: string,
    dto: UpdateProfileDto,
  ): Promise<UserResponseDto> {
    if (!userId || userId === 'undefined' || userId === 'null') {
      this.logger.error({ msg: 'updateProfile: INVALID_USER_ID', userId });
      throw new BadRequestException('Invalid user ID');
    }

    this.logger.debug({ msg: 'updateProfile: INPUT', userId, dto });

    const user = await this.userRepository.findOne({ where: { id: userId } });
    if (!user) {
      this.logger.warn({ msg: 'updateProfile: USER_NOT_FOUND', userId });
      throw new NotFoundException('Usuario no encontrado');
    }

    const oldValue = this.mapToPlainObject(user);

    if (dto.fullName !== undefined) user.fullName = dto.fullName;
    if (dto.phone !== undefined) user.phone = dto.phone;
    if (dto.avatarUrl !== undefined) user.avatarUrl = dto.avatarUrl;
    if (dto.language !== undefined) user.language = dto.language;
    if (dto.timezone !== undefined) user.timezone = dto.timezone;

    await this.userRepository.save(user);

    const newValue = this.mapToPlainObject(user);

    await this.auditLogsService.create({
      tenantId: user.tenantId,
      userId: userId,
      action: 'PROFILE_UPDATE',
      entityType: 'users',
      entityId: userId,
      oldValue,
      newValue,
    });

    const response = this.mapToResponse(user);
    this.logger.debug({ msg: 'updateProfile: OUTPUT', userId, response });

    return response;
  }

  async changePassword(
    userId: string,
    dto: ChangePasswordDto,
  ): Promise<{ success: boolean }> {
    if (!userId || userId === 'undefined' || userId === 'null') {
      this.logger.error({ msg: 'changePassword: INVALID_USER_ID', userId });
      throw new BadRequestException('Invalid user ID');
    }

    this.logger.debug({ msg: 'changePassword: INPUT', userId });

    const user = await this.userRepository.findOne({
      where: { id: userId },
      select: ['id', 'passwordHash', 'tenantId'],
    });

    if (!user) {
      this.logger.warn({ msg: 'changePassword: USER_NOT_FOUND', userId });
      throw new NotFoundException('Usuario no encontrado');
    }

    if (dto.newPassword !== dto.confirmPassword) {
      this.logger.warn({ msg: 'changePassword: PASSWORDS_MISMATCH', userId });
      throw new BadRequestException('Las contraseñas nuevas no coinciden');
    }

    const isMatch = await bcrypt.compare(
      dto.currentPassword,
      user.passwordHash,
    );
    if (!isMatch) {
      this.logger.warn({
        msg: 'changePassword: INVALID_CURRENT_PASSWORD',
        userId,
      });
      throw new BadRequestException('La contraseña actual es incorrecta');
    }

    const saltRounds = 12;
    const newHash = await bcrypt.hash(dto.newPassword, saltRounds);

    await this.userRepository.update(userId, {
      passwordHash: newHash,
      sessionToken: null as any,
    });

    await this.auditLogsService.create({
      tenantId: user.tenantId,
      userId,
      action: 'PASSWORD_CHANGE',
      entityType: 'users',
      entityId: userId,
      oldValue: { passwordChanged: false },
      newValue: { passwordChanged: true },
    });

    this.logger.debug({ msg: 'changePassword: OUTPUT', userId, success: true });

    return { success: true };
  }

  private mapToPlainObject(user: User): Record<string, any> {
    return {
      id: user.id,
      tenantId: user.tenantId,
      email: user.email,
      fullName: user.fullName,
      phone: user.phone,
      roleId: user.roleId,
      branchIds: user.branchIds,
      isActive: user.isActive,
      isBlocked: user.isBlocked,
      twoFactorEnabled: user.twoFactorEnabled,
      lastLoginAt: user.lastLoginAt?.toISOString() || null,
      avatarUrl: user.avatarUrl,
      language: user.language,
      timezone: user.timezone,
    };
  }

  private mapToResponse(user: User): UserResponseDto {
    return {
      id: user.id,
      tenantId: user.tenantId,
      email: user.email,
      fullName: user.fullName,
      phone: user.phone,
      roleId: user.roleId,
      branchIds: user.branchIds,
      isActive: user.isActive,
      isBlocked: user.isBlocked,
      twoFactorEnabled: user.twoFactorEnabled,
      lastLoginAt: user.lastLoginAt
        ? user.lastLoginAt.toISOString()
        : undefined,
      avatarUrl: user.avatarUrl,
      language: user.language,
      timezone: user.timezone,
      createdAt: user.createdAt.toISOString(),
      updatedAt: user.updatedAt.toISOString(),
    };
  }
}
