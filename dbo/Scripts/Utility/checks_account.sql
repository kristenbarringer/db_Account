
--------DELETE FROM dbo.controller --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
--------DELETE FROM dbo.equipment --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
--------DELETE FROM dbo.device --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';
--------DELETE FROM dbo.asset --where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV';

--select top 100 * from zzz_seed_test_data_customer
exec usp_seed_reset_all
select count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
from dbo.account_details a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid, a.tenant_id , notes
order by count(*) desc, tenant_uuid asc
 

--select top 100 * from dbo.asset where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV' order by tenant_uuid asc


exec usp_seed_load_all

select count(*) counts, c.name,a.tenant_uuid, a.tenant_id , notes
from dbo.account_details a
left join zzz_seed_test_data_customer c on a.tenant_uuid = c.tenant_uuid
group by c.name,a.tenant_uuid, a.tenant_id , notes
order by count(*) desc, tenant_uuid asc
 
select * from dbo.account_details where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV' order by tenant_uuid asc
select * from dbo.user_accounts where coalesce(notes, '') = 'TEST DATA PROCESS ON DEV' order by tenant_uuid asc
