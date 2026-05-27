CREATE PROCEDURE [dbo].[usp_seed_load_tenantinfo]
AS
BEGIN

    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_tenantinfo may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    --alter table asset drop constraint if exists fk_as%set_tenant_uuid
    --delete tenantinfo
    --update tenantinfo set tenant_id = tenant_uuid
    insert into  tenantinfo
        (
        tenant_uuid, organization
        ,company_name
        ,minimum_user
        ,customer_rid
        ,user_rid
        ,user_name
        ,v2_user_rid
        ,Pipeline_Id, notes)
    select
        tenant_uuid
, name
, name
, 105334
, rid
, 105334
, NULL
, 105334
, 105334, 'TEST DATA PROCESS ON DEV'
    from dbo.test_seed_data_customer
    where tenant_uuid not in (select tenant_uuid
    from tenantinfo)



    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_tenantinfo: inserted ', @rows, ' row(s) into dbo.tenantinfo.');
END;
GO