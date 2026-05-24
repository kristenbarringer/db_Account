CREATE /* OR ALTER */ PROCEDURE [dbo].[usp_seed_load_account_details] 
AS
BEGIN
print 'TODO FIX THIS'
/* TODO FIX THIS
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_asset may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    -- Flush-fill: clear existing data first

    DELETE FROM dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
 drop table if exists #test_data
 select *   
            , cast(null as varchar(50) ) as additional_address2
            , cast(null as varchar(50) ) as phone_number2
            , cast(null as varchar(50) ) as fax_number2
            , cast(null as varchar(50) ) as company_website2 
            , cast(null as varchar(50) ) as support_contact_number2
            , cast(null as varchar(50) ) as phone_extension2
            , cast(null as varchar(50) ) as account_type_code2
    
    into #test_data 
    from dbo.zzz_seed_test_data_customer
    
   -- select *    FROM dbo.zzz_seed_test_data_customer 
update #test_data set additional_address2 = 'PO Box 123' ,phone_number2 = '555-555-1212',fax_number2 = '555-555-1212',company_website2 = 'www.example.com',support_contact_number2 = '555-555-1212',phone_extension2 = '123',account_type_code2 = 'ACT_CUSTOMER'  where name like '%Walmart%'
update #test_data set additional_address2 = 'PO Box 123' ,phone_number2 = '555-555-1212',fax_number2 = '555-555-1212',company_website2 = 'www.example.com',support_contact_number2 = '555-555-1212',phone_extension2 = '123',account_type_code2 = 'ACT_CUSTOMER'  where name like '%Prime%'
update #test_data set additional_address2 = 'PO Box 123' ,phone_number2 = '555-555-1212',fax_number2 = '555-555-1212',company_website2 = 'www.example.com',support_contact_number2 = '555-555-1212',phone_extension2 = '123',account_type_code2 = 'ACT_CUSTOMER'  where name like '%Hunt%'
update #test_data set additional_address2 = 'PO Box 123' ,phone_number2 = '555-555-1212',fax_number2 = '555-555-1212',company_website2 = 'www.example.com',support_contact_number2 = '555-555-1212',phone_extension2 = '123',account_type_code2 = 'ACT_CUSTOMER'  where name like '%Premier%'
update #test_data set additional_address2 = 'PO Box 123' ,phone_number2 = '555-555-1212',fax_number2 = '555-555-1212',company_website2 = 'www.example.com',support_contact_number2 = '555-555-1212',phone_extension2 = '123',account_type_code2 = 'ACT_CUSTOMER'  where name like '%Martin%'

declare @user_rid int
select @user_rid = max(user_rid) from dbo.user_accounts

 --select top 100 * from dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV' order by tenant_uuid asc
 -- [usp_seed_load_account_details]
 --select * from dbo.user_accounts
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
        [migrated_data],
        notes
    )
    SELECT
      NEWID() as account_uuid,
     -- xxxx as account_rid,
      c.name as organization,
        c.tenant_uuid      AS tenant_id,
        c.tenant_uuid      AS tenant_id,
      address_1 as company_address,
      additional_address2 as additional_address,
      '60803' as zip_code,
      phone_number2 as phone_number,
      fax_number2 as fax_number,
      'zzz_john_smith@example' + left(lower(c.name), 20) + '.com' as email,
      cast(getdate() as date) as created,
      1 as active,
      company_website2 as company_website,
      support_contact_number2 as support_contact_number,
      'Milwaukee' as city,
      'WI' as state,
      'PHT_MOBILE' as phone_type_code,
      phone_extension2 as phone_extension,
      'USA' as country,
      @user_rid as admin_user_rid, 
      1 as account_type_rid,
      account_type_code2 as account_type_code,
      0 as migrated_data,
      'TEST DATA PROCESS ON DEV' 
       
     
    FROM #test_data c
    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_account_details: inserted ', @rows, ' row(s) into dbo.account_details.');
*/END;
GO
