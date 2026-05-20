CREATE TABLE [dbo].[customer_billing_information] (
    [customer_billing_information_rid]    INT             IDENTITY (1, 1) NOT NULL,
    [billing_service_level_rid]           INT             NULL,
    [service_assist_subscription_flag]    BIT             NOT NULL,
    [logging_interval_rid_on]             INT             NULL,
    [logging_interval_rid_off]            INT             NULL,
    [restrict_logging_service_level_flag] BIT             NOT NULL,
    [pay_up_front_auto_renew_flag]        BIT             NOT NULL,
    [pay_up_front_term_rid]               TINYINT         NULL,
    [contract_term_rid]                   TINYINT         NULL,
    [contract_unit]                       INT             NULL,
    [dealer_rid]                          INT             NULL,
    [created_by_user_rid]                 INT             NOT NULL,
    [billing_option_type_rid]             TINYINT         NOT NULL,
    [customer_rid]                        INT             NULL,
    [tenant_id]                           NVARCHAR (100)  NOT NULL,
    [Tracking_admin_email]                NVARCHAR (60)   NULL,
    [customer_type_rid]                   INT             NULL,
    [master_customer_rid]                 INT             NULL,
    [billing_service_type_rid]            TINYINT         NULL,
    [approval_status]                     NVARCHAR (50)   NULL,
    [notes_dealer]                        NVARCHAR (2000) NULL,
    [created]                             DATETIME        NULL,
    [updated]                             DATETIME        NULL,
    [artifact_id]                         NVARCHAR (500)  NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [DF_customer_billing_information_restrict_logging_service_level_flag] DEFAULT ((0)) FOR [restrict_logging_service_level_flag];
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [DF_customer_billing_information_pay_up_front_auto_renew_flag] DEFAULT ((0)) FOR [pay_up_front_auto_renew_flag];
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [DF_customer_billing_information_created] DEFAULT (getdate()) FOR [created];
GO

CREATE NONCLUSTERED INDEX [IDX_customer_billing_information_contract_term_rid]
    ON [dbo].[customer_billing_information]([contract_term_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_billing_information_logging_interval_rid_on]
    ON [dbo].[customer_billing_information]([logging_interval_rid_on] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_billing_information_pay_up_front_term_rid]
    ON [dbo].[customer_billing_information]([pay_up_front_term_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_billing_information_billing_service_type_rid]
    ON [dbo].[customer_billing_information]([billing_service_type_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_billing_information_billing_option_type_rid]
    ON [dbo].[customer_billing_information]([billing_option_type_rid] ASC);
GO

CREATE NONCLUSTERED INDEX [IDX_customer_billing_information_logging_interval_rid_off]
    ON [dbo].[customer_billing_information]([logging_interval_rid_off] ASC);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [FK_customer_billing_information_billing_option_type] FOREIGN KEY ([billing_option_type_rid]) REFERENCES [dbo].[billing_option_type] ([billing_option_type_rid]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [FK_customer_billing_information_pay_up_front_term] FOREIGN KEY ([pay_up_front_term_rid]) REFERENCES [dbo].[pay_up_front_term] ([pay_up_front_term_rid]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [FK_customer_billing_information_off_logging_interval] FOREIGN KEY ([logging_interval_rid_off]) REFERENCES [dbo].[logging_interval] ([logging_interval_rid]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [FK_customer_billing_information_contract_term] FOREIGN KEY ([contract_term_rid]) REFERENCES [dbo].[contract_term] ([contract_term_rid]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [FK_customer_billing_information_on_logging_interval] FOREIGN KEY ([logging_interval_rid_on]) REFERENCES [dbo].[logging_interval] ([logging_interval_rid]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [FK_customer_billing_information_billing_service_type] FOREIGN KEY ([billing_service_type_rid]) REFERENCES [dbo].[billing_service_type] ([billing_service_type_rid]);
GO

ALTER TABLE [dbo].[customer_billing_information]
    ADD CONSTRAINT [PK_customer_billing_information] PRIMARY KEY NONCLUSTERED ([customer_billing_information_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

