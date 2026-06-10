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


CREATE TABLE [dbo].[customer_internal_view] (
    [customer_internal_view_rid]        INT             IDENTITY (1, 1) NOT NULL,
    [customer_rid]                      INT             NULL,
    [tenant_id]                         NVARCHAR (100)  NOT NULL,
    [created_by_user_rid]               INT             NOT NULL,
    [admin_notes]                       NVARCHAR (2000) NULL,
    [admin_approve_date]                DATETIME        NULL,
    [admin_user_rid]                    INT             NULL,
    [celtrak_support_approve_date]      DATETIME        NULL,
    [celtrak_support_approver_user_rid] INT             NULL,
    [created]                           DATETIME        NOT NULL,
    [updated]                           DATETIME        NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[customer_internal_view]
    ADD CONSTRAINT [DF_customer_internal_view_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[customer_internal_view]
    ADD CONSTRAINT [PK_customer_internal_view] PRIMARY KEY NONCLUSTERED ([customer_internal_view_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

