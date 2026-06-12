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

 -- alter table role alter column [created_by_user_rid] UNIQUEIDENTIFIER NULL 
   insert into role (role_uuid,  tenant_uuid, name, description, role_type_code, is_active, is_standard_role, created_date, updated_date,
    notes, test_data_group, created, active)
   values (NEWID(),'3e2070b4-5b0e-499b-bfc0-2001d796581a', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'391afaad-4a35-4ace-8770-3f9d5c2d005d', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'51ee8b72-0b78-450a-abea-61022393cd99', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'0655a47a-d24b-43ab-a691-b4ffbb0d9677', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1),
  (NEWID(),'30b4f849-7138-4817-8f3b-dab8ae5c9a54', 'Admin', 'Admin role with all permissions', 'ROL_ADMIN', 1, 1, GETDATE(), GETDATE(), 
  'TEST DATA PROCESS ON DEV', 1, GETDATE(), 1)

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_role: inserted ', @rows, ' row(s) into dbo.role.');
END;
GO