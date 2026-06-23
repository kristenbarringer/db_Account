CREATE TABLE [dbo].[data_integration_document]( -- TODO refactor
	[document_id] [int] IDENTITY(1,1) NOT NULL,
	[integration_id] [int] NOT NULL,
	[artifact_id] [nvarchar](100) NOT NULL,
	[file_name] [nvarchar](255) NOT NULL,
	[document_type] [nvarchar](20) NOT NULL,
	[created_date] [datetime2](3) NOT NULL,
	[file_size] [bigint] NOT NULL,
	[created_by] [int] NOT NULL,
 CONSTRAINT [pk_integration_document] PRIMARY KEY CLUSTERED 
(
	[document_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[data_integration_document] ADD  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dbo].[data_integration_document]    ADD  CONSTRAINT [fk_integration_document] FOREIGN KEY([integration_id])
REFERENCES [dbo].[data_integration_details] ([integration_id])
GO

--ALTER TABLE [dbo].[data_integration_document] CHECK CONSTRAINT [fk_integration_document]
--GO

