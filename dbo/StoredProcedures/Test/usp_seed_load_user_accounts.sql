CREATE /* OR ALTER */ PROCEDURE [dbo].[usp_seed_load_user_accounts] 
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
  --  alter table dbo.user_accounts add notes varchar(255) null
    DELETE FROM dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
    DELETE FROM dbo.user_accounts where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';

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
    from dbo.zzz_seed_test_data_customer
    
   -- select *    FROM dbo.zzz_seed_test_data_customer 
update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'jhsmith'
        ,first_name = 'John'
        ,last_name = 'Smith'
        ,account_type_code = 'account_type_code'
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
        ,tour_status = 'tour_status'
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
        ,account_type_code = 'account_type_code'
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
        ,tour_status = 'tour_status'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'  where name like '%Prime%'
update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'bbunny'
        ,first_name = 'Bugs'
        ,last_name = 'Bunny'
        ,account_type_code = 'account_type_code'
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
        ,tour_status = 'tour_status'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'   where name like '%Hunt%'
update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'rrunner'
        ,first_name = 'Road'
        ,last_name = 'Runner'
        ,account_type_code = 'account_type_code'
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
        ,tour_status = 'tour_status'
        ,onboarding_status = 'onboarding_status'
        ,expires = 'expires'
        ,migrated_data = 'migrated_data'
        ,landing_page = 'www.example.com'   where name like '%Premier%'
update #test_data 
    set user_rid = 'user_rid'
        ,user_name = 'wcoyote'
        ,first_name = 'Wiley'
        ,last_name = 'Coyote'
        ,account_type_code = 'account_type_code'
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
        ,tour_status = 'tour_status'
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
select @role_rid = max(role_rid) from dbo.role

--alter table dbo.user_accounts drop column object_id
 --select * from information_schema.columns where TABLE_NAME = 'user_accounts' and TABLE_SCHEMA = 'dbo' order by ORDINAL_POSITION
    INSERT INTO dbo.user_accounts
    (
        -- user_rid
        user_name
        ,first_name
        ,last_name
        ,account_type_code
        ,tenant_id
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
        ,updated
        ,activated
        ,phone_extension
        ,created_by
        ,speed_type_code
        ,language_code
        ,temperature_type_code
        ,fuel_type_code
        ,timezone_code
        ,theme_code
        ,tour_status
        ,onboarding_status
        ,expires
        ,migrated_data
        ,landing_page
        ,notes
    )
    SELECT
      --user_rid
      user_name
    , first_name
    , last_name
    , 'ACT_CUSTOMER' as account_type_code

       , c.tenant_uuid      AS tenant_id
      ,  c.tenant_uuid      AS tenant_uuid
    ,@role_rid as role_rid
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
    , 123 as created_by
    , 'SPT_MPH' as speed_type_code
    , 'LNG_EN' as language_code
    --         select * from lookup_code where lookup_list_code like '%user_status%'
    , 'TMP_FAHRENHEIT' as temperature_type_code
    , 'FLT_U_S_GALLONS' as fuel_type_code
    , 'TMZ_AMERICA_PHOENIX' as timezone_code
    , 'THM_DARK' as theme_code
    , 1 as tour_status
    ,  1 as onboarding_status
    , '1/1/1900' as expires
    , 0 as migrated_data
    , landing_page
    ,'TEST DATA PROCESS ON DEV'
    FROM #test_data c

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_user_accounts: inserted ', @rows, ' row(s) into dbo.user_accounts.');
END;
GO
-- select * from zzz_seed_test_data_customer