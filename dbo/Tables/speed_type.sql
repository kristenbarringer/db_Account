CREATE TABLE [dbo].[speed_type] (
    [speed_type_rid] TINYINT       NOT NULL,
    [description]    NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[speed_type]
    ADD CONSTRAINT [PK_speed_type] PRIMARY KEY CLUSTERED ([speed_type_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

