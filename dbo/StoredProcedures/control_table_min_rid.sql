CREATE   procedure [dbo].[control_table_min_rid]
AS
BEGIN

print 'TODO FIX THIS'
/* TODO FIX THIS
DECLARE @minaccount_detailsrid INT;
SELECT @minaccount_detailsrid = MAX(account_rid)
FROM account_details;
UPDATE control_table set minrid=@minaccount_detailsrid where  destinationTable = 'account_details'

DECLARE @minuser_accountsrid INT;
SELECT @minuser_accountsrid = MAX(user_rid)
FROM user_accounts;
UPDATE control_table set minrid=@minuser_accountsrid  where  destinationTable = 'user_accounts'

*/END
GO

