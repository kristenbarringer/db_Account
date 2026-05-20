CREATE PROCEDURE spr_update_tenant_lower_case
AS
BEGIN
print 'TODO - fix this'
/*
DECLARE @ColumnName NVARCHAR(128) = 'tenant_id'; -- Replace with your column name
DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = STRING_AGG(
    'UPDATE [' + TABLE_SCHEMA + '].[' + TABLE_NAME + '] ' +
    'SET [' + @ColumnName + '] = LOWER([' + @ColumnName + ']) ' +
    'WHERE [' + @ColumnName + '] IS NOT NULL;', 
    CHAR(13) + CHAR(10)
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = @ColumnName;

IF @SQL IS NOT NULL AND @SQL <> ''
BEGIN
    PRINT @SQL; 
    EXEC sp_executesql @SQL;
END
ELSE
BEGIN
    PRINT 'No tables found with the specified column.';
END
*/
END
GO

