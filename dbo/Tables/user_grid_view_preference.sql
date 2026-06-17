

CREATE TABLE [dbo].[user_grid_view_preference]
( -- REFACTOR DONE as of 6/7/2026
    -- ------------------------------------
    -- pks and main uq columns
    [user_grid_view_preference_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_grid_view_preference_user_grid_view_preference_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [user_grid_view_preference_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
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
    [created_by_user_rid] BIGINT NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
    [created] DATETIME CONSTRAINT [df_user_grid_view_preference_created] DEFAULT (getdate()) NOT NULL,
    [user_rid] BIGINT NULL -- TODO keep these?


    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [pk_user_grid_view_preference_tenant_uuid_user_grid_view_preference_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [user_grid_view_preference_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [uk_user_grid_view_preference_uuid] UNIQUE NONCLUSTERED ([user_grid_view_preference_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [uk_user_grid_view_preference_rid] UNIQUE ([user_grid_view_preference_rid]);
GO

-- fks - to tenant
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[account_details] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_tenant_uuid] 
  ON [dbo].[user_grid_view_preference]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_user_id] FOREIGN KEY ([user_rid]) REFERENCES [dbo].user_accounts ([user_rid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_user_id] 
  ON [dbo].[user_grid_view_preference]([user_rid] ASC); 
  GO
ALTER TABLE [dbo].[user_grid_view_preference]
    ADD CONSTRAINT [fk_user_grid_view_preference_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_preference_created_by_user_rid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[user_grid_view_preference]([created_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code
-- other constraints and indexes 
-- N/A
-- END