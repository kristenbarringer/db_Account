CREATE TABLE [dbo].[user_accounts]
(
    -- ------------------------------------
    -- pks and main uq columns
    [user_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_accounts_id] DEFAULT (NEWID()) NOT NULL,
    [user_rid] INT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER NOT NULL,
    -- main attribute columns of this entity 
    [user_name] NVARCHAR (200) NULL,
    [first_name] NVARCHAR (50) CONSTRAINT [df_user_accounts_first_name] DEFAULT ('Tracking') NOT NULL,
    [last_name] NVARCHAR (50) CONSTRAINT [df_user_accounts_last_name] DEFAULT ('User') NOT NULL,
    [email_address] NVARCHAR (300) NOT NULL,
    [phone_number] NVARCHAR (50) NULL,
    [phone_extension] INT NULL,
    [title] NVARCHAR (200) NULL,
    [landing_page] NVARCHAR (55) CONSTRAINT [df_user_accounts_landing_page] DEFAULT ('DEFAULT') NOT NULL,
    [object_id] NVARCHAR (50) NULL,
    -- the object_id in user_accounts is the Entra ID object ID for the user 
    -- fk columns - other main fks
    [role_rid] INT CONSTRAINT [DF_user_accounts_role_rid] DEFAULT (1) NOT NULL,
    -- fk columns - to lookup code
    [account_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_account_type_code] DEFAULT ('ACT_CUSTOMER') NOT NULL,
    [speed_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_speed_type_code] DEFAULT ('SPT_MPH') NOT NULL,
    [language_code] VARCHAR (30) CONSTRAINT [df_user_accounts_language_code] DEFAULT ('ENUS') NOT NULL,
    [temperature_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_temperature_type_code] DEFAULT ('TMP_FAHRENHEIT') NOT NULL,
    [fuel_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_fuel_type_code] DEFAULT ('FLT_U_S_GALLONS') NOT NULL,
    [timezone_code] VARCHAR (30) CONSTRAINT [df_user_accounts_timezone_code] DEFAULT ('TMZ_AMERICA_CHICAGO') NOT NULL,
    [theme_code] VARCHAR (30) CONSTRAINT [df_user_accounts_theme_code] DEFAULT ('THM_LIGHT') NOT NULL,
    [tour_status_code] VARCHAR (30) CONSTRAINT [df_user_accounts_tour_status_code] DEFAULT ('TOR_0') NOT NULL,
    [phone_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_phone_type_code] DEFAULT ('PHT_MOBILE') NOT NULL,
    [status_code] VARCHAR (30) CONSTRAINT [df_user_accounts_status_code] DEFAULT ('USR_ACTIVE') NOT NULL,
    -- bit flag columns
    [is_active] BIT CONSTRAINT [df_user_accounts_is_active] DEFAULT (1) NOT NULL,
    [is_onboarded] BIT CONSTRAINT [df_user_accounts_is_onboarded] DEFAULT (1) NULL,
    [is_migrated_data] BIT CONSTRAINT [df_user_accounts_is_migrated_data] DEFAULT (0) NOT NULL,
    -- date columns
    [created_date] DATETIME CONSTRAINT [df_user_accounts_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME CONSTRAINT [df_user_accounts_updated_date] DEFAULT (getdate()) NOT NULL,
    [activated_date] DATETIME NULL,
    [expiration_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_uuid] UNIQUEIDENTIFIER NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    [test_data_group] int null,
    -- columns to be deprecated
    [active] BIT CONSTRAINT [df_user_accounts_active] DEFAULT (1) NOT NULL,
    [created] DATETIME CONSTRAINT [df_user_accounts_created] DEFAULT (getdate()) NOT NULL
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [cix_user_rid] PRIMARY KEY CLUSTERED ([user_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[user_accounts]
ADD CONSTRAINT uk_user_uuid UNIQUE ([user_uuid]);
GO
-- fks - to tenant
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_tenant_uuid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[user_accounts]([tenant_uuid] ASC); 
  GO
-- -- fks - to user
-- ALTER TABLE [dbo].[user_accounts]
--     ADD CONSTRAINT [fk_user_accounts_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
-- GO
-- CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_user_uuid] -- add explicit index for the FK column, to improve join performance
--     ON [dbo].[user_accounts]([created_by_user_uuid] ASC);
-- GO
-- fks - other main fks
ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_role] FOREIGN KEY ([role_rid]) REFERENCES [dbo].[role] ([role_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_role]
    ON [dbo].[user_accounts]([role_rid] ASC);
GO
-- fks - to lookup code
--   [[account_type_code]] VARCHAR (30) CONSTRAINT [df_user_accounts_account_type_code] DEFAULT ('ACT_CUSTOMER') NOT NULL,
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_account_type_code] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_account_type_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([account_type_code] ASC); 
GO
--   [speed_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_speed_type_code] DEFAULT ('SPT_MPH') NOT NULL,
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_speed_type_code] FOREIGN KEY ([speed_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_speed_type_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([speed_type_code] ASC); 
 --   [language_code] VARCHAR (30) CONSTRAINT [df_user_accounts_language_code] DEFAULT ('ENUS') NOT NULL,
GO
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_language_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([language_code] ASC); 
 --   [temperature_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_temperature_type_code] DEFAULT ('TMP_FAHRENHEIT') NOT NULL,
GO
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_temperature_type_code] FOREIGN KEY ([temperature_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_temperature_type_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([temperature_type_code] ASC); 
 --   [fuel_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_fuel_type_code] DEFAULT ('FLT_U_S_GALLONS') NOT NULL,
GO
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_fuel_type_code] FOREIGN KEY ([fuel_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_fuel_type_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([fuel_type_code] ASC); 
 --   [timezone_code] VARCHAR (30) CONSTRAINT [df_user_accounts_timezone_code] DEFAULT ('TMZ_AMERICA_CHICAGO') NOT NULL,
GO
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_timezone_code] FOREIGN KEY ([timezone_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_timezone_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([timezone_code] ASC); 
GO
--   [theme_code] VARCHAR (30) CONSTRAINT [df_user_accounts_theme_code] DEFAULT ('THM_LIGHT') NOT NULL,
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_theme_code] FOREIGN KEY ([theme_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_theme_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([theme_code] ASC); 
 --   [tour_status_code] VARCHAR (30) CONSTRAINT [df_user_accounts_tour_status_code] DEFAULT (0) NOT NULL,
GO
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_tour_status_code] FOREIGN KEY ([tour_status_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_tour_status_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([tour_status_code] ASC); 
 --   [onboarding_status_code] VARCHAR (30) CONSTRAINT [df_user_accounts_onboarding_status_code] DEFAULT (1) NOT NULL,
GO


ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accountsphone_type_code] FOREIGN KEY ([phone_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_phone_type_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([phone_type_code] ASC); 
 GO

ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_status_code] FOREIGN KEY ([status_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_status_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([status_code] ASC); 
 GO

-- other constraints and indexes 
CREATE NONCLUSTERED INDEX [ix_user_accounts_tenant_uuid_status_code]
    ON [dbo].[user_accounts]([tenant_uuid] ASC, [status_code] ASC);
GO
-- END
 