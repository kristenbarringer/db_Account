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

