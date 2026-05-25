
CREATE TABLE [dbo].[contact]
(
-- ------------------------------------
-- pks and main uq columns
    [contact_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_contact_id] DEFAULT (NEWID()) NOT NULL,
    [contact_rid] INT IDENTITY (1, 1) NOT NULL,
-- fk columns - to tenant
    [tenant_id] UNIQUEIDENTIFIER CONSTRAINT [df_contact_tenant_id] DEFAULT (NEWID()) NOT NULL,    
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_contact_tenant_uuid] DEFAULT (NEWID()) NOT NULL, 
-- main attribute columns of this entity 
    [first_name]           NVARCHAR (100) NULL,
    [last_name]            NVARCHAR (100) NULL,
    [email_id]             NVARCHAR (60)  NULL,
    [mobile_number]        NVARCHAR (20)  NULL,
-- fk columns - other main fks
-- fk columns - to lookup code
    [language_code] VARCHAR (30) CONSTRAINT [df_contact_language_code] DEFAULT ('ENUS') NOT NULL,
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
    [created_by]    UNIQUEIDENTIFIER CONSTRAINT [df_contact_created_by_user_rid] DEFAULT (NEWID()) NOT NULL,
-- note columns
-- test data columns (only used for test data process on dev)
-- columns to be deprecated
    [active] BIT CONSTRAINT [df_contact_active] DEFAULT (1) NOT NULL,
    [created] DATETIME CONSTRAINT [df_contact_created] DEFAULT (getdate()) NOT NULL,

-- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [cix_contact_rid] PRIMARY KEY CLUSTERED ([contact_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE dbo.[contact]
ADD CONSTRAINT uk_contact_uuid UNIQUE ([contact_uuid]);
GO
-- fks - to tenant
ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_tenant_uuid] FOREIGN KEY ([tenant_uuid]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_tenant_uuid] 
  ON [dbo].[contact]([tenant_uuid] ASC); 
  GO
 ALTER TABLE [dbo].[contact] ADD CONSTRAINT [fk_contact_tenant_id] FOREIGN KEY ([tenant_id]) REFERENCES [dbo].[tenantinfo] ([tenant_uuid]); 
 GO
 CREATE NONCLUSTERED INDEX [ix_fk_contact_tenant_id] 
  ON [dbo].[contact]([tenant_id] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [fk_contact_admin_user_rid] FOREIGN KEY ([created_by]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_contact_admin_user_rid]
    ON [dbo].[contact]([created_by] ASC);
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
 
-- ------------------------------------
-- END

  

 