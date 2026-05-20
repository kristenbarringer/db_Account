CREATE TABLE [dbo].[role] (
    [role_rid]      INT            IDENTITY (1, 1) NOT NULL,
    [description]   NVARCHAR (100) NOT NULL,
    [created]       DATETIME       NOT NULL,
    [standard_role] BIT            NOT NULL,
    [active]        BIT            NOT NULL,
    [user_type_rid] INT            NOT NULL,
    [tenant_id]     NVARCHAR (50)  NOT NULL,
    [created_by]    INT            NULL,
    [name]          NVARCHAR (100) NOT NULL,
    [last_updated]  DATETIME       NULL,
    [updated]       DATETIME       NULL
);
GO

ALTER TABLE [dbo].[role]
    ADD CONSTRAINT [PK_role] PRIMARY KEY CLUSTERED ([role_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[role]
    ADD CONSTRAINT [DF_role_active] DEFAULT ((0)) FOR [active];
GO

ALTER TABLE [dbo].[role]
    ADD CONSTRAINT [DF_role_created] DEFAULT (getdate()) FOR [created];
GO

