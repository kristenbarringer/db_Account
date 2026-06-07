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



CREATE TABLE [dbo].[customer_account_information] (
    [customer_account_information_rid] INT            IDENTITY (1, 1) NOT NULL,
    [customer_rid]                     INT            NOT NULL,
    [tenant_id]                        NVARCHAR (100) NOT NULL,
    [customer_billing_information_rid] INT            NULL,
    [customer_rate_information_rid]    INT            NULL,
    [customer_internal_view_rid]       INT            NULL,
    [custom_data_intergration_rid]     INT            NULL,
    [created]                          DATETIME       NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_account_information_customer_internal_view_rid]
    ON [dbo].[customer_account_information]([customer_internal_view_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_account_information_customer_rate_information_rid]
    ON [dbo].[customer_account_information]([customer_rate_information_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_account_information_custom_data_intergration_rid]
    ON [dbo].[customer_account_information]([custom_data_intergration_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_account_information_customer_billing_information_rid]
    ON [dbo].[customer_account_information]([customer_billing_information_rid] ASC);
GO

ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [FK_customer_account_information_customer_rate_information] FOREIGN KEY ([customer_rate_information_rid]) REFERENCES [dbo].[customer_rate_information] ([customer_rate_information_rid]);
GO

ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [FK_customer_account_information_custom_data_intergration] FOREIGN KEY ([custom_data_intergration_rid]) REFERENCES [dbo].[custom_data_intergration] ([custom_data_intergration_rid]);
GO

ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [FK_customer_account_information_customer_internal_view] FOREIGN KEY ([customer_internal_view_rid]) REFERENCES [dbo].[customer_internal_view] ([customer_internal_view_rid]);
GO

ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [FK_customer_account_information_customer_billing_information] FOREIGN KEY ([customer_billing_information_rid]) REFERENCES [dbo].[customer_billing_information] ([customer_billing_information_rid]);
GO

ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [DF_customer_account_information_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[customer_account_information]
    ADD CONSTRAINT [PK_customer_account_information] PRIMARY KEY NONCLUSTERED ([customer_account_information_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

