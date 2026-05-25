CREATE TABLE [dbo].[account_details]
(
-- ------------------------------------
-- pks and main uq columns
    [account_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_details_id] DEFAULT (NEWID()) NOT NULL,
    [account_rid] INT IDENTITY (1, 1) NOT NULL,
-- fk columns - to tenant
    [tenant_id] UNIQUEIDENTIFIER CONSTRAINT [df_account_details_tenant_id] DEFAULT (NEWID()) NOT NULL,    
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_details_tenant_uuid] DEFAULT (NEWID()) NOT NULL, 
-- main attribute columns of this entity
    [organization]           NVARCHAR (100) NOT NULL,
    [company_address]        NVARCHAR (200) NULL,
    [additional_address]     NVARCHAR (200) NULL,
    [zip_code]               NVARCHAR (50)  NULL,
    [phone_number]           NVARCHAR (50)  NULL,
    [fax_number]             NVARCHAR (50)  NULL,
    [email]                  NVARCHAR (50)  NULL,
    [company_website]        NVARCHAR (200) NULL,
    [support_contact_number] NVARCHAR (50)  NULL,
    [city]                   NVARCHAR (50)  NULL,
    [state]                  NVARCHAR (50)  NULL,
    [phone_extension]        INT            NULL,
    [country]                NVARCHAR (50)  NULL, 
-- fk columns - other main fks
    [dealer_rid] INT NULL, -- TODO came from customer_dealer_mapping 
    [dealer_uuid] UNIQUEIDENTIFIER NULL, -- TODO came from customer_dealer_mapping  
        -- customer_rid and dealer_rid were both ints in account_details.  In most cases a customer only has one device.  There was some bad data on Dev resulting in a few dupes.
-- fk columns - to lookup code
    [account_type_code]     VARCHAR (30) CONSTRAINT [df_account_details_type_code] DEFAULT ('ACT_CUSTOMER') NOT NULL,
     [phone_type_code] VARCHAR(30)    NULL,
-- bit flag columns
    [is_active] BIT CONSTRAINT [df_account_details_is_active] DEFAULT (1) NOT NULL,
    [is_door_sensor_1] BIT NULL,
    [is_door_sensor_2] BIT NULL,
    [is_door_sensor_3] BIT NULL,
-- date columns    
    [created_date] DATETIME CONSTRAINT [df_account_details_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    [activated_date] DATETIME NULL,
-- fk columns - to user
    [admin_user_rid]     UNIQUEIDENTIFIER CONSTRAINT [df_account_details_created_by_user_rid] DEFAULT (1) NOT NULL,
-- note columns
    [notes] NVARCHAR (1000) NULL,
-- test data columns (only used for test data process on dev)
    [test_data_group] int null, 
-- columns to be deprecated
    [active] BIT NOT NULL,
    [created] DATETIME CONSTRAINT [df_account_details_created] DEFAULT (getdate()) NOT NULL,
     [migrated_data] BIT CONSTRAINT [df_account_details_migrated_data] DEFAULT (0) NOT NULL 

-- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [cix_account_details_rid] PRIMARY KEY CLUSTERED ([account_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[account_details]
ADD CONSTRAINT uk_account_details_uuid UNIQUE ([account_uuid]);
GO
-- fks - to tenant
 ALTER TABLE [dbo].[account_details] ADD CONSTRAINT [fk_account_details_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_account_details_tenant_uuid] 
  ON [dbo].[account_details]([tenant_uuid] ASC); 
  GO
 ALTER TABLE [dbo].[account_details] ADD CONSTRAINT [fk_account_details_tenant_id] FOREIGN KEY ([tenant_id]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_account_details_tenant_id] 
  ON [dbo].[account_details]([tenant_id] ASC); 
  GO

-- fks - to user
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_admin_user_rid] FOREIGN KEY ([admin_user_rid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_details_admin_user_rid]
    ON [dbo].[account_details]([admin_user_rid] ASC);
GO  
-- fks - other main fks
-- fks - to lookup code
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_account_details_type] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_details_account_details_type] 
    ON [dbo].[account_details]([account_type_code] ASC);
GO
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_phone_type_code] FOREIGN KEY ([phone_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_details_phone_type_code] 
    ON [dbo].[account_details]([phone_type_code] ASC);
GO
-- other constraints and indexes 
-- extended properties: table
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'This table stores customer information.',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'account_details';
GO
-- extended properties: columns
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'Customer unique identifier',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'account_details',  
    @level2type = N'COLUMN',  @level2name = N'account_rid';
GO
-- ------------------------------------