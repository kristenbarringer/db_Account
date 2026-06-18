CREATE TABLE [dbo].[db_m_customer_mapping]
(
	[tenant_uuid] UNIQUEIDENTIFIER NOT NULL,
	[v1_customer_rid] [bigint] NULL,
	[last_modified] [nvarchar](max) NOT NULL,
	[last_sync_time] [nvarchar](max) NOT NULL,
	[last_entry_hash] [nvarchar](max) NOT NULL
) 
GO