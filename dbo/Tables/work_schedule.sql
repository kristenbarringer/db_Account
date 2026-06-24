CREATE TABLE [dbo].[work_schedule] -- created by app in every database, same schema
(
	[work_schedule_rid] [int] IDENTITY(100,1) NOT NULL,
	[tenant_id] [int] NULL,
	[description] [nvarchar](100) NULL,
	[created] [datetime] NULL,
	[timezone_rid] [int] NULL,
 CONSTRAINT [PK_work_schedule] PRIMARY KEY CLUSTERED 
(
	[work_schedule_rid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO