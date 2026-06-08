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
    select @user_uuid = max(user_uuid)
    from dbo.user_accounts
    if @user_uuid is null set @user_uuid = NEWID()
    select @tenant_uuid = max(tenant_uuid)
    from dbo.account_details
    --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV'

    insert into contact
        (contact_uuid, tenant_uuid,first_name,last_name,created_by_user_uuid,created_by, language_code, notes)
    values
        (NEWID(), '3E2070B4-5B0E-499B-BFC0-2001D796581A', 'John', 'Smith', @user_uuid, @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV')
,
        (NEWID(), '391AFAAD-4A35-4ACE-8770-3F9D5C2D005D', 'John', 'Smith', @user_uuid, @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV')
,
        (NEWID(), '51EE8B72-0B78-450A-ABEA-61022393CD99', 'John', 'Smith', @user_uuid, @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV')
,
        (NEWID(), '0655A47A-D24B-43AB-A691-B4FFBB0D9677', 'John', 'Smith', @user_uuid, @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV')
,
        (NEWID(), '30B4F849-7138-4817-8F3B-DAB8AE5C9A54', 'John', 'Smith', @user_uuid, @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV')


    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_contact: inserted ', @rows, ' row(s) into dbo.contact.');
END;
GO
--select * from lookup_code where lookup_list_code = 'language'