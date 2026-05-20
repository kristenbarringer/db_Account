CREATE TABLE [dbo].[subscription_detail] (
    [subscription_id]         VARCHAR (100) NOT NULL,
    [service_level_id]        INT           NOT NULL,
    [logging_interval_on]     INT           NOT NULL,
    [logging_interval_off]    INT           NOT NULL,
    [billing_option_type_rid] INT           NOT NULL,
    [contract_term_rid]       INT           NOT NULL,
    [pay_up_front_term_rid]   INT           NOT NULL,
    [pay_up_front_auto_renew] BIT           NOT NULL,
    [active]                  BIT           NOT NULL,
    [activated_date]          DATETIME      NULL,
    [deactivated_date]        DATETIME      NULL,
    [created_date]            DATETIME      NULL,
    [updated_date]            DATETIME      NULL
);
GO

ALTER TABLE [dbo].[subscription_detail]
    ADD CONSTRAINT [DF_subscription_detail_pay_up_front_auto_renew] DEFAULT ((0)) FOR [pay_up_front_auto_renew];
GO

ALTER TABLE [dbo].[subscription_detail]
    ADD CONSTRAINT [DF_subscription_detail_active] DEFAULT ((1)) FOR [active];
GO

ALTER TABLE [dbo].[subscription_detail]
    ADD CONSTRAINT [PK_subscription_detail] PRIMARY KEY CLUSTERED ([subscription_id] ASC);
GO

