CREATE TABLE [dbo].[locations_common] (
    [rid]                             INT            IDENTITY (1, 1) NOT NULL,
    [image_rid]                       INT            NOT NULL,
    [system_function_rid]             INT            NULL,
    [longitude]                       FLOAT (53)     NOT NULL,
    [latitude]                        FLOAT (53)     NOT NULL,
    [key_name]                        NVARCHAR (100) NOT NULL,
    [name]                            NVARCHAR (100) NOT NULL,
    [address_1]                       NVARCHAR (100) NOT NULL,
    [address_2]                       NVARCHAR (100) NULL,
    [address_3]                       NVARCHAR (1)   NULL,
    [city]                            NVARCHAR (50)  NOT NULL,
    [zip_code]                        NVARCHAR (50)  NULL,
    [country]                         NVARCHAR (50)  NOT NULL,
    [opening_hours]                   NVARCHAR (50)  NULL,
    [phone_number]                    FLOAT (53)     NULL,
    [phone_number_2]                  NVARCHAR (1)   NULL,
    [fax_number]                      FLOAT (53)     NULL,
    [created]                         DATETIME       NULL,
    [calculated_longitude_in_radians] FLOAT (53)     NOT NULL,
    [calculated_latitude_in_radians]  FLOAT (53)     NOT NULL,
    [last_modified_by_user_rid]       INT            NULL
);
GO

ALTER TABLE [dbo].[locations_common]
    ADD CONSTRAINT [PK_locations_common] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

