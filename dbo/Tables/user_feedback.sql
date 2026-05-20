CREATE TABLE [dbo].[user_feedback] (
    [user_feedback_rid]  INT            IDENTITY (1, 1) NOT NULL,
    [user_rid]           INT            NOT NULL,
    [user_name]          NVARCHAR (200) NULL,
    [user_role_rid]      INT            NULL,
    [organization_name]  NVARCHAR (200) NULL,
    [tenant_id]          NVARCHAR (100) NULL,
    [email_id]           NVARCHAR (100) NULL,
    [session_id]         INT            NULL,
    [rating]             INT            NULL,
    [question_rid]       INT            NULL,
    [answer_text]        NVARCHAR (MAX) NULL,
    [feedback_type]      NVARCHAR (100) NULL,
    [created_at]         DATETIME       NOT NULL,
    [page_source]        NVARCHAR (155) NULL,
    [is_submitted]       BIT            NOT NULL,
    [feedback_dismissed] BIT            NULL
);
GO

ALTER TABLE [dbo].[user_feedback]
    ADD CONSTRAINT [PK_user_feedback] PRIMARY KEY CLUSTERED ([user_feedback_rid] ASC);
GO

ALTER TABLE [dbo].[user_feedback]
    ADD CONSTRAINT [DF_user_feedback_is_submitted] DEFAULT ((0)) FOR [is_submitted];
GO

ALTER TABLE [dbo].[user_feedback]
    ADD CONSTRAINT [DF_user_feedback_created_at] DEFAULT (getdate()) FOR [created_at];
GO

