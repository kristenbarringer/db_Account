CREATE TABLE [dbo].[v1_user_change_log] (
    [v1_user_rid]     INT            NULL,
    [v1_user_name]    NVARCHAR (255) NULL,
    [v2_user_rid]     INT            NULL,
    [tenant_id]       NVARCHAR (255) NULL,
    [v1_customer_rid] INT            NULL,
    [v1_company_name] NVARCHAR (255) NULL,
    [v2_organization] NVARCHAR (255) NULL
);
GO

