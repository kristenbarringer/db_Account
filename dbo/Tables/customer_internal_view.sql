CREATE TABLE [dbo].[customer_internal_view] (
    [customer_internal_view_rid]        INT             IDENTITY (1, 1) NOT NULL,
    [customer_rid]                      INT             NULL,
    [tenant_id]                         NVARCHAR (100)  NOT NULL,
    [created_by_user_rid]               INT             NOT NULL,
    [admin_notes]                       NVARCHAR (2000) NULL,
    [admin_approve_date]                DATETIME        NULL,
    [admin_user_rid]                    INT             NULL,
    [celtrak_support_approve_date]      DATETIME        NULL,
    [celtrak_support_approver_user_rid] INT             NULL,
    [created]                           DATETIME        NOT NULL,
    [updated]                           DATETIME        NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[customer_internal_view]
    ADD CONSTRAINT [DF_customer_internal_view_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[customer_internal_view]
    ADD CONSTRAINT [PK_customer_internal_view] PRIMARY KEY NONCLUSTERED ([customer_internal_view_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

