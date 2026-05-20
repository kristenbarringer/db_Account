CREATE TABLE [dbo].[temperature_type] (
    [temperature_type_rid] TINYINT       NOT NULL,
    [description]          NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[temperature_type]
    ADD CONSTRAINT [PK_temperature_type] PRIMARY KEY CLUSTERED ([temperature_type_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

