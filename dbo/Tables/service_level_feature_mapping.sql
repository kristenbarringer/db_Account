CREATE TABLE [dbo].[service_level_feature_mapping]
( -- TODO what is this table?
-- TRULY a MANY-TO-MANY Table - 6/12
 
    [service_level_code] VARCHAR(30) NOT NULL,
    [created] DATETIME NOT NULL,
    [feature_code] VARCHAR (100) NOT NULL
);
GO
-- pks and main uq indexes - MANY-TO-MANY tables should have a PK of the 2 tables that are joined
ALTER TABLE [dbo].[service_level_feature_mapping] ADD CONSTRAINT [pk_service_level_feature_mapping_service_level_code_feature_code] 
PRIMARY KEY CLUSTERED ([service_level_code] ASC, [feature_code] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO


CREATE NONCLUSTERED INDEX [ix_service_level_feature_mapping_service_level_code]
    ON [dbo].[service_level_feature_mapping]([service_level_code] ASC);
GO

 
ALTER TABLE [dbo].[service_level_feature_mapping]
    ADD CONSTRAINT [FK_service_level_feature_mapping_service_level] FOREIGN KEY ([service_level_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[service_level_feature_mapping]
    ADD CONSTRAINT [DF_service_level_feature_mapping_created] DEFAULT (getdate()) FOR [created];
GO

