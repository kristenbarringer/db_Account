  CREATE   procedure [dbo].[sp_update_role]
  @pipeline_run_id nvarchar(100)
  AS
  BEGIN
  print 'TODO FIX THIS'
  /* TODO FIX THIS
	DROP TABLE IF EXISTS #admin_users;
    DROP TABLE IF EXISTS #customer_role_admin;
	DROP TABLE IF EXISTS #basic_users;
	DROP TABLE IF EXISTS #customer_role_basic;
	DROP TABLE IF EXISTS #admin_user_rid;
	DROP TABLE IF EXISTS cosmos_table
	CREATE TABLE #admin_users (
        tenant_id VARCHAR(255),
        user_name VARCHAR(255)
    );
	CREATE TABLE #basic_users (
        tenant_id VARCHAR(255),
        user_name VARCHAR(255)
    );
	CREATE TABLE #customer_role_admin (
        role_rid INT,
        role_description VARCHAR(255),
		tenant_id VARCHAR(255),
		user_name VARCHAR(255)
    );
	CREATE TABLE #customer_role_basic (
        role_rid INT,
        role_description VARCHAR(255),
		tenant_id VARCHAR(255),
		user_name VARCHAR(255)
    );
	CREATE TABLE #admin_user_rid (
        user_rid INT,
		tenant_id VARCHAR(255)

    );
	CREATE TABLE cosmos_table (
        id  VARCHAR(255),
		tenant_id VARCHAR(255),
		adminName nvarchar(100),
		organization nvarchar(200),
		state nvarchar(100),
		activationToken varchar(50) DEFAULT 'NULL',
		createdReason varchar(50) DEFAULT 'V1_migrated_data',
		comments varchar(50) DEFAULT 'V1_migrated_data',
		adminEmail nvarchar(100),
		createdAt datetime  DEFAULT GETDATE(),
		updatedAt datetime  DEFAULT GETDATE(),
		accountType varchar(50),
		phone_number nvarchar(50) DEFAULT '0000000000'


    );
	INSERT INTO #admin_users (tenant_id, user_name)
	select tenant_id,user_name from tenantinfo where minimum_user = user_rid
	AND pipeline_id = @pipeline_run_id

	INSERT INTO #customer_role_admin (role_rid, role_description, tenant_id, user_name)
	select a.role_rid,a.description,a.tenant_id,b.user_name from role a, #admin_users b
	where a.tenant_id = b.tenant_id and a.description = 'ADMIN'
	
	INSERT INTO #basic_users (tenant_id, user_name)
	select tenant_id,user_name from tenantinfo where minimum_user <> user_rid
	AND pipeline_id = @pipeline_run_id
	
	INSERT INTO #customer_role_basic (role_rid, role_description, tenant_id, user_name)
	select a.role_rid,a.description,a.tenant_id,b.user_name from role a, #basic_users b 
	where a.tenant_id = b.tenant_id and a.description = 'BASIC'
	
	INSERT INTO #admin_user_rid (user_rid, tenant_id)
	select b.user_rid,a.tenant_id  from #admin_users a, user_accounts b where a.user_name = b.user_name
	--select a.role_rid,a.description,a.tenant_id,b.user_name from role a, #basic_users b where a.tenant_id = b.tenant_id and a.description = 'CUSTOMER BASIC'

	Update ua
	set ua.role_rid=ub.role_rid from user_accounts ua inner join #customer_role_admin ub ON ua.user_name=ub.user_name 
	Update ua
	set ua.admin_user_rid=ub.user_rid from account_details ua inner join #admin_user_rid ub ON ua.tenant_id=ub.tenant_id
	Update ua
	set ua.role_rid=ub.role_rid from user_accounts ua inner join #customer_role_basic ub ON ua.user_name=ub.user_name
	
	INSERT INTO cosmos_table(tenant_id,adminName,organization,state,adminEmail,accountType)
	Select a.tenant_id,b.user_name as adminName,a.organization,
	CASE 
		WHEN a.active = '1'
			then 'ACTIVE'
		ELSE 'INACTIVE'
		END as state,
	b.email_address as adminEmail,
	CASE 
		WHEN a.account_type_rid = '1'
			then 'CUSTOMER'
		WHEN a.account_type_rid = '2'
			then 'TKADMIN'
		WHEN a.account_type_rid = '3'
			then 'DEALER'
		ELSE 'NON-CUSTOMER'
		END as accountType

	 from account_details a left join user_accounts b on a.admin_user_rid = b.user_rid
	 WHERE a.tenant_id IN (SELECT tenant_id FROM #admin_users);
	
*/
end
GO

