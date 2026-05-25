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

 

 -- alter table role alter column [created_by_user_uuid] UNIQUEIDENTIFIER NULL 
   insert into role (role_uuid,  tenant_uuid, name, description, role_type_code, is_active, is_standard_role, created_date, updated_date,
    notes, test_data_group, created, active)
   values (NEWID(),'3E2070B4-5B0E-499B-BFC0-2001D796581A', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'391AFAAD-4A35-4ACE-8770-3F9D5C2D005D', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'51EE8B72-0B78-450A-ABEA-61022393CD99', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'0655A47A-D24B-43AB-A691-B4FFBB0D9677', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'30B4F849-7138-4817-8F3B-DAB8AE5C9A54', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1)

  




    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_role: inserted ', @rows, ' row(s) into dbo.role.');
END;
GO