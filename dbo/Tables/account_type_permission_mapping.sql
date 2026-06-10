-- drop table if exists [dbo].[account_type_permission_mapping];
--drop table if exists [dbo].[account_type_permission_mapping];
CREATE TABLE [dbo].[account_type_permission_mapping]
( 
    -- ------------------------------------
    -- pks and main uq columns
    [account_type_permission_mapping_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_type_permission_mapping_account_type_permission_mapping_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [account_type_permission_mapping_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
   -- [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    [account_type_rid] BIGINT NULL ,
    [role_rid]        INT           NOT NULL,
    [permission_code] VARCHAR (100) NULL,
    -- fk columns - to lookup code (suffixed with "_code")
    --[lookup_code] VARCHAR (30) CONSTRAINT [df_account_type_permission_mapping_language_code] DEFAULT ('LNG_ENUS') NOT NULL,
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_account_type_permission_mapping_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_account_type_permission_mapping_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    [updated_by_user_rid] BIGINT NULL,
    -- note columns
    --[notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[account_type_permission_mapping] ADD CONSTRAINT [pk_account_type_permission_mapping_rid] PRIMARY KEY CLUSTERED ([account_type_permission_mapping_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[account_type_permission_mapping] ADD CONSTRAINT [uk_account_type_permission_mapping_uuid] UNIQUE NONCLUSTERED ([account_type_permission_mapping_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[account_type_permission_mapping] ADD CONSTRAINT [uk_account_type_permission_mapping_rid] UNIQUE ([account_type_permission_mapping_rid]);
GO


-- fks - to tenant
-- ALTER TABLE [dbo].[account_type_permission_mapping] ADD CONSTRAINT [fk_account_type_permission_mapping_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
-- /* On Fleet, should reference tenant_ref, on Account should reference account_details */
-- REFERENCES [dbo].account_details  ([tenant_uuid]); 
--  GO
-- CREATE NONCLUSTERED INDEX [ix_fk_account_type_permission_mapping_tenant_uuid] 
--   ON [dbo].[account_type_permission_mapping]([tenant_uuid] ASC); 
--   GO
-- fks - to user
ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [fk_account_type_permission_mapping_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_type_permission_mapping_created_by_user_rid] 
    ON [dbo].[account_type_permission_mapping]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [fk_account_type_permission_mapping_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_type_permission_mapping_updated_by_user_rid] 

    ON [dbo].[account_type_permission_mapping]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END
    