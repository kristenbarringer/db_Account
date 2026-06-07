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



CREATE TABLE [dbo].[role_permission_mapping]
( -- REFACTOR DONE as of 6/7/2026
    -- ------------------------------------
    -- pks and main uq columns
    [role_permission_mapping_uuid] UNIQUEIDENTIFIER NOT NULL,
    [role_permission_mapping_rid] INT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    [permission_code] VARCHAR (100) NOT NULL ,
    -- fk columns - other main fks    
    [role_rid] int NOT NULL,
    [role_uuid] UNIQUEIDENTIFIER NOT NULL,

    -- fk columns - to lookup code
    -- bit flag columns
    -- date columns
    -- fk columns - to user
    [created_by_user_uuid] UNIQUEIDENTIFIER NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[role_permission_mapping]
    ADD CONSTRAINT [cix_role_permission_mapping_uuid] PRIMARY KEY CLUSTERED ([role_permission_mapping_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[role_permission_mapping]
ADD CONSTRAINT uk_role_permission_mapping_rid UNIQUE ([role_permission_mapping_rid]);
GO
-- fks - to tenant
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [fk_role_permission_mapping_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_tenant_uuid] 
  ON [dbo].[role_permission_mapping]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[role_permission_mapping]
    ADD CONSTRAINT [fk_role_permission_mapping_created_by_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_created_by_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[role_permission_mapping]([created_by_user_uuid] ASC);
GO
-- fks - other main fks
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [fk_role_permission_mapping_role_uuid] FOREIGN KEY ([role_uuid]) REFERENCES [dbo].role ([role_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_role_uuid] 
  ON [dbo].[role_permission_mapping]([role_uuid] ASC); 
  GO
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [fk_role_permission_mapping_user_rid] FOREIGN KEY ([role_rid]) REFERENCES [dbo].role ([role_rid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_user_rid] 
  ON [dbo].[role_permission_mapping]([role_rid] ASC); 
  GO
-- fks - to lookup code
-- other constraints and indexes 
-- N/A
-- END
 