CREATE TABLE [dbo].[language] (
    [language_rid] INT           NOT NULL,
    [description]  NVARCHAR (50) NOT NULL,
    [lang_id]      NVARCHAR (25) NOT NULL,
    [country_id]   NVARCHAR (25) NOT NULL
);
GO

ALTER TABLE [dbo].[language]
    ADD CONSTRAINT [PK_language] PRIMARY KEY CLUSTERED ([language_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

