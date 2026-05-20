CREATE TABLE [dbo].[service_level_feature_mapping] (
    [rid]               INT           IDENTITY (1, 1) NOT NULL,
    [service_level_rid] INT           NOT NULL,
    [created]           DATETIME      NOT NULL,
    [feature_code]      VARCHAR (100) NOT NULL
);
GO

CREATE NONCLUSTERED INDEX [IDX_service_level_feature_mapping_service_level_rid]
    ON [dbo].[service_level_feature_mapping]([service_level_rid] ASC);
GO

ALTER TABLE [dbo].[service_level_feature_mapping]
    ADD CONSTRAINT [PK_service_level_feature_mapping] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

ALTER TABLE [dbo].[service_level_feature_mapping]
    ADD CONSTRAINT [FK_service_level_feature_mapping_service_level] FOREIGN KEY ([service_level_rid]) REFERENCES [dbo].[service_level] ([service_level_rid]);
GO

ALTER TABLE [dbo].[service_level_feature_mapping]
    ADD CONSTRAINT [DF_service_level_feature_mapping_created] DEFAULT (getdate()) FOR [created];
GO

