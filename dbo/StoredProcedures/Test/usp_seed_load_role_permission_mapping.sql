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



    declare @role_rid1 bigint
    declare @role_rid2 bigint
    declare @role_rid3 bigint
    declare @role_rid4 bigint
    declare @role_rid5 bigint
     
select @role_rid1 = max(role_rid) from dbo.role where tenant_uuid = '3E2070B4-5B0E-499B-BFC0-2001D796581A'
select @role_rid2 = max(role_rid) from dbo.role where tenant_uuid = '391AFAAD-4A35-4ACE-8770-3F9D5C2D005D'
select @role_rid3 = max(role_rid) from dbo.role where tenant_uuid = '51EE8B72-0B78-450A-ABEA-61022393CD99'
select @role_rid4 = max(role_rid) from dbo.role where tenant_uuid = '0655A47A-D24B-43AB-A691-B4FFBB0D9677'
select @role_rid5 = max(role_rid) from dbo.role where tenant_uuid = '30B4F849-7138-4817-8F3B-DAB8AE5C9A54'

-- delete from dbo.role_permission_mapping

    insert into dbo.role_permission_mapping ( permission_code, role_rid,  created_by_user_rid, notes)
    values   (    'account.user.view',    @role_rid1,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.activate',   @role_rid1,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.track',      @role_rid1,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'report.report.standard', @role_rid1,  @user_uuid, 'TEST DATA PROCESS ON DEV')

           , (    'account.user.view',    @role_rid2,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.activate',   @role_rid2,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.track',      @role_rid2,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'report.report.standard', @role_rid2,  @user_uuid, 'TEST DATA PROCESS ON DEV')

           , (    'account.user.view',    @role_rid3,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.activate',   @role_rid3,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.track',      @role_rid3,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'report.report.standard', @role_rid3,  @user_uuid, 'TEST DATA PROCESS ON DEV')

           , (    'account.user.view',    @role_rid4,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.activate',   @role_rid4,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'asset.asset.track',      @role_rid4,  @user_uuid, 'TEST DATA PROCESS ON DEV')
           , (  'report.report.standard', @role_rid4,  @user_uuid, 'TEST DATA PROCESS ON DEV')
 

    
    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_role_perm: inserted ', @rows, ' row(s) into dbo.role_perm.');
END;
GO