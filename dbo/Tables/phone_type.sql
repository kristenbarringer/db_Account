CREATE TABLE [dbo].[phone_type] (
    [phone_type_rid] INT            IDENTITY (1, 1) NOT NULL,
    [name]           NVARCHAR (100) NOT NULL,
    [created]        DATETIME       NOT NULL
);
GO

ALTER TABLE [dbo].[phone_type]
    ADD CONSTRAINT [DF_phone_type_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[phone_type]
    ADD CONSTRAINT [PK_phone_type] PRIMARY KEY CLUSTERED ([phone_type_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

