CREATE TABLE [dbo].[user_accounts]
(
    [user_rid] INT IDENTITY (1, 1) NOT NULL,
    [user_name] NVARCHAR (200) NULL,
    [first_name] NVARCHAR (50) NOT NULL,
    [last_name] NVARCHAR (50) NOT NULL,
    [account_type_code] VARCHAR(30) NULL,   
    [tenant_id] NVARCHAR (50) NOT NULL,
    [tenant_uuid] UNIQUEIDENTIFIER NULL, 
    [role_rid] INT NULL,
    [active] BIT NOT NULL,
    [created] DATETIME NOT NULL,
    [email_address] NVARCHAR (50) NOT NULL,
    [phone_number] NVARCHAR (50) NULL,
    [title] NVARCHAR (200) NULL,
    [phone_type_code] VARCHAR (30) NULL,
    [status_code] VARCHAR (30) NOT NULL,
    [updated] DATETIME NULL,
    [activated] DATETIME NULL,
    [phone_extension] INT NULL,
    [created_by] INT NULL,
    [speed_type_code] VARCHAR (30) NOT NULL,
    [language_code] VARCHAR (30) NOT NULL,
    [temperature_type_code] VARCHAR (30) NOT NULL,
    [fuel_type_code] VARCHAR (30) NOT NULL,
    [timezone_code] VARCHAR (30) NOT NULL,
    [theme_code] VARCHAR (30) NOT NULL,
    [tour_status] TINYINT NULL,
    [onboarding_status] BIT NOT NULL,
    [expires] DATETIME NULL,
    [migrated_data] BIT NOT NULL,
    [landing_page] NVARCHAR (55) NULL,
    [notes] varchar(255) NULL 
);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_updated] DEFAULT (getdate()) FOR [updated];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_onboarding_status] DEFAULT ((1)) FOR [onboarding_status];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_account_type_code] DEFAULT (('ACT_CUSTOMER')) FOR [account_type_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_speed_type_code] DEFAULT (('SPT_MPH')) FOR [speed_type_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [df_user_accounts_theme_code] DEFAULT (('THM_LIGHT')) FOR [theme_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_tour_status] DEFAULT ((0)) FOR [tour_status];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [df_user_accounts_fuel_type_code] DEFAULT (('FLT_U_S_GALLONS')) FOR [fuel_type_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_first_name] DEFAULT ('Tracking') FOR [first_name];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_landing_page] DEFAULT ('DEFAULT') FOR [landing_page];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_active] DEFAULT ((1)) FOR [active];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_migrated_data] DEFAULT ((0)) FOR [migrated_data];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_temperature_type_code] DEFAULT (('TMP_FAHRENHEIT')) FOR [temperature_type_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_tenant_id] DEFAULT ((1)) FOR [tenant_id];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_language_code] DEFAULT (('ENUS')) FOR [language_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_timezone_code] DEFAULT (('TMZ_AMERICA_CHICAGO')) FOR [timezone_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [df_user_accounts_status_code] DEFAULT (('USR_ACTIVE')) FOR [status_code];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_last_name] DEFAULT ('User') FOR [last_name];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_role_rid] DEFAULT ((1)) FOR [role_rid];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_account_type] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_temperature_type_code] FOREIGN KEY ([temperature_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_speed_type] FOREIGN KEY ([speed_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_fuel_type_code] FOREIGN KEY ([fuel_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [fk_user_accounts_timezone_code] FOREIGN KEY ([timezone_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_role] FOREIGN KEY ([role_rid]) REFERENCES [dbo].[role] ([role_rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_user_status_code] FOREIGN KEY ([status_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [fk_user_accounts_theme_code] FOREIGN KEY ([theme_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_account_type_code]
    ON [dbo].[user_accounts]([account_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_speed_type_code]
    ON [dbo].[user_accounts]([speed_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_fuel_type_code]
    ON [dbo].[user_accounts]([fuel_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_temperature_type_code]
    ON [dbo].[user_accounts]([temperature_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_theme_code]
    ON [dbo].[user_accounts]([theme_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_tenant_id_status_code]
    ON [dbo].[user_accounts]([tenant_id] ASC, [status_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_status_code]
    ON [dbo].[user_accounts]([status_code] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_role_rid]
    ON [dbo].[user_accounts]([role_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_language_code]
    ON [dbo].[user_accounts]([language_code] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_timezone_code]
    ON [dbo].[user_accounts]([timezone_code] ASC);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [PK_user_accounts] PRIMARY KEY CLUSTERED ([user_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

