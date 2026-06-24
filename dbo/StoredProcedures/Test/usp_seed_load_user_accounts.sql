CREATE PROCEDURE [dbo].[usp_seed_load_user_accounts]
AS
BEGIN

    SET NOCOUNT ON;
   -- delete from dbo.contact
   -- delete from dbo.dealer
   -- delete from dbo.role_permission_mapping
   -- delete from dbo.user_grid_view_preference
    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_user_accounts may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    -- Flush-fill: clear existing data first
    --  alter table dbo.user_accounts add notes varchar(255) null
    --DELETE FROM dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    DELETE FROM dbo.user_accounts where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';

    --  alter table dbo.user_accounts drop constraint if exists fk_user_accounts_nboarding_status_code
    -- alter table dbo.user_accounts add is_onboarded bit null
    drop table if exists #test_data
    select *   
            , cast(null as varchar(50) ) as user_rid
            , cast(null as varchar(50) ) as user_name
            , cast(null as varchar(50) ) as first_name
            , cast(null as varchar(50) ) as last_name
            , cast(null as varchar(50) ) as account_type_code
            , cast(null as varchar(50) ) as tenant_id
            , cast(null as varchar(50) ) as role_code
            , cast(null as varchar(50) ) as active2
            , cast(null as varchar(50) ) as created2
            , cast(null as varchar(50) ) as email_address
            , cast(null as varchar(50) ) as object_id
            , cast(null as varchar(50) ) as phone_number2
            , cast(null as varchar(50) ) as title
            , cast(null as varchar(50) ) as phone_type
            , cast(null as varchar(50) ) as status
            , cast(null as varchar(50) ) as updated
            , cast(null as varchar(50) ) as activated
            , cast(null as varchar(50) ) as phone_extension
            , cast(null as varchar(50) ) as created_by
            , cast(null as varchar(50) ) as speed_type_code
            , cast(null as varchar(50) ) as language_code
            , cast(null as varchar(50) ) as temperature_type_code
            , cast(null as varchar(50) ) as fuel_type_code
            , cast(null as varchar(50) ) as timezone_code
            , cast(null as varchar(50) ) as theme_code
            , cast(null as varchar(50) ) as tour_status
            , cast(null as varchar(50) ) as onboarding_status
            , cast(null as varchar(50) ) as expires
            , cast(null as varchar(50) ) as migrated_data
            , cast(null as varchar(50) ) as landing_page
    into #test_data
    from dbo.test_seed_data_customer

    --insert into dbo.lookup_code_list (lookup_list_code, lookup_list_short_desc, lookup_list_long_desc, lookup_list_abbrev, former_table_db, former_table_schema, former_table_name)
    --values ('TOR_0','Tour Status','Tour Status','TOR','tk2_Accounts','dbo','NULL')
    --insert into dbo.lookup_code (lookup_list_code, code, code_without_prefix_all_caps, code_without_prefix_camel_case, 
    --short_desc, long_desc, notes, custom_col1_desc, custom_col1, custom_col2_desc, custom_col2, 
    --custom_col3_desc, custom_col3, custom_col4_desc, custom_col4, former_code, former_code_2, is_active)
    --VALUES 
    --('TOR_0','TOR_0','1','1','1','1','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','0','NULL','1')
    --,('TOR_0','TOR_1','1','1','1','1','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','1','NULL','1')
    --,('TOR_0','TOR_2','1','1','1','1','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','2','NULL','1')
    --,('TOR_0','TOR_3','1','1','1','1','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','3','NULL','1')

    -- select * from lookup_code_list where lookup_list_code like '%tour%' or lookup_list_abbrev like '%TOR%'

    -- select *    FROM dbo.test_seed_data_customer 
    update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'jhsmith'
        ,first_name = 'John'
        ,last_name = 'Smith'
        
        ,tenant_id = 'tenant_id'
        ,role_code = 'role_code'
        ,active2 = 'active2'
        ,created2 = 'created2'
        ,email_address = 'example@example.com'
        ,object_id = 'object_id'
        ,phone_number2 = 'phone_number2'
        ,title = 'President'
        ,phone_type = 'PHT_MOBILE'
        ,status = 'status'
        ,updated = 'updated'
        ,activated = 'activated'
        ,phone_extension = 'phone_extension'
        ,created_by = 'created_by'
        ,speed_type_code = 'speed_type_code'
        ,language_code = 'language_code'
        ,temperature_type_code = 'temperature_type_code'
        ,fuel_type_code = 'fuel_type_code'
        ,timezone_code = 'timezone_code'
        ,theme_code = 'theme_code'
        ,tour_status = 'TOR_0'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'
where name like '%Walmart%'
    update  #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'jasmith'
        ,first_name = 'Jane'
        ,last_name = 'Smith'
        
        ,tenant_id = 'tenant_id'
        ,role_code = 'role_code'
        ,active2 = 'active2'
        ,created2 = 'created2'
        ,email_address = 'example@example.com'
        ,object_id = 'object_id'
        ,phone_number2 = 'phone_number2'
        ,title = 'Vice President'
        ,phone_type = 'PHT_MOBILE'
        ,status = 'status'
        ,updated = 'updated'
        ,activated = 'activated'
        ,phone_extension = 'phone_extension'
        ,created_by = 'created_by'
        ,speed_type_code = 'speed_type_code'
        ,language_code = 'language_code'
        ,temperature_type_code = 'temperature_type_code'
        ,fuel_type_code = 'fuel_type_code'
        ,timezone_code = 'timezone_code'
        ,theme_code = 'theme_code'
        ,tour_status = 'TOR_0'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'  where name like '%Prime%'
    update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'bbunny'
        ,first_name = 'Bugs'
        ,last_name = 'Bunny'
        
        ,tenant_id = 'tenant_id'
        ,role_code = 'role_code'
        ,active2 = 'active2'
        ,created2 = 'created2'
        ,email_address = 'example@example.com'
        ,object_id = 'object_id'
        ,phone_number2 = 'phone_number2'
        ,title = 'CEO'
        ,phone_type = 'PHT_MOBILE'
        ,status = 'status'
        ,updated = 'updated'
        ,activated = 'activated'
        ,phone_extension = 'phone_extension'
        ,created_by = 'created_by'
        ,speed_type_code = 'speed_type_code'
        ,language_code = 'language_code'
        ,temperature_type_code = 'temperature_type_code'
        ,fuel_type_code = 'fuel_type_code'
        ,timezone_code = 'timezone_code'
        ,theme_code = 'theme_code'
        ,tour_status = 'TOR_0'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'   where name like '%Hunt%'
    update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'rrunner'
        ,first_name = 'Road'
        ,last_name = 'Runner'
        
        ,tenant_id = 'tenant_id'
        ,role_code = 'role_code'
        ,active2 = 'active2'
        ,created2 = 'created2'
        ,email_address = 'example@example.com'
        ,object_id = 'object_id'
        ,phone_number2 = 'phone_number2'
        ,title = 'CIO'
        ,phone_type = 'PHT_MOBILE'
        ,status = 'status'
        ,updated = 'updated'
        ,activated = 'activated'
        ,phone_extension = 'phone_extension'
        ,created_by = 'created_by'
        ,speed_type_code = 'speed_type_code'
        ,language_code = 'language_code'
        ,temperature_type_code = 'temperature_type_code'
        ,fuel_type_code = 'fuel_type_code'
        ,timezone_code = 'timezone_code'
        ,theme_code = 'theme_code'
        ,tour_status = 'TOR_0'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'   where name like '%Premier%'
    update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'wcoyote'
        ,first_name = 'Wiley'
        ,last_name = 'Coyote'
        
        ,tenant_id = 'tenant_id'
        ,role_code = 'role_code'
        ,active2 = 'active2'
        ,created2 = 'created2'
        ,email_address = 'example@example.com'
        ,object_id = 'object_id'
        ,phone_number2 = 'phone_number2'
        ,title = 'CFO'
        ,phone_type = 'PHT_MOBILE'
        ,status = 'status'
        ,updated = 'updated'
        ,activated = 'activated'
        ,phone_extension = 'phone_extension'
        ,created_by = 'created_by'
        ,speed_type_code = 'speed_type_code'
        ,language_code = 'language_code'
        ,temperature_type_code = 'temperature_type_code'
        ,fuel_type_code = 'fuel_type_code'
        ,timezone_code = 'timezone_code'
        ,theme_code = 'theme_code'
        ,tour_status = 'TOR_0'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'   where name like '%Martin%'

    --select * from lookup_code where lookup_list_code like '%account_type%'
    -- select * from lookup_code where lookup_list_code like '%user_status%'
    -- select * from lookup_code where lookup_list_code like '%phone_type%'
    --select top 100 * from dbo.user_accounts where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV' order by tenant_uuid asc
    -- [usp_seed_load_user_accounts]
    --select * from dbo.user_accounts
    declare @role_rid int
    select @role_rid = max(role_rid)
    from dbo.role

    --alter table dbo.user_accounts drop column object_id
    --select * from information_schema.columns where TABLE_NAME = 'user_accounts' and TABLE_SCHEMA = 'dbo' order by ORDINAL_POSITION
    INSERT INTO dbo.user_accounts
        (
         user_uuid
        ,user_name
        ,first_name
        ,last_name
        ,account_type_rid
        ,tenant_uuid
        ,role_rid
        ,active
        ,created
        ,email_address
        --,object_id
        ,phone_number
        ,title
        ,phone_type_code
        ,status_code
        ,updated_date
        ,activated_date
        ,phone_extension
        ,created_by_user_rid
        ,speed_type_code
        ,language_code
        ,temperature_type_code
        ,fuel_type_code
        ,timezone_code
        ,theme_code
        ,tour_status_code
        ,is_onboarded
        ,expiration_date
        ,is_migrated_data
        ,landing_page
        ,notes
        )
    SELECT
       NEWID()
     ,user_name
    , first_name
    , last_name
    , 1 as account_type_rid

  
      , c.tenant_uuid      AS tenant_uuid
    , @role_rid as role_rid
    , active
    , '1/1/1900' as created
    , email_address
    --, object_id
    , phone_number
    , title
    , phone_type as phone_type_code
    , 'USR_ACTIVE' as status_code
    , '1/1/1900' as updated
    , '1/1/1900' as activated
    , 1 as phone_extension
    , NULL as created_by
    , 'SPT_MPH' as speed_type_code
    , 'LNG_EN' as language_code
    --         select * from lookup_code where lookup_list_code like '%user_status%'
    , 'TMP_FAHRENHEIT' as temperature_type_code
    , 'FLT_U_S_GALLONS' as fuel_type_code
    , 'TMZ_AMERICA_PHOENIX' as timezone_code
    , 'THM_DARK' as theme_code
    , tour_status as tour_status
    , 1 as is_onboarded
    , '1/1/1900' as expires
    , 0 as migrated_data
    , landing_page
    , 'TEST DATA PROCESS ON DEV'
    FROM #test_data c

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_user_accounts: inserted ', @rows, ' row(s) into dbo.user_accounts.');
END;
GO
-- select * from test_seed_data_customer