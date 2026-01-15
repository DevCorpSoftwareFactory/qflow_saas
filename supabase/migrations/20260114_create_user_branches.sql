-- Migration: Create user_branches table
-- Purpose: Many-to-many relationship between users and branches

CREATE TABLE IF NOT EXISTS user_branches (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    branch_id UUID NOT NULL REFERENCES branches(id) ON DELETE CASCADE,
    tenant_id UUID NOT NULL REFERENCES tenants(id),
    is_default BOOLEAN DEFAULT false,
    can_sell BOOLEAN DEFAULT true,
    can_manage_inventory BOOLEAN DEFAULT false,
    can_view_reports BOOLEAN DEFAULT false,
    assigned_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (user_id, branch_id)
);

-- Enable RLS
ALTER TABLE user_branches ENABLE ROW LEVEL SECURITY;

-- RLS Policy: Tenant isolation
CREATE POLICY tenant_isolation ON user_branches
    FOR ALL
    USING (tenant_id = current_setting('app.current_tenant_id')::uuid);

-- Indexes for performance
CREATE INDEX idx_user_branches_user_id ON user_branches(user_id);
CREATE INDEX idx_user_branches_branch_id ON user_branches(branch_id);
CREATE INDEX idx_user_branches_tenant_id ON user_branches(tenant_id);

-- Comments
COMMENT ON TABLE user_branches IS 'User-Branch assignments with granular permissions per branch';
COMMENT ON COLUMN user_branches.is_default IS 'Default branch for user login';
COMMENT ON COLUMN user_branches.can_sell IS 'Permission to create sales in this branch';
COMMENT ON COLUMN user_branches.can_manage_inventory IS 'Permission to manage inventory in this branch';
COMMENT ON COLUMN user_branches.can_view_reports IS 'Permission to view reports for this branch';
