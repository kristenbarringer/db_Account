CREATE TABLE [dbo].[db_m_user_mapping]
(
tenant_uuid UNIQUEIDENTIFIER,
v1_user_rid BIGINT NULL,
v2_user_uuid UNIQUEIDENTIFIER,
v2_user_rid BIGINT NULL,
last_modified datetime,
last_sync_time datetime,
last_entry_hash [nvarchar](max)
)
