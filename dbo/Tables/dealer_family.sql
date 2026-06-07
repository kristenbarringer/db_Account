/*

CREATE TABLE [dbo].[xxxx]
(
-- TODO REFACTOR TEMPLATE IS AS FOLLOWS:
-- ------------------------------------
-- pks and main uq columns
	-- UUID no default!
	-- TODO possibly remove identity prop on RID (or remove RID altogether)
-- fk columns - to tenant
-- main attribute columns of this entity 
-- fk columns - other main fks (todo check legacy DB for all existing fks)
-- fk columns - to lookup code (suffixed with "_code")
-- bit flag columns (prefixed with "is_")
-- date columns (suffixed with "_date")
-- fk columns - to user (uuids)
-- note columns
-- test data columns (only used for test data process on dev)
-- columns to be deprecated
-- TODO make sure to format before committing (Shift + Alt + F)

-- ------------------------------------
);
GO
-- ------------------------------------
-- pks and main uq indexes
	-- UUID --> pk
	-- RID --> uk
-- fks - to tenant
-- fks - to user (todo - possibly remove these fks to user)
-- fks - other main fks
-- fks - to lookup code
-- other constraints and indexes 
-- extended properties: table
-- extended properties: columns
-- ------------------------------------
-- TODO make sure to format before committing (Shift + Alt + F)
-- END


*/



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