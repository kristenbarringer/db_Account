CREATE PROCEDURE [dbo].[usp_seed_load_contact] 
AS
 
BEGIN

    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_contact may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    declare @user_uuid uniqueidentifier
    declare @tenant_uuid uniqueidentifier
    select @user_uuid = max(user_uuid) from dbo.user_accounts
    select @tenant_uuid = max(tenant_uuid) from dbo.tenantinfo --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV'

    insert into contact
    (
        
        tenant_uuid,
        first_name,
        last_name,       
        created_by_user_uuid,       
        created_by, language_code
    )
    values 
    (
        @tenant_uuid,
        'John',
        'Smith',       
        @user_uuid,       
        @user_uuid, 'LNG_ENUS'
        )

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_contact: inserted ', @rows, ' row(s) into dbo.contact.');
END;
GO
--select * from lookup_code where lookup_list_code = 'language'