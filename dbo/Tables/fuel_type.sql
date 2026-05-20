CREATE TABLE [dbo].[fuel_type] (
    [fuel_type_rid] TINYINT       NOT NULL,
    [description]   NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[fuel_type]
    ADD CONSTRAINT [PK_fuel_type] PRIMARY KEY CLUSTERED ([fuel_type_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

