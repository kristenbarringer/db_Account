CREATE TABLE [dbo].[user_grid_view_preference] (
    [rid]            INT             IDENTITY (1, 1) NOT NULL,
    [user_rid]       INT             NOT NULL,
    [grid_name]      NVARCHAR (200)  NOT NULL,
    [columns_hidden] NVARCHAR (3000) NOT NULL,
    [tenant_id]      NVARCHAR (200)  NOT NULL,
    [created]        DATETIME        NOT NULL,
    [updated]        DATETIME        NULL
);
GO

ALTER TABLE [dbo].[user_grid_view_preference]
    ADD CONSTRAINT [FK_user_grid_view_preference_user_accounts] FOREIGN KEY ([user_rid]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO

CREATE NONCLUSTERED INDEX [IDX_user_grid_view_preference_user_rid]
    ON [dbo].[user_grid_view_preference]([user_rid] ASC);
GO

