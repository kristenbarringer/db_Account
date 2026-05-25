--alter table account_details drop constraint if exists FK_account_details_user_accounts;
--alter table dbo.customer_dealer_mapping drop constraint if exists customer_dealer_mapping_account_details_customer_FK
--alter table dbo.customer_dealer_mapping drop constraint if exists customer_dealer_mapping_account_details_dealer_FK
--go
--sp_helpconstraint 'account_details'
--drop table if exists [dbo].[account_details]
CREATE TABLE [dbo].[account_details]
(
-- pks for this table
    [account_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_details_id] DEFAULT (NEWID()) NOT NULL,
    [account_rid] INT IDENTITY (1, 1) NOT NULL,
-- important fks to other trx tables - these should be in almost every table (tenant_id is needed on almost all tables, including many-to-many tables)
    [tenant_id] NVARCHAR (50) CONSTRAINT [df_account_details_tenant_id] DEFAULT (NEWID()) NOT NULL,    
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_account_details_tenant_uuid] DEFAULT (NEWID()) NOT NULL, -- every table must have a tenant_uuid  
    [dealer_rid] INT NULL, -- TODO came from customer_dealer_mapping 
    [dealer_uuid] UNIQUEIDENTIFIER NULL, -- TODO came from customer_dealer_mapping 
        -- customer_rid and dealer_rid were both ints in account_details.  In most cases a customer only has one device.  There was some bad data on Dev resulting in a few dupes.
    --[equipment_rid] NVARCHAR (50) NOT NULL,
    --[equipment_uuid] UNIQUEIDENTIFIER NOT NULL, 
-- attributes of this entity -- avoid using the table_name as a prefix in the column_name (so just "name" instead of "account_details_name")
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
-- lookup code fks:  most foreign keys that reference lookup_code suffixed with "_code"
    -- suffix "_code" if character data, suffix "_id" if numeric or uuid.  corresponds to the code in lookup_table 
    -- select * from lookup_code where lookup_list_code like '%account%type%'
    [account_type_code]     VARCHAR (30) CONSTRAINT [df_account_details_type_code] DEFAULT ('ACT_CUSTOMER') NOT NULL,
     [phone_type_code] VARCHAR(30)    NULL,
-- flags: all bit flags prefixed by "is_"
    [active] BIT NOT NULL,
    [door_sensor_1] BIT NULL,
    [door_sensor_2] BIT NULL,
    [door_sensor_3] BIT NULL,
-- dates: all dates suffixed by "_date"
    [created] DATETIME CONSTRAINT [df_account_details_created] DEFAULT (getdate()) NOT NULL,
    [updated] DATETIME NULL,
    [activated] DATETIME NULL,
-- change_log
    -- user tracking fields suffix with "_by" with a UUID that references user_accounts
    -- user_accounts, the object_id in user_accounts is the Entra ID object ID for the user
    [admin_user_rid]     INT CONSTRAINT [df_account_details_created_by_user_rid] DEFAULT (1) NOT NULL,
-- notes
    [notes] NVARCHAR (1000) NULL,
-- test data columns - will be deprecated?
    [test_data_group] int null, 
-- columns that might be deprecated
     [migrated_data] BIT CONSTRAINT [df_account_details_migrated_data] DEFAULT (0) NOT NULL 
);
GO

-- constraints and indexes:  all constraints and indexes must be explicitly named
-- naming convention:
-- <constraint_type> _ <table_name> _ <column_name>
-- examples:
--pk_account_details_id
--fk_account_details_account_details_type_code
--ux_account_details_vin_number
--ix_account_details_is_active


-- PKs and indexes - for now, the pk will be the rid.  need to test performance before changing it to the uuid
-- For the mapping tables (valid many-to-many tables, for example account_details_group_mapping), the primary key should be a composite key of the two ids that 
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [cix_account_details_rid] PRIMARY KEY CLUSTERED ([account_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[account_details]
ADD CONSTRAINT uk_account_details_uuid UNIQUE ([account_uuid]);
GO
-- FKs and indexes:  anything that is a reference must have a FK constraint 
ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_account_details_type] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_details_account_details_type] -- add explicit index for the FK column, to improve join performance
    ON [dbo].[account_details]([account_type_code] ASC);
GO
-- -- FKs and indexes - other FKs: anything that is a reference must have a FK constraint 
-- ALTER TABLE [dbo].[account_details] -- TODO FIX THIS
--     ADD CONSTRAINT [FK_account_details_user_accounts] FOREIGN KEY ([admin_user_rid]) REFERENCES [dbo].[user_accounts] ([user_rid]);
-- GO -- TODO
 
 CREATE NONCLUSTERED INDEX [ix_fk_account_details_admin_user_rid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[account_details]([admin_user_rid] ASC); 
  GO
-- ALTER TABLE [dbo].[account_details] ADD CONSTRAINT [fk_account_details_tenant_id] FOREIGN KEY ([tenant_id]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
-- GO
-- CREATE NONCLUSTERED INDEX [ix_fk_account_details_tenant_id] -- add explicit index for the FK column, to improve join performance
--  ON [dbo].[account_details]([tenant_id] ASC); 
--  GO

 
-- -- FKs and indexes - lookup_code: anything that is a reference must have a FK constraint 
-- -- [account_details_type_code]
-- ALTER TABLE [dbo].[account_details] ADD CONSTRAINT [fk_account_details_account_details_type_code] FOREIGN KEY ([account_details_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
-- GO
-- CREATE NONCLUSTERED INDEX [ix_fk_account_details_account_details_type_code] -- add explicit index for the FK column, to improve join performance
--  ON [dbo].[account_details]([account_details_type_code] ASC); 
--  GO
-- -- unique constraints and indexes
-- ALTER TABLE dbo.[account_details]
-- ADD CONSTRAINT uk_account_details_example UNIQUE ([example_unique_constraint_col]);
-- GO
-- -- check constraints and indexes
-- ALTER TABLE [account_details]
-- ADD CONSTRAINT ck_account_details_Status
-- CHECK ([example_check_constraint_col] IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'));
-- GO
-- -- Other indexes
CREATE NONCLUSTERED INDEX [IDX_account_details_admin_user_rid]
    ON [dbo].[account_details]([admin_user_rid] ASC);
GO

-- extended properties:  all tables and columns should have descriptions in extended properties
-- also listing the former name of the columns
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