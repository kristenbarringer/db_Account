CREATE TABLE [dbo].[db_m_dealer_mapping](
	[v1_customer_rid] [int] NULL,
	[v2_customer_rid] [nvarchar](max) NULL,
	[customer_tenant_id] [nvarchar](max) NULL,
	[v1_dealer_rid] [int] NULL,
	[v2_dealer_rid] [nvarchar](max) NULL,
	[dealer_tenant_id] [nvarchar](max) NULL,
	[customer_name] [nvarchar](max) NULL,
	[dealer_name] [nvarchar](max) NULL
) 
GO