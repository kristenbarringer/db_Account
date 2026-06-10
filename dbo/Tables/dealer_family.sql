-- drop table if exists [dbo].[dealer_family];
--drop table if exists [dbo].[dealer_family];
CREATE TABLE [dbo].[dealer_family]
(  
    -- ------------------------------------
    -- pks and main uq columns
    [dealer_family_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_dealer_family_dealer_family_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [dealer_family_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    [name] varchar(300) NULL,
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_dealer_family_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_dealer_family_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    [updated_by_user_rid] BIGINT NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[dealer_family] ADD CONSTRAINT [pk_dealer_family_tenant_uuid_dealer_family_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [dealer_family_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[dealer_family] ADD CONSTRAINT [uk_dealer_family_uuid] UNIQUE NONCLUSTERED ([dealer_family_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[dealer_family] ADD CONSTRAINT [uk_dealer_family_rid] UNIQUE ([dealer_family_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[dealer_family] ADD CONSTRAINT [fk_dealer_family_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_family_tenant_uuid] 
  ON [dbo].[dealer_family]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[dealer_family]
    ADD CONSTRAINT [fk_dealer_family_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_family_created_by_user_rid] 
    ON [dbo].[dealer_family]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[dealer_family]
    ADD CONSTRAINT [fk_dealer_family_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_family_updated_by_user_rid] 

    ON [dbo].[dealer_family]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END

  

