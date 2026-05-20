CREATE TABLE [dbo].[billing_option_type] (
    [billing_option_type_rid] TINYINT       IDENTITY (1, 1) NOT NULL,
    [description]             NVARCHAR (50) NOT NULL,
    [active]                  BIT           NOT NULL,
    [created]                 DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[billing_option_type]
    ADD CONSTRAINT [PK_billing_option_type] PRIMARY KEY NONCLUSTERED ([billing_option_type_rid] ASC);
GO

ALTER TABLE [dbo].[billing_option_type]
    ADD CONSTRAINT [DF_billing_option_type_active] DEFAULT ((1)) FOR [active];
GO

ALTER TABLE [dbo].[billing_option_type]
    ADD CONSTRAINT [DF_billing_option_type_created] DEFAULT (getdate()) FOR [created];
GO

