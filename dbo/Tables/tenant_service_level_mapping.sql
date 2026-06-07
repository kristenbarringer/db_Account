/*

CREATE TABLE [dbo].[xxxx]
(
-- TODO REFACTOR TEMPLATE IS AS FOLLOWS:
-- ------------------------------------
-- pks and main uq columns
	-- UUID no default!
	-- TODO possibly remove identity prop on RID (or remove RID altogether)
-- fk columns - to tenant
-- main attribute columns of this entity 
-- fk columns - other main fks (todo check legacy DB for all existing fks)
-- fk columns - to lookup code (suffixed with "_code")
-- bit flag columns (prefixed with "is_")
-- date columns (suffixed with "_date")
-- fk columns - to user (uuids)
-- note columns
-- test data columns (only used for test data process on dev)
-- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

-- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
	-- UUID --> pk
	-- RID --> uk
-- fks - to tenant
-- fks - to user (todo - possibly remove these fks to user)
-- fks - other main fks
-- fks - to lookup code
-- other constraints and indexes 
-- extended properties: table
-- extended properties: columns
-- ------------------------------------
-- TODO make sure to format before committing (Shift + Alt + F)
-- END


*/



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

