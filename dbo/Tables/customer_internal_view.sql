/*

CREATE TABLE [dbo].[xxxx]
(
-- TODO REFACTOR TEMPLATE IS AS FOLLOWS:
-- ------------------------------------
-- pks and main uq columns
	-- UUID no default!
	-- TODO possibly remove identity prop on RID (or remove RID altogether)
-- fk columns - to tenant
-- main attribute columns of this entity 
-- fk columns - other main fks (todo check legacy DB for all existing fks)
-- fk columns - to lookup code (suffixed with "_code")
-- bit flag columns (prefixed with "is_")
-- date columns (suffixed with "_date")
-- fk columns - to user (uuids)
-- note columns
-- test data columns (only used for test data process on dev)
-- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

-- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
	-- UUID --> pk
	-- RID --> uk
-- fks - to tenant
-- fks - to user (todo - possibly remove these fks to user)
-- fks - other main fks
-- fks - to lookup code
-- other constraints and indexes 
-- extended properties: table
-- extended properties: columns
-- ------------------------------------
-- TODO make sure to format before committing (Shift + Alt + F)
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

