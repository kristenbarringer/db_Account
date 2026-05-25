CREATE   procedure [dbo].[sp_role_creation]
    @tenant_id NVARCHAR(100)

AS
BEGIN

DECLARE @role_rid INT;
    INSERT INTO role (description, is_standard_role, active, role_type_code, tenant_uuid, name)
    VALUES ('ADMIN', 1, 1, 'ROL_ADMIN', @tenant_id, 'ADMIN');
	SET @role_rid = SCOPE_IDENTITY();
	EXEC sp_role_permission_mapping_admin @role_rid

	INSERT INTO role (description, is_standard_role, active, role_type_code, tenant_uuid, name)
    VALUES ('BASIC', 1, 1, 'ROL_BASIC', @tenant_id, 'BASIC');
	SET @role_rid = SCOPE_IDENTITY();
	EXEC sp_role_permission_mapping_basic @role_rid
END;
GO

