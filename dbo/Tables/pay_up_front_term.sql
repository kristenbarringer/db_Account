CREATE TABLE [dbo].[pay_up_front_term] (
    [pay_up_front_term_rid] TINYINT       IDENTITY (1, 1) NOT NULL,
    [months]                TINYINT       NULL,
    [years]                 TINYINT       NULL,
    [description]           NVARCHAR (50) NOT NULL,
    [created]               DATETIME      NOT NULL,
    [active]                BIT           NOT NULL
);
GO

ALTER TABLE [dbo].[pay_up_front_term]
    ADD CONSTRAINT [PK_pay_up_front_term] PRIMARY KEY CLUSTERED ([pay_up_front_term_rid] ASC);
GO

