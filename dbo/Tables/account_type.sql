CREATE TABLE [dbo].[account_type] (
    [rid]                  INT           IDENTITY (1, 1) NOT NULL,
    [description]          NVARCHAR (50) NOT NULL,
    [status]               BIT           NOT NULL,
    [service_level_filter] BIT           NULL
);
GO

ALTER TABLE [dbo].[account_type]
    ADD CONSTRAINT [PK_account_type] PRIMARY KEY CLUSTERED ([rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[account_type]
    ADD CONSTRAINT [DF_account_type_status] DEFAULT ((1)) FOR [status];
GO

ALTER TABLE [dbo].[account_type]
    ADD CONSTRAINT [DF_account_type_service_level_filter] DEFAULT ((0)) FOR [service_level_filter];
GO

