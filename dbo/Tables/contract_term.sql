CREATE TABLE [dbo].[contract_term] (
    [contract_term_rid] TINYINT       IDENTITY (1, 1) NOT NULL,
    [description]       NVARCHAR (50) NOT NULL,
    [active]            BIT           NOT NULL,
    [created]           DATETIME      NOT NULL,
    [read_only]         BIT           NOT NULL,
    [months]            INT           NULL
);
GO

ALTER TABLE [dbo].[contract_term]
    ADD CONSTRAINT [DF_contract_term_active] DEFAULT ((1)) FOR [active];
GO

ALTER TABLE [dbo].[contract_term]
    ADD CONSTRAINT [DF_contract_term_read_only] DEFAULT ((0)) FOR [read_only];
GO

ALTER TABLE [dbo].[contract_term]
    ADD CONSTRAINT [DF_contract_term_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[contract_term]
    ADD CONSTRAINT [PK_contract_term] PRIMARY KEY NONCLUSTERED ([contract_term_rid] ASC);
GO

