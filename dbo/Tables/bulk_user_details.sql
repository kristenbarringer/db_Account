CREATE TABLE [dbo].[bulk_user_details] (
    [rid]        INT            IDENTITY (1, 1) NOT NULL,
    [first_name] VARCHAR (50)   NULL,
    [last_name]  VARCHAR (50)   NULL,
    [email_id]   VARCHAR (50)   NULL,
    [is_valid]   BIT            NULL,
    [err_msg]    NVARCHAR (200) NULL,
    [tenant_id]  NVARCHAR (50)  NULL,
    [created_at] DATETIME       NULL,
    [updated_at] DATETIME       NULL,
    [file_rid]   INT            NOT NULL
);
GO

CREATE NONCLUSTERED INDEX [IDX_bulk_user_details_file_rid]
    ON [dbo].[bulk_user_details]([file_rid] ASC);
GO

ALTER TABLE [dbo].[bulk_user_details]
    ADD CONSTRAINT [PK_bulk_user_details] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

ALTER TABLE [dbo].[bulk_user_details]
    ADD CONSTRAINT [FK_bulk_user_details_file_processing_tracker] FOREIGN KEY ([file_rid]) REFERENCES [dbo].[file_processing_tracker] ([file_rid]);
GO

