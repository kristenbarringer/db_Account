CREATE PROCEDURE [dbo].[usp_seed_load_role_perm] 
AS
 
BEGIN

    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_role_perm may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
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

    insert into dbo.role_permission_mapping (role_permission_mapping_uuid, tenant_uuid, permission_code, role_rid, role_uuid, created_by_user_uuid, notes)
    select NEWID(), @tenant_uuid, '', @role_id, @role_uuid, @user_uuid, ''


    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_role_perm: inserted ', @rows, ' row(s) into dbo.role_perm.');
END;
GO