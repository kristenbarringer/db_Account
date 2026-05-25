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
    
       declare @user_uuid uniqueidentifier 
    select @user_uuid = max(user_uuid) from dbo.user_accounts 
    declare @role_uuid uniqueidentifier
    select @role_uuid = max(role_uuid) from dbo.role
    declare @role_id int
    select @role_id = max(role_rid) from dbo.role --where coalesce(note

    insert into user_grid_view_preference (user_grid_view_preference_uuid, tenant_uuid, user_uuid, grid_name, columns_hidden, created_by_user_uuid, notes) 
        values (NEWID(), '3E2070B4-5B0E-499B-BFC0-2001D796581A', @user_uuid, '','', @user_uuid, 'TEST DATA PROCESS ON DEV')
        ,(NEWID(), '391AFAAD-4A35-4ACE-8770-3F9D5C2D005D', @user_uuid, '','', @user_uuid, 'TEST DATA PROCESS ON DEV')
        ,(NEWID(), '51EE8B72-0B78-450A-ABEA-61022393CD99', @user_uuid, '','', @user_uuid, 'TEST DATA PROCESS ON DEV')
        ,(NEWID(), '0655A47A-D24B-43AB-A691-B4FFBB0D9677', @user_uuid, '','', @user_uuid, 'TEST DATA PROCESS ON DEV')
        ,(NEWID(), '30B4F849-7138-4817-8F3B-DAB8AE5C9A54', @user_uuid, '','', @user_uuid, 'TEST DATA PROCESS ON DEV')
        






    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_user_grid_pref: inserted ', @rows, ' row(s) into dbo.user_grid_pref.');
END;
GO