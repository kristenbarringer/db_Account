CREATE TABLE [dbo].[account_type_permission_mapping] (
    [rid]             INT           IDENTITY (1, 1) NOT NULL,
    [role_rid]        INT           NOT NULL,
    [created]         DATETIME      NOT NULL,
    [permission_code] VARCHAR (100) NOT NULL
);
GO

ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [FK_account_type_permission_mapping_account_type_role_mapping] FOREIGN KEY ([role_rid]) REFERENCES [dbo].[account_type_role_mapping] ([rid]);
GO

ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [DF_account_type_permission_mapping_created] DEFAULT (getdate()) FOR [created];
GO

CREATE NONCLUSTERED INDEX [IDX_account_type_permission_mapping_role_rid]
    ON [dbo].[account_type_permission_mapping]([role_rid] ASC);
GO

