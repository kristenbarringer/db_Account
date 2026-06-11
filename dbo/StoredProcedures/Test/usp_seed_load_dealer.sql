CREATE PROCEDURE [dbo].[usp_seed_load_dealer]
AS

BEGIN

    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_dealer may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;
    declare @user_rid BIGINT

    select @user_rid = max(user_rid)
    from dbo.user_accounts
    --if @user_rid is null set @user_rid = NEWID()
    -- TODO create dealer table and uncomment this section

    -- alter table dealer alter column [created_by_user_rid] UNIQUEIDENTIFIER NULL 
    insert into dealer
        (dealer_uuid, dealer_code,tenant_uuid,name,address,phone_number,email_address,zip_code,oracle_id,party_site_id_code 
        ,atlas_terr_id_code,atlas_terr_name,atlas_terr_id
        ,is_blue_track_dealer
        ,notes,created_by_user_rid, updated_by_user_rid, updated_date)
    values
        (NEWID(), 'C0960001', '3E2070B4-5B0E-499B-BFC0-2001D796581A', 'Mid Missouri Thermo King', '11085 OO Hwy, Boonville, MO 65233', '660-882-6030', 'dianah@midmissouritk.com', '65233', 123456, '19568426'
   , 'T0697', 'Fleetsource TK', 456789
, 0, 'TEST DATA PROCESS ON DEV', @user_rid, @user_rid, getdate())

,
        (NEWID(), 'C2645004', '391AFAAD-4A35-4ACE-8770-3F9D5C2D005D', 'Thermo King Mid Canada - Saskatoon', 'Saskatoon Freeway, Martensville, Saskatchewan S0K 0A2, Canada', '306-933-0572',
            'swowryk@tkwinnipeg.com', 'S0K 2T0', 123456, '36278676'
, 'C2645', 'Thermo King of Mid Canada', 456789
, 1, 'TEST DATA PROCESS ON DEV', @user_rid, @user_rid, getdate())

,
        (NEWID(), 'C0966', '51EE8B72-0B78-450A-ABEA-61022393CD99', 'Central States Thermo King of St. Louis, LLC', '420 Carrie Ave', '555-444-3333', 'beiese@cstk.com', '63147', 123456, '27138254'
, 'T2820', 'Thermo King Midwest', 456789
, 1, 'TEST DATA PROCESS ON DEV', @user_rid, @user_rid, getdate())

,
        (NEWID(), 'K1003', '0655A47A-D24B-43AB-A691-B4FFBB0D9677', 'Thermo King of Dallas - Commerce City', '5170 E58th Place', '111-222-3333', 'dvalentine@convoyservicing.com', '80022', 123456, '46625466'
, 'ABC123', 'Test Terr Name', 456789
, 0, 'TEST DATA PROCESS ON DEV', @user_rid, @user_rid, getdate())

,
        (NEWID(), 'ABC123', '30B4F849-7138-4817-8F3B-DAB8AE5C9A54', 'Test Dealer', '123 Main St, Anytown, MN 55555', '555-555-1212', 'test@example.com', '01234', 123, 1523
, 'DEF456', 'Test Terr Name', 456789
, 0, 'TEST DATA PROCESS ON DEV', @user_rid, @user_rid, getdate())

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_dealer: inserted ', @rows, ' row(s) into dbo.dealer.');
END;
GO