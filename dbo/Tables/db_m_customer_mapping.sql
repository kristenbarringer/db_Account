CREATE TABLE [dbo].[db_m_customer_mapping](
	[tenant_uuid] [nvarchar](max) NOT NULL,
	[v1_customer_rid] [int] NULL,
	[last_modified] [nvarchar](max) NOT NULL,
	[last_sync_time] [nvarchar](max) NOT NULL,
	[last_entry_hash] [nvarchar](max) NOT NULL
) 
GO