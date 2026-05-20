CREATE TABLE [dbo].[role_permission_mapping] (
    [rid]             INT           IDENTITY (1, 1) NOT NULL,
    [role_rid]        INT           NOT NULL,
    [created]         DATETIME      NOT NULL,
    [permission_code] VARCHAR (100) NOT NULL
);
GO

ALTER TABLE [dbo].[role_permission_mapping]
    ADD CONSTRAINT [DF_role_permission_mapping_created] DEFAULT (getdate()) FOR [created];
GO

CREATE NONCLUSTERED INDEX [IDX_role_permission_mapping_role_rid]
    ON [dbo].[role_permission_mapping]([role_rid] ASC)
    INCLUDE([rid], [created], [permission_code]);
GO

CREATE NONCLUSTERED INDEX [IDX_role_permission_mapping_permission_code]
    ON [dbo].[role_permission_mapping]([permission_code] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_role_permission_mapping_rid]
    ON [dbo].[role_permission_mapping]([rid] ASC);
GO

ALTER TABLE [dbo].[role_permission_mapping]
    ADD CONSTRAINT [FK_role_permission_mapping_role] FOREIGN KEY ([role_rid]) REFERENCES [dbo].[role] ([role_rid]);
GO

