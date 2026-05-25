-- drop table if exists [dbo].[user_grid_view_preference]
CREATE TABLE [dbo].[user_grid_view_preference]
(
---- pks for this table
    [user_grid_view_preference_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_grid_view_preference_id] DEFAULT (NEWID()) NOT NULL,
    [user_grid_view_preference_rid] INT IDENTITY (1, 1) NOT NULL,
---- important fks to other trx tables - these should be in almost every table (tenant_id is needed on almost all tables, including many-to-many tables)
    [tenant_id] UNIQUEIDENTIFIER CONSTRAINT [df_user_grid_view_preference_tenant_id] DEFAULT (NEWID()) NOT NULL,    
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_user_grid_view_preference_tenant_uuid] DEFAULT (NEWID()) NOT NULL, -- every table must have a tenant_uuid  
    [user_rid] INT NULL,
    [user_uuid] UNIQUEIDENTIFIER NULL,
--    [equipment_rid] NVARCHAR (50) NOT NULL,
--    [equipment_uuid] UNIQUEIDENTIFIER NOT NULL, 
---- attributes of this entity -- avoid using the table_name as a prefix in the column_name (so just "name" instead of "asset_name")
    [grid_name]      NVARCHAR (200)  NOT NULL,
    [columns_hidden] NVARCHAR (3000) NOT NULL,
---- lookup code fks:  most foreign keys that reference lookup_code suffixed with "_code"
--    -- suffix "_code" if character data, suffix "_id" if numeric or uuid.  corresponds to the code in lookup_table 
--    [asset_type_code] VARCHAR (30) CONSTRAINT [df_user_grid_view_preference_type_code] DEFAULT ('AST_TRUCK') NOT NULL,
--    [power_source_code] VARCHAR (30) NULL,
--    [asset_icon_code] VARCHAR (30) NULL,
--    [asset_usage_code] VARCHAR (30) NULL,
--    [activation_status_code] VARCHAR (30) CONSTRAINT df_user_grid_view_preference_status_code DEFAULT 'AAS_ACTIVATED' NOT NULL,
--    [billing_service_level_code] VARCHAR (30) NULL,
---- flags: all bit flags prefixed by "is_"
--    [active] BIT NOT NULL,
--    [door_sensor_1] BIT NULL,
--    [door_sensor_2] BIT NULL,
--    [door_sensor_3] BIT NULL,
---- dates: all dates suffixed by "_date"
    [created] DATETIME CONSTRAINT [df_user_grid_view_preference_created] DEFAULT (getdate()) NOT NULL,
    [updated] DATETIME NULL,
--    [activated] DATETIME NULL,
---- change_log
--    -- user tracking fields suffix with "_by" with a UUID that references user_accounts
--    -- user_accounts, the object_id in user_accounts is the Entra ID object ID for the user
--    [created_by_user_rid] INT CONSTRAINT [df_user_grid_view_preference_created_by_user_rid] DEFAULT (1) NOT NULL,
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
--pk_asset_id
--fk_asset_asset_type_code
--ux_asset_vin_number
--ix_asset_is_active


-- PKs and indexes - for now, the pk will be the rid.  need to test performance before changing it to the uuid
-- For the mapping tables (valid many-to-many tables, for example asset_group_mapping), the primary key should be a composite key of the two ids that 
ALTER TABLE [dbo].[user_grid_view_preference]
    ADD CONSTRAINT [cix_user_grid_view_preference_rid] PRIMARY KEY CLUSTERED ([user_grid_view_preference_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[user_grid_view_preference]
ADD CONSTRAINT uk_user_grid_view_preference_uuid UNIQUE ([user_grid_view_preference_uuid]);
GO
 
-- -- FKs and indexes - other FKs: anything that is a reference must have a FK constraint 
 ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_tenant_uuid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[user_grid_view_preference]([tenant_uuid] ASC); 
  GO
 ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_tenant_id] FOREIGN KEY ([tenant_id]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_tenant_id] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[user_grid_view_preference]([tenant_id] ASC); 
  GO

  ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_user_uuid] FOREIGN KEY ([user_uuid]) REFERENCES [dbo].user_accounts ([user_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_user_uuid] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[user_grid_view_preference]([user_uuid] ASC); 
  GO
 ALTER TABLE [dbo].[user_grid_view_preference] ADD CONSTRAINT [fk_user_grid_view_pref_user_id] FOREIGN KEY ([user_rid]) REFERENCES [dbo].user_accounts ([user_rid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_user_grid_view_pref_user_id] -- add explicit index for the FK column, to improve join performance
  ON [dbo].[user_grid_view_preference]([user_rid] ASC); 
  GO

-- -- FKs and indexes - lookup_code: anything that is a reference must have a FK constraint 
-- -- [asset_type_code]
-- ALTER TABLE [dbo].[asset] ADD CONSTRAINT [fk_asset_asset_type_code] FOREIGN KEY ([asset_type_code]) REFERENCES [dbo].[lookup_code] ([code]); 
-- GO
-- CREATE NONCLUSTERED INDEX [ix_fk_asset_asset_type_code] -- add explicit index for the FK column, to improve join performance
--  ON [dbo].[asset]([asset_type_code] ASC); 
--  GO
-- -- unique constraints and indexes
-- ALTER TABLE dbo.[user_grid_view_preference]
-- ADD CONSTRAINT uk_user_grid_view_preference_example UNIQUE ([example_unique_constraint_col]);
-- GO
-- -- check constraints and indexes
-- ALTER TABLE [user_grid_view_preference]
-- ADD CONSTRAINT ck_user_grid_view_preference_Status
-- CHECK ([example_check_constraint_col] IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'));
-- GO
-- -- Other indexes
-- CREATE NONCLUSTERED INDEX [ix_user_grid_view_preference_type_code]
--     ON [dbo].[user_grid_view_preference]([asset_type_code] ASC);
-- GO

-- extended properties:  all tables and columns should have descriptions in extended properties
-- also listing the former name of the columns
-- extended properties: table
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'This table stores customer information.',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'user_grid_view_preference';
GO
-- extended properties: columns
EXEC sys.sp_addextendedproperty  
    @name = N'Description',  
    @value = N'Customer unique identifier',  
    @level0type = N'SCHEMA',  @level0name = N'dbo',  
    @level1type = N'TABLE',   @level1name = N'user_grid_view_preference',  
    @level2type = N'COLUMN',  @level2name = N'user_grid_view_preference_rid';
GO