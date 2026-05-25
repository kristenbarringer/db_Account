-- drop table if exists [dbo].[contact]
CREATE TABLE [dbo].[contact]
(
---- pks for this table
    [contact_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_contact_id] DEFAULT (NEWID()) NOT NULL,
    [contact_rid] INT IDENTITY (1, 1) NOT NULL,
---- important fks to other trx tables - these should be in almost every table (tenant_id is needed on almost all tables, including many-to-many tables)
    [tenant_id] UNIQUEIDENTIFIER CONSTRAINT [df_contact_tenant_id] DEFAULT (NEWID()) NOT NULL,    
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_contact_tenant_uuid] DEFAULT (NEWID()) NOT NULL, -- every table must have a tenant_uuid  
--    [contact_rid] INT NULL,
--    [contact_uuid] UNIQUEIDENTIFIER NULL,
--    [equipment_rid] NVARCHAR (50) NOT NULL,
--    [equipment_uuid] UNIQUEIDENTIFIER NOT NULL, 
---- attributes of this entity -- avoid using the table_name as a prefix in the column_name (so just "name" instead of "contact_name")
--    [description] varchar(30),
--    [example_check_constraint_col] varchar(30),
--    [example_unique_constraint_col] varchar(30),
    [first_name]           NVARCHAR (100) NULL,
    [last_name]            NVARCHAR (100) NULL,
    [email_id]             NVARCHAR (60)  NULL,
    [mobile_number]        NVARCHAR (20)  NULL,
---- lookup code fks:  most foreign keys that reference lookup_code suffixed with "_code"
--    -- suffix "_code" if character data, suffix "_id" if numeric or uuid.  corresponds to the code in lookup_table 
--    [contact_type_code] VARCHAR (30) CONSTRAINT [df_contact_type_code] DEFAULT ('AST_TRUCK') NOT NULL,
--    [power_source_code] VARCHAR (30) NULL,
--    [contact_icon_code] VARCHAR (30) NULL,
--    [contact_usage_code] VARCHAR (30) NULL,
--    [activation_status_code] VARCHAR (30) CONSTRAINT df_contact_status_code DEFAULT 'AAS_ACTIVATED' NOT NULL,
--    [billing_service_level_code] VARCHAR (30) NULL
--select * from lookup_code where lookup_list_code like '%fuel%' and former_code = '6'
    [language_code] VARCHAR (30) CONSTRAINT [df_contact_language_code] DEFAULT ('ENUS') NOT NULL,
    [timezone_code] VARCHAR (30) CONSTRAINT [df_contact_timezone_code] DEFAULT ('TMZ_AMERICA_DETROIT') NOT NULL,
    [speed_type_code] VARCHAR (30) CONSTRAINT [df_contact_speed_type_code] DEFAULT ('SPT_MPH') NOT NULL,
    [temperature_type_code] VARCHAR (30) CONSTRAINT [df_contact_temperature_type_code] DEFAULT ('TMP_FAHRENHEIT') NOT NULL,
    [fuel_type_code] VARCHAR (30) CONSTRAINT [df_contact_fuel_type_code] DEFAULT ('FLT_U_S_GALLONS') NOT NULL,
---- flags: all bit flags prefixed by "is_"
        [active] BIT CONSTRAINT [df_contact_active] DEFAULT (1) NOT NULL,
        [email] BIT CONSTRAINT [df_contact_email] DEFAULT (0) NOT NULL,
        [SMS] BIT CONSTRAINT [df_contact_SMS] DEFAULT (0) NOT NULL,
        [inapp] BIT CONSTRAINT [df_contact_inapp] DEFAULT (0) NOT NULL,
--    [door_sensor_1] BIT NULL,
--    [door_sensor_2] BIT NULL,
--    [door_sensor_3] BIT NULL,
---- dates: all dates suffixed by "_date"
    [created] DATETIME CONSTRAINT [df_contact_created] DEFAULT (getdate()) NOT NULL,
    [updated] DATETIME NULL,
--    [activated] DATETIME NULL,
---- change_log
--    -- user tracking fields suffix with "_by" with a UUID that references user_accounts
--    -- user_accounts, the object_id in user_accounts is the Entra ID object ID for the user
    [created_by] INT CONSTRAINT [df_contact_created_by_user_rid] DEFAULT (1) NOT NULL,
---- notes
--    [notes] NVARCHAR (1000) NULL,
---- test data columns - will be deprecated?
--    [test_data_group] int null, 
---- columns that might be deprecated
--    [account_additional_notes] VARCHAR (255) NULL    
);
GO  


 

-- constraints and indexes:  all constraints and indexes must be explicitly named
-- naming convention:
-- <constraint_type> _ <table_name> _ <column_name>
-- examples:
--pk_contact_id
--fk_contact_contact_type_code
--ux_contact_vin_number
--ix_contact_is_active


-- PKs and indexes - for now, the pk will be the rid.  need to test performance before changing it to the uuid
-- For the mapping tables (valid many-to-many tables, for example contact_group_mapping), the primary key should be a composite key of the two ids that 
ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [cix_contact_rid] PRIMARY KEY CLUSTERED ([contact_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[contact]
ADD CONSTRAINT uk_contact_uuid UNIQUE ([contact_uuid]);
GO
 
 -- FKs and indexes - other FKs: anything that is a reference must have a FK constraint 
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_tenant_uuid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[contact]([tenant_uuid] ASC); 
  GO
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_tenant_id] FOREIGN KEY ([tenant_id]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_tenant_id] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[contact]([tenant_id] ASC); 
  GO

 
 -- FKs and indexes - lookup_code: anything that is a reference must have a FK constraint 
    --[language_code] VARCHAR (30) CONSTRAINT [df_contact_language_code] DEFAULT ('ENUS') NOT NULL,
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_language_code] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[contact]([language_code] ASC); 
  GO
    --[timezone_code] VARCHAR (30) CONSTRAINT [df_contact_timezone_code] DEFAULT ('TMZ_AMERICA_DETROIT') NOT NULL,
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_timezone_code] FOREIGN KEY ([timezone_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_timezone_code] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[contact]([timezone_code] ASC); 
  GO
    --[speed_type_code] VARCHAR (30) CONSTRAINT [df_contact_speed_type_code] DEFAULT ('SPT_MPH') NOT NULL,
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_speed_type_code] FOREIGN KEY ([speed_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_speed_type_code] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[contact]([speed_type_code] ASC); 
  GO
    --[temperature_type_code] VARCHAR (30) CONSTRAINT [df_contact_temperature_type_code] DEFAULT ('TMP_FAHRENHEIT') NOT NULL,
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_temperature_type_code] FOREIGN KEY ([temperature_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_temperature_type_code] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[contact]([temperature_type_code] ASC); 
  GO
    --[fuel_type_code] VARCHAR (30) CONSTRAINT [df_contact_fuel_type_code] DEFAULT ('FLT_U_S_GALLONS') NOT NULL,
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_fuel_type_code] FOREIGN KEY ([fuel_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_fuel_type_code] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[contact]([fuel_type_code] ASC); 
  GO

-- -- unique constraints and indexes
-- ALTER TABLE dbo.[contact]
-- ADD CONSTRAINT uk_contact_example UNIQUE ([example_unique_constraint_col]);
-- GO
-- -- check constraints and indexes
-- ALTER TABLE [contact]
-- ADD CONSTRAINT ck_contact_Status
-- CHECK ([example_check_constraint_col] IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'));
-- GO
-- -- Other indexes
-- CREATE NONCLUSTERED INDEX [ix_contact_type_code]
--     ON [dbo].[contact]([contact_type_code] ASC);
-- GO

-- extended properties:  all tables and columns should have descriptions in extended properties
-- also listing the former name of the columns
-- extended properties: table
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'This table stores customer information.',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'contact';
GO
-- extended properties: columns
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'Customer unique identifier',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'contact',  
    @level2type = N'COLUMN',  @level2name = N'contact_rid';
GO