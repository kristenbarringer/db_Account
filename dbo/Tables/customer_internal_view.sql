 -- drop table if exists [dbo].[customer_internal_view];
--drop table if exists [dbo].[customer_internal_view];
CREATE TABLE [dbo].[customer_internal_view]
(  
    -- ------------------------------------
    -- pks and main uq columns
    [customer_internal_view_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_customer_internal_view_customer_internal_view_uuid] DEFAULT (NEWSEQUENTIALID()) NOT NULL,   
    [customer_internal_view_rid]  BIGINT IDENTITY (1, 1) NOT NULL,
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
      -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_customer_internal_view_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_customer_internal_view_created_date] DEFAULT (getdate()) NOT NULL,
    [updated_date] DATETIME NULL,
    [admin_approve_date]                DATETIME        NULL,
    [celtrak_support_approve_date]      DATETIME        NULL,
    -- fk columns - to user
    [created_by_user_rid] BIGINT NULL,
    [updated_by_user_rid] BIGINT NULL,
    [admin_user_rid]                    INT             NULL,
    [celtrak_support_approver_user_rid] INT             NULL,
    -- note columns
    [notes] NVARCHAR (1000) NULL,
    [admin_notes]                       NVARCHAR (2000) NULL,
    -- test data columns (only used for test data process on dev)
    -- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

    -- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
ALTER TABLE [dbo].[customer_internal_view] ADD CONSTRAINT [pk_customer_internal_view_tenant_uuid_customer_internal_view_rid] PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [customer_internal_view_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[customer_internal_view] ADD CONSTRAINT [uk_customer_internal_view_uuid] UNIQUE NONCLUSTERED ([customer_internal_view_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO
ALTER TABLE [dbo].[customer_internal_view] ADD CONSTRAINT [uk_customer_internal_view_rid] UNIQUE ([customer_internal_view_rid]);
GO


-- fks - to tenant
ALTER TABLE [dbo].[customer_internal_view] ADD CONSTRAINT [fk_customer_internal_view_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_internal_view_tenant_uuid] 
  ON [dbo].[customer_internal_view]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[customer_internal_view]
    ADD CONSTRAINT [fk_customer_internal_view_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_internal_view_created_by_user_rid] 
    ON [dbo].[customer_internal_view]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[customer_internal_view]
    ADD CONSTRAINT [fk_customer_internal_view_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_customer_internal_view_updated_by_user_rid] 

    ON [dbo].[customer_internal_view]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END 