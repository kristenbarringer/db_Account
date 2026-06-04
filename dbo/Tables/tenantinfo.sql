CREATE TABLE [dbo].[tenantinfo] -- (TODO - tenantinfo is only used for migration.  account_details is the source)
(
    -- ------------------------------------
    -- pks and main uq columns
    [tenant_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_tenantinfo_tenant_uuid] DEFAULT (NEWID()) NOT NULL,
    -- fk columns - to tenant
    -- N/A
    -- main attribute columns of this entity 
    [organization] varchar(255),
    [company_name] varchar(255),
    [minimum_user] INT NULL,
    [customer_rid] INT NULL,
    -- fk columns - other main fks
    -- N/A
    -- fk columns - to lookup code    
    [work_schedule_code] VARCHAR (30) CONSTRAINT [df_tenantinfo_work_schedule_code] DEFAULT ('WRK_TODO') NOT NULL, -- todo came from work_schedule
    -- N/A
    -- bit flag columns
    [is_active] BIT CONSTRAINT [df_tenantinfo_is_active] DEFAULT (1) NOT NULL,
    -- date columns
    [created_date] DATETIME CONSTRAINT [df_tenantinfo_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME CONSTRAINT [df_tenantinfo_updated_date] DEFAULT (getdate()) NOT NULL,
    -- fk columns - to user
    [created_by_user_uuid] UNIQUEIDENTIFIER NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- N/A
    -- test data columns (only used for test data process on dev)
    [test_data_group] int null,
    -- columns to be deprecated
    [Pipeline_Id] NVARCHAR (100) DEFAULT (NULL) NULL,
    [created] DATETIME CONSTRAINT [df_tenantinfo_created] DEFAULT (getdate()) NOT NULL,
    [v2_user_rid] INT NULL,
    [user_rid] INT NULL,
    [user_uuid] UNIQUEIDENTIFIER NULL,
    [user_name] varchar(255),

);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[tenantinfo]
    ADD CONSTRAINT [cix_tenantinfo_tenant_uuid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
-- fks - to tenant   
-- N/A
-- fks - to user -- TODO this creates a circular dependency so let's rethink this
-- ALTER TABLE [dbo].[tenantinfo]
--     ADD CONSTRAINT [fk_tenantinfo_user_uuid] FOREIGN KEY ([user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
-- GO
-- CREATE NONCLUSTERED INDEX [ix_fk_tenantinfo_user_uuid] -- add explicit index for the FK column, to improve join performance
--     ON [dbo].[tenantinfo]([user_uuid] ASC);
-- GO
-- ALTER TABLE [dbo].[tenantinfo]
--     ADD CONSTRAINT [fk_tenantinfo_created_by_user_uuid] FOREIGN KEY ([created_by_user_uuid]) REFERENCES [dbo].[user_accounts] ([user_uuid]);
-- GO
-- CREATE NONCLUSTERED INDEX [ix_fk_tenantinfo_created_by_user_uuid]
--     ON [dbo].[tenantinfo]([created_by_user_uuid] ASC);
-- GO
-- fks - other main fks
-- N/A
-- fks - to lookup code
ALTER TABLE [dbo].[tenantinfo] ADD CONSTRAINT [fk_tenantinfo_work_schedule_code] FOREIGN KEY ([work_schedule_code]) REFERENCES [dbo].[lookup_code] ([code]); 
GO
CREATE NONCLUSTERED INDEX [ix_fk_tenantinfo_work_schedule_code] -- add explicit index for the FK column, to improve join performance
ON [dbo].[tenantinfo]([work_schedule_code] ASC); 
GO
-- other constraints and indexes 
-- N/A
-- END
