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

    declare @user_uuid BIGINT
    declare @tenant_uuid uniqueidentifier
    select @user_uuid = max(user_rid)
    from dbo.user_accounts
    --if @user_uuid is null set @user_uuid = NEWID()
    select @tenant_uuid = max(tenant_uuid)
    from dbo.account_details
    --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV'

    insert into contact
        (contact_uuid, tenant_uuid,first_name,last_name,created_by_user_rid, language_code, notes)
    values
        (NEWID(), '3e2070b4-5b0e-499b-bfc0-2001d796581a', 'John', 'Smith', @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV'),                                                                                    
        (NEWID(), '391afaad-4a35-4ace-8770-3f9d5c2d005d', 'John', 'Smith', @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV'),                                                                                    
        (NEWID(), '51ee8b72-0b78-450a-abea-61022393cd99', 'John', 'Smith', @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV'),                                                                                    
        (NEWID(), '0655a47a-d24b-43ab-a691-b4ffbb0d9677', 'John', 'Smith', @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV'),                                                                                    
        (NEWID(), '30b4f849-7138-4817-8f3b-dab8ae5c9a54', 'John', 'Smith', @user_uuid, 'LNG_ENUS', 'TEST DATA PROCESS ON DEV')


    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_contact: inserted ', @rows, ' row(s) into dbo.contact.');
END;
GO
--select * from lookup_code where lookup_list_code = 'language'