CREATE TABLE [dbo].[tenant_service_level_mapping] (
    [rid]                INT           IDENTITY (1, 1) NOT NULL,
    [tenant_id]          NVARCHAR (50) NOT NULL,
    [service_level_rid]  INT           NOT NULL,
    [created_by]         INT           NOT NULL,
    [created_at]         DATETIME      NULL,
    [tenant_category_id] INT           NULL
);
GO

ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [FK_tenant_service_level_mapping_account_type] FOREIGN KEY ([tenant_category_id]) REFERENCES [dbo].[account_type] ([rid]);
GO

ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [FK_tenant_service_level_mapping_service_level] FOREIGN KEY ([service_level_rid]) REFERENCES [dbo].[service_level] ([service_level_rid]);
GO

CREATE NONCLUSTERED INDEX [IDX_tenant_service_level_mapping_tenant_category_id]
    ON [dbo].[tenant_service_level_mapping]([tenant_category_id] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_tenant_service_level_mapping_service_level_rid]
    ON [dbo].[tenant_service_level_mapping]([service_level_rid] ASC);
GO

ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [PK_tenant_service_level_mapping] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

