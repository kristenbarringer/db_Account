CREATE PROCEDURE [dbo].[usp_seed_load_role] 
AS
 
BEGIN

    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_role may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

   declare @tenantinfo uniqueidentifier 
  select @tenantinfo = max(tenant_uuid) from tenantinfo 
 -- alter table role alter column [created_by_user_uuid] UNIQUEIDENTIFIER NULL 
   insert into role (role_uuid,  tenant_uuid, name, description, role_type_code, is_active, is_standard_role, created_date, updated_date,
    notes, test_data_group, created, active)
   values (NEWID(),@tenantinfo, 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'Seed data - Admin role', 1, GETDATE(), 1)


    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_role: inserted ', @rows, ' row(s) into dbo.role.');
END;
GO