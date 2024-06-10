import { Injectable, CanActivate, ExecutionContext, UnauthorizedException, Logger } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { ROLES_KEY } from './roles.decorator';
import { Role } from './user/schemas/user.schema';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class RolesGuard implements CanActivate {
    private readonly logger = new Logger(RolesGuard.name);

    constructor(private reflector: Reflector) {}

    canActivate(context: ExecutionContext): boolean {
        const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
            context.getHandler(),
            context.getClass(),
        ]);
        if (!requiredRoles) {
            return true;
        }

        const request = context.switchToHttp().getRequest();
        const authHeader = request.headers['authorization'];
        if (!authHeader) {
            throw new UnauthorizedException('Authorization header not found');
        }


        const token = authHeader.split(' ')[1];
        if (!token) {
            throw new UnauthorizedException('JWT token not found in authorization header');
        }

        let user: any;
        try {
            user = jwt.verify(token, 'herica');
        } catch (err) {
            this.logger.error('JWT token verification failed', err.message);
            throw new UnauthorizedException('JWT token verification failed');
        }


        if (!user || !user.role) {
            throw new UnauthorizedException('Authentication failed: User role not provided');
        }

        const hasRole = requiredRoles.includes(user.role);
        if (!hasRole) {
            throw new UnauthorizedException(`Authorization failed: User role '${user.role}' not authorized`);
        }

        return true;
    }
}
