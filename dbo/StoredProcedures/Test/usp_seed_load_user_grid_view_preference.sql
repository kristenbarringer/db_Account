CREATE PROCEDURE [dbo].[usp_seed_load_user_grid_pref]
AS
BEGIN

    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_user_grid_pref may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    declare @user_uuid BIGINT
    select @user_uuid = max(user_rid)
    from dbo.user_accounts
    declare @role_uuid BIGINT
    select @role_uuid = max(role_rid)
    from dbo.role
    declare @role_id int
    select @role_id = max(role_rid)
    from dbo.role
    --where coalesce(note

    insert into user_grid_view_preference
        (user_grid_view_preference_uuid, tenant_uuid, user_rid, grid_name, columns_hidden, created_by_user_rid, notes)
    values
        (NEWID(), '3e2070b4-5b0e-499b-bfc0-2001d796581a', @user_uuid, '', '', @user_uuid, 'TEST DATA PROCESS ON DEV')        ,
        (NEWID(), '391afaad-4a35-4ace-8770-3f9d5c2d005d', @user_uuid, '', '', @user_uuid, 'TEST DATA PROCESS ON DEV')        ,
        (NEWID(), '51ee8b72-0b78-450a-abea-61022393cd99', @user_uuid, '', '', @user_uuid, 'TEST DATA PROCESS ON DEV')        ,
        (NEWID(), '0655a47a-d24b-43ab-a691-b4ffbb0d9677', @user_uuid, '', '', @user_uuid, 'TEST DATA PROCESS ON DEV')        ,
        (NEWID(), '30b4f849-7138-4817-8f3b-dab8ae5c9a54', @user_uuid, '', '', @user_uuid, 'TEST DATA PROCESS ON DEV')

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_user_grid_pref: inserted ', @rows, ' row(s) into dbo.user_grid_pref.');
END;
GO