CREATE TABLE [dbo].[db_m_user_mapping]
(
	[tenant_uuid] UNIQUEIDENTIFIER NULL,
	[v1_user_rid] [bigint] NULL,
	[v2_user_uuid] UNIQUEIDENTIFIER NOT NULL,
	[v2_user_rid] [bigint] NULL,
	[last_modified] [nvarchar](max) NOT NULL,
	[last_sync_time] [nvarchar](max) NOT NULL,
	[last_entry_hash] [nvarchar](max) NOT NULL
) 
GO