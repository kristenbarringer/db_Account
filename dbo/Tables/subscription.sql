

 
-- drop table if exists [dbo].[subscription];
--drop table if exists [dbo].[subscription];
CREATE TABLE [dbo].[subscription] -- todo is this the same as customer_billing_information?
(  
    -- ------------------------------------
    -- pks and main uq columns
    [subscription_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_subscription_subscription_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [subscription_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
    [subscription_type_code] varchar(30) NOT NULL,
      [pay_up_front_term_code] VARCHAR (30) NULL,
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_subscription_is_active] DEFAULT (1) NOT NULL,
      [pay_up_front_auto_renew_flag] BIT NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_subscription_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    [closed_date] [datetime] NULL,
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
ALTER TABLE [dbo].[subscription] ADD CONSTRAINT [pk_subscription_tenant_uuid_subscription_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [subscription_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[subscription] ADD CONSTRAINT [uk_subscription_uuid] UNIQUE NONCLUSTERED ([subscription_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[subscription] ADD CONSTRAINT [uk_subscription_rid] UNIQUE ([subscription_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[subscription] ADD CONSTRAINT [fk_subscription_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_subscription_tenant_uuid] 
  ON [dbo].[subscription]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[subscription]
    ADD CONSTRAINT [fk_subscription_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_subscription_created_by_user_rid] 
    ON [dbo].[subscription]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[subscription]
    ADD CONSTRAINT [fk_subscription_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_subscription_updated_by_user_rid] 

    ON [dbo].[subscription]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END

  

 