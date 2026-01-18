import {
  Injectable,
  Logger,
  BadRequestException,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource, EntityManager } from 'typeorm';
import { CashSession, CashMovement, User, CashRegister } from '@qflow/database';
import { OpenSessionDto, CloseSessionDto } from '@qflow/shared';
import { JwtUser } from '../auth/interfaces/jwt-user.interface';

@Injectable()
export class CashSessionService {
  private readonly logger = new Logger(CashSessionService.name);

  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(CashSession)
    private readonly sessionRepository: Repository<CashSession>,
    @InjectRepository(CashMovement)
    private readonly movementRepository: Repository<CashMovement>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    @InjectRepository(CashRegister)
    private readonly registerRepository: Repository<CashRegister>,
  ) {}

  /**
   * Open a new cash session.
   * Ensures no open session exists for the register/user.
   */
  async openSession(user: JwtUser, dto: OpenSessionDto): Promise<CashSession> {
    const { cashRegisterId, openingAmount, openingNotes, branchId } = dto;
    const tenantId = user.tenantId;

    this.logger.log(
      `Opening session for user ${user.userId} on register ${cashRegisterId}`,
    );

    // 1. Validation: Verify register exists and belongs to tenant
    const register = await this.registerRepository.findOne({
      where: { id: cashRegisterId, tenantId },
    });
    if (!register) {
      throw new NotFoundException('Cash register not found');
    }

    // 2. Validation: Ensure no active session for this register
    const activeSession = await this.sessionRepository.findOne({
      where: {
        cashRegisterId,
        status: 'open',
      },
    });

    if (activeSession) {
      throw new ConflictException(
        `Register already has an open session (ID: ${activeSession.id})`,
      );
    }

    // 3. Create Session (Transactional)
    return this.dataSource.transaction(async (manager) => {
      // Create session record - aligned with init.sql schema
      const session = manager.create(CashSession, {
        tenantId,
        cashRegisterId,
        userId: user.userId,
        status: 'open',
        openingDate: new Date(),
        initialAmount: openingAmount || 0,
        systemAmount: openingAmount || 0, // Start with initial amount
      });
      await manager.save(session);

      // Create initial movement (Fund start)
      // movement_type in DB: 'income', 'expense', 'withdrawal', 'transfer_in', 'transfer_out'
      const movement = manager.create(CashMovement, {
        tenantId,
        branchId: branchId || register.branchId,
        cashSessionId: session.id,
        movementType: 'income', // initial fund is income
        category: 'initial_fund',
        amount: openingAmount || 0,
        concept: openingNotes || 'Apertura de caja',
        createdBy: user.userId,
      });
      await manager.save(movement);

      this.logger.log(`Session ${session.id} opened successfully`);
      return session;
    });
  }

  /**
   * Close a cash session (Blind balancing).
   * RF-007: system_amount vs declared_amount
   */
  async closeSession(
    user: JwtUser,
    sessionId: string,
    dto: CloseSessionDto,
  ): Promise<CashSession> {
    const { declaredAmount, differenceJustification } = dto;
    const tenantId = user.tenantId;

    const session = await this.sessionRepository.findOne({
      where: { id: sessionId, tenantId },
    });

    if (!session) {
      throw new NotFoundException('Cash session not found');
    }

    if (session.status !== 'open') {
      throw new BadRequestException('Session is already closed');
    }

    return this.dataSource.transaction(async (manager) => {
      // Update session with closing data - aligned with init.sql
      session.declaredAmount = declaredAmount;
      session.status = 'closed';
      session.closingDate = new Date();

      // difference is a GENERATED column, so we don't set it
      // but we can store the justification
      if (differenceJustification) {
        session.differenceJustification = differenceJustification;
      }

      await manager.save(session);

      this.logger.log(
        `Session ${session.id} closed. Declared: ${declaredAmount}, System: ${session.systemAmount}`,
      );
      return session;
    });
  }

  /**
   * Get active session for user
   */
  async getActiveSession(user: JwtUser): Promise<CashSession | null> {
    return this.sessionRepository.findOne({
      where: {
        userId: user.userId,
        status: 'open',
      },
      relations: ['cashRegister'],
    });
  }

  /**
   * Helper to update session's system_amount balance
   * Called when cash movements are created (e.g., from sales)
   */
  async updateSessionBalance(
    manager: EntityManager,
    sessionId: string,
    amount: number,
    type: 'IN' | 'OUT',
  ): Promise<void> {
    const delta = type === 'IN' ? amount : -amount;
    await manager.increment(
      CashSession,
      { id: sessionId },
      'systemAmount',
      delta,
    );
  }
}
