-- drop table if exists [dbo].[contact];

CREATE TABLE [dbo].[contact]
( -- REFACTOR DONE as of 6/7/2026
    -- ------------------------------------
    -- pks and main uq columns
    [contact_uuid] UNIQUEIDENTIFIER NOT NULL,
    [contact_rid] INT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    [first_name] NVARCHAR (100) NULL,
    [last_name] NVARCHAR (100) NULL,
    [email_id] NVARCHAR (60) NULL,
    [mobile_number] NVARCHAR (20) NULL,
    -- fk columns - other main fks
    -- fk columns - to lookup code
    [language_code] VARCHAR (30) CONSTRAINT [df_contact_language_code] DEFAULT ('LNG_ENUS') NOT NULL,
    [timezone_code] VARCHAR (30) CONSTRAINT [df_contact_timezone_code] DEFAULT ('TMZ_AMERICA_DETROIT') NOT NULL,
    [speed_type_code] VARCHAR (30) CONSTRAINT [df_contact_speed_type_code] DEFAULT ('SPT_MPH') NOT NULL,
    [temperature_type_code] VARCHAR (30) CONSTRAINT [df_contact_temperature_type_code] DEFAULT ('TMP_FAHRENHEIT') NOT NULL,
    [fuel_type_code] VARCHAR (30) CONSTRAINT [df_contact_fuel_type_code] DEFAULT ('FLT_U_S_GALLONS') NOT NULL,
    -- bit flag columns        
    [is_active] BIT CONSTRAINT [df_contact_is_active] DEFAULT (1) NOT NULL,
    [is_email] BIT CONSTRAINT [df_contact_is_email] DEFAULT (0) NOT NULL,
    [is_SMS] BIT CONSTRAINT [df_contact_is_SMS] DEFAULT (0) NOT NULL,
    [is_inapp] BIT CONSTRAINT [df_contact_is_inapp] DEFAULT (0) NOT NULL,
    -- date columns
    [created_date] DATETIME CONSTRAINT [df_contact_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_uuid] UNIQUEIDENTIFIER NULL,-- TODO 6/10 - make NULLABLE ON ALL TABLES
    [updated_by_user_uuid] UNIQUEIDENTIFIER NULL, -- TODO 6/10 - make NULLABLE ON ALL TABLES  -- TODO add this to all tables
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
    [active] BIT CONSTRAINT [df_contact_active] DEFAULT (1) NULL, -- TODO make all deprecated columns are nullable
    [created] DATETIME CONSTRAINT [df_contact_created] DEFAULT (getdate()) NULL,
    [created_by] UNIQUEIDENTIFIER NULL,

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [cix_contact_uuid] PRIMARY KEY CLUSTERED ([contact_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[contact]
ADD CONSTRAINT uk_contact_rid UNIQUE ([contact_rid]);
GO
-- fks - to tenant
ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[account_details] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_tenant_uuid] 
  ON [dbo].[contact]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [fk_contact_created_by_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_created_by_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[contact]([created_by_user_uuid] ASC);
GO
ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [fk_contact_updated_by_user_uuid] FOREIGN KEY ([updated_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_updated_by_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[contact]([updated_by_user_uuid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code
ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_language_code] 
  ON [dbo].[contact]([language_code] ASC); 
  GO
--[timezone_code] VARCHAR (30) CONSTRAINT [df_contact_timezone_code] DEFAULT ('TMZ_AMERICA_DETROIT') NOT NULL,
ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_timezone_code] FOREIGN KEY ([timezone_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_timezone_code] 
  ON [dbo].[contact]([timezone_code] ASC); 
  GO
--[speed_type_code] VARCHAR (30) CONSTRAINT [df_contact_speed_type_code] DEFAULT ('SPT_MPH') NOT NULL,
ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_speed_type_code] FOREIGN KEY ([speed_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_speed_type_code] 
  ON [dbo].[contact]([speed_type_code] ASC); 
  GO
--[temperature_type_code] VARCHAR (30) CONSTRAINT [df_contact_temperature_type_code] DEFAULT ('TMP_FAHRENHEIT') NOT NULL,
ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_temperature_type_code] FOREIGN KEY ([temperature_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_temperature_type_code] 
  ON [dbo].[contact]([temperature_type_code] ASC); 
  GO
--[fuel_type_code] VARCHAR (30) CONSTRAINT [df_contact_fuel_type_code] DEFAULT ('FLT_U_S_GALLONS') NOT NULL,
ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_fuel_type_code] FOREIGN KEY ([fuel_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_fuel_type_code] 
  ON [dbo].[contact]([fuel_type_code] ASC); 
  GO
-- other constraints and indexes 
-- N/A
-- END

  

 