-- =============================================================================
-- Stored Procedure: usp_seed_reset_all
-- Purpose:  Wipe all seed test data from Account tables, in reverse dependency
--           order (children first, parents last).
-- Scope:    Dev environments ONLY.
-- Notes:    Each individual loader already does its own DELETE, so this proc
--           is for "wipe without re-load" scenarios.
-- =============================================================================
CREATE PROCEDURE dbo.usp_seed_reset_all
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_reset_all may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    PRINT '=== Starting seed data reset ===';

    -- Reverse FK order: children first, then parents
    DELETE FROM dbo.role_permission_mapping where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.role_permission_mapping (', @@ROWCOUNT, ' row(s)).');
    DELETE FROM dbo.user_grid_view_preference where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.user_grid_view_preference (', @@ROWCOUNT, ' row(s)).');
    DELETE FROM dbo.contact where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.contact (', @@ROWCOUNT, ' row(s)).');
    DELETE FROM dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.account_details (', @@ROWCOUNT, ' row(s)).');
    DELETE FROM dbo.dealer where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.dealer (', @@ROWCOUNT, ' row(s)).');
    DELETE FROM dbo.user_accounts where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.user_accounts (', @@ROWCOUNT, ' row(s)).');
    DELETE FROM dbo.role where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.role (', @@ROWCOUNT, ' row(s)).');
    DELETE FROM dbo.tenantinfo where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    PRINT CONCAT('  Cleared dbo.tenantinfo (', @@ROWCOUNT, ' row(s)).'); 

    PRINT '=== Seed data reset complete ===';
END;
GO
