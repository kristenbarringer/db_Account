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
    declare @role_id int
    select @role_id = max(role_rid) from dbo.role
    declare @role_uuid uniqueidentifier
    select @role_uuid = max(role_uuid) from dbo.role where role_rid = @role_id

    insert into dbo.role_permission_mapping (role_permission_mapping_uuid, tenant_uuid, permission_code, role_rid, role_uuid, created_by_user_uuid, notes)
    values ( NEWID(), '3E2070B4-5B0E-499B-BFC0-2001D796581A', '', @role_id, @role_uuid, @user_uuid, 'TEST DATA PROCESS ON DEV')
    , ( NEWID(), '391AFAAD-4A35-4ACE-8770-3F9D5C2D005D', '', @role_id, @role_uuid, @user_uuid, 'TEST DATA PROCESS ON DEV')
    , ( NEWID(), '51EE8B72-0B78-450A-ABEA-61022393CD99', '', @role_id, @role_uuid, @user_uuid, 'TEST DATA PROCESS ON DEV')
    , ( NEWID(), '0655A47A-D24B-43AB-A691-B4FFBB0D9677', '', @role_id, @role_uuid, @user_uuid, 'TEST DATA PROCESS ON DEV')
    , ( NEWID(), '30B4F849-7138-4817-8F3B-DAB8AE5C9A54', '', @role_id, @role_uuid, @user_uuid, 'TEST DATA PROCESS ON DEV')

    
    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_role_perm: inserted ', @rows, ' row(s) into dbo.role_perm.');
END;
GO