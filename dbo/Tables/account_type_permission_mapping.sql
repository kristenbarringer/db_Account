CREATE TABLE [dbo].[account_type_permission_mapping] (
    [rid]             INT           IDENTITY (1, 1) NOT NULL,
    [role_rid]        INT           NOT NULL,
    [role_code] VARCHAR (30) NULL,
    [created]         DATETIME      NOT NULL,
    [permission_code] VARCHAR (100) NOT NULL
);
GO

 

ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [DF_account_type_permission_mapping_created] DEFAULT (getdate()) FOR [created];
GO

CREATE NONCLUSTERED INDEX [IDX_account_type_permission_mapping_role_rid]
    ON [dbo].[account_type_permission_mapping]([role_rid] ASC);
GO

ALTER TABLE [dbo].[account_type_permission_mapping]
    ADD CONSTRAINT [fk_account_type_permission_mapping_role_code] FOREIGN KEY ([role_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
CREATE NONCLUSTERED INDEX [ix_fk_account_type_permission_mapping_role_code] 
    ON [dbo].[account_type_permission_mapping]([role_code] ASC);
GO