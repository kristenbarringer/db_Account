CREATE TABLE [dbo].[account_type_role_mapping] (
    [rid]               INT            IDENTITY (1, 1) NOT NULL,
    [account_type_code]  VARCHAR(30)            NULL,
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

CREATE NONCLUSTERED INDEX [ix_account_type_role_mapping_account_type_code]
    ON [dbo].[account_type_role_mapping]([account_type_code] ASC);
GO

ALTER TABLE [dbo].[account_type_role_mapping]
    ADD CONSTRAINT [fk_account_type_role_mapping_account_type_code] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

