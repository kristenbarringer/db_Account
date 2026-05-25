-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[v2_process_new_v1_user]
AS
BEGIN
print 'TODO FIX THIS'
/* TODO FIX THIS
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    BEGIN TRAN;

    DECLARE
        @v1_user_rid int,
        @v2_user_rid int,
        @v1_user_name nvarchar(255),
        @tenant_id nvarchar(255),
        @v1_customer_rid int,
        @v1_company_name nvarchar(255),
        @v2_organization nvarchar(255);          

    DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
        SELECT
            [v1_user_rid],
            [v1_user_name],
            [v2_user_rid],
            [tenant_id],
            [v1_customer_rid],
            [v1_company_name],
            [v2_organization]
        FROM [dbo].[v1_user_change_log]
        -- WHERE Processed = 0 ORDER BY ChangeLogId ASC;

    
    OPEN cur;
    FETCH NEXT FROM cur INTO @v1_user_rid, @v1_user_name, @v2_user_rid, @tenant_id, @v1_customer_rid,
                                @v1_company_name,@v2_organization;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @tenantcount int;
            SELECT @tenantcount=COUNT(1) FROM [dbo].[tenantinfo] AS A (nolock) WHERE A.[tenant_id] = @tenant_id AND A.v2_user_rid=@v2_user_rid;
            IF (@tenantcount=0)
                INSERT INTO tenantinfo(
                    [tenant_id],
                    [organization],
                    [company_name],
                    [customer_rid],
                    [user_rid],
                    [user_name],
                    [v2_user_rid]
                )
                VALUES (@tenant_id,@v2_organization, @v1_company_name,@v1_customer_rid,@v1_user_rid,@v1_user_name, @v2_user_rid);            

        FETCH NEXT FROM cur INTO @v1_user_rid, @v1_user_name, @v2_user_rid, @tenant_id, @v1_customer_rid,
                                @v1_company_name,@v2_organization;
        END
    CLOSE cur;
    DEALLOCATE cur;

    COMMIT TRAN;

    -- TRUNCATE TABLE [dbo].[v1_user_change_log];
*/END;
GO

