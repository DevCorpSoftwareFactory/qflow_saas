import {
    BadRequestException,
    ConflictException,
    Injectable,
    NotFoundException,
    UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User, Role } from '@qflow/database';
import * as bcrypt from 'bcrypt';
import { authenticator } from 'otplib';
import * as QRCode from 'qrcode';
import {
    RegisterDto,
    LoginDto,
    LoginResponse,
    MfaSetupResponse,
} from './dto/auth.dto';

export interface JwtPayload {
    sub: string; // user id
    tenantId: string;
    email?: string;
    roleId?: string;
    branchIds?: string[];
    iat?: number;
    exp?: number;
}

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(User)
        private readonly userRepository: Repository<User>,
        @InjectRepository(Role)
        private readonly roleRepository: Repository<Role>,
        private readonly jwtService: JwtService,
    ) { }

    async register(dto: RegisterDto): Promise<{ id: string; email: string }> {
        const existingUser = await this.userRepository.findOne({
            where: { email: dto.email, tenantId: dto.tenantId },
        });

        if (existingUser) {
            throw new ConflictException('El email ya está registrado');
        }

        // Validate that roleId exists
        const role = await this.roleRepository.findOne({
            where: { id: dto.roleId },
        });
        if (!role) {
            throw new BadRequestException(`El rol con ID ${dto.roleId} no existe`);
        }

        const saltRounds = 12;
        const passwordHash = await bcrypt.hash(dto.password, saltRounds);

        const user = this.userRepository.create({
            email: dto.email,
            passwordHash,
            fullName: dto.fullName,
            phone: dto.phone,
            tenantId: dto.tenantId,
            roleId: dto.roleId,
            branchIds: dto.branchIds || [],
            isActive: true,
            isBlocked: false,
            failedLoginAttempts: 0,
            twoFactorEnabled: false,
        });

        await this.userRepository.save(user);

        return { id: user.id, email: user.email };
    }

    async validateUser(email: string, password: string): Promise<User | null> {
        const user = await this.userRepository.findOne({
            where: { email, isActive: true, isBlocked: false },
            select: [
                'id',
                'email',
                'passwordHash',
                'fullName',
                'tenantId',
                'roleId',
                'branchIds',
                'failedLoginAttempts',
                'twoFactorEnabled',
                'twoFactorSecret',
            ],
        });

        if (!user) {
            return null;
        }

        const isPasswordValid = await bcrypt.compare(password, user.passwordHash);
        if (!isPasswordValid) {
            // Increment failed login attempts
            await this.userRepository.increment(
                { id: user.id },
                'failedLoginAttempts',
                1,
            );
            return null;
        }

        // Reset failed attempts on successful login
        await this.userRepository.update(user.id, {
            failedLoginAttempts: 0,
            lastLoginAt: new Date(),
        });

        return user;
    }

    async login(dto: LoginDto): Promise<LoginResponse> {
        const user = await this.validateUser(dto.email, dto.password);

        if (!user) {
            throw new UnauthorizedException('Credenciales inválidas');
        }

        if (user.twoFactorEnabled) {
            if (!dto.mfaCode) {
                return {
                    accessToken: '',
                    requiresMfa: true,
                    user: {
                        id: user.id,
                        email: user.email,
                        fullName: user.fullName,
                        tenantId: user.tenantId,
                    },
                };
            }

            const isValidMfa = authenticator.verify({
                token: dto.mfaCode,
                secret: user.twoFactorSecret || '',
            });

            if (!isValidMfa) {
                throw new UnauthorizedException('Código MFA inválido');
            }
        }

        const payload: JwtPayload = {
            sub: user.id,
            tenantId: user.tenantId,
        };

        const accessToken = this.jwtService.sign(payload);

        await this.userRepository.update(user.id, {
            sessionToken: accessToken,
            sessionExpiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
        });

        return {
            accessToken,
            requiresMfa: false,
            user: {
                id: user.id,
                email: user.email,
                fullName: user.fullName,
                tenantId: user.tenantId,
            },
        };
    }

    async logout(userId: string): Promise<{ success: boolean }> {
        await this.userRepository.update(userId, {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any, @typescript-eslint/no-unsafe-assignment
            sessionToken: null as any,
            // eslint-disable-next-line @typescript-eslint/no-explicit-any, @typescript-eslint/no-unsafe-assignment
            sessionExpiresAt: null as any,
        });
        return { success: true };
    }

    async setupMfa(userId: string): Promise<MfaSetupResponse> {
        const user = await this.userRepository.findOne({
            where: { id: userId },
        });

        if (!user) {
            throw new NotFoundException('Usuario no encontrado');
        }

        const secret = authenticator.generateSecret();
        const otpauthUrl = authenticator.keyuri(user.email, 'QFlow Pro', secret);
        const qrCodeUrl = await QRCode.toDataURL(otpauthUrl);

        await this.userRepository.update(userId, {
            twoFactorSecret: secret,
        });

        return { secret, qrCodeUrl };
    }

    async verifyMfa(userId: string, code: string): Promise<{ success: boolean }> {
        const user = await this.userRepository.findOne({
            where: { id: userId },
            select: ['id', 'twoFactorSecret'],
        });

        if (!user || !user.twoFactorSecret) {
            throw new NotFoundException('MFA no configurado');
        }

        const isValid = authenticator.verify({
            token: code,
            secret: user.twoFactorSecret,
        });

        if (!isValid) {
            throw new UnauthorizedException('Código MFA inválido');
        }

        await this.userRepository.update(userId, {
            twoFactorEnabled: true,
        });

        return { success: true };
    }

    async validateToken(payload: JwtPayload): Promise<User | null> {
        return this.userRepository.findOne({
            where: { id: payload.sub, isActive: true, isBlocked: false },
        });
    }
}
