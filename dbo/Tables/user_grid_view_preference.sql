
CREATE TABLE [dbo].[user_grid_view_preference]
(
    -- ------------------------------------
    -- pks and main uq columns
    [user_grid_view_preference_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_grid_view_preference_id] DEFAULT (NEWID()) NOT NULL,
    [user_grid_view_preference_rid] INT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_grid_view_preference_tenant_uuid] DEFAULT (NEWID()) NOT NULL,
    -- main attribute columns of this entity 
    [grid_name] NVARCHAR (200) NOT NULL,
    [columns_hidden] NVARCHAR (3000) NOT NULL,
    -- fk columns - other main fks
    -- fk columns - to lookup code
    -- bit flag columns
    -- date columns
    [created_date] DATETIME CONSTRAINT [df_user_grid_view_preference_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_uuid] UNIQUEIDENTIFIER NULL,
    -- note columns
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
    [created] DATETIME CONSTRAINT [df_user_grid_view_preference_created] DEFAULT (getdate()) NOT NULL,
    [user_rid] INT NULL,
    [user_uuid] UNIQUEIDENTIFIER NULL

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[user_grid_view_preference]
    ADD CONSTRAINT [cix_user_grid_view_preference_rid] PRIMARY KEY CLUSTERED ([user_grid_view_preference_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[user_grid_view_preference]
ADD CONSTRAINT uk_user_grid_view_preference_uuid UNIQUE ([user_grid_view_preference_uuid]);
GO
-- fks - to tenant
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_tenant_uuid] 
  ON [dbo].[user_grid_view_preference]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_user_uuid] FOREIGN KEY ([user_uuid]) REFERENCES [dbo].user_accounts ([user_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_user_uuid] 
  ON [dbo].[user_grid_view_preference]([user_uuid] ASC); 
  GO
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_user_id] FOREIGN KEY ([user_rid]) REFERENCES [dbo].user_accounts ([user_rid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_user_id] 
  ON [dbo].[user_grid_view_preference]([user_rid] ASC); 
  GO
ALTER TABLE [dbo].[user_grid_view_preference]
    ADD CONSTRAINT [fk_user_grid_view_preference_created_by_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_preference_created_by_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[user_grid_view_preference]([created_by_user_uuid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code
-- other constraints and indexes 
-- extended properties: table
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'This table stores customer information.',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'user_grid_view_preference';
GO
-- extended properties: columns
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'Customer unique identifier',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'user_grid_view_preference',  
    @level2type = N'COLUMN',  @level2name = N'user_grid_view_preference_rid';
GO
-- ------------------------------------
 