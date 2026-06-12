-- drop table if exists [dbo].[tenant_service_level_mapping];
--drop table if exists [dbo].[tenant_service_level_mapping];
CREATE TABLE [dbo].[tenant_service_level_mapping]
(  -- TRULY a MANY-TO-MANY Table - 6/12
    -- ------------------------------------
    -- pks and main uq columns
    -- fk columns - to tenant
    [tenant_uuid] UNIQUEIDENTIFIER  NOT NULL,
    -- main attribute columns of this entity 
    -- fk columns - other main fks (todo check legacy DB for all existing fks)
    -- fk columns - to lookup code (suffixed with "_code")
    --[lookup_code] VARCHAR (30) CONSTRAINT [df_tenant_service_level_mapping_language_code] DEFAULT ('LNG_ENUS') NOT NULL,
    [service_level_code] VARCHAR(30) NOT NULL, -- todo possibly make it an RID
   -- [account_type_code] VARCHAR(30) NULL,
    -- bit flag columns (prefixed with "is_")        
    [is_active] BIT CONSTRAINT [df_tenant_service_level_mapping_is_active] DEFAULT (1) NOT NULL,
    -- date columns (suffixed with "_date")
    [created_date] DATETIME CONSTRAINT [df_tenant_service_level_mapping_created_date] DEFAULT (getdate()) NOT NULL,
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
-- pks and main uq indexes - MANY-TO-MANY tables should have a PK of the 2 tables that are joined
ALTER TABLE [dbo].[tenant_service_level_mapping] ADD CONSTRAINT [pk_tenant_service_level_mapping_tenant_uuid_service_level_code] 
PRIMARY KEY CLUSTERED ([tenant_uuid] ASC, [service_level_code] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO


-- fks - to tenant
ALTER TABLE [dbo].[tenant_service_level_mapping] ADD CONSTRAINT [fk_tenant_service_level_mapping_tenant_uuid] FOREIGN KEY ([tenant_uuid]) 
/* On Fleet, should reference tenant_ref, on Account should reference account_details */
REFERENCES [dbo].account_details  ([tenant_uuid]); 
 GO
CREATE NONCLUSTERED INDEX [ix_fk_tenant_service_level_mapping_tenant_uuid] 
  ON [dbo].[tenant_service_level_mapping]([tenant_uuid] ASC); 
  GO
-- fks - to user
ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [fk_tenant_service_level_mapping_created_by_user_rid] FOREIGN KEY ([created_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_tenant_service_level_mapping_created_by_user_rid] 
    ON [dbo].[tenant_service_level_mapping]([created_by_user_rid] ASC);
GO
ALTER TABLE [dbo].[tenant_service_level_mapping]
    ADD CONSTRAINT [fk_tenant_service_level_mapping_updated_by_user_rid] FOREIGN KEY ([updated_by_user_rid]) 
/* On Fleet, should reference user_ref, on Account should reference user_accounts */
    REFERENCES [dbo].user_accounts ([user_rid]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_tenant_service_level_mapping_updated_by_user_rid] 

    ON [dbo].[tenant_service_level_mapping]([updated_by_user_rid] ASC);
GO
-- fks - other main fks
-- fks - to lookup code

-- other constraints and indexes 
-- N/A
-- END

  
 

 