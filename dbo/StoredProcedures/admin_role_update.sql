CREATE PROCEDURE [dbo].[admin_role_update]
as
begin
print 'TODO FIX THIS'
/* TODO FIX THIS
delete from role_permission_mapping where role_rid in (SELECT role_rid
FROM role where tenant_id in (select tenant_id  from tenantinfo) and description = 'ADMIN')

DECLARE @role_rid INT;

DECLARE tenant_role_admin CURSOR FOR
SELECT role_rid
FROM role where tenant_id in (select tenant_id  from tenantinfo) and description = 'ADMIN'
OPEN tenant_role_admin
FETCH NEXT FROM tenant_role_admin into @role_rid
WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_contact_email');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.role.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_profile.batch_profile.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.company_profile.edit_company_phone');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_it_notes');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_group.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_ip_address');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.move');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_contact_name');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.company_profile.edit_fax');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.role.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.role.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.company_profile.edit_email_address');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.account.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.deactivate_bulk');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_command.batch_command.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_contact.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_contact_phone');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.view_all');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.activate');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.activate_bulk');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_command.diagnostics');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_command.batch_command.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_it_approved_user');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.track');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_group.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_group.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.company_profile.edit_name');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.edit_telematics_mode');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'geofence.geofence.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.execute');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota_bundle.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.role.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_command.batch_command.execute');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.deactivate');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_profile.batch_profile.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.company_profile.edit_support_phone');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_contact.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.company_profile.edit_website');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'geofence.geofence.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.upload');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota_bundle.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'dealer.dealer.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_command.swd');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.user.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_contact_company');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.user.bulk_create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.view_upgrade_bundle');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.user.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.company_profile.edit_address');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_command.optiset');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_command.batch_command.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_profile.batch_profile.execute');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_command.batch_command.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota_bundle.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_it_approved_date');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.transfer');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_profile.batch_profile.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota_bundle.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'dashboard.dashboard.tracking');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_contact.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'report.report.standard');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_group.manage');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.cancel');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.billing.edit_tracking_admin');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.user.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_group.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'notification.notification_contact.edit');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'geofence.geofence.delete');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'asset.asset_command.two_way');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.edit_integration_settings');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'dashboard.dashboard.basic');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'batch_profile.batch_profile.create');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.customer_data_integration.select_existing_data_integration');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.billing.edit_tracking_admin_email');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'geofence.geofence.view');
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'flota.flota.bulk_execute');
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
	INSERT INTO role_permission_mapping (role_rid,permission_code) VALUES (@role_rid, 'account.account.create');

	FETCH NEXT FROM tenant_role_admin into @role_rid
END
CLOSE tenant_role_admin
DEALLOCATE tenant_role_admin

*/end
GO

