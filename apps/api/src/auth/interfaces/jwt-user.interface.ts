export interface JwtUser {
  userId: string;
  tenantId: string;
  email: string;
  roleId: string;
  branchIds: string[];
}
