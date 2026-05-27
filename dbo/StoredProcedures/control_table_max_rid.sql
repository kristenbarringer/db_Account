CREATE procedure [dbo].[control_table_max_rid]
AS
BEGIN
print 'TODO FIX THIS'
/* TODO FIX THIS
    DECLARE @maxaccount_detailsrid INT;
    SELECT @maxaccount_detailsrid = MAX(account_rid)
    FROM account_details;

    UPDATE control_table set maxrid=@maxaccount_detailsrid where destinationTable = 'account_details';

    DECLARE @maxuser_accountsrid INT;
    SELECT @maxuser_accountsrid = MAX(user_rid)
    FROM user_accounts;

    UPDATE control_table set maxrid=@maxuser_accountsrid where destinationTable = 'user_accounts';
*/
END
GO

