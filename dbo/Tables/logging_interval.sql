CREATE TABLE [dbo].[logging_interval] (
    [logging_interval_rid]     INT           IDENTITY (1, 1) NOT NULL,
    [logging_interval_minutes] INT           NOT NULL,
    [description]              NVARCHAR (50) NOT NULL,
    [active]                   BIT           NULL
);
GO

ALTER TABLE [dbo].[logging_interval]
    ADD CONSTRAINT [PK_logging_interval] PRIMARY KEY CLUSTERED ([logging_interval_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

