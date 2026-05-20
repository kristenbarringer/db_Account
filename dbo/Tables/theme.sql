CREATE TABLE [dbo].[theme] (
    [theme_rid]   TINYINT       NOT NULL,
    [description] NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[theme]
    ADD CONSTRAINT [PK_theme] PRIMARY KEY CLUSTERED ([theme_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

