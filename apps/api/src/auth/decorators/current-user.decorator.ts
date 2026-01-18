import { createParamDecorator, ExecutionContext } from '@nestjs/common';

/**
 * Parameter decorator to extract current user from request.
 * The user is attached to request by Passport's JWT strategy.
 */
export const CurrentUser = createParamDecorator(
  (data: string | undefined, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();
    const user = request.user;

    // If a specific property is requested, return only that
    if (data && user) {
      return user[data];
    }

    return user;
  },
);
