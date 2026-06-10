CREATE TABLE [dbo].[account_type]
(
  [account_type_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_type_account_type_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,
  [account_type_rid] BIGINT IDENTITY (1, 1) NOT NULL,
  [description] [nvarchar](50) NOT NULL,
  [status] [bit] NOT NULL,
  [service_level_filter] [bit] NULL
)
GO
-- pks and main uq indexes
ALTER TABLE [dbo].[account_type] ADD CONSTRAINT [pk_account_type_tenant_uuid_account_type_rid] PRIMARY KEY CLUSTERED ([account_type_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[account_type] ADD CONSTRAINT [uk_account_type_uuid] UNIQUE NONCLUSTERED ([account_type_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
 