/*

CREATE TABLE [dbo].[xxxx]
(
-- TODO REFACTOR TEMPLATE IS AS FOLLOWS:
-- ------------------------------------
-- pks and main uq columns
	-- UUID no default!
	-- TODO possibly remove identity prop on RID (or remove RID altogether)
-- fk columns - to tenant
-- main attribute columns of this entity 
-- fk columns - other main fks (todo check legacy DB for all existing fks)
-- fk columns - to lookup code (suffixed with "_code")
-- bit flag columns (prefixed with "is_")
-- date columns (suffixed with "_date")
-- fk columns - to user (uuids)
-- note columns
-- test data columns (only used for test data process on dev)
-- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

-- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
	-- UUID --> pk
	-- RID --> uk
-- fks - to tenant
-- fks - to user (todo - possibly remove these fks to user)
-- fks - other main fks
-- fks - to lookup code
-- other constraints and indexes 
-- extended properties: table
-- extended properties: columns
-- ------------------------------------
-- TODO make sure to format before committing (Shift + Alt + F)
-- END


*/



CREATE TABLE [dbo].[dealer]
(
-- ------------------------------------
-- pks and main uq columns
    [dealer_uuid] UNIQUEIDENTIFIER NOT NULL,
    [dealer_rid] INT IDENTITY (1, 1) NOT NULL,
    [dealer_code] VARCHAR (50) NULL,
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
-- fk columns - other main fks
    [dealer_family_uuid] UNIQUEIDENTIFIER NULL, -- TODO join to dealer_family
-- fk columns - to lookup code
  --  [dealer_type_code] VARCHAR (30) CONSTRAINT [df_dealer_dealer_type_code] DEFAULT ('ROL_BASIC')  NULL,
-- bit flag columns
    [is_active] BIT CONSTRAINT [df_dealer_is_active] DEFAULT (1) NOT NULL,
    [is_blue_track_dealer] BIT NULL,
-- date columns
    [created_date] DATETIME CONSTRAINT [df_dealer_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
-- fk columns - to user
    [created_by_user_uuid] UNIQUEIDENTIFIER NULL,
    [updated_by_user_uuid] UNIQUEIDENTIFIER NULL,
-- note columns
    [notes] NVARCHAR (1000) NULL
-- test data columns (only used for test data process on dev)
-- columns to be deprecated

-- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[dealer]
    ADD CONSTRAINT [cix_dealer_uuid] PRIMARY KEY CLUSTERED ([dealer_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[dealer]
ADD CONSTRAINT uk_dealer_rid UNIQUE ([dealer_rid]);
GO
-- fks - to tenant
ALTER TABLE [dbo].[dealer] ADD CONSTRAINT [fk_dealer_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[account_details] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_tenant_uuid] 
  ON [dbo].[dealer]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[dealer]
    ADD CONSTRAINT [fk_dealer_created_by_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_created_by_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[dealer]([created_by_user_uuid] ASC);
GO

ALTER TABLE [dbo].[dealer]
    ADD CONSTRAINT [fk_dealer_updated_by_user_uuid] FOREIGN KEY ([updated_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_updated_by_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[dealer]([updated_by_user_uuid] ASC);
GO

-- fks - other main fks

ALTER TABLE [dbo].[dealer]
    ADD CONSTRAINT [fk_dealer_dealer_family_uuid] FOREIGN KEY ([dealer_family_uuid]) REFERENCES [dbo].[dealer_family] ([dealer_family_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_dealer_dealer_family_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[dealer]([dealer_family_uuid] ASC);
GO
-- fks - to lookup code

 
-- other constraints and indexes 
-- N/A
-- END