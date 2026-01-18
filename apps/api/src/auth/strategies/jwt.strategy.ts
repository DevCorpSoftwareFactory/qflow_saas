import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { ConfigService } from '@nestjs/config';
import { AuthService, JwtPayload } from '../auth.service';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    private readonly authService: AuthService,
    configService: ConfigService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey:
        configService.get<string>('auth.jwtSecret') || 'default-secret',
    });
  }

  async validate(payload: JwtPayload) {
    const user = await this.authService.validateToken(payload);

    if (!user) {
      throw new UnauthorizedException('Token inválido o usuario inactivo');
    }

    return {
      userId: user.id,
      tenantId: user.tenantId,
      email: user.email,
      roleId: user.roleId,
      branchIds: user.branchIds,
    };
  }
}
