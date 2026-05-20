-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE v2_process_contactsChanges
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    INSERT INTO [dbo].[contact]
    (
      [tenant_id],
      [first_name], 
      [last_name], 
      [email_id], 
      [language_rid],
      [timezone_rid],
      [speed_type_rid],
      [temperature_type_rid],
      [created], 
      [active],
      [mobile_number],
      [email],
      [SMS],
      [inapp]
    )
    SELECT 
      customer_rid,
      contact_name, '',
      email_1, 
      language_rid, 
      timezone_rid, 
      speed_type_rid,
      temperature_type_rid,
      created,
      1,
      mobile_number_1,
      0,
      0,
      0
    FROM [dbo].[v1_contact] UNION ALL
    SELECT 
      customer_rid,
      contact_name, '',
      email_2, 
      language_rid, 
      timezone_rid, 
      speed_type_rid,
      temperature_type_rid,
      created,
      1,
      mobile_number_2,
      0,
      0,
      0
    FROM [dbo].[v1_contact] UNION ALL
    SELECT 
      customer_rid,
      contact_name, '',
      email_3, 
      language_rid, 
      timezone_rid, 
      speed_type_rid,
      temperature_type_rid,
      created,
      1,
      mobile_number_3,
      0,
      0,
      0
    FROM [dbo].[v1_contact] UNION ALL
    SELECT 
      customer_rid,
      contact_name, '',
      email_4, 
      language_rid, 
      timezone_rid, 
      speed_type_rid,
      temperature_type_rid,
      created,
      1,
      mobile_number_4,
      0,
      0,
      0
    FROM [dbo].[v1_contact] UNION ALL
    SELECT 
      customer_rid,
      contact_name, '',
      email_5, 
      language_rid, 
      timezone_rid, 
      speed_type_rid,
      temperature_type_rid,
      created,
      1,
      mobile_number_5,
      0,
      0,
      0
    FROM [dbo].[v1_contact];

    UPDATE ct SET ct.tenant_id=tenant.tenant_id 
    FROM [dbo].[contact]  AS ct INNER JOIN
        [dbo].[tenantinfo] as tenant ON ct.tenant_id = CAST(tenant.customer_rid AS NVARCHAR(255));
END
GO

