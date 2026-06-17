/* TODO what is this table?
CREATE TABLE [dbo].[custom_data_intergration] (
    [custom_data_intergration_rid]       INT             IDENTITY (1, 1) NOT NULL,
    [customer_rid]                       INT             NULL,
    [tenant_id]                          NVARCHAR (100)  NOT NULL,
    [custom_data_integrator_company_rid] TINYINT         NULL,
    [custom_data_intergration_flag]      BIT             NULL,
    [ip_address]                         VARCHAR (100)   NULL,
    [notes_celtrak_it]                   NVARCHAR (2000) NULL,
    [celtrak_it_approve_date]            DATETIME        NULL,
    [celtrak_it_user_rid]                INT             NULL,
    [celtrak_it_approve_flag]            BIT             NULL,
    [it_contact_name]                    NVARCHAR (50)   NULL,
    [it_contact_email]                   NVARCHAR (50)   NULL,
    [it_contact_company]                 NVARCHAR (50)   NULL,
    [it_contact_phone]                   NVARCHAR (25)   NULL,
    [created]                            DATETIME        NULL,
    [updated]                            DATETIME        NULL,
    [artifact_id]                        NVARCHAR (500)  NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[custom_data_intergration]
    ADD CONSTRAINT [DF_custom_data_intergration_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[custom_data_intergration]
    ADD CONSTRAINT [PK_custom_data_intergration] PRIMARY KEY NONCLUSTERED ([custom_data_intergration_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

*/