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
  [created_by_user_uuid] UNIQUEIDENTIFIER NULL,
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
ALTER TABLE [dbo].[locations_common] ADD CONSTRAINT [fk_location_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_location_tenant_uuid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[locations_common]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[locations_common]
    ADD CONSTRAINT [fk_location_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_location_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[locations_common]([created_by_user_uuid] ASC);
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

