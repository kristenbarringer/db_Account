CREATE TABLE [dbo].[cosmos_table] (
    [id]              VARCHAR (255)  NULL,
    [tenant_id]       VARCHAR (255)  NULL,
    [adminName]       NVARCHAR (100) NULL,
    [organization]    NVARCHAR (200) NULL,
    [state]           NVARCHAR (100) NULL,
    [activationToken] VARCHAR (50)   NULL,
    [createdReason]   VARCHAR (50)   NULL,
    [comments]        VARCHAR (50)   NULL,
    [adminEmail]      NVARCHAR (100) NULL,
    [createdAt]       DATETIME       NULL,
    [updatedAt]       DATETIME       NULL,
    [accountType]     VARCHAR (50)   NULL,
    [phone_number]    NVARCHAR (50)  NULL
);
GO

ALTER TABLE [dbo].[cosmos_table]
    ADD CONSTRAINT [DF_cosmos_table_updatedAt] DEFAULT (getdate()) FOR [updatedAt];
GO

ALTER TABLE [dbo].[cosmos_table]
    ADD CONSTRAINT [DF_cosmos_table_id] DEFAULT (newid()) FOR [id];
GO

ALTER TABLE [dbo].[cosmos_table]
    ADD CONSTRAINT [DF_cosmos_table_createdReason] DEFAULT ('V1_migrated_data') FOR [createdReason];
GO

ALTER TABLE [dbo].[cosmos_table]
    ADD CONSTRAINT [DF_cosmos_table_activationToken] DEFAULT ('NULL') FOR [activationToken];
GO

ALTER TABLE [dbo].[cosmos_table]
    ADD CONSTRAINT [DF_cosmos_table_createdAt] DEFAULT (getdate()) FOR [createdAt];
GO

ALTER TABLE [dbo].[cosmos_table]
    ADD CONSTRAINT [DF_cosmos_table_comments] DEFAULT ('V1_migrated_data') FOR [comments];
GO

ALTER TABLE [dbo].[cosmos_table]
    ADD CONSTRAINT [DF_cosmos_table_phone_number] DEFAULT ('0000000000') FOR [phone_number];
GO

