/*
-- drop table if exists [dbo].[TABLENAME];
drop table if exists [dbo].[TABLENAME];
CREATE TABLE [dbo].[TABLENAME]
( -- TODO REFACTOR TEMPLATE IS AS FOLLOWS:
    -- ------------------------------------
    -- pks and main uq columns
    [TABLENAME_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_TABLENAME_TABLENAME_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [TABLENAME_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
    [language_code] VARCHAR (30) CONSTRAINT [df_TABLENAME_language_code] DEFAULT ('LNG_ENUS') NOT NULL,
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_TABLENAME_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_TABLENAME_created_date] DEFAULT (getdate()) NOT NULL,
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
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [pk_TABLENAME_tenant_uuid_TABLENAME_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [TABLENAME_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [uk_TABLENAME_uuid] UNIQUE NONCLUSTERED ([TABLENAME_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [uk_TABLENAME_rid] UNIQUE ([TABLENAME_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [fk_TABLENAME_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].tenant_ref  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_tenant_uuid] 
  ON [dbo].[TABLENAME]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[TABLENAME]
    ADD CONSTRAINT [fk_TABLENAME_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_ref ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_created_by_user_rid] 
    ON [dbo].[TABLENAME]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[TABLENAME]
    ADD CONSTRAINT [fk_TABLENAME_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_ref ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_updated_by_user_rid] 

    ON [dbo].[TABLENAME]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [fk_TABLENAME_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_language_code] 
  ON [dbo].[TABLENAME]([language_code] ASC); 
  GO
-- other constraints and indexes 
-- N/A
-- END

  

 */




CREATE TABLE [dbo].[locations_common]
( -- TODO combine locations_common and geo_fence into one main locations table?  with a location_type or maybe a parent_id and parent_type (like 'dealer" would be a parent_type and the location_type would be the dealer_locaiont?)
  -- ------------------------------------
  -- pks and main uq columns
  [location_uuid] UNIQUEIDENTIFIER NOT NULL,
  [location_rid] INT IDENTITY (1, 1) NOT NULL,
  -- fk columns - to tenant
  [tenant_uuid] UNIQUEIDENTIFIER NOT NULL,
  -- main attribute columns of this entity 
  [address_1] [nvarchar](100) NOT NULL,
  [address_2] [nvarchar](100) NULL,
  [address_3] [nvarchar](1) NULL,
  [city] [nvarchar](50) NOT NULL,
  [zip_code] [nvarchar](50) NULL,
  [country] [nvarchar](50) NOT NULL,
  [longitude] [float] NOT NULL,
  [latitude] [float] NOT NULL,
  [calculated_longitude_in_radians] [float] NOT NULL,
  [calculated_latitude_in_radians] [float] NOT NULL,
  -- fk columns - other main fks
  [dealer_uuid] UNIQUEIDENTIFIER NULL,
  -- fk columns - to lookup code
  -- bit flag columns
  -- date columns
  [created_date] DATETIME CONSTRAINT [df_location_created_date] DEFAULT (getdate()) NOT NULL,
  [updated_date] DATETIME CONSTRAINT [df_location_updated_date] DEFAULT (getdate()) NOT NULL,
  -- fk columns - to user
  [created_by_user_rid] UNIQUEIDENTIFIER NULL,
  -- note columns
  [notes] NVARCHAR (1000) NULL,
  -- test data columns (only used for test data process on dev)
  -- columns to be deprecated
  [phone_number] [float] NULL,
  [phone_number_2] [nvarchar](1) NULL,
  [fax_number] [float] NULL,
  [opening_hours] [nvarchar](50) NULL,
  [key_name] [nvarchar](100) NOT NULL,
  [image_rid] [int] NOT NULL,
  [system_function_rid] [int] NULL,
  [name] [nvarchar](100) NOT NULL
  -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[locations_common]
    ADD CONSTRAINT [cix_location_uuid] PRIMARY KEY CLUSTERED ([location_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[locations_common]
ADD CONSTRAINT uk_location_rid UNIQUE ([location_rid]);
GO
-- fks - to tenant
-- todo change all tenant fks to account_details?
ALTER TABLE [dbo].[locations_common] ADD CONSTRAINT [fk_location_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[account_details] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_location_tenant_uuid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[locations_common]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[locations_common]
    ADD CONSTRAINT [fk_location_user_uuid] FOREIGN KEY ([created_by_user_rid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_location_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[locations_common]([created_by_user_rid] ASC);
GO
-- fks - other main fks
ALTER TABLE [dbo].[locations_common]
    ADD CONSTRAINT [fk_locations_common_dealer_uuid] FOREIGN KEY ([dealer_uuid]) REFERENCES [dbo].[dealer] ([dealer_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_locations_common_dealer_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[locations_common]([dealer_uuid] ASC);
GO

-- fks - to lookup code
-- other constraints and indexes 
-- extended properties: table
-- extended properties: columns
-- ------------------------------------
-- END

