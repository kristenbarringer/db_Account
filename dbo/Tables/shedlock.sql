CREATE TABLE [dbo].[shedlock] (
    [name]       VARCHAR (64)  NOT NULL,
    [lock_until] DATETIME2 (7) NOT NULL,
    [locked_at]  DATETIME2 (7) NOT NULL,
    [locked_by]  VARCHAR (255) NOT NULL
);
GO

ALTER TABLE [dbo].[shedlock]
    ADD CONSTRAINT [PK_shedlock] PRIMARY KEY CLUSTERED ([name] ASC);
GO

