--sp_helpconstraint 'user_accounts'
--alter table dbo.account_details drop constraint FK_account_details_user_accounts
--alter table dbo.contact drop constraint  FK_contact_user_accounts
--alter table dbo.customer_dealer_mapping drop constraint  FK_customer_dealer_mapping_users_created
--alter table dbo.customer_dealer_mapping drop constraint  FK_customer_dealer_mapping_users_updated
--alter table dbo.user_grid_view_preference drop constraint  FK_user_grid_view_preference_user_accounts

 --drop table if exists [dbo].[user_accounts]
CREATE TABLE [dbo].[user_accounts]
(
-- pks for this table
    [user_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_accounts_id] DEFAULT (NEWID()) NOT NULL,
    [user_rid] INT IDENTITY (1, 1) NOT NULL,
-- important fks to other trx tables - these should be in almost every table (tenant_id is needed on almost all tables, including many-to-many tables)
    [tenant_id] UNIQUEIDENTIFIER CONSTRAINT [df_user_accounts_tenant_id] DEFAULT (NEWID()) NOT NULL,    
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_accounts_tenant_uuid] DEFAULT (NEWID()) NOT NULL, -- every table must have a tenant_uuid  
    [role_rid] INT CONSTRAINT [DF_user_accounts_role_rid] DEFAULT (1) NOT NULL,
    [object_id] NVARCHAR (50) NULL, -- the object_id in user_accounts is the Entra ID object ID for the user
-- attributes of this entity -- avoid using the table_name as a prefix in the column_name (so just "name" instead of "asset_name")
    [user_name] NVARCHAR (200) NULL,
    [first_name] NVARCHAR (50) CONSTRAINT [df_user_accounts_first_name] DEFAULT ('Tracking') NOT NULL,
    [last_name] NVARCHAR (50) CONSTRAINT [df_user_accounts_last_name] DEFAULT ('User') NOT NULL,
    [email_address] NVARCHAR (50) NOT NULL,
    [phone_number] NVARCHAR (50) NULL,
    [phone_extension] INT NULL,
    [title] NVARCHAR (200) NULL,
    [landing_page] NVARCHAR (55) CONSTRAINT [df_user_accounts_landing_page] DEFAULT ('DEFAULT') NOT NULL,
-- lookup code fks:  most foreign keys that reference lookup_code suffixed with "_code"
    -- suffix "_code" if character data, suffix "_id" if numeric or uuid.  corresponds to the code in lookup_table 
    [account_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_account_type_code] DEFAULT ('ACT_CUSTOMER') NOT NULL,   
    [speed_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_speed_type_code] DEFAULT ('SPT_MPH') NOT NULL,
    [language_code] VARCHAR (30) CONSTRAINT [df_user_accounts_language_code] DEFAULT ('ENUS') NOT NULL,
    [temperature_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_temperature_type_code] DEFAULT ('TMP_FAHRENHEIT') NOT NULL,
    [fuel_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_fuel_type_code] DEFAULT ('FLT_U_S_GALLONS') NOT NULL,
    [timezone_code] VARCHAR (30) CONSTRAINT [df_user_accounts_timezone_code] DEFAULT ('TMZ_AMERICA_CHICAGO') NOT NULL,
    [theme_code] VARCHAR (30) CONSTRAINT [df_user_accounts_theme_code] DEFAULT ('THM_LIGHT') NOT NULL,
    [tour_status_code] VARCHAR (30) CONSTRAINT [df_user_accounts_tour_status_code] DEFAULT (0) NOT NULL,
    [onboarding_status_code] VARCHAR (30) CONSTRAINT [df_user_accounts_onboarding_status_code] DEFAULT (1) NOT NULL,
    [phone_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_phone_type_code] DEFAULT ('PHT_MOBILE') NOT NULL,
    --select * from lookup_code where lookup_list_code like '%phone%type%'
    [status_code] VARCHAR (30) CONSTRAINT [df_user_accounts_status_code] DEFAULT ('USR_ACTIVE') NOT NULL,
-- flags: all bit flags prefixed by "is_"
    [active] BIT CONSTRAINT [df_user_accounts_active] DEFAULT (1) NOT NULL,
    [migrated_data] BIT CONSTRAINT [df_user_accounts_migrated_data] DEFAULT (0) NOT NULL,
-- dates: all dates suffixed by "_date"
    [created] DATETIME CONSTRAINT [df_user_accounts_created] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME CONSTRAINT [df_user_accounts_updated] DEFAULT (getdate()) NOT NULL,
    [activated_date] DATETIME NULL, 
    [expiration_date] DATETIME NULL,
-- change_log
    -- user tracking fields suffix with "_by" with a UUID that references user_accounts
    -- user_accounts, the object_id in user_accounts is the Entra ID object ID for the user
    [created_by] INT NULL,
-- notes
    [notes] NVARCHAR (1000) NULL,
-- test data columns - will be deprecated?
    --todo 
-- columns that might be deprecated
   --todo 
);
GO

-- constraints and indexes:  all constraints and indexes must be explicitly named
-- naming convention:
-- <constraint_type> _ <table_name> _ <column_name>
-- examples:
--pk_asset_id
--fk_asset_asset_type_code
--ux_asset_vin_number
--ix_asset_is_active


-- PKs and indexes - for now, the pk will be the rid.  need to test performance before changing it to the uuid
-- For the mapping tables (valid many-to-many tables, for example asset_group_mapping), the primary key should be a composite key of the two ids that 
ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [cix_user_rid] PRIMARY KEY CLUSTERED ([user_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[user_accounts]
ADD CONSTRAINT uk_user_uuid UNIQUE ([user_uuid]);
GO
-- FKs and indexes:  anything that is a reference must have a FK constraint 
 

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_role] FOREIGN KEY ([role_rid]) REFERENCES [dbo].[role] ([role_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_role] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[user_accounts]([role_rid] ASC);
GO
 
 
-- -- FKs and indexes - lookup_code: anything that is a reference must have a FK constraint 
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
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accounts_nboarding_status_code] FOREIGN KEY ([onboarding_status_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_nboarding_status_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([onboarding_status_code] ASC); 
 --   [phone_type_code] VARCHAR (30) CONSTRAINT [df_user_accounts_phone_type_code] DEFAULT ('PHT_MOBILE') NOT NULL,
GO
ALTER TABLE [dbo].[user_accounts] ADD CONSTRAINT [fk_user_accountsphone_type_code] FOREIGN KEY ([phone_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_user_accounts_phone_type_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[user_accounts]([phone_type_code] ASC); 
 GO

-- -- unique constraints and indexes
-- ALTER TABLE dbo.[user_accounts]
-- ADD CONSTRAINT uk_user_accounts_example UNIQUE ([example_unique_constraint_col]);
-- GO
-- -- check constraints and indexes
-- ALTER TABLE [user_accounts]
-- ADD CONSTRAINT ck_user_accounts_Status
-- CHECK ([example_check_constraint_col] IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'));
-- GO
-- -- Other indexes
CREATE NONCLUSTERED INDEX [ix_user_accounts_tenant_id_status_code]
    ON [dbo].[user_accounts]([tenant_id] ASC, [status_code] ASC);
GO

-- extended properties:  all tables and columns should have descriptions in extended properties
-- also listing the former name of the columns
-- extended properties: table
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'This table stores customer information.',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'user_accounts';
GO
-- extended properties: columns
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'Customer unique identifier',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'user_accounts',  
    @level2type = N'COLUMN',  @level2name = N'user_rid';
GO