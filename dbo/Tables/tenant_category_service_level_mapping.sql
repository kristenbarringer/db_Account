CREATE TABLE [dbo].[tenant_category_service_level_mapping]
( -- TODO what is this table?
    [rid] INT IDENTITY (1, 1) NOT NULL,
    [account_type_code] VARCHAR(30) NULL,
    [service_level_code] VARCHAR(30) NULL,
    [created] DATETIME NULL
);
GO

CREATE NONCLUSTERED INDEX [ix_tenant_category_service_level_mapping_service_level_code]
    ON [dbo].[tenant_category_service_level_mapping]([service_level_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_tenant_category_service_level_mapping_account_type_code]
    ON [dbo].[tenant_category_service_level_mapping]([account_type_code] ASC);
GO

ALTER TABLE [dbo].[tenant_category_service_level_mapping]
    ADD CONSTRAINT [fk_tenant_category_service_level_mapping_account_type] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[tenant_category_service_level_mapping]
    ADD CONSTRAINT [fk_tenant_category_service_level_mapping_service_level_code] FOREIGN KEY ([service_level_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[tenant_category_service_level_mapping]
    ADD CONSTRAINT [PK_tenant_category_service_level_mapping] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

