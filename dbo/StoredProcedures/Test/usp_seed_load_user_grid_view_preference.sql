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
    declare @tenant_uuid uniqueidentifier
    select @user_uuid = max(user_uuid) from dbo.user_accounts
    select @tenant_uuid = max(tenant_uuid) from dbo.tenantinfo --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV'
    declare @role_uuid uniqueidentifier
    select @role_uuid = max(role_uuid) from dbo.role
    declare @role_id int
    select @role_id = max(role_rid) from dbo.role --where coalesce(note

    insert into user_grid_view_preference (user_grid_view_preference_uuid, tenant_uuid, user_uuid, grid_name, columns_hidden, created_by_user_uuid, notes) 
        values (NEWID(), @tenant_uuid, @user_uuid, '','', @user_uuid, 'TEST DATA PROCESS ON DEV')



    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_user_grid_pref: inserted ', @rows, ' row(s) into dbo.user_grid_pref.');
END;
GO