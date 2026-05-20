CREATE TABLE [dbo].[account_type_role_mapping] (
    [rid]               INT            IDENTITY (1, 1) NOT NULL,
    [account_type_rid]  INT            NULL,
    [default_role_name] NVARCHAR (100) NOT NULL,
    [created]           DATETIME       NOT NULL,
    [updated]           DATETIME       NULL,
    [created_by]        INT            NOT NULL,
    [updated_by]        INT            NULL
);
GO

ALTER TABLE [dbo].[account_type_role_mapping]
    ADD CONSTRAINT [PK_account_type_role_mapping] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_account_type_role_mapping_account_type_rid]
    ON [dbo].[account_type_role_mapping]([account_type_rid] ASC);
GO

ALTER TABLE [dbo].[account_type_role_mapping]
    ADD CONSTRAINT [FK_account_type_role_mapping_account_type] FOREIGN KEY ([account_type_rid]) REFERENCES [dbo].[account_type] ([rid]);
GO

