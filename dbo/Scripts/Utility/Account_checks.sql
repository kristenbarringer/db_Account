--select * from zzz_test_20260525_0832
--select * from lookup_code_list where lookup_list_code = 'zzz_test_20260525_0832'


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



--exec usp_seed_reset_all

--exec usp_seed_load_all

--alter table dbo.role_permission_mapping drop constraint FK_role_permission_mapping_role
--alter table dbo.user_accounts drop constraint FK_user_accounts_role
--[dbo].[user_accounts] 
--drop table role
--sp_helpconstraint 'role'

--select 'account_details' as table_name, count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
--from dbo.account_details a
--left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
--group by c.name,a.tenant_uuid, a.tenant_id , notes
--order by count(*) desc, tenant_uuid asc

--select 'user_accounts' as table_name, count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
--from dbo.user_accounts a
--left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
--group by c.name,a.tenant_uuid, a.tenant_id , notes
--order by count(*) desc, tenant_uuid asc

 

-- select * from dbo.account_details
-- select * from dbo.user_accounts
-- sp_helpconstraint 'role'
 
--alter table dbo.account_details drop constraint if exists FK_account_details_user_accounts
--alter table dbo.contact drop constraint if exists FK_contact_user_accounts
--alter table dbo.customer_dealer_mapping drop constraint if exists FK_customer_dealer_mapping_users_created
--alter table dbo.customer_dealer_mapping drop constraint if exists FK_customer_dealer_mapping_users_updated
--alter table dbo.user_grid_view_preference drop constraint if exists FK_user_grid_view_preference_user_accounts
--alter table dbo.user_grid_view_preference drop constraint if exists fk_user_grid_view_pref_user_id
--alter table dbo.user_grid_view_preference drop constraint if exists fk_user_grid_view_pref_user_uuid
 
--alter table dbo.tenantinfo drop constraint if exists fk_tenantinfo_user_rid
--alter table dbo.tenantinfo drop constraint if exists fk_tenantinfo_user_uuid
 
--drop table if exists account_details
--drop table if exists account_details2
--drop table if exists user_accounts
--drop table if exists role
--drop table if exists tenantinfo



-- sp_helpconstraint 'tenantinfo'

--drop table if exists user_accounts
--drop table if exists role
--drop table if exists tenantinfo 
--alter table dbo.account_details drop constraint if exists fk_account_details_tenant_id
--alter table dbo.account_details drop constraint if exists fk_account_details_tenant_uuid
--alter table dbo.contact drop constraint if exists fk_contact_tenant_id
--alter table dbo.contact drop constraint if exists fk_contact_tenant_uuid
--alter table dbo.role drop constraint if exists fk_role_tenant_id
--alter table dbo.role drop constraint if exists fk_role_tenant_uuid
--alter table dbo.role_permission_mapping drop constraint if exists fk_role_permission_mapping_tenant_id
--alter table dbo.role_permission_mapping drop constraint if exists fk_role_permission_mapping_tenant_uuid
--alter table dbo.user_accounts drop constraint if exists fk_user_accounts_tenant_id
--alter table dbo.user_accounts drop constraint if exists fk_user_accounts_tenant_uuid
--alter table dbo.user_grid_view_preference drop constraint if exists fk_user_grid_view_pref_tenant_id
--alter table dbo.user_grid_view_preference drop constraint if exists fk_user_grid_view_pref_tenant_uuid





exec usp_seed_reset_all

exec usp_seed_load_all

 
select 'tenantinfo' as table_name, count(*) counts, c.name,a.tenant_uuid,  notes
from dbo.tenantinfo a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc

select 'role' as table_name, count(*) counts, c.name,a.tenant_uuid,  notes
from dbo.role a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc

select 'user_accounts' as table_name, count(*) counts, c.name,a.tenant_uuid, notes
from dbo.user_accounts a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc

select 'account_details' as table_name, count(*) counts, c.name,a.tenant_uuid,  notes
from dbo.account_details a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc

select 'contact' as table_name, count(*) counts, c.name,a.tenant_uuid,  notes
from dbo.contact a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc

select 'user_grid_view_preference' as table_name, count(*) counts, c.name,a.tenant_uuid,  notes
from dbo.user_grid_view_preference a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc

select 'role_permission_mapping' as table_name, count(*) counts, c.name,a.tenant_uuid,  notes
from dbo.role_permission_mapping a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc

select 'dealer' as table_name, count(*) counts, c.name,a.tenant_uuid,  notes
from dbo.dealer a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid,  notes
order by count(*) desc, tenant_uuid asc
 
 select * from information_schema.columns where table_name = 'dealer'
 select db_name()
  
select top 10 * from tenantinfo
select top 10 * from user_accounts
select top 10 * from role
select top 10 * from account_details
select top 10 * from contact
select top 10 * from user_grid_view_preference
select top 10 * from role_permission_mapping

drop proc usp_dq_data_integrity_check

truncate table dq_data_integrity_check

EXEC dbo.usp_dq_data_integrity_check 
EXEC dbo.usp_dq_data_integrity_rid_to_uuid_check 

 
SELECT * FROM dbo.dq_data_integrity_check WHERE CheckName = 'WrongLookupList' AND ResolvedDate IS NULL 
SELECT * FROM dbo.dq_data_integrity_check WHERE CheckName = 'Wrong_rid_to_uuid' AND ResolvedDate IS NULL

select table_name, column_name from information_schema.columns where table_name in ('tenantinfo','user_accounts','role','account_details','contact','user_grid_view_preference','role_permission_mapping','dealer','asset','equipment','device','controller','device_sim'
) order by table_name, column_name

select * from lookup_code where code like '%basic%'


select * from information_schema.tables 
where table_type = 'BASE TABLE'
--and table_name not like 'zzz%' 
and table_name not like 'lookup%' 
and table_name not like 'dq%'
and table_name not in ('xxx','xxx','xxx','xxx')
order by table_name




if db_name() = 'Account' drop table if exists account_type_role_mapping
if db_name() = 'Account' drop table if exists xxxxx
if db_name() = 'Account' drop table if exists xxxxx
if db_name() = 'Account' drop table if exists xxxxx
if db_name() = 'Account' drop table if exists xxxxx

sp_helpconstraint 'work_schedule'
alter table dbo.account_type_permission_mapping drop constraint if exists FK_account_type_permission_mapping_account_type_role_mapping
if db_name() = 'Account' drop table if exists account_type_role_mapping
if db_name() = 'Account' drop table if exists control_table
if db_name() = 'Account' drop table if exists subscription_detail
if db_name() = 'Account' drop table if exists tenant_subscription_mapping
if db_name() = 'Account' drop table if exists user_type_permission_template
if db_name() = 'Account' drop table if exists v1_contact
if db_name() = 'Account' drop table if exists v1_user_change_log

if db_name() = 'Account' drop table if exists zzz_test_20260524_1709_account
if db_name() = 'Account' drop table if exists zzz_test_20260525_0832
if db_name() = 'Account' drop table if exists zzz_test_added_to_Account_20260520
if db_name() = 'Account' drop table if exists zzz_test_added_to_Account_20260520_1020
if db_name() = 'Account' drop table if exists zzz_test_table_20260520_1215
if db_name() = 'Account' drop table if exists zzz_test_table_20260522_1355_account_new
if db_name() = 'Account' drop table if exists zzz_test_table_20260522_1355_accountb
if db_name() = 'Account' drop table if exists zzz_test_table_20260522_1418_account


fk_tenantinfo_work_schedule_code

