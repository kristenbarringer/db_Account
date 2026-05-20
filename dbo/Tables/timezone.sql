CREATE TABLE [dbo].[timezone] (
    [timezone_rid] INT            NOT NULL,
    [timezone_id]  NVARCHAR (25)  NOT NULL,
    [display_name] NVARCHAR (100) NOT NULL
);
GO

ALTER TABLE [dbo].[timezone]
    ADD CONSTRAINT [PK_timezone] PRIMARY KEY CLUSTERED ([timezone_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

