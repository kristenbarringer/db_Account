CREATE TABLE [dbo].[dealer_family]
(
    [dealer_family_uuid] UNIQUEIDENTIFIER NOT NULL,
    -- TODO what other columns are needed?
    [name] varchar(300) NULL
)
GO
ALTER TABLE [dbo].[dealer_family]
    ADD CONSTRAINT [cix_dealer_family_uuid] PRIMARY KEY CLUSTERED ([dealer_family_uuid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO