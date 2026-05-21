CREATE TABLE [dbo].[user_accounts] (
    [user_rid]             INT            IDENTITY (1, 1) NOT NULL,
    [user_name]            NVARCHAR (200) NULL,
    [first_name]           NVARCHAR (50)  NOT NULL,
    [last_name]            NVARCHAR (50)  NOT NULL,
    [account_type_rid]     INT            NULL,
    [tenant_id]            NVARCHAR (50)  NOT NULL,
    [role_rid]             INT            NULL,
    [active]               BIT            NOT NULL,
    [created]              DATETIME       NOT NULL,
    [email_address]        NVARCHAR (50)  NOT NULL,
    [object_id]            NVARCHAR (50)  NULL,
    [phone_number]         NVARCHAR (50)  NULL,
    [title]                NVARCHAR (200) NULL,
    [phone_type]           INT            NULL,
    [status]               INT            NOT NULL,
    [updated]              DATETIME       NULL,
    [activated]            DATETIME       NULL,
    [phone_extension]      INT            NULL,
    [created_by]           INT            NULL,
    [speed_type_rid]       TINYINT        NOT NULL,
    [language_code]        VARCHAR (30)   NOT NULL,
    [temperature_type_code] VARCHAR (30)  NOT NULL,
    [fuel_type_rid]        TINYINT        NOT NULL,
    [timezone_rid]         INT            NOT NULL,
    [theme_rid]            TINYINT        NOT NULL,
    [tour_status]          TINYINT        NULL,
    [onboarding_status]    BIT            NOT NULL,
    [expires]              DATETIME       NULL,
    [migrated_data]        BIT            NOT NULL,
    [landing_page]         NVARCHAR (55)  NULL
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
    ADD CONSTRAINT [DF_user_accounts_account_type_rid] DEFAULT ((1)) FOR [account_type_rid];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_speed_type_rid] DEFAULT ((2)) FOR [speed_type_rid];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_theme_rid] DEFAULT ((2)) FOR [theme_rid];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_tour_status] DEFAULT ((0)) FOR [tour_status];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_fuel_type_rid] DEFAULT ((3)) FOR [fuel_type_rid];
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
    ADD CONSTRAINT [DF_user_accounts_timezone_rid] DEFAULT ((5)) FOR [timezone_rid];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_status] DEFAULT ((2)) FOR [status];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_last_name] DEFAULT ('User') FOR [last_name];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [DF_user_accounts_role_rid] DEFAULT ((1)) FOR [role_rid];
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_account_type] FOREIGN KEY ([account_type_rid]) REFERENCES [dbo].[account_type] ([rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_temperature_type_code] FOREIGN KEY ([temperature_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_speed_type] FOREIGN KEY ([speed_type_rid]) REFERENCES [dbo].[speed_type] ([speed_type_rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_fuel_type] FOREIGN KEY ([fuel_type_rid]) REFERENCES [dbo].[fuel_type] ([fuel_type_rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_timezone] FOREIGN KEY ([timezone_rid]) REFERENCES [dbo].[timezone] ([timezone_rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_role] FOREIGN KEY ([role_rid]) REFERENCES [dbo].[role] ([role_rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_user_status] FOREIGN KEY ([status]) REFERENCES [dbo].[user_status] ([status_rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_theme] FOREIGN KEY ([theme_rid]) REFERENCES [dbo].[theme] ([theme_rid]);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [FK_user_accounts_language_code] FOREIGN KEY ([language_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_account_type_rid]
    ON [dbo].[user_accounts]([account_type_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_speed_type_rid]
    ON [dbo].[user_accounts]([speed_type_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_fuel_type_rid]
    ON [dbo].[user_accounts]([fuel_type_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_temperature_type_code]
    ON [dbo].[user_accounts]([temperature_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_theme_rid]
    ON [dbo].[user_accounts]([theme_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_tenant_id_status]
    ON [dbo].[user_accounts]([tenant_id] ASC, [status] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_status]
    ON [dbo].[user_accounts]([status] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_role_rid]
    ON [dbo].[user_accounts]([role_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [ix_user_accounts_language_code]
    ON [dbo].[user_accounts]([language_code] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_user_accounts_timezone_rid]
    ON [dbo].[user_accounts]([timezone_rid] ASC);
GO

ALTER TABLE [dbo].[user_accounts]
    ADD CONSTRAINT [PK_user_accounts] PRIMARY KEY CLUSTERED ([user_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

