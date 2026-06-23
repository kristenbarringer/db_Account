CREATE TABLE [dbo].[custom_data_integration]( -- TODO refactor
	[custom_data_integration_rid] [int] IDENTITY(1,1) NOT NULL,
	[customer_rid] [int] NULL,
	[tenant_id] [nvarchar](100) NOT NULL,
	[custom_data_integrator_company_rid] [tinyint] NULL,
	[custom_data_integration_flag] [bit] NULL,
	[ip_address] [varchar](100) NULL,
	[notes_celtrak_it] [nvarchar](2000) NULL,
	[celtrak_it_approve_date] [datetime] NULL,
	[celtrak_it_user_rid] [int] NULL,
	[celtrak_it_approve_flag] [bit] NULL,
	[it_contact_name] [nvarchar](50) NULL,
	[it_contact_email] [nvarchar](50) NULL,
	[it_contact_company] [nvarchar](50) NULL,
	[it_contact_phone] [nvarchar](25) NULL,
	[created] [datetime] NULL,
	[updated] [datetime] NULL,
	[artifact_id] [nvarchar](500) NULL,
 CONSTRAINT [PK_custom_data_integration] PRIMARY KEY NONCLUSTERED 
(
	[custom_data_integration_rid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO

ALTER TABLE [dbo].[custom_data_integration] ADD  CONSTRAINT [DF_custom_data_integration_created]  DEFAULT (getdate()) FOR [created]
GO

