import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Logger } from 'nestjs-pino';
import { AuditLog } from '@qflow/database';

export interface AuditLogEntry {
  tenantId?: string;
  userId?: string;
  action: string;
  entityType: string;
  entityId?: string;
  oldValue?: Record<string, any>;
  newValue?: Record<string, any>;
  ipAddress?: string;
  userAgent?: string;
  metadata?: Record<string, any>;
}

@Injectable()
export class AuditLogsService {
  constructor(
    @InjectRepository(AuditLog)
    private readonly auditLogRepository: Repository<AuditLog>,
    private readonly logger: Logger,
  ) {}

  async create(entry: AuditLogEntry): Promise<AuditLog> {
    try {
      const auditLog = this.auditLogRepository.create({
        tenantId: entry.tenantId,
        userId: entry.userId,
        action: entry.action,
        entityType: entry.entityType,
        entityId: entry.entityId,
        oldValue: entry.oldValue,
        newValue: entry.newValue,
        ipAddress: entry.ipAddress,
        userAgent: entry.userAgent,
        deviceInfo: entry.metadata,
      });

      const saved = await this.auditLogRepository.save(auditLog);

      this.logger.debug({
        msg: 'Audit log created',
        auditId: saved.id,
        tenantId: entry.tenantId,
        userId: entry.userId,
        action: entry.action,
        entityType: entry.entityType,
        entityId: entry.entityId,
      });

      return saved;
    } catch (error) {
      this.logger.error({
        msg: 'Failed to create audit log',
        error: error instanceof Error ? error.message : 'Unknown error',
        entry,
      });
      throw error;
    }
  }

  async getByEntity(
    tenantId: string,
    entityType: string,
    entityId: string,
    limit = 100,
  ): Promise<AuditLog[]> {
    return this.auditLogRepository.find({
      where: {
        tenantId,
        entityType,
        entityId,
      },
      order: { createdAt: 'DESC' },
      take: limit,
    });
  }

  async getByUser(
    tenantId: string,
    userId: string,
    limit = 100,
  ): Promise<AuditLog[]> {
    return this.auditLogRepository.find({
      where: {
        tenantId,
        userId,
      },
      order: { createdAt: 'DESC' },
      take: limit,
    });
  }

  async getByAction(
    tenantId: string,
    action: string,
    limit = 100,
  ): Promise<AuditLog[]> {
    return this.auditLogRepository.find({
      where: {
        tenantId,
        action,
      },
      order: { createdAt: 'DESC' },
      take: limit,
    });
  }
}
