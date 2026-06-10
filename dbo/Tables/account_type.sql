-- drop table if exists [dbo].[account_type];
--drop table if exists [dbo].[account_type];
CREATE TABLE [dbo].[account_type]
(  
    -- ------------------------------------
    -- pks and main uq columns
    [account_type_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_type_account_type_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [account_type_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
   -- [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
  [description] [nvarchar](50) NOT NULL,
  [service_level_filter] [bit] NULL,
  [service_level_code] VARCHAR(30) NULL,
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
       -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_account_type_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_account_type_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    [updated_by_user_rid] BIGINT NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
    [status] [bit] NOT NULL,
-- TODO make sure to format before committing (Shift + Alt + F)

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[account_type] ADD CONSTRAINT [pk_account_type_tenant_uuid_account_type_rid] PRIMARY KEY CLUSTERED (  [account_type_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[account_type] ADD CONSTRAINT [uk_account_type_uuid] UNIQUE NONCLUSTERED ([account_type_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[account_type] ADD CONSTRAINT [uk_account_type_rid] UNIQUE ([account_type_rid]);
GO


-- fks - to tenant
-- ALTER TABLE [dbo].[account_type] ADD CONSTRAINT [fk_account_type_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
-- /* On Fleet, should reference tenant_ref, on Account should reference account_details */
-- REFERENCES [dbo].tenant_ref  ([tenant_uuid]); 
--  GO
-- CREATE NONCLUSTERED INDEX [ix_fk_account_type_tenant_uuid] 
--   ON [dbo].[account_type]([tenant_uuid] ASC); 
--   GO
-- fks - to user
ALTER TABLE [dbo].[account_type]
    ADD CONSTRAINT [fk_account_type_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_type_created_by_user_rid] 
    ON [dbo].[account_type]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[account_type]
    ADD CONSTRAINT [fk_account_type_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_type_updated_by_user_rid] 

    ON [dbo].[account_type]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END

 