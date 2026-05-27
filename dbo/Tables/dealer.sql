CREATE TABLE [dbo].[dealer]
(
-- ------------------------------------
-- pks and main uq columns
    [dealer_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_dealer_id] DEFAULT (NEWID()) NOT NULL,
    [dealer_rid] INT IDENTITY (1, 1) NOT NULL,
-- fk columns - to tenant
-- main attribute columns of this entity 
    [name] VARCHAR (50) NULL,
    [address] VARCHAR (50) NULL,
    [phone_number] VARCHAR (50) NULL,
    [email_address] VARCHAR (50) NULL,
    [zip_code] VARCHAR (10) NULL,
    [oracle_id] INT NULL,
    [party_site_id_code ] INT NULL,
    [atlas_terr_id_code] VARCHAR (50) NULL,
    [atlas_terr_name] VARCHAR (50) NULL,
    [atlas_terr_id] INT NULL,
-- fk columns - other main fks
-- fk columns - to lookup code
    [dealer_type_code] VARCHAR (30) CONSTRAINT [df_dealer_dealer_type_code] DEFAULT ('ROL_BASIC') NOT NULL,
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
    ADD CONSTRAINT [cix_dealer_rid] PRIMARY KEY CLUSTERED ([dealer_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[dealer]
ADD CONSTRAINT uk_dealer_uuid UNIQUE ([dealer_uuid]);
GO
-- fks - to tenant
-- fks - to user
-- fks - other main fks
-- fks - to lookup code
-- other constraints and indexes 
-- extended properties: table
-- extended properties: columns
-- ------------------------------------
-- END

