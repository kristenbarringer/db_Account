CREATE TABLE [dbo].[feedback_question] (
    [feedback_question_rid] INT            IDENTITY (1, 1) NOT NULL,
    [question_name]         NVARCHAR (450) NOT NULL,
    [type]                  NVARCHAR (155) NOT NULL,
    [is_active]             BIT            NOT NULL,
    [attributes]            NVARCHAR (155) NULL
);
GO

ALTER TABLE [dbo].[feedback_question]
    ADD CONSTRAINT [DF_feedback_question_is_active] DEFAULT ((1)) FOR [is_active];
GO

ALTER TABLE [dbo].[feedback_question]
    ADD CONSTRAINT [PK_feedback_question] PRIMARY KEY CLUSTERED ([feedback_question_rid] ASC);
GO

