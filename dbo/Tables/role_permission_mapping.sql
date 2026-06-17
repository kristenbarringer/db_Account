
CREATE TABLE [dbo].[role_permission_mapping]
(  -- TRULY a MANY-TO-MANY Table - 6/12
    -- ------------------------------------
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
-- pks and main uq indexes - MANY-TO-MANY tables should have a PK of the 2 tables that are joined
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [pk_role_permission_mapping_permission_code_role_rid] 
PRIMARY KEY CLUSTERED ([permission_code] ASC, [role_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO



-- fks - to user
ALTER TABLE [dbo].[role_permission_mapping]
    ADD CONSTRAINT [fk_role_permission_mapping_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_created_by_user_rid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[role_permission_mapping]([created_by_user_rid] ASC);
GO
-- fks - other main fks
-- todo do we need a permissions table?
ALTER TABLE [dbo].[role_permission_mapping] ADD CONSTRAINT [fk_role_permission_mapping_user_rid] FOREIGN KEY ([role_rid]) REFERENCES [dbo].role ([role_rid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_role_permission_mapping_user_rid] 
  ON [dbo].[role_permission_mapping]([role_rid] ASC); 
  GO
-- fks - to lookup code
-- other constraints and indexes 
-- N/A
-- END
 