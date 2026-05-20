CREATE TABLE [dbo].[customer_dealer_mapping] (
    [customer_rid] INT      NOT NULL,
    [dealer_rid]   INT      NOT NULL,
    [created]      DATETIME NULL,
    [created_by]   INT      NULL,
    [updated]      DATETIME NULL,
    [updated_by]   INT      NULL
);
GO

ALTER TABLE [dbo].[customer_dealer_mapping]
    ADD CONSTRAINT [customer_dealer_mapping_account_details_customer_FK] FOREIGN KEY ([customer_rid]) REFERENCES [dbo].[account_details] ([account_rid]);
GO

ALTER TABLE [dbo].[customer_dealer_mapping]
    ADD CONSTRAINT [FK_customer_dealer_mapping_users_updated] FOREIGN KEY ([updated_by]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO

ALTER TABLE [dbo].[customer_dealer_mapping]
    ADD CONSTRAINT [customer_dealer_mapping_account_details_dealer_FK] FOREIGN KEY ([dealer_rid]) REFERENCES [dbo].[account_details] ([account_rid]);
GO

ALTER TABLE [dbo].[customer_dealer_mapping]
    ADD CONSTRAINT [FK_customer_dealer_mapping_users_created] FOREIGN KEY ([created_by]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO

ALTER TABLE [dbo].[customer_dealer_mapping]
    ADD CONSTRAINT [PK_customer_dealer_mapping] PRIMARY KEY CLUSTERED ([customer_rid] ASC, [dealer_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_dealer_mapping_updated_by]
    ON [dbo].[customer_dealer_mapping]([updated_by] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_dealer_mapping_created_by]
    ON [dbo].[customer_dealer_mapping]([created_by] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_dealer_mapping_dealer_rid]
    ON [dbo].[customer_dealer_mapping]([dealer_rid] ASC);
GO

