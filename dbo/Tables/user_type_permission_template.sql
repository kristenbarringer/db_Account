CREATE TABLE [dbo].[user_type_permission_template] (
    -- TODO what is this table?
    [rid]              INT           IDENTITY (1, 1) NOT NULL,
    [account_type_code] VARCHAR(30)           NULL,
    [permission_code]  VARCHAR (100) NOT NULL
);
GO

ALTER TABLE [dbo].[user_type_permission_template]
    ADD CONSTRAINT [FK_user_type_permission_template_account_type] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_type_permission_template]
    ADD CONSTRAINT [PK_user_type_permission_template] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_type_permission_template_account_type_code]
    ON [dbo].[user_type_permission_template]([account_type_code] ASC);
GO

