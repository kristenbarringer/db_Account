CREATE TABLE [dbo].[account_details]
( -- REFACTOR DONE as of 6/7/2026
    -- ------------------------------------
    -- pks and main uq columns
    [tenant_uuid] UNIQUEIDENTIFIER NOT NULL,
    [customer_rid] INT IDENTITY (1, 1) NOT NULL,
    -- main attribute columns of this entity
    [organization] NVARCHAR (100) NOT NULL,
    [company_address] NVARCHAR (200) NULL,
    [additional_address] NVARCHAR (200) NULL,
    [zip_code] NVARCHAR (50) NULL,
    [phone_number] NVARCHAR (50) NULL,
    [fax_number] NVARCHAR (50) NULL,
    [email] NVARCHAR (50) NULL,
    [company_website] NVARCHAR (200) NULL,
    [support_contact_number] NVARCHAR (50) NULL,
    [city] NVARCHAR (50) NULL,
    [state] NVARCHAR (50) NULL,
    [phone_extension] INT NULL,
    [country] NVARCHAR (50) NULL,
    -- fk columns - other main fks    
    /*
        The CSM-->Dealer-->Customer hierarchy goes from:
            v1                              v2
                CSM (tk_service_manager)        All three stored in account_details?
                    |
                    V
                Dealer (tk_dealer)
                    |
                    V
                Customer (tk_customer)
    */
    [dealer_uuid] UNIQUEIDENTIFIER NULL,-- TODO came from customer_dealer_mapping 
    [dealer_rid] INT NULL,-- TODO came from customer_dealer_mapping 
    [csm_uuid] UNIQUEIDENTIFIER NULL, -- TODO do we need this?  This is for tk_Admin and tk_Master (formerly known as celtrak_service_manager, a.k.a. "CSM")
    [csm_rid] INT NULL, -- TODO do we need this?  This is for tk_Admin and tk_Master (formerly known as celtrak_service_manager, a.k.a. "CSM")
    -- TODO came from customer_dealer_mapping  
    -- customer_rid and dealer_rid were both ints in account_details.  In most cases a customer only has one device.  There was some bad data on Dev resulting in a few dupes.
    -- fk columns - to lookup code
    [account_type_code] VARCHAR (30) CONSTRAINT [df_account_details_type_code] DEFAULT ('ACT_CUSTOMER') NOT NULL,
    [phone_type_code] VARCHAR(30) NULL,
    [default_role_code] VARCHAR (30) CONSTRAINT [df_account_default_role_code] DEFAULT ('ROL_BASIC') NOT NULL,
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
    [admin_user_rid] UNIQUEIDENTIFIER NOT NULL,
    [created_by_user_uuid] UNIQUEIDENTIFIER NULL,
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
    ADD CONSTRAINT [cix_account_details_tenant_uuid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[account_details]
ADD CONSTRAINT uk_account_details_customer_rid UNIQUE ([customer_rid]);
GO
-- -- fks - to tenant -- TODO no FK needed.  account = customer = tenant.  (TODO - tenantinfo is only used for migration.  account_details is the source)
-- ALTER TABLE [dbo].[account_details] ADD CONSTRAINT [fk_account_details_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
--  GO
-- CREATE NONCLUSTERED INDEX [ix_fk_account_details_tenant_uuid] 
--   ON [dbo].[account_details]([tenant_uuid] ASC); 
--   GO

-- fks - to user
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_admin_user_rid] FOREIGN KEY ([admin_user_rid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_details_admin_user_rid]
    ON [dbo].[account_details]([admin_user_rid] ASC);
GO
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_created_by_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_details_created_by_user_uuid] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[account_details]([created_by_user_uuid] ASC);
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
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_default_role_code] FOREIGN KEY ([default_role_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_details_default_role_code] 
    ON [dbo].[account_details]([default_role_code] ASC);
GO
-- other constraints and indexes 
-- N/A
-- END