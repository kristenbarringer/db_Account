CREATE TABLE [dbo].[db_m_customer_mapping]
(
 
tenant_uuid UNIQUEIDENTIFIER,
v1_customer_rid BIGINT NULL,
last_modified datetime,
last_sync_time datetime,
last_entry_hash [nvarchar](max)

)
 
 
 