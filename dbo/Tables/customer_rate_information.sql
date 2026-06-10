 
-- drop table if exists [dbo].[customer_rate_information];
--drop table if exists [dbo].[customer_rate_information];
CREATE TABLE [dbo].[customer_rate_information]
( 
    -- ------------------------------------
    -- pks and main uq columns
    [customer_rate_information_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_customer_rate_information_customer_rate_information_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [customer_rate_information_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
        [rate_deviation_pct]               DECIMAL (5, 2)  NULL,
    [standard_rate]                    DECIMAL (9, 2)  NULL,
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_customer_rate_information_is_active] DEFAULT (1) NOT NULL,
    [rate_approve_flag]                BIT             NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_customer_rate_information_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    [rate_deviation_approve_date]      DATETIME        NULL,
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    [updated_by_user_rid] BIGINT NULL,
    [rate_deviation_approver_user_rid] INT             NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    [rate_approver_notes]              NVARCHAR (2000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[customer_rate_information] ADD CONSTRAINT [pk_customer_rate_information_tenant_uuid_customer_rate_information_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [customer_rate_information_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[customer_rate_information] ADD CONSTRAINT [uk_customer_rate_information_uuid] UNIQUE NONCLUSTERED ([customer_rate_information_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[customer_rate_information] ADD CONSTRAINT [uk_customer_rate_information_rid] UNIQUE ([customer_rate_information_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[customer_rate_information] ADD CONSTRAINT [fk_customer_rate_information_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_rate_information_tenant_uuid] 
  ON [dbo].[customer_rate_information]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[customer_rate_information]
    ADD CONSTRAINT [fk_customer_rate_information_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_rate_information_created_by_user_rid] 
    ON [dbo].[customer_rate_information]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[customer_rate_information]
    ADD CONSTRAINT [fk_customer_rate_information_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_rate_information_updated_by_user_rid] 

    ON [dbo].[customer_rate_information]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END
 