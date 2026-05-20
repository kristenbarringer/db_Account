CREATE PROCEDURE [dbo].[basic_role_update]
as
begin

delete from role_permission_mapping where role_rid in (SELECT role_rid
FROM role where tenant_id in (select tenant_id  from tenantinfo) and description = 'basic')


DECLARE @role_rid INT;

DECLARE tenant_role_basic CURSOR FOR
SELECT role_rid
FROM role where tenant_id in (select tenant_id  from tenantinfo) and description = 'basic' 
OPEN tenant_role_basic
FETCH NEXT FROM tenant_role_basic into @role_rid
WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.user.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_profile.batch_profile.execute');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.manage');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'dashboard.dashboard.basic');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_profile.batch_profile.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'dashboard.dashboard.tracking');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_command.two_way');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_command.batch_command.execute');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.role.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'geofence.geofence.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_command.batch_command.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'report.report.standard');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_contact.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.activate');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.track');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_group.view');
	FETCH NEXT FROM tenant_role_basic into @role_rid
END
CLOSE tenant_role_basic
DEALLOCATE tenant_role_basic

end
GO

