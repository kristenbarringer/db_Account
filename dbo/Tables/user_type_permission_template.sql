CREATE TABLE [dbo].[user_type_permission_template] (
    [rid]              INT           IDENTITY (1, 1) NOT NULL,
    [account_type_rid] INT           NULL,
    [permission_code]  VARCHAR (100) NOT NULL
);
GO

ALTER TABLE [dbo].[user_type_permission_template]
    ADD CONSTRAINT [FK_user_type_permission_template_account_type] FOREIGN KEY ([account_type_rid]) REFERENCES [dbo].[account_type] ([rid]);
GO

ALTER TABLE [dbo].[user_type_permission_template]
    ADD CONSTRAINT [PK_user_type_permission_template] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_type_permission_template_account_type_rid]
    ON [dbo].[user_type_permission_template]([account_type_rid] ASC);
GO

