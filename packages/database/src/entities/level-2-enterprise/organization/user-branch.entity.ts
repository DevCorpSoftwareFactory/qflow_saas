import {
    Entity,
    PrimaryColumn,
    Column,
    ManyToOne,
    JoinColumn,
    CreateDateColumn,
} from 'typeorm';
import { User } from './user.entity';
import { Branch } from '../organization/branch.entity';

/**
 * User-Branch assignment table (Many-to-Many relationship).
 * Allows assigning users to multiple branches with specific permissions.
 */
@Entity({ name: 'user_branches' })
export class UserBranch {
    @PrimaryColumn({ type: 'uuid', name: 'user_id' })
    userId: string;

    @PrimaryColumn({ type: 'uuid', name: 'branch_id' })
    branchId: string;

    @Column({ type: 'uuid', name: 'tenant_id' })
    tenantId: string;

    @Column({ type: 'boolean', name: 'is_default', default: false })
    isDefault: boolean;

    @Column({ type: 'boolean', name: 'can_sell', default: true })
    canSell: boolean;

    @Column({ type: 'boolean', name: 'can_manage_inventory', default: false })
    canManageInventory: boolean;

    @Column({ type: 'boolean', name: 'can_view_reports', default: false })
    canViewReports: boolean;

    @CreateDateColumn({ name: 'assigned_at', type: 'timestamptz' })
    assignedAt: Date;

    // Relations
    @ManyToOne(() => User, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'user_id' })
    user: User;

    @ManyToOne(() => Branch, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'branch_id' })
    branch: Branch;
}
