CREATE TABLE [dbo].[tenant_service_level_mapping]
(
    [rid] INT IDENTITY (1, 1) NOT NULL,
    [tenant_id] NVARCHAR (50) NOT NULL,
    [service_level_code] VARCHAR(30) NOT NULL,
    [created_by] INT NOT NULL,
    [created_at] DATETIME NULL,
    [account_type_code] VARCHAR(30) NULL
);
GO

ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [FK_tenant_service_level_mapping_account_type_code] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [fk_tenant_service_level_mapping_service_level_code] FOREIGN KEY ([service_level_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

CREATE NONCLUSTERED INDEX [ix_tenant_service_level_mapping_tenant_account_type_code]
    ON [dbo].[tenant_service_level_mapping]([account_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_tenant_service_level_mapping_service_level_code]
    ON [dbo].[tenant_service_level_mapping]([service_level_code] ASC);
GO

ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [PK_tenant_service_level_mapping] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

