import {
  Injectable,
  CanActivate,
  ExecutionContext,
  ForbiddenException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Role } from '@qflow/database';
import { Request } from 'express';

export const PERMISSIONS_KEY = 'permissions';

export interface AuthenticatedUser {
  userId: string;
  tenantId: string;
  email: string;
  roleId: string;
  branchIds: string[];
}

// Extend Express Request to include user
interface RequestWithUser extends Request {
  user?: AuthenticatedUser;
}

// Permission format: "module.action" e.g., "inventory.write"
type PermissionString = string;

@Injectable()
export class PermissionsGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    @InjectRepository(Role)
    private readonly roleRepository: Repository<Role>,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const requiredPermissions = this.reflector.getAllAndOverride<
      PermissionString[]
    >(PERMISSIONS_KEY, [context.getHandler(), context.getClass()]);

    // If no permissions required, allow access
    if (!requiredPermissions || requiredPermissions.length === 0) {
      return true;
    }

    const request: RequestWithUser = context
      .switchToHttp()
      .getRequest<RequestWithUser>();
    const user = request.user;

    if (!user) {
      throw new ForbiddenException('Usuario no autenticado');
    }

    // Get user's role with permissions
    const role = await this.roleRepository.findOne({
      where: { id: user.roleId },
    });

    if (!role) {
      throw new ForbiddenException('Rol no encontrado');
    }

    // Check if role has required permissions
    // Permissions are stored as { module: { action: boolean } }
    const hasPermission = requiredPermissions.every((permissionStr) => {
      const [module, action] = permissionStr.split('.');
      const modulePerms = role.permissions[module];
      return modulePerms && modulePerms[action] === true;
    });

    if (!hasPermission) {
      throw new ForbiddenException('Permisos insuficientes');
    }

    return true;
  }
}

/**
 * Check if user has a specific permission.
 * @param permissions - Role permissions object { module: { action: bool } }
 * @param requiredPermission - Format: "module.action" e.g., "inventory.write"
 */
export function checkPermission(
  permissions: Record<string, Record<string, boolean>>,
  requiredPermission: string,
): boolean {
  const [module, action] = requiredPermission.split('.');
  const modulePerms = permissions[module];
  return modulePerms && modulePerms[action] === true;
}
