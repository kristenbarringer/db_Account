CREATE TABLE [dbo].[account_type]
(
  [account_type_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_type_account_type_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,
  [account_type_rid] BIGINT IDENTITY (1, 1) NOT NULL,
  [description] [nvarchar](50) NOT NULL,
  [status] [bit] NOT NULL,
  [service_level_filter] [bit] NULL
)