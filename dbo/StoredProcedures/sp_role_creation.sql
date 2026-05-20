CREATE   procedure [dbo].[sp_role_creation]
    @tenant_id NVARCHAR(100)

AS
BEGIN
DECLARE @role_rid INT;
    INSERT INTO role (description, standard_role, active, user_type_rid, tenant_id, name)
    VALUES ('ADMIN', 1, 1, 1, @tenant_id, 'ADMIN');
	SET @role_rid = SCOPE_IDENTITY();
	EXEC sp_role_permission_mapping_admin @role_rid

	INSERT INTO role (description, standard_role, active, user_type_rid, tenant_id, name)
    VALUES ('BASIC', 1, 1, 1, @tenant_id, 'BASIC');
	SET @role_rid = SCOPE_IDENTITY();
	EXEC sp_role_permission_mapping_basic @role_rid
END;
GO

