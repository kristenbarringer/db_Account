CREATE TABLE [dbo].[account_details] (
    [account_rid]            INT            IDENTITY (1, 1) NOT NULL,
    [organization]           NVARCHAR (100) NOT NULL,
    [tenant_id]              NVARCHAR (50)  NOT NULL,
    [company_address]        NVARCHAR (200) NULL,
    [additional_address]     NVARCHAR (200) NULL,
    [zip_code]               NVARCHAR (50)  NULL,
    [phone_number]           NVARCHAR (50)  NULL,
    [fax_number]             NVARCHAR (50)  NULL,
    [email]                  NVARCHAR (50)  NULL,
    [created]                DATETIME       NOT NULL,
    [active]                 BIT            NOT NULL,
    [company_website]        NVARCHAR (200) NULL,
    [support_contact_number] NVARCHAR (50)  NULL,
    [city]                   NVARCHAR (50)  NULL,
    [state]                  NVARCHAR (50)  NULL,
    [phone_type_code]        VARCHAR(30)    NULL,
    [phone_extension]        INT            NULL,
    [country]                NVARCHAR (50)  NULL,
    [admin_user_rid]         INT            NULL,
    [account_type_rid]       INT            NULL,
    [account_type_code]      VARCHAR (30)   NULL,
    [migrated_data]          INT            NULL
);
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [DF_account_details_active] DEFAULT ((1)) FOR [active];
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [DF_account_details_tenant_id] DEFAULT (newid()) FOR [tenant_id];
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [DF_account_details_migrated_data] DEFAULT ((0)) FOR [migrated_data];
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [DF_account_details_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [DF_account_details_account_type_rid] DEFAULT ((1)) FOR [account_type_rid];
GO

CREATE NONCLUSTERED INDEX [ix_account_details_phone_type_code]
    ON [dbo].[account_details]([phone_type_code] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_account_details_account_type_rid]
    ON [dbo].[account_details]([account_type_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_account_details_admin_user_rid]
    ON [dbo].[account_details]([admin_user_rid] ASC);
GO

--ALTER TABLE [dbo].[account_details]
    --ADD CONSTRAINT [FK_account_details_account_type] FOREIGN KEY ([account_type_rid]) REFERENCES [dbo].[account_type] ([rid]);
--GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [FK_account_details_account_type] FOREIGN KEY ([account_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [fk_account_details_phone_type_code] FOREIGN KEY ([phone_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [FK_account_details_user_accounts] FOREIGN KEY ([admin_user_rid]) REFERENCES [dbo].[user_accounts] ([user_rid]);
GO

ALTER TABLE [dbo].[account_details]
    ADD CONSTRAINT [PK_account_details] PRIMARY KEY CLUSTERED ([account_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

