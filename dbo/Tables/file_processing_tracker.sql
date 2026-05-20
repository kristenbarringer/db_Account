CREATE TABLE [dbo].[file_processing_tracker] (
    [file_rid]           INT           IDENTITY (1, 1) NOT NULL,
    [file_name]          VARCHAR (100) NOT NULL,
    [total_record_count] INT           NULL,
    [processed_count]    INT           NULL,
    [status]             VARCHAR (30)  NULL,
    [tenant_id]          VARCHAR (50)  NULL,
    [created_by]         INT           NULL,
    [created_at]         DATETIME      NULL,
    [updated_at]         DATETIME      NULL,
    [upload_type]        VARCHAR (30)  NOT NULL
);
GO

ALTER TABLE [dbo].[file_processing_tracker]
    ADD CONSTRAINT [PK_file_processing_tracker] PRIMARY KEY CLUSTERED ([file_rid] ASC);
GO

