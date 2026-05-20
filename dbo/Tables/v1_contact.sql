CREATE TABLE [dbo].[v1_contact] (
    [rid]                  INT            IDENTITY (1, 1) NOT NULL,
    [customer_rid]         INT            NOT NULL,
    [contact_name]         NVARCHAR (50)  NULL,
    [email_1]              NVARCHAR (60)  NULL,
    [email_2]              NVARCHAR (60)  NULL,
    [email_3]              NVARCHAR (60)  NULL,
    [email_4]              NVARCHAR (60)  NULL,
    [email_5]              NVARCHAR (60)  NULL,
    [mobile_number_1]      NVARCHAR (20)  NULL,
    [mobile_number_2]      NVARCHAR (20)  NULL,
    [mobile_number_3]      NVARCHAR (20)  NULL,
    [mobile_number_4]      NVARCHAR (20)  NULL,
    [mobile_number_5]      NVARCHAR (20)  NULL,
    [created]              DATETIME       NULL,
    [language_rid]         INT            NOT NULL,
    [timezone_rid]         INT            NOT NULL,
    [speed_type_rid]       INT            NOT NULL,
    [temperature_type_rid] INT            NOT NULL,
    [tk_password]          NVARCHAR (65)  NULL,
    [is_existing_user]     BIT            NOT NULL,
    [obj_id]               NVARCHAR (50)  NULL,
    [Pipeline_Id]          NVARCHAR (100) NULL
);
GO

ALTER TABLE [dbo].[v1_contact]
    ADD CONSTRAINT [DF_v1_contact_Pipeline_Id] DEFAULT (NULL) FOR [Pipeline_Id];
GO

ALTER TABLE [dbo].[v1_contact]
    ADD CONSTRAINT [PK_v1_contact] PRIMARY KEY CLUSTERED ([rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

