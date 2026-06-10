CREATE TABLE [dbo].[db_m_tenantinfo] -- (TODO - tenantinfo is only used for migration.  account_details is the source)
-- TODO I don't understand why this table is needed - why not just use account_details?
( -- REFACTOR DONE as of 6/7/2026
    -- ------------------------------------
    -- pks and main uq columns
    [tenant_uuid] UNIQUEIDENTIFIER NOT NULL,
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
    -- below does not seem valuable
    --[work_schedule_code] VARCHAR (30) CONSTRAINT [df_ti_work_schedule_code] DEFAULT ('WRK_TODO') NOT NULL, -- todo came from work_schedule
    -- N/A
    -- bit flag columns
    [is_active] BIT CONSTRAINT [df_ti_is_active] DEFAULT (1) NOT NULL,
    -- date columns
    [created_date] DATETIME CONSTRAINT [df_ti_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME CONSTRAINT [df_ti_updated_date] DEFAULT (getdate()) NOT NULL,
    -- fk columns - to user
    [created_by_user_rid] UNIQUEIDENTIFIER NULL,
    [updated_by_user_rid] UNIQUEIDENTIFIER NULL, -- TODO add this to all tables
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- N/A
    -- test data columns (only used for test data process on dev)
    [test_data_group] int null,
    -- columns to be deprecated
    [Pipeline_Id] NVARCHAR (100) DEFAULT (NULL) NULL,
    [created] DATETIME CONSTRAINT [df_ti_created] DEFAULT (getdate()) NOT NULL,
    [v2_user_rid] INT NULL,
    [user_rid] INT NULL,
    [user_uuid] UNIQUEIDENTIFIER NULL,
    [user_name] varchar(255),

);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[db_m_tenantinfo]
    ADD CONSTRAINT [cix_tenantinfo_tenant_uuid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
-- fks - to tenant   
-- N/A
-- fks - to user -- TODO this creates a circular dependency so let's rethink this
-- fks - other main fks
-- N/A
-- fks - to lookup code
-- other constraints and indexes 
-- N/A
-- END
