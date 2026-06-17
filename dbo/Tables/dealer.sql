-- drop table if exists [dbo].[dealer];
--drop table if exists [dbo].[dealer];
CREATE TABLE [dbo].[dealer]
(  
    -- ------------------------------------
    -- pks and main uq columns
    [dealer_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_dealer_dealer_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [dealer_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    [dealer_code] VARCHAR (50) NULL, -- todo what is this?
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    [name] VARCHAR (50) NULL,
    [address] VARCHAR (300) NULL,
    [phone_number] VARCHAR (50) NULL,
    [email_address] VARCHAR (50) NULL,
    [zip_code] VARCHAR (10) NULL,
    [oracle_id] INT NULL,
    [party_site_id_code] INT NULL,
    [atlas_terr_id_code] VARCHAR (50) NULL,
    [atlas_terr_name] VARCHAR (50) NULL,
    [atlas_terr_id] INT NULL,
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    [dealer_family_rid] BIGINT NULL, 
    -- fk columns - to lookup code (suffixed with "_code")
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_dealer_is_active] DEFAULT (1) NOT NULL,
    [is_blue_track_dealer] BIT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_dealer_created_date] DEFAULT (getdate()) NOT NULL,
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
ALTER TABLE [dbo].[dealer] ADD CONSTRAINT [pk_dealer_tenant_uuid_dealer_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [dealer_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[dealer] ADD CONSTRAINT [uk_dealer_uuid] UNIQUE NONCLUSTERED ([dealer_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[dealer] ADD CONSTRAINT [uk_dealer_rid] UNIQUE ([dealer_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[dealer] ADD CONSTRAINT [fk_dealer_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_tenant_uuid] 
  ON [dbo].[dealer]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[dealer]
    ADD CONSTRAINT [fk_dealer_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_created_by_user_rid] 
    ON [dbo].[dealer]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[dealer]
    ADD CONSTRAINT [fk_dealer_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_updated_by_user_rid] 

    ON [dbo].[dealer]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
ALTER TABLE [dbo].[dealer]
    ADD CONSTRAINT [fk_dealer_dealer_family_rid] FOREIGN KEY ([dealer_family_rid]) REFERENCES [dbo].[dealer_family] ([dealer_family_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_dealer_family_rid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[dealer]([dealer_family_rid] ASC);
GO
 
-- fks - to lookup code
-- other constraints and indexes 
-- N/A
-- END

  

 


