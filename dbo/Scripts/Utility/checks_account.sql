
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



select count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
from dbo.account_details a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid, a.tenant_id , notes
order by count(*) desc, tenant_uuid asc

select count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
from dbo.user_accounts a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid, a.tenant_id , notes
order by count(*) desc, tenant_uuid asc

 

 select * from dbo.account_details
 select * from dbo.user_accounts