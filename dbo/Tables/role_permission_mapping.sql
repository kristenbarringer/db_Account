
CREATE TABLE [dbo].[role_permission_mapping]
( -- REFACTOR DONE as of 6/7/2026
    -- ------------------------------------
    -- pks and main uq columns
    [role_permission_mapping_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_role_permission_mapping_role_permission_mapping_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [role_permission_mapping_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    [permission_code] VARCHAR (100) NOT NULL ,
    -- fk columns - other main fks    
    [role_rid] BIGINT NOT NULL,

    -- fk columns - to lookup code
    -- bit flag columns
    -- date columns
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [pk_role_permission_mapping_tenant_uuid_role_permission_mapping_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [role_permission_mapping_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [uk_role_permission_mapping_uuid] UNIQUE NONCLUSTERED ([role_permission_mapping_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [uk_role_permission_mapping_rid] UNIQUE ([role_permission_mapping_rid]);
GO

-- fks - to tenant
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [fk_role_permission_mapping_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[account_details] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_tenant_uuid] 
  ON [dbo].[role_permission_mapping]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[role_permission_mapping]
    ADD CONSTRAINT [fk_role_permission_mapping_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_created_by_user_rid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[role_permission_mapping]([created_by_user_rid] ASC);
GO
-- fks - other main fks
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [fk_role_permission_mapping_user_rid] FOREIGN KEY ([role_rid]) REFERENCES [dbo].role ([role_rid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_user_rid] 
  ON [dbo].[role_permission_mapping]([role_rid] ASC); 
  GO
-- fks - to lookup code
-- other constraints and indexes 
-- N/A
-- END
 