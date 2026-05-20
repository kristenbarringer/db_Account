CREATE TABLE [dbo].[contact] (
    [contact_rid]          INT            IDENTITY (1, 1) NOT NULL,
    [tenant_id]            NVARCHAR (60)  NOT NULL,
    [first_name]           NVARCHAR (100) NULL,
    [last_name]            NVARCHAR (100) NULL,
    [email_id]             NVARCHAR (60)  NULL,
    [language_rid]         INT            NOT NULL,
    [timezone_rid]         INT            NOT NULL,
    [speed_type_rid]       INT            NOT NULL,
    [temperature_type_rid] INT            NOT NULL,
    [created]              DATETIME       NULL,
    [created_by]           INT            NULL,
    [active]               BIT            NOT NULL,
    [updated]              DATETIME       NULL,
    [mobile_number]        NVARCHAR (20)  NULL,
    [email]                BIT            NOT NULL,
    [SMS]                  BIT            NOT NULL,
    [inapp]                BIT            NOT NULL,
    [fuel_type_rid]        INT            NOT NULL
);
GO

ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [DF_contact_inapp] DEFAULT ((0)) FOR [inapp];
GO

ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [DF_contact_email] DEFAULT ((0)) FOR [email];
GO

ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [DF_contact_SMS] DEFAULT ((0)) FOR [SMS];
GO

CREATE NONCLUSTERED INDEX [IDX_contact_created_by]
    ON [dbo].[contact]([created_by] ASC);
GO

ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [FK_contact_user_accounts] FOREIGN KEY ([created_by]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO

ALTER TABLE [dbo].[contact]
    ADD CONSTRAINT [PK_contact] PRIMARY KEY CLUSTERED ([contact_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

