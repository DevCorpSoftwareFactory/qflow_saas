import { Request } from 'express';

export interface AuthenticatedUserPayload {
  userId: string;
  tenantId: string;
  email?: string;
  roleId?: string;
  branchIds?: string[];
  iat?: number;
  exp?: number;
}

export interface AuthenticatedRequest extends Request {
  user: AuthenticatedUserPayload;
}
