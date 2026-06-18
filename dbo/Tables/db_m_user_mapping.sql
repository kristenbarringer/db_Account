CREATE TABLE [dbo].[db_m_user_mapping](
	[tenant_uuid] [nvarchar](max) NULL,
	[v1_user_rid] [int] NULL,
	[v2_user_uuid] [nvarchar](max) NOT NULL,
	[v2_user_rid] [nvarchar](max) NULL,
	[last_modified] [nvarchar](max) NOT NULL,
	[last_sync_time] [nvarchar](max) NOT NULL,
	[last_entry_hash] [nvarchar](max) NOT NULL
) 
GO