-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[v2_process_contacts_changes_custom]
@PipeLine_Run_Id nvarchar(100)
AS
BEGIN
print 'TODO FIX THIS'
/* TODO FIX THIS
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
      [mobile_number]
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
      mobile_number_1
    FROM [dbo].[v1_contact] WHERE Pipeline_Id = @PipeLine_Run_Id AND (email_1  <> '' OR mobile_number_1  <> '') UNION ALL
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
      mobile_number_2
    FROM [dbo].[v1_contact] WHERE Pipeline_Id = @PipeLine_Run_Id AND (email_2  <> '' OR mobile_number_2  <> '') UNION ALL
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
      mobile_number_3
    FROM [dbo].[v1_contact] WHERE Pipeline_Id = @PipeLine_Run_Id AND (email_3  <> '' OR mobile_number_3  <> '') UNION ALL
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
      mobile_number_4
    FROM [dbo].[v1_contact] WHERE Pipeline_Id = @PipeLine_Run_Id AND (email_4  <> '' OR mobile_number_4  <> '') UNION ALL
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
      mobile_number_5
    FROM [dbo].[v1_contact] WHERE Pipeline_Id = @PipeLine_Run_Id AND (email_5  <> '' OR mobile_number_5  <> '');

    UPDATE ct SET ct.tenant_id=tenant.tenant_id 
    FROM [dbo].[contact]  AS ct INNER JOIN
        [dbo].[v1_contact] AS v1c ON ct.tenant_id = v1c.customer_rid AND v1c.Pipeline_Id = @PipeLine_Run_Id INNER JOIN
        [dbo].[tenantinfo] as tenant ON ct.tenant_id = CAST(tenant.customer_rid AS NVARCHAR(255));
*/ END
GO

