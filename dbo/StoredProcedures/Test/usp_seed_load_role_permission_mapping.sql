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
       declare @user_uuid BIGINT
    declare @tenant_uuid uniqueidentifier
    select @user_uuid = max(user_rid) from dbo.user_accounts
    select @tenant_uuid = max(tenant_uuid) from dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV'
    declare @role_id bigint
    select @role_id = max(role_rid) from dbo.role
 

    insert into dbo.role_permission_mapping ( permission_code, role_rid,  created_by_user_rid, notes)
    values (    '', @role_id,  @user_uuid, 'TEST DATA PROCESS ON DEV')
    , (  '', @role_id,  @user_uuid, 'TEST DATA PROCESS ON DEV')
    , (  '', @role_id,  @user_uuid, 'TEST DATA PROCESS ON DEV')
    , (  '', @role_id,  @user_uuid, 'TEST DATA PROCESS ON DEV')
    , (  '', @role_id,  @user_uuid, 'TEST DATA PROCESS ON DEV')

    
    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_role_perm: inserted ', @rows, ' row(s) into dbo.role_perm.');
END;
GO