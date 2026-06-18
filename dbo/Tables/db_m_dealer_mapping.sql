CREATE TABLE [dbo].[db_m_dealer_mapping]
(
	[v1_customer_rid] [bigint] NULL,
	[v2_customer_rid] [bigint] NULL,
	[customer_tenant_id] UNIQUEIDENTIFIER NULL,
	[v1_dealer_rid] [bigint] NULL,
	[v2_dealer_rid] [bigint] NULL,
	[dealer_tenant_id] UNIQUEIDENTIFIER NULL,
	[customer_name] [nvarchar](max) NULL,
	[dealer_name] [nvarchar](max) NULL
) 
GO