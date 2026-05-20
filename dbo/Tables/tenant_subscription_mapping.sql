CREATE TABLE [dbo].[tenant_subscription_mapping] (
    [tenant_id]            NVARCHAR (100)   NOT NULL,
    [subscription_id]      VARCHAR (100)    NOT NULL,
    [active]               BIT              NOT NULL,
    [default_subscription] BIT              NOT NULL,
    [created_date]         DATETIME         NULL,
    [updated_date]         DATETIME         NULL,
    [correlation_id]       UNIQUEIDENTIFIER NOT NULL
);
GO

ALTER TABLE [dbo].[tenant_subscription_mapping]
    ADD CONSTRAINT [PK_tenant_subscription_mapping] PRIMARY KEY CLUSTERED ([subscription_id] ASC, [tenant_id] ASC);
GO

ALTER TABLE [dbo].[tenant_subscription_mapping]
    ADD CONSTRAINT [FK_tenant_subscription_mapping_subscription_detail] FOREIGN KEY ([subscription_id]) REFERENCES [dbo].[subscription_detail] ([subscription_id]);
GO

ALTER TABLE [dbo].[tenant_subscription_mapping]
    ADD CONSTRAINT [DF_tenant_subscription_mapping_default_subscription] DEFAULT ((0)) FOR [default_subscription];
GO

ALTER TABLE [dbo].[tenant_subscription_mapping]
    ADD CONSTRAINT [DF_tenant_subscription_mapping_active] DEFAULT ((1)) FOR [active];
GO

