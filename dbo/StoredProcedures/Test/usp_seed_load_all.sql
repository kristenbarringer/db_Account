-- =============================================================================
-- Stored Procedure: usp_seed_load_all
-- Purpose:  Orchestrate loading all seed test data into Account tables, in
--           dependency order (parents first).
-- Scope:    Dev environments ONLY.
-- =============================================================================
CREATE /* OR ALTER */ PROCEDURE dbo.usp_seed_load_all
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers (defense in depth; each child also checks)
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_all may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    PRINT '=== Starting seed data load ===';

    EXEC dbo.usp_seed_load_account_details;

    PRINT '=== Seed data load complete ===';
END;
GO
