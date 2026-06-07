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



CREATE TABLE [dbo].[bulk_user_details] (
    [rid]        INT            IDENTITY (1, 1) NOT NULL,
    [first_name] VARCHAR (50)   NULL,
    [last_name]  VARCHAR (50)   NULL,
    [email_id]   VARCHAR (50)   NULL,
    [is_valid]   BIT            NULL,
    [err_msg]    NVARCHAR (200) NULL,
    [tenant_id]  NVARCHAR (50)  NULL,
    [created_at] DATETIME       NULL,
    [updated_at] DATETIME       NULL,
    [file_rid]   INT            NOT NULL
);
GO

CREATE NONCLUSTERED INDEX [IDX_bulk_user_details_file_rid]
    ON [dbo].[bulk_user_details]([file_rid] ASC);
GO

ALTER TABLE [dbo].[bulk_user_details]
    ADD CONSTRAINT [PK_bulk_user_details] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

ALTER TABLE [dbo].[bulk_user_details]
    ADD CONSTRAINT [FK_bulk_user_details_file_processing_tracker] FOREIGN KEY ([file_rid]) REFERENCES [dbo].[file_processing_tracker] ([file_rid]);
GO

