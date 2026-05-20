CREATE PROCEDURE [dbo].[usp_dq_data_integrity_check]
AS
BEGIN
    SET NOCOUNT ON;

    -- Clear previous unresolved issues from this check run
    --TODO do I need this? -- DELETE FROM dbo.dq_data_integrity_check WHERE ResolvedDate IS NULL;

    INSERT INTO dbo.dq_data_integrity_check
        (CheckName, TableName, ColumnName, OffendingValue, RowKey, ExpectedCategory, Notes)
    SELECT
        'WrongLookupCategory',
        'dbo.Employee',
        'DesignationCode',
        e.account_type_code, 
        CAST(e.account_rid AS NVARCHAR(50)),
        'DesignationType',
        'Code does not belong to expected category'
        -- select *
    FROM [dbo].[account_details]  e
    LEFT JOIN dbo.lookup_code lc
        ON lc.code = e.account_type_code
       AND lc.lookup_list_code = 'account_type'
    WHERE e.account_type_code 
    IS NOT NULL
      AND lc.code IS NULL;


    -- Repeat the INSERT block for each FK column that should match a specific category
    -- e.g., Employee.StatusCode → StatusCode, Vehicle.RegionCode → Region, etc.

END
