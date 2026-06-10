/*
-- drop table if exists [dbo].[TABLENAME];
drop table if exists [dbo].[TABLENAME];
CREATE TABLE [dbo].[TABLENAME]
( -- TODO REFACTOR TEMPLATE IS AS FOLLOWS:
    -- ------------------------------------
    -- pks and main uq columns
    [TABLENAME_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_TABLENAME_TABLENAME_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [TABLENAME_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
    [language_code] VARCHAR (30) CONSTRAINT [df_TABLENAME_language_code] DEFAULT ('LNG_ENUS') NOT NULL,
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_TABLENAME_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_TABLENAME_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    [updated_by_user_rid] BIGINT NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [pk_TABLENAME_tenant_uuid_TABLENAME_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [TABLENAME_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [uk_TABLENAME_uuid] UNIQUE NONCLUSTERED ([TABLENAME_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [uk_TABLENAME_rid] UNIQUE ([TABLENAME_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [fk_TABLENAME_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].tenant_ref  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_tenant_uuid] 
  ON [dbo].[TABLENAME]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[TABLENAME]
    ADD CONSTRAINT [fk_TABLENAME_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_ref ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_created_by_user_rid] 
    ON [dbo].[TABLENAME]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[TABLENAME]
    ADD CONSTRAINT [fk_TABLENAME_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_ref ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_updated_by_user_rid] 

    ON [dbo].[TABLENAME]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code
ALTER TABLE [dbo].[TABLENAME] ADD CONSTRAINT [fk_TABLENAME_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_TABLENAME_language_code] 
  ON [dbo].[TABLENAME]([language_code] ASC); 
  GO
-- other constraints and indexes 
-- N/A
-- END

  

 */



CREATE TABLE [dbo].[customer_billing_information]
(
    [customer_billing_information_rid] INT IDENTITY (1, 1) NOT NULL,
    [billing_service_level_rid] INT NULL,
    [service_assist_subscription_flag] BIT NOT NULL,
    [logging_interval_code_on] VARCHAR (30) NULL,
    [logging_interval_code_off] VARCHAR (30) NULL,
    [restrict_logging_service_level_flag] BIT NOT NULL,
    [pay_up_front_auto_renew_flag] BIT NOT NULL,
    [pay_up_front_term_code] VARCHAR (30) NULL,
    [contract_term_code] VARCHAR (30) NULL,
    [contract_unit] INT NULL,
    [dealer_rid] INT NULL,
    [created_by_user_rid] INT NOT NULL,
    [billing_option_type_code] VARCHAR (30) NOT NULL,
    [customer_rid] INT NULL,
    [tenant_id] NVARCHAR (100) NOT NULL,
    [Tracking_admin_email] NVARCHAR (60) NULL,
    [customer_type_rid] INT NULL,
    [master_customer_rid] INT NULL,
    [billing_service_type_code] VARCHAR(30) NULL,
    [approval_status] NVARCHAR (50) NULL,
    [notes_dealer] NVARCHAR (2000) NULL,
    [created] DATETIME NULL,
    [updated] DATETIME NULL,
    [artifact_id] NVARCHAR (500) NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [DF_customer_billing_information_restrict_logging_service_level_flag] DEFAULT ((0)) FOR [restrict_logging_service_level_flag];
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [DF_customer_billing_information_pay_up_front_auto_renew_flag] DEFAULT ((0)) FOR [pay_up_front_auto_renew_flag];
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [DF_customer_billing_information_created] DEFAULT (getdate()) FOR [created];
GO

CREATE NONCLUSTERED INDEX [ix_customer_billing_information_contract_term_code]
    ON [dbo].[customer_billing_information]([contract_term_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_customer_billing_information_logging_interval_code_on]
    ON [dbo].[customer_billing_information]([logging_interval_code_on] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_customer_billing_information_pay_up_front_term_code]
    ON [dbo].[customer_billing_information]([pay_up_front_term_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_customer_billing_information_billing_service_type_code]
    ON [dbo].[customer_billing_information]([billing_service_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_customer_billing_information_billing_option_type_code]
    ON [dbo].[customer_billing_information]([billing_option_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_customer_billing_information_logging_interval_code_off]
    ON [dbo].[customer_billing_information]([logging_interval_code_off] ASC);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [fk_customer_billing_information_billing_option_type_code] FOREIGN KEY ([billing_option_type_code]) REFERENCES [dbo].[lookup_code]([code]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [fk_customer_billing_information_pay_up_front_term_code] FOREIGN KEY ([pay_up_front_term_code]) REFERENCES [dbo].[lookup_code]([code]);
    GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [fk_customer_billing_information_logging_interval_code_off] FOREIGN KEY ([logging_interval_code_off]) 
    REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [fk_customer_billing_information_contract_term_code] FOREIGN KEY ([contract_term_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [fk_customer_billing_information_logging_interval_code_on] FOREIGN KEY ([logging_interval_code_on]) 
    REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [FK_customer_billing_information_billing_service_type_code] FOREIGN KEY ([billing_service_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [PK_customer_billing_information] PRIMARY KEY NONCLUSTERED ([customer_billing_information_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

