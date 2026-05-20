CREATE procedure [dbo].[control_table_rollback]
  AS
  BEGIN

        DECLARE @deleteuser_accountsrid INT;
        SELECT @deleteuser_accountsrid = minrid
        FROM control_table where  destinationTable = 'user_accounts';

        delete from user_accounts where user_rid > @deleteuser_accountsrid

        DECLARE @deleteaccount_detailsrid INT;
        SELECT @deleteaccount_detailsrid = minrid
        FROM control_table where  destinationTable = 'account_details';

        DELETE from account_details where account_rid > @deleteaccount_detailsrid

   END
GO

