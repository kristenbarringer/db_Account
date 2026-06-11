
-- drop table if exists [dbo].[customer_account_information];
--drop table if exists [dbo].[customer_account_information];
CREATE TABLE [dbo].[customer_account_information]
(
    -- ------------------------------------
    -- pks and main uq columns
    [customer_account_information_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_customer_account_information_customer_account_information_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [customer_account_information_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    [customer_billing_information_rid] INT            NULL,
    [customer_rate_information_rid]    INT            NULL,
    [customer_internal_view_rid]       INT            NULL,
    [custom_data_intergration_rid]     INT            NULL,
    -- fk columns - to lookup code (suffixed with "_code")
     -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_customer_account_information_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_customer_account_information_created_date] DEFAULT (getdate()) NOT NULL,
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
ALTER TABLE [dbo].[customer_account_information] ADD CONSTRAINT [pk_customer_account_information_tenant_uuid_customer_account_information_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [customer_account_information_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[customer_account_information] ADD CONSTRAINT [uk_customer_account_information_uuid] UNIQUE NONCLUSTERED ([customer_account_information_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[customer_account_information] ADD CONSTRAINT [uk_customer_account_information_rid] UNIQUE ([customer_account_information_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[customer_account_information] ADD CONSTRAINT [fk_customer_account_information_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_account_information_tenant_uuid] 
  ON [dbo].[customer_account_information]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [fk_customer_account_information_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_account_information_created_by_user_rid] 
    ON [dbo].[customer_account_information]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [fk_customer_account_information_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_account_information_updated_by_user_rid] 

    ON [dbo].[customer_account_information]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code
-- ALTER TABLE [dbo].[customer_account_information] ADD CONSTRAINT [fk_customer_account_information_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]); 
--  GO
-- CREATE NONCLUSTERED INDEX [ix_fk_customer_account_information_language_code] 
--   ON [dbo].[customer_account_information]([language_code] ASC); 
--   GO
-- other constraints and indexes 
-- N/A
-- END

  

  

 

-- ALTER TABLE [dbo].[customer_account_information]
--     ADD CONSTRAINT [FK_customer_account_information_customer_rate_information] FOREIGN KEY ([customer_rate_information_rid]) REFERENCES [dbo].[customer_rate_information] ([customer_rate_information_rid]);
-- GO

-- ALTER TABLE [dbo].[customer_account_information]
--     ADD CONSTRAINT [FK_customer_account_information_custom_data_intergration] FOREIGN KEY ([custom_data_intergration_rid]) REFERENCES [dbo].[custom_data_intergration] ([custom_data_intergration_rid]);
-- GO

-- ALTER TABLE [dbo].[customer_account_information]
--     ADD CONSTRAINT [FK_customer_account_information_customer_internal_view] FOREIGN KEY ([customer_internal_view_rid]) REFERENCES [dbo].[customer_internal_view] ([customer_internal_view_rid]);
-- GO

-- ALTER TABLE [dbo].[customer_account_information]
--     ADD CONSTRAINT [FK_customer_account_information_customer_billing_information] FOREIGN KEY ([customer_billing_information_rid]) REFERENCES [dbo].[customer_billing_information] ([customer_billing_information_rid]);
-- GO

-- ALTER TABLE [dbo].[customer_account_information]
--     ADD CONSTRAINT [DF_customer_account_information_created] DEFAULT (getdate()) FOR [created];
-- GO

-- ALTER TABLE [dbo].[customer_account_information]
--     ADD CONSTRAINT [PK_customer_account_information] PRIMARY KEY NONCLUSTERED ([customer_account_information_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
-- GO

