


 -- TODO combine locations_common and geo_fence into one main locations table?  with a location_type or maybe a parent_id and parent_type (like 'dealer" would be a parent_type and the location_type would be the dealer_locaiont?)
 
-- drop table if exists [dbo].[locations_common];
--drop table if exists [dbo].[locations_common];
CREATE TABLE [dbo].[locations_common]
(  
    -- ------------------------------------
    -- pks and main uq columns
    [locations_common_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_locations_common_locations_common_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [locations_common_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
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
  
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
      [dealer_rid] BIGINT NULL, -- todo join to dealer
    -- fk columns - to lookup code (suffixed with "_code")

    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_locations_common_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_locations_common_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    [updated_by_user_rid] BIGINT NULL,
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
-- TODO make sure to format before committing (Shift + Alt + F)

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[locations_common] ADD CONSTRAINT [pk_locations_common_tenant_uuid_locations_common_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [locations_common_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[locations_common] ADD CONSTRAINT [uk_locations_common_uuid] UNIQUE NONCLUSTERED ([locations_common_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[locations_common] ADD CONSTRAINT [uk_locations_common_rid] UNIQUE ([locations_common_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[locations_common] ADD CONSTRAINT [fk_locations_common_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_locations_common_tenant_uuid] 
  ON [dbo].[locations_common]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[locations_common]
    ADD CONSTRAINT [fk_locations_common_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_locations_common_created_by_user_rid] 
    ON [dbo].[locations_common]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[locations_common]
    ADD CONSTRAINT [fk_locations_common_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_locations_common_updated_by_user_rid] 

    ON [dbo].[locations_common]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END

  
 
 