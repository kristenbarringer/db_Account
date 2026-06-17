CREATE TABLE [dbo].[role]
( -- REFACTOR DONE as of 6/7/2026
    -- ------------------------------------
    -- pks and main uq columns
    [role_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_role_role_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [role_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER NOT NULL,
    -- every table must have a tenant_uuid  
    -- main attribute columns of this entity 
    [name] NVARCHAR (100) NOT NULL,
    [description] NVARCHAR (100) NOT NULL,
    -- fk columns - other main fks
    -- fk columns - to lookup code
    [role_type_code] VARCHAR(30) NOT NULL,
    -- bit flag columns
    [is_active] BIT CONSTRAINT [df_role_is_active] DEFAULT (1) NOT NULL,
    [is_standard_role] BIT CONSTRAINT [df_role_is_standard_role] DEFAULT (1) NOT NULL,
    -- date columns
    [created_date] DATETIME CONSTRAINT [df_role_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME CONSTRAINT [df_role_updated_date] DEFAULT (getdate()) NOT NULL,
    -- fk columns - to user
    [created_by_user_rid] UNIQUEIDENTIFIER NULL,
    [updated_by_user_rid] UNIQUEIDENTIFIER NULL, -- TODO add this to all tables
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    [test_data_group] int null  ,
    -- columns to be deprecated
    [created] DATETIME CONSTRAINT [df_role_created] DEFAULT (getdate()) NOT NULL,
    [active] BIT NOT NULL,
);
GO

-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[role] ADD CONSTRAINT [pk_role_tenant_uuid_role_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [role_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[role] ADD CONSTRAINT [uk_role_uuid] UNIQUE NONCLUSTERED ([role_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[role] ADD CONSTRAINT [uk_role_rid] UNIQUE ([role_rid]);
GO

-- fks - to tenant
ALTER TABLE [dbo].[role] ADD CONSTRAINT [fk_role_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[account_details] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_role_tenant_uuid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[role]([tenant_uuid] ASC); 
  GO
-- -- fks - to user - TODO circular logic - need to rethink this
-- ALTER TABLE [dbo].[role]
--     ADD CONSTRAINT [fk_role_user_uuid] FOREIGN KEY ([created_by_user_rid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
-- GO
-- CREATE NONCLUSTERED INDEX [ix_fk_role_user_uuid] -- add explicit index for the FK column, to improve join performance
--     ON [dbo].[role]([created_by_user_rid] ASC);
-- GO
-- fks - other main fks
-- fks - to lookup code
ALTER TABLE [dbo].[role]
    ADD CONSTRAINT [fk_role_role_type_code] FOREIGN KEY ([role_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_role_role_type_code] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[role]([role_type_code] ASC);
GO
-- other constraints and indexes 
-- N/A
-- END