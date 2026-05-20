CREATE TABLE [dbo].[tenant_category_service_level_mapping] (
    [rid]              INT      IDENTITY (1, 1) NOT NULL,
    [category_id]      INT      NULL,
    [service_level_id] INT      NULL,
    [created]          DATETIME NULL
);
GO

CREATE NONCLUSTERED INDEX [IDX_tenant_category_service_level_mapping_service_level_id]
    ON [dbo].[tenant_category_service_level_mapping]([service_level_id] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_tenant_category_service_level_mapping_category_id]
    ON [dbo].[tenant_category_service_level_mapping]([category_id] ASC);
GO

ALTER TABLE [dbo].[tenant_category_service_level_mapping]
    ADD CONSTRAINT [FK_tenant_category_service_level_mapping_account_type] FOREIGN KEY ([category_id]) REFERENCES [dbo].[account_type] ([rid]);
GO

ALTER TABLE [dbo].[tenant_category_service_level_mapping]
    ADD CONSTRAINT [FK_tenant_category_service_level_mapping_service_level] FOREIGN KEY ([service_level_id]) REFERENCES [dbo].[service_level] ([service_level_rid]);
GO

ALTER TABLE [dbo].[tenant_category_service_level_mapping]
    ADD CONSTRAINT [PK_tenant_category_service_level_mapping] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

