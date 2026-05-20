CREATE TABLE [dbo].[control_table] (
    [SourceSchema]      NVARCHAR (50)  NULL,
    [SourceTable]       NVARCHAR (50)  NULL,
    [destinationSchema] NVARCHAR (50)  NULL,
    [destinationTable]  NVARCHAR (50)  NULL,
    [jsonmapping]       NVARCHAR (MAX) NULL,
    [Hooksscript]       NVARCHAR (MAX) NULL,
    [minrid]            INT            NULL,
    [maxrid]            INT            NULL
);
GO

ALTER TABLE [dbo].[control_table]
    ADD CONSTRAINT [DF_control_table_minrid] DEFAULT (NULL) FOR [minrid];
GO

ALTER TABLE [dbo].[control_table]
    ADD CONSTRAINT [DF_control_table_maxrid] DEFAULT (NULL) FOR [maxrid];
GO

