CREATE TABLE [dbo].[service_level] (
    [service_level_rid]  INT           IDENTITY (1, 1) NOT NULL,
    [service_level_name] NVARCHAR (50) NOT NULL,
    [created]            DATETIME      NULL,
    [updated]            DATETIME      NULL,
    [created_by]         INT           NULL,
    [updated_by]         INT           NULL
);
GO

ALTER TABLE [dbo].[service_level]
    ADD CONSTRAINT [PK_service_level] PRIMARY KEY CLUSTERED ([service_level_rid] ASC);
GO

