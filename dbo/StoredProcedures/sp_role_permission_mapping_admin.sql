CREATE procedure [dbo].[sp_role_permission_mapping_admin]
@role_rid int
AS
BEGIN
INSERT INTO role_permission_mapping (role_rid, permission_code)
VALUES (@role_rid, 'account.user.view');
END
GO

