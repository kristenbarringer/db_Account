CREATE procedure [dbo].[default_constraints_for_accounts]
AS 
BEGIN
print 'TODO FIX THIS'
/* TODO FIX THIS
	alter table [dbo].[user_accounts] 
	drop constraint DF_first_name_v1migration;

	alter table [dbo].[user_accounts] 
	drop constraint DF_last_name_v1migration;

	alter table [dbo].[user_accounts] 
	drop constraint DF_role_v1migration;

	alter table [dbo].[user_accounts] 
	drop constraint DF_tenant_v1migration;

	ALTER TABLE [dbo].[user_accounts] 
	ADD CONSTRAINT [DF_first_name_v1migration]  DEFAULT ('Tracking') FOR [first_name]
	
	ALTER TABLE [dbo].[user_accounts] 
	ADD CONSTRAINT [DF_last_name_v1migration]  DEFAULT ('User') FOR [last_name]
	
	ALTER TABLE [dbo].[user_accounts]
	ADD CONSTRAINT [DF_role_v1migration]  DEFAULT ((1)) FOR [role_rid]
	
	ALTER TABLE [dbo].[user_accounts] 
	ADD CONSTRAINT [DF_tenant_v1migration]  DEFAULT ((1)) FOR [tenant_id]

	ALTER TABLE [dbo].[account_details]
	DROP CONSTRAINT DF_account_type_rid_v1migration

	ALTER TABLE [dbo].[account_details] 
	DROP CONSTRAINT DF_tenant_id_v1migration

	ALTER TABLE [dbo].[account_details] 
	ADD CONSTRAINT [DF_account_type_rid_v1migration]  DEFAULT ((1)) FOR [account_type_rid]
	
	ALTER TABLE [dbo].[account_details] 
	ADD CONSTRAINT [DF_tenant_id_v1migration]  DEFAULT (newid()) FOR [tenant_id]
*/	
END
GO

