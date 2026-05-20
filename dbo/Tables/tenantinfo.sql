CREATE TABLE [dbo].[tenantinfo] (
    [tenant_id]    VARCHAR (255)  NULL,
    [organization] VARCHAR (255)  NULL,
    [company_name] VARCHAR (255)  NULL,
    [minimum_user] INT            NULL,
    [customer_rid] INT            NULL,
    [user_rid]     INT            NULL,
    [user_name]    VARCHAR (255)  NULL,
    [v2_user_rid]  INT            NULL,
    [pipeline_id]  NVARCHAR (100) NULL
);
GO

ALTER TABLE [dbo].[tenantinfo]
    ADD CONSTRAINT [DF_tenantinfo_pipeline_id] DEFAULT (NULL) FOR [pipeline_id];
GO

