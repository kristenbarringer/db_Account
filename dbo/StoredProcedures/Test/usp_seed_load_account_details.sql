CREATE /* OR ALTER */ PROCEDURE [dbo].[usp_seed_load_account_details] 
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_asset may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    -- Flush-fill: clear existing data first

    DELETE FROM dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
 

    INSERT INTO dbo.account_details
    (
        [account_uuid],
       -- [account_rid],
        [organization],
        [tenant_id],
        [tenant_uuid],
        [company_address],
        [additional_address],
        [zip_code],
        [phone_number],
        [fax_number],
        [email],
        [created],
        [active],
        [company_website],
        [support_contact_number],
        [city],
        [state],
        [phone_type_code],
        [phone_extension],
        [country],
        [admin_user_rid],
        [account_type_rid],
        [account_type_code],
        [migrated_data]
    )
    SELECT
      NEWID() as account_uuid,
     -- xxxx as account_rid,
      c.name as organization,
        c.tenant_uuid      AS tenant_id,
        c.tenant_uuid      AS tenant_id,
      address_1 as company_address,
      address_2 as additional_address,
      '60803' as zip_code,
      '555-1212' as phone_number,
      NULL as fax_number,
      'zzz_john_smith@example' + left(lower(c.name), 20) + '.com' as email,
      cast(getdate() as date) as created,
      1 as active,
      NULL as company_website,
      NULL as support_contact_number,
      'Milwaukee' as city,
      'WI' as state,
      'PHT_MOBILE' as phone_type_code,
      NULL as phone_extension,
      'USA' as country,
      NULL as admin_user_rid,
      NULL as account_type_rid,
      'ACT_CUSTOMER' as account_type_code,
      NULL as migrated_data
    FROM dbo.zzz_seed_test_data_customer c
    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_account_details: inserted ', @rows, ' row(s) into dbo.account_details.');
END;
GO
