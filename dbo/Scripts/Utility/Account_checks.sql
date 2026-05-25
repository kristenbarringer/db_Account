select * from zzz_test_20260525_0832
select * from lookup_code_list where lookup_list_code = 'zzz_test_20260525_0832'


----------DELETE FROM dbo.controller --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
----------DELETE FROM dbo.equipment --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
----------DELETE FROM dbo.device --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
----------DELETE FROM dbo.asset --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';

----select top 100 * from zzz_seed_test_data_customer
--exec usp_seed_reset_all
--select count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
--from dbo.account_details a
--left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
--group by c.name,a.tenant_uuid, a.tenant_id , notes
--order by count(*) desc, tenant_uuid asc
 

----select top 100 * from dbo.asset where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV' order by tenant_uuid asc
--/*
-- delete from dbo.user_accounts 
-- go
-- delete from dbo.account_details 
-- go
-- delete from dbo.user_accounts 
--*/
--exec usp_seed_load_all

--select count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
--from dbo.account_details a
--left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
--group by c.name,a.tenant_uuid, a.tenant_id , notes
--order by count(*) desc, tenant_uuid asc
 
--select c.name, * from dbo.account_details a
--left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid order by a.tenant_uuid
--select c.name, * from dbo.user_accounts a
--left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid order by a.tenant_uuid  



-- insert into dbo.role ( description, standard_role, active, user_type_rid, tenant_id, name)
-- values ( 'Test Role', 0, 1, 1, '12345', 'Test Role')



exec usp_seed_reset_all

exec usp_seed_load_all

alter table dbo.role_permission_mapping drop constraint FK_role_permission_mapping_role
alter table dbo.user_accounts drop constraint FK_user_accounts_role
[dbo].[user_accounts] 
drop table role
sp_helpconstraint 'role'

select 'account_details' as table_name, count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
from dbo.account_details a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid, a.tenant_id , notes
order by count(*) desc, tenant_uuid asc

select 'user_accounts' as table_name, count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
from dbo.user_accounts a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid, a.tenant_id , notes
order by count(*) desc, tenant_uuid asc

 

 select * from dbo.account_details
 select * from dbo.user_accounts
 sp_helpconstraint 'role'
 
alter table dbo.account_details drop constraint if exists FK_account_details_user_accounts
alter table dbo.contact drop constraint if exists FK_contact_user_accounts
alter table dbo.customer_dealer_mapping drop constraint if exists FK_customer_dealer_mapping_users_created
alter table dbo.customer_dealer_mapping drop constraint if exists FK_customer_dealer_mapping_users_updated
alter table dbo.user_grid_view_preference drop constraint if exists FK_user_grid_view_preference_user_accounts
alter table dbo.user_grid_view_preference drop constraint if exists fk_user_grid_view_pref_user_id
alter table dbo.user_grid_view_preference drop constraint if exists fk_user_grid_view_pref_user_uuid
 
alter table dbo.tenantinfo drop constraint if exists fk_tenantinfo_user_rid
alter table dbo.tenantinfo drop constraint if exists fk_tenantinfo_user_uuid
 
drop table if exists account_details
drop table if exists user_accounts
drop table if exists role
drop table if exists tenantinfo
