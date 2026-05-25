CREATE TABLE [dbo].[role_permission_mapping]
(
    -- ------------------------------------
    -- pks and main uq columns
    [role_permission_mapping_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_role_permission_mapping_id] DEFAULT (NEWID()) NOT NULL,
    [role_permission_mapping_rid] INT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_role_permission_mapping_tenant_uuid] DEFAULT (NEWID()) NOT NULL,
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
    ADD CONSTRAINT [cix_role_permission_mapping_rid] PRIMARY KEY CLUSTERED ([role_permission_mapping_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[role_permission_mapping]
ADD CONSTRAINT uk_role_permission_mapping_uuid UNIQUE ([role_permission_mapping_uuid]);
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
-- extended properties: table
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'This table stores customer information.',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'role_permission_mapping';
GO
-- extended properties: columns
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'Customer unique identifier',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'role_permission_mapping',  
    @level2type = N'COLUMN',  @level2name = N'role_permission_mapping_rid';
GO
-- ------------------------------------
 