CREATE TABLE [dbo].[data_integration_details]( -- TODO refactor
	[integration_id] [int] IDENTITY(1,1) NOT NULL,
	[tenant_id] [nvarchar](50) NOT NULL,
	[integration_type] [nvarchar](30) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[integration_contact] [nvarchar](200) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone_number] [nvarchar](50) NOT NULL,
	[is_api_shared] [bit] NOT NULL,
	[is_ibox_shared] [bit] NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[created_by] [int] NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[approved_by] [int] NULL,
	[approved_date] [datetime2](3) NULL,
	[rejected_by] [int] NULL,
	[rejected_date] [datetime2](7) NULL,
	[requested_by] [nvarchar](100) NOT NULL,
	[updated_by] [int] NULL,
	[updated_date] [datetime2](3) NULL,
	[active] [bit] NOT NULL,
	[is_soap_shared] [bit] NOT NULL,
	[rejected_reason] [nvarchar](255) NULL,
 CONSTRAINT [pk_integration] PRIMARY KEY CLUSTERED 
(
	[integration_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[data_integration_details] ADD  DEFAULT ((0)) FOR [is_api_shared]
GO

ALTER TABLE [dbo].[data_integration_details] ADD  DEFAULT ((0)) FOR [is_ibox_shared]
GO

ALTER TABLE [dbo].[data_integration_details] ADD  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dbo].[data_integration_details] ADD  DEFAULT ((0)) FOR [active]
GO

ALTER TABLE [dbo].[data_integration_details] ADD  DEFAULT ((0)) FOR [is_soap_shared]
GO

