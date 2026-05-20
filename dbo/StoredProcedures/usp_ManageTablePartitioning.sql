
CREATE   PROCEDURE [dbo].[usp_ManageTablePartitioning]
    @Mode varchar(20),
    @StartDate date,
    @EndDate date,
    @MinPartitionScore int = 40,
    @TargetSchema sysname = NULL,
    @OnlyTable sysname = NULL
AS
BEGIN
print 'TODO FIX THIS'
/*
    SET NOCOUNT ON;

    IF @Mode NOT IN ('DISCOVER', 'PREVIEW', 'APPLY', 'ROLLBACK')
    BEGIN
        RAISERROR('Invalid @Mode. Allowed values: DISCOVER, PREVIEW, APPLY, ROLLBACK.', 16, 1);
        RETURN;
    END;

    IF @StartDate >= @EndDate
    BEGIN
        RAISERROR('@StartDate must be earlier than @EndDate.', 16, 1);
        RETURN;
    END;

    IF OBJECT_ID('tempdb..#Candidates') IS NOT NULL DROP TABLE #Candidates;
    IF OBJECT_ID('tempdb..#Preview') IS NOT NULL DROP TABLE #Preview;
    IF OBJECT_ID('tempdb..#ApplyLog') IS NOT NULL DROP TABLE #ApplyLog;

    CREATE TABLE #Candidates
    (
        CandidateId int IDENTITY(1,1) PRIMARY KEY,
        object_id int NOT NULL,
        SchemaName sysname NOT NULL,
        TableName sysname NOT NULL,
        QualifiedTableName nvarchar(300) NOT NULL,
        RowCnt bigint NULL,
        DataMB decimal(18,2) NULL,
        HasDateColumn bit NULL,
        SuggestedPartitionColumn sysname NULL,
        MaxFragmentation decimal(10,2) NULL,
        PartitionScore int NULL,
        PartitionFunctionName sysname NULL,
        PartitionSchemeName sysname NULL,
        NewTableName sysname NULL,
        QualifiedNewTableName nvarchar(300) NULL
    );

    CREATE TABLE #Preview
    (
        CandidateId int,
        StepOrder int,
        StepName varchar(50),
        SchemaName sysname,
        TableName sysname,
        GeneratedSql nvarchar(max)
    );

    CREATE TABLE #ApplyLog
    (
        LogId int IDENTITY(1,1) PRIMARY KEY,
        CandidateId int,
        SchemaName sysname,
        TableName sysname,
        StepName varchar(50),
        ExecutedSql nvarchar(max),
        ExecutedAt datetime2(0) NOT NULL DEFAULT sysdatetime()
    );

    ;WITH TableStats AS
    (
        SELECT
            t.object_id,
            s.name AS SchemaName,
            t.name AS TableName,
            SUM(p.rows) AS RowCnt,
            SUM(a.used_pages) * 8.0 AS UsedKB,
            SUM(a.data_pages) * 8.0 AS DataKB,
            MAX(i.type_desc) AS IndexType
        FROM sys.tables t
        JOIN sys.schemas s
            ON s.schema_id = t.schema_id
        JOIN sys.indexes i
            ON t.object_id = i.object_id
        JOIN sys.partitions p
            ON i.object_id = p.object_id
           AND i.index_id = p.index_id
        JOIN sys.allocation_units a
            ON p.partition_id = a.container_id
        WHERE (@TargetSchema IS NULL OR s.name = @TargetSchema)
          AND (@OnlyTable IS NULL OR t.name = @OnlyTable)
        GROUP BY t.object_id, s.name, t.name
    ),
    DateColumns AS
    (
        SELECT
            t.object_id,
            MAX(CASE
                WHEN c.system_type_id IN (40, 41, 42, 43, 58, 61)
                  OR c.name LIKE '%date%'
                  OR c.name LIKE '%time%'
                THEN 1 ELSE 0 END) AS HasDateColumn
        FROM sys.tables t
        JOIN sys.columns c
            ON t.object_id = c.object_id
        GROUP BY t.object_id
    ),
    BestDateColumn AS
    (
        SELECT
            t.object_id,
            c.name AS ColumnName,
            ROW_NUMBER() OVER
            (
                PARTITION BY t.object_id
                ORDER BY
                    CASE
                        WHEN c.name LIKE '%createddate%' THEN 1
                        WHEN c.name LIKE '%orderdate%' THEN 2
                        WHEN c.name LIKE '%eventdate%' THEN 3
                        WHEN c.name LIKE '%modifieddate%' THEN 4
                        WHEN c.name LIKE '%date%' THEN 5
                        WHEN c.name LIKE '%time%' THEN 6
                        ELSE 99
                    END,
                    c.column_id
            ) AS rn
        FROM sys.tables t
        JOIN sys.columns c
            ON t.object_id = c.object_id
        WHERE c.system_type_id IN (40, 41, 42, 43, 58, 61)
           OR c.name LIKE '%date%'
           OR c.name LIKE '%time%'
    ),
    Fragmentation AS
    (
        SELECT
            ps.object_id,
            MAX(ps.avg_fragmentation_in_percent) AS MaxFragmentation
        FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'SAMPLED') ps
        GROUP BY ps.object_id
    )
    INSERT INTO #Candidates
    (
        object_id,
        SchemaName,
        TableName,
        QualifiedTableName,
        RowCnt,
        DataMB,
        HasDateColumn,
        SuggestedPartitionColumn,
        MaxFragmentation,
        PartitionScore,
        PartitionFunctionName,
        PartitionSchemeName,
        NewTableName,
        QualifiedNewTableName
    )
    SELECT
        ts.object_id,
        ts.SchemaName,
        ts.TableName,
        QUOTENAME(ts.SchemaName) + '.' + QUOTENAME(ts.TableName),
        ts.RowCnt,
        CAST(ts.DataKB / 1024.0 AS decimal(18,2)) AS DataMB,
        CAST(ISNULL(dc.HasDateColumn, 0) AS bit),
        bdc.ColumnName,
        CAST(ISNULL(f.MaxFragmentation, 0) AS decimal(10,2)),
        (
            CASE
                WHEN ts.RowCnt > 100000000 THEN 50
                WHEN ts.RowCnt > 10000000 THEN 40
                WHEN ts.RowCnt > 1000000 THEN 30
                ELSE 0
            END
            +
            CASE WHEN ISNULL(dc.HasDateColumn, 0) = 1 THEN 30 ELSE 0 END
            +
            CASE
                WHEN ISNULL(f.MaxFragmentation, 0) > 30 THEN 20
                WHEN ISNULL(f.MaxFragmentation, 0) > 10 THEN 10
                ELSE 0
            END
        ) AS PartitionScore,
        CONCAT('PF_', ts.SchemaName, '_', ts.TableName, '_', ISNULL(bdc.ColumnName, 'Date')),
        CONCAT('PS_', ts.SchemaName, '_', ts.TableName, '_', ISNULL(bdc.ColumnName, 'Date')),
        CONCAT(ts.TableName, '_Partitioned'),
        QUOTENAME(ts.SchemaName) + '.' + QUOTENAME(CONCAT(ts.TableName, '_Partitioned'))
    FROM TableStats ts
    LEFT JOIN DateColumns dc
        ON ts.object_id = dc.object_id
    LEFT JOIN Fragmentation f
        ON ts.object_id = f.object_id
    LEFT JOIN BestDateColumn bdc
        ON ts.object_id = bdc.object_id
       AND bdc.rn = 1
    WHERE
    (
        CASE
            WHEN ts.RowCnt > 100000000 THEN 50
            WHEN ts.RowCnt > 10000000 THEN 40
            WHEN ts.RowCnt > 1000000 THEN 30
            ELSE 0
        END
        +
        CASE WHEN ISNULL(dc.HasDateColumn, 0) = 1 THEN 30 ELSE 0 END
        +
        CASE
            WHEN ISNULL(f.MaxFragmentation, 0) > 30 THEN 20
            WHEN ISNULL(f.MaxFragmentation, 0) > 10 THEN 10
            ELSE 0
        END
    ) >= @MinPartitionScore
    AND ISNULL(dc.HasDateColumn, 0) = 1;

    IF @Mode = 'DISCOVER'
    BEGIN
        SELECT
            TableName,
            RowCnt,
            DataMB,
            HasDateColumn,
            SuggestedPartitionColumn,
            MaxFragmentation,
            PartitionScore
        FROM #Candidates
        ORDER BY PartitionScore DESC, DataMB DESC, RowCnt DESC;

        RETURN;
    END;

    DECLARE
        @CandidateId int,
        @SchemaName sysname,
        @TableName sysname,
        @QualifiedTableName nvarchar(300),
        @SuggestedPartitionColumn sysname,
        @PartitionFunctionName sysname,
        @PartitionSchemeName sysname,
        @NewTableName sysname,
        @QualifiedNewTableName nvarchar(300),
        @ObjectId int;

    DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT
        CandidateId,
        SchemaName,
        TableName,
        QualifiedTableName,
        SuggestedPartitionColumn,
        PartitionFunctionName,
        PartitionSchemeName,
        NewTableName,
        QualifiedNewTableName,
        object_id
    FROM #Candidates
    ORDER BY CandidateId;

    OPEN cur;

    FETCH NEXT FROM cur INTO
        @CandidateId,
        @SchemaName,
        @TableName,
        @QualifiedTableName,
        @SuggestedPartitionColumn,
        @PartitionFunctionName,
        @PartitionSchemeName,
        @NewTableName,
        @QualifiedNewTableName,
        @ObjectId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @BoundaryList nvarchar(max);
        DECLARE @CreatePF nvarchar(max);
        DECLARE @CreatePS nvarchar(max);
        DECLARE @CreateTable nvarchar(max);
        DECLARE @InsertData nvarchar(max);
        DECLARE @DropNewTable nvarchar(max);
        DECLARE @DropPS nvarchar(max);
        DECLARE @DropPF nvarchar(max);
        DECLARE @ColumnList nvarchar(max);
        DECLARE @CreateColumnList nvarchar(max);

        ;WITH MonthBoundaries AS
        (
            SELECT @StartDate AS BoundaryValue
            UNION ALL
            SELECT DATEADD(MONTH, 1, BoundaryValue)
            FROM MonthBoundaries
            WHERE DATEADD(MONTH, 1, BoundaryValue) < @EndDate
        )
        SELECT
            @BoundaryList = STRING_AGG(CONCAT('''', CONVERT(varchar(10), BoundaryValue, 120), ''''), ', ')
        FROM MonthBoundaries
        OPTION (MAXRECURSION 32767);

        SELECT
            @ColumnList = STRING_AGG(QUOTENAME(c.name), ', ')
        FROM sys.columns c
        WHERE c.object_id = @ObjectId;

        SELECT
            @CreateColumnList = STRING_AGG(
                QUOTENAME(c.name) + ' ' +
                CASE
                    WHEN ty.name IN ('varchar', 'char', 'varbinary', 'binary')
                        THEN ty.name + '(' + CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length AS varchar(10)) END + ')'
                    WHEN ty.name IN ('nvarchar', 'nchar')
                        THEN ty.name + '(' + CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length / 2 AS varchar(10)) END + ')'
                    WHEN ty.name IN ('decimal', 'numeric')
                        THEN ty.name + '(' + CAST(c.precision AS varchar(10)) + ',' + CAST(c.scale AS varchar(10)) + ')'
                    WHEN ty.name IN ('datetime2', 'datetimeoffset', 'time')
                        THEN ty.name + '(' + CAST(c.scale AS varchar(10)) + ')'
                    ELSE ty.name
                END + ' ' +
                CASE WHEN c.is_nullable = 1 THEN 'NULL' ELSE 'NOT NULL' END
            , ',' + CHAR(13) + CHAR(10))
        FROM sys.columns c
        JOIN sys.types ty
            ON c.user_type_id = ty.user_type_id
        WHERE c.object_id = @ObjectId;

        SET @CreatePF = '
CREATE PARTITION FUNCTION ' + QUOTENAME(@PartitionFunctionName) + ' (date)
AS RANGE RIGHT
FOR VALUES (' + @BoundaryList + ');';

        SET @CreatePS = '
CREATE PARTITION SCHEME ' + QUOTENAME(@PartitionSchemeName) + '
AS PARTITION ' + QUOTENAME(@PartitionFunctionName) + '
ALL TO ([PRIMARY]);';

        SET @CreateTable = '
CREATE TABLE ' + @QualifiedNewTableName + '
(
' + @CreateColumnList + '
)
ON ' + QUOTENAME(@PartitionSchemeName) + '(' + QUOTENAME(@SuggestedPartitionColumn) + ');';

        SET @InsertData = '
INSERT INTO ' + @QualifiedNewTableName + '
(' + @ColumnList + ')
SELECT ' + @ColumnList + '
FROM ' + @QualifiedTableName + ';';

        SET @DropNewTable = '
IF OBJECT_ID(''' + @QualifiedNewTableName + ''') IS NOT NULL
    DROP TABLE ' + @QualifiedNewTableName + ';';

        SET @DropPS = '
IF EXISTS (SELECT 1 FROM sys.partition_schemes WHERE name = ''' + @PartitionSchemeName + ''')
    DROP PARTITION SCHEME ' + QUOTENAME(@PartitionSchemeName) + ';';

        SET @DropPF = '
IF EXISTS (SELECT 1 FROM sys.partition_functions WHERE name = ''' + @PartitionFunctionName + ''')
    DROP PARTITION FUNCTION ' + QUOTENAME(@PartitionFunctionName) + ';';

        INSERT INTO #Preview (CandidateId, StepOrder, StepName, SchemaName, TableName, GeneratedSql)
        VALUES
        (@CandidateId, 1, 'CreatePartitionFunction', @SchemaName, @TableName, @CreatePF),
        (@CandidateId, 2, 'CreatePartitionScheme',   @SchemaName, @TableName, @CreatePS),
        (@CandidateId, 3, 'CreatePartitionedTable',  @SchemaName, @TableName, @CreateTable),
        (@CandidateId, 4, 'CopyData',                @SchemaName, @TableName, @InsertData),
        (@CandidateId, 5, 'RollbackDropTable',       @SchemaName, @TableName, @DropNewTable),
        (@CandidateId, 6, 'RollbackDropScheme',      @SchemaName, @TableName, @DropPS),
        (@CandidateId, 7, 'RollbackDropFunction',    @SchemaName, @TableName, @DropPF);

        IF @Mode = 'APPLY'
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM sys.partition_functions WHERE name = @PartitionFunctionName)
            BEGIN
                EXEC sp_executesql @CreatePF;
                INSERT INTO #ApplyLog (CandidateId, SchemaName, TableName, StepName, ExecutedSql)
                VALUES (@CandidateId, @SchemaName, @TableName, 'CreatePartitionFunction', @CreatePF);
            END;

            IF NOT EXISTS (SELECT 1 FROM sys.partition_schemes WHERE name = @PartitionSchemeName)
            BEGIN
                EXEC sp_executesql @CreatePS;
                INSERT INTO #ApplyLog (CandidateId, SchemaName, TableName, StepName, ExecutedSql)
                VALUES (@CandidateId, @SchemaName, @TableName, 'CreatePartitionScheme', @CreatePS);
            END;

            IF OBJECT_ID(@QualifiedNewTableName) IS NULL
            BEGIN
                EXEC sp_executesql @CreateTable;
                INSERT INTO #ApplyLog (CandidateId, SchemaName, TableName, StepName, ExecutedSql)
                VALUES (@CandidateId, @SchemaName, @TableName, 'CreatePartitionedTable', @CreateTable);
            END;

            DECLARE @CntSql nvarchar(max) = N'SELECT COUNT(*) AS Cnt FROM ' + @QualifiedNewTableName + ';';
            DECLARE @TargetCnt bigint;

            CREATE TABLE #TmpCnt (Cnt bigint);
            INSERT INTO #TmpCnt EXEC sp_executesql @CntSql;
            SELECT @TargetCnt = Cnt FROM #TmpCnt;
            DROP TABLE #TmpCnt;

            IF ISNULL(@TargetCnt, 0) = 0
            BEGIN
                EXEC sp_executesql @InsertData;
                INSERT INTO #ApplyLog (CandidateId, SchemaName, TableName, StepName, ExecutedSql)
                VALUES (@CandidateId, @SchemaName, @TableName, 'CopyData', @InsertData);
            END;
        END;

        IF @Mode = 'ROLLBACK'
        BEGIN
            IF OBJECT_ID(@QualifiedNewTableName) IS NOT NULL
            BEGIN
                EXEC sp_executesql @DropNewTable;
                INSERT INTO #ApplyLog (CandidateId, SchemaName, TableName, StepName, ExecutedSql)
                VALUES (@CandidateId, @SchemaName, @TableName, 'RollbackDropTable', @DropNewTable);
            END;

            IF EXISTS (SELECT 1 FROM sys.partition_schemes WHERE name = @PartitionSchemeName)
            BEGIN
                EXEC sp_executesql @DropPS;
                INSERT INTO #ApplyLog (CandidateId, SchemaName, TableName, StepName, ExecutedSql)
                VALUES (@CandidateId, @SchemaName, @TableName, 'RollbackDropScheme', @DropPS);
            END;

            IF EXISTS (SELECT 1 FROM sys.partition_functions WHERE name = @PartitionFunctionName)
            BEGIN
                EXEC sp_executesql @DropPF;
                INSERT INTO #ApplyLog (CandidateId, SchemaName, TableName, StepName, ExecutedSql)
                VALUES (@CandidateId, @SchemaName, @TableName, 'RollbackDropFunction', @DropPF);
            END;
        END;

        FETCH NEXT FROM cur INTO
            @CandidateId,
            @SchemaName,
            @TableName,
            @QualifiedTableName,
            @SuggestedPartitionColumn,
            @PartitionFunctionName,
            @PartitionSchemeName,
            @NewTableName,
            @QualifiedNewTableName,
            @ObjectId;
    END

    CLOSE cur;
    DEALLOCATE cur;

    IF @Mode = 'PREVIEW'
    BEGIN
        SELECT
            c.TableName,
            c.RowCnt,
            c.DataMB,
            c.SuggestedPartitionColumn,
            c.PartitionScore,
            p.StepOrder,
            p.StepName,
            p.GeneratedSql
        FROM #Preview p
        JOIN #Candidates c
            ON c.CandidateId = p.CandidateId
        ORDER BY c.PartitionScore DESC, c.TableName, p.StepOrder;
    END;

    IF @Mode IN ('APPLY', 'ROLLBACK')
    BEGIN
        SELECT
            LogId,
            SchemaName,
            TableName,
            StepName,
            ExecutedAt,
            ExecutedSql
        FROM #ApplyLog
        ORDER BY LogId;
    END;
*/
END;
GO

