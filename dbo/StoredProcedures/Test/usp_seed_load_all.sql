-- =============================================================================
-- Stored Procedure: usp_seed_load_all
-- Purpose:  Orchestrate loading all seed test data into Account tables, in
--           dependency order (parents first).
-- Scope:    Dev environments ONLY.
-- =============================================================================
CREATE PROCEDURE dbo.usp_seed_load_all
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers (defense in depth; each child also checks)
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_all may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;
    -- alter table account_details drop constraint fk_account_details_admin_user_rid
    -- alter table account_details drop constraint fk_account_details_created_by_user_uuid
    PRINT '=== Starting seed data reset ===';
    exec dbo.usp_seed_reset_all

    PRINT '=== Starting seed data load ===';
    
    EXEC dbo.usp_seed_load_account_details;
    EXEC dbo.usp_seed_load_tenantinfo;
    EXEC dbo.usp_seed_load_role;
    EXEC dbo.usp_seed_load_user_accounts;
    EXEC dbo.usp_seed_load_dealer;
    EXEC dbo.usp_seed_load_contact;
    EXEC dbo.usp_seed_load_user_grid_pref;
    EXEC dbo.usp_seed_load_role_perm;
 
    --select distinct user_rid from user_accounts
    --sp_helpconstraint 'account_details'  -- FK_account_details_user_accounts
    PRINT '=== Seed data load complete ===';
END;
GO
