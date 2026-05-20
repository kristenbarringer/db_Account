CREATE TABLE [dbo].[customer_rate_information] (
    [customer_rate_information_rid]    INT             IDENTITY (1, 1) NOT NULL,
    [customer_rid]                     INT             NULL,
    [tenant_id]                        NVARCHAR (100)  NOT NULL,
    [rate_deviation_pct]               DECIMAL (5, 2)  NULL,
    [standard_rate]                    DECIMAL (9, 2)  NULL,
    [rate_approver_notes]              NVARCHAR (2000) NULL,
    [rate_deviation_approve_date]      DATETIME        NULL,
    [rate_deviation_approver_user_rid] INT             NULL,
    [rate_approve_flag]                BIT             NULL,
    [created]                          DATETIME        NULL,
    [updated]                          DATETIME        NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[customer_rate_information]
    ADD CONSTRAINT [PK_customer_rate_information] PRIMARY KEY NONCLUSTERED ([customer_rate_information_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[customer_rate_information]
    ADD CONSTRAINT [DF_customer_rate_information_created] DEFAULT (getdate()) FOR [created];
GO

