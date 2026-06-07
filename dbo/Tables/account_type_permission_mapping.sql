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



CREATE TABLE [dbo].[account_type_permission_mapping] (
    [rid]             INT           IDENTITY (1, 1) NOT NULL,
    [role_rid]        INT           NOT NULL,
    [role_code] VARCHAR (30) NULL,
    [created]         DATETIME      NOT NULL,
    [permission_code] VARCHAR (100) NOT NULL
);
GO

 

ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [DF_account_type_permission_mapping_created] DEFAULT (getdate()) FOR [created];
GO

CREATE NONCLUSTERED INDEX [IDX_account_type_permission_mapping_role_rid]
    ON [dbo].[account_type_permission_mapping]([role_rid] ASC);
GO

ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [fk_account_type_permission_mapping_role_code] FOREIGN KEY ([role_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_type_permission_mapping_role_code] 
    ON [dbo].[account_type_permission_mapping]([role_code] ASC);
GO