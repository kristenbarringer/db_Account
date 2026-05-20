CREATE TABLE [dbo].[user_status] (
    [status_rid]         INT           NOT NULL,
    [status_description] VARCHAR (255) NOT NULL
);
GO

ALTER TABLE [dbo].[user_status]
    ADD CONSTRAINT [PK_user_status] PRIMARY KEY CLUSTERED ([status_rid] ASC);
GO

