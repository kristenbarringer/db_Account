
CREATE   PROCEDURE [dbo].[IndexRecom_WithTempLog]
    @MinMissingIndexImprovement DECIMAL(18,2) = 100,
    @MinPageCount INT = 1000,
    @ReorganizeMinFrag DECIMAL(5,2) = 10.0,
    @RebuildMinFrag DECIMAL(5,2) = 30.0,
    @MinUnusedIndexUpdates BIGINT = 100,
    @ExecuteActions BIT = 0,
    @IncludeCreate BIT = 1,
    @IncludeAlter BIT = 1,
    @IncludeDrop BIT = 0,
    @UseTransaction BIT = 0,
    @RollbackOnError BIT = 1,
    @ForceRollback BIT = 0
AS
BEGIN
print 'TODO fix this'
/*
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @HasFailure BIT = 0;
    DECLARE @TransactionStarted BIT = 0;

    IF OBJECT_ID('tempdb..#Recommendations') IS NOT NULL
        DROP TABLE #Recommendations;

    IF OBJECT_ID('tempdb..#ExecutionLog') IS NOT NULL
        DROP TABLE #ExecutionLog;

    CREATE TABLE #Recommendations
    (
        rec_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        action_type VARCHAR(20) NOT NULL,
        recommendation_source VARCHAR(50) NOT NULL,
        schema_name SYSNAME NOT NULL,
        table_name SYSNAME NOT NULL,
        index_name SYSNAME NULL,
        priority_score DECIMAL(18,2) NULL,
        reason VARCHAR(1000) NULL,
        create_script NVARCHAR(MAX) NULL,
        alter_script NVARCHAR(MAX) NULL,
        drop_script NVARCHAR(MAX) NULL
    );

    CREATE TABLE #ExecutionLog
    (
        log_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        rec_id INT NOT NULL,
        action_type VARCHAR(20) NOT NULL,
        recommendation_source VARCHAR(50) NOT NULL,
        schema_name SYSNAME NOT NULL,
        table_name SYSNAME NOT NULL,
        index_name SYSNAME NULL,
        executed_sql NVARCHAR(MAX) NULL,
        execution_start_time DATETIME2(0) NOT NULL,
        execution_end_time DATETIME2(0) NULL,
        execution_status VARCHAR(20) NOT NULL,
        error_number INT NULL,
        error_message NVARCHAR(4000) NULL
    );

    ;WITH MissingIndexRecs AS
    (
        SELECT
            'CREATE' AS action_type,
            'MISSING_INDEX' AS recommendation_source,
            OBJECT_SCHEMA_NAME(mid.object_id) AS schema_name,
            OBJECT_NAME(mid.object_id) AS table_name,
            CAST(NULL AS SYSNAME) AS index_name,
            CAST(
                (
                    (migs.user_seeks + migs.user_scans)
                    * migs.avg_total_user_cost
                    * (migs.avg_user_impact / 100.0)
                ) AS DECIMAL(18,2)
            ) AS priority_score,
            'Review missing-index DMV suggestion before creating.' AS reason,
            'CREATE INDEX '
            + QUOTENAME(
                LEFT(
                    'IX_' + OBJECT_NAME(mid.object_id) + '_'
                    + REPLACE(REPLACE(REPLACE(ISNULL(mid.equality_columns, ''), '[', ''), ']', ''), ', ', '_')
                    + CASE
                        WHEN mid.inequality_columns IS NOT NULL
                            THEN '_' + REPLACE(REPLACE(REPLACE(mid.inequality_columns, '[', ''), ']', ''), ', ', '_')
                        ELSE ''
                    END,
                    128
                )
            )
            + ' ON '
            + QUOTENAME(OBJECT_SCHEMA_NAME(mid.object_id))
            + '.'
            + QUOTENAME(OBJECT_NAME(mid.object_id))
            + ' ('
            + ISNULL(mid.equality_columns, '')
            + CASE
                WHEN mid.equality_columns IS NOT NULL
                 AND mid.inequality_columns IS NOT NULL
                    THEN ', '
                ELSE ''
            END
            + ISNULL(mid.inequality_columns, '')
            + ')'
            + CASE
                WHEN mid.included_columns IS NOT NULL
                    THEN ' INCLUDE (' + mid.included_columns + ')'
                ELSE ''
            END
            + ';' AS create_script,
            CAST(NULL AS NVARCHAR(MAX)) AS alter_script,
            CAST(NULL AS NVARCHAR(MAX)) AS drop_script
        FROM sys.dm_db_missing_index_groups mig
        INNER JOIN sys.dm_db_missing_index_group_stats migs
            ON mig.index_group_handle = migs.group_handle
        INNER JOIN sys.dm_db_missing_index_details mid
            ON mig.index_handle = mid.index_handle
        WHERE mid.database_id = DB_ID()
          AND CAST(
                (
                    (migs.user_seeks + migs.user_scans)
                    * migs.avg_total_user_cost
                    * (migs.avg_user_impact / 100.0)
                ) AS DECIMAL(18,2)
              ) >= @MinMissingIndexImprovement
    ),
    FkMissingIndexRecs AS
    (
        SELECT
            'CREATE' AS action_type,
            'FK_MISSING_INDEX' AS recommendation_source,
            SCHEMA_NAME(t.schema_id) AS schema_name,
            OBJECT_NAME(fk.parent_object_id) AS table_name,
            CAST(NULL AS SYSNAME) AS index_name,
            CAST(NULL AS DECIMAL(18,2)) AS priority_score,
            'Foreign key column does not appear as a leading key in an enabled index.' AS reason,
            'CREATE INDEX '
            + QUOTENAME(LEFT('IX_' + OBJECT_NAME(fk.parent_object_id) + '_' + c1.name, 128))
            + ' ON '
            + QUOTENAME(SCHEMA_NAME(t.schema_id))
            + '.'
            + QUOTENAME(OBJECT_NAME(fk.parent_object_id))
            + ' ('
            + QUOTENAME(c1.name)
            + ');' AS create_script,
            CAST(NULL AS NVARCHAR(MAX)) AS alter_script,
            CAST(NULL AS NVARCHAR(MAX)) AS drop_script
        FROM sys.foreign_keys fk
        INNER JOIN sys.foreign_key_columns fkc
            ON fk.object_id = fkc.constraint_object_id
        INNER JOIN sys.columns c1
            ON fkc.parent_object_id = c1.object_id
           AND fkc.parent_column_id = c1.column_id
        INNER JOIN sys.tables t
            ON fk.parent_object_id = t.object_id
        WHERE t.is_ms_shipped = 0
          AND NOT EXISTS
          (
              SELECT 1
              FROM sys.index_columns ic
              INNER JOIN sys.indexes i
                  ON ic.object_id = i.object_id
                 AND ic.index_id = i.index_id
              WHERE ic.object_id = fk.parent_object_id
                AND ic.column_id = c1.column_id
                AND ic.is_included_column = 0
                AND ic.key_ordinal = 1
                AND i.is_disabled = 0
                AND i.is_hypothetical = 0
          )
    ),
    IndexMaintenanceRecs AS
    (
        SELECT
            'ALTER' AS action_type,
            'INDEX_FRAGMENTATION' AS recommendation_source,
            s.name AS schema_name,
            t.name AS table_name,
            i.name AS index_name,
            CAST(ips.avg_fragmentation_in_percent AS DECIMAL(18,2)) AS priority_score,
            'Fragmentation='
            + CAST(CAST(ips.avg_fragmentation_in_percent AS DECIMAL(18,2)) AS VARCHAR(30))
            + '%, PageCount='
            + CAST(ips.page_count AS VARCHAR(30)) AS reason,
            CAST(NULL AS NVARCHAR(MAX)) AS create_script,
            CASE
                WHEN ips.avg_fragmentation_in_percent >= @RebuildMinFrag
                    THEN 'ALTER INDEX '
                         + QUOTENAME(i.name)
                         + ' ON '
                         + QUOTENAME(s.name)
                         + '.'
                         + QUOTENAME(t.name)
                         + ' REBUILD;'
                WHEN ips.avg_fragmentation_in_percent >= @ReorganizeMinFrag
                    THEN 'ALTER INDEX '
                         + QUOTENAME(i.name)
                         + ' ON '
                         + QUOTENAME(s.name)
                         + '.'
                         + QUOTENAME(t.name)
                         + ' REORGANIZE;'
            END AS alter_script,
            CAST(NULL AS NVARCHAR(MAX)) AS drop_script
        FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
        INNER JOIN sys.indexes i
            ON ips.object_id = i.object_id
           AND ips.index_id = i.index_id
        INNER JOIN sys.tables t
            ON i.object_id = t.object_id
        INNER JOIN sys.schemas s
            ON t.schema_id = s.schema_id
        WHERE ips.index_id > 0
          AND i.name IS NOT NULL
          AND ips.page_count >= @MinPageCount
          AND ips.avg_fragmentation_in_percent >= @ReorganizeMinFrag
          AND i.is_disabled = 0
          AND i.is_hypothetical = 0
    ),
    UnusedIndexDropRecs AS
    (
        SELECT
            'DROP' AS action_type,
            'UNUSED_INDEX' AS recommendation_source,
            SCHEMA_NAME(t.schema_id) AS schema_name,
            t.name AS table_name,
            i.name AS index_name,
            CAST(ISNULL(us.user_updates, 0) AS DECIMAL(18,2)) AS priority_score,
            'No seeks/scans/lookups recorded; updates='
            + CAST(ISNULL(us.user_updates, 0) AS VARCHAR(30))
            + '. Review workload history before dropping.' AS reason,
            CAST(NULL AS NVARCHAR(MAX)) AS create_script,
            CAST(NULL AS NVARCHAR(MAX)) AS alter_script,
            'DROP INDEX '
            + QUOTENAME(i.name)
            + ' ON '
            + QUOTENAME(SCHEMA_NAME(t.schema_id))
            + '.'
            + QUOTENAME(t.name)
            + ';' AS drop_script
        FROM sys.indexes i
        INNER JOIN sys.tables t
            ON i.object_id = t.object_id
        LEFT JOIN sys.dm_db_index_usage_stats us
            ON us.database_id = DB_ID()
           AND us.object_id = i.object_id
           AND us.index_id = i.index_id
        WHERE t.is_ms_shipped = 0
          AND i.index_id > 1
          AND i.is_primary_key = 0
          AND i.is_unique = 0
          AND i.is_unique_constraint = 0
          AND i.has_filter = 0
          AND i.is_disabled = 0
          AND i.is_hypothetical = 0
          AND ISNULL(us.user_seeks, 0) = 0
          AND ISNULL(us.user_scans, 0) = 0
          AND ISNULL(us.user_lookups, 0) = 0
          AND ISNULL(us.user_updates, 0) >= @MinUnusedIndexUpdates
    )
    INSERT INTO #Recommendations
    (
        action_type,
        recommendation_source,
        schema_name,
        table_name,
        index_name,
        priority_score,
        reason,
        create_script,
        alter_script,
        drop_script
    )
    SELECT action_type, recommendation_source, schema_name, table_name, index_name,
           priority_score, reason, create_script, alter_script, drop_script
    FROM MissingIndexRecs
    WHERE @IncludeCreate = 1

    UNION ALL

    SELECT action_type, recommendation_source, schema_name, table_name, index_name,
           priority_score, reason, create_script, alter_script, drop_script
    FROM FkMissingIndexRecs
    WHERE @IncludeCreate = 1

    UNION ALL

    SELECT action_type, recommendation_source, schema_name, table_name, index_name,
           priority_score, reason, create_script, alter_script, drop_script
    FROM IndexMaintenanceRecs
    WHERE @IncludeAlter = 1

    UNION ALL

    SELECT action_type, recommendation_source, schema_name, table_name, index_name,
           priority_score, reason, create_script, alter_script, drop_script
    FROM UnusedIndexDropRecs
    WHERE @IncludeDrop = 1;

    IF @ExecuteActions = 1
    BEGIN
        IF @UseTransaction = 1 AND @@TRANCOUNT = 0
        BEGIN
            BEGIN TRANSACTION;
            SET @TransactionStarted = 1;
        END;

        DECLARE
            @rec_id INT,
            @action_type VARCHAR(20),
            @recommendation_source VARCHAR(50),
            @schema_name SYSNAME,
            @table_name SYSNAME,
            @index_name SYSNAME,
            @sql NVARCHAR(MAX),
            @execution_start_time DATETIME2(0);

        DECLARE recommendation_cursor CURSOR LOCAL FAST_FORWARD FOR
            SELECT
                rec_id,
                action_type,
                recommendation_source,
                schema_name,
                table_name,
                index_name,
                COALESCE(create_script, alter_script, drop_script) AS sql_to_execute
            FROM #Recommendations
            ORDER BY
                CASE action_type
                    WHEN 'CREATE' THEN 1
                    WHEN 'ALTER' THEN 2
                    WHEN 'DROP' THEN 3
                    ELSE 4
                END,
                priority_score DESC,
                schema_name,
                table_name,
                index_name;

        OPEN recommendation_cursor;

        FETCH NEXT FROM recommendation_cursor
        INTO @rec_id, @action_type, @recommendation_source, @schema_name, @table_name, @index_name, @sql;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @execution_start_time = SYSDATETIME();

            IF XACT_STATE() <> -1
            BEGIN
                INSERT INTO #ExecutionLog
                (
                    rec_id,
                    action_type,
                    recommendation_source,
                    schema_name,
                    table_name,
                    index_name,
                    executed_sql,
                    execution_start_time,
                    execution_status
                )
                VALUES
                (
                    @rec_id,
                    @action_type,
                    @recommendation_source,
                    @schema_name,
                    @table_name,
                    @index_name,
                    @sql,
                    @execution_start_time,
                    'RUNNING'
                );
            END;

            BEGIN TRY
                EXEC sys.sp_executesql @sql;

                IF XACT_STATE() <> -1
                BEGIN
                    UPDATE #ExecutionLog
                    SET
                        execution_end_time = SYSDATETIME(),
                        execution_status = 'SUCCESS'
                    WHERE rec_id = @rec_id
                      AND execution_start_time = @execution_start_time;
                END
            END TRY
            BEGIN CATCH
                SET @HasFailure = 1;

                IF XACT_STATE() = -1
                BEGIN
                    IF @@TRANCOUNT > 0
                        ROLLBACK TRANSACTION;
                    SET @TransactionStarted = 0;
                    BREAK;
                END;

                UPDATE #ExecutionLog
                SET
                    execution_end_time = SYSDATETIME(),
                    execution_status = 'FAILED',
                    error_number = ERROR_NUMBER(),
                    error_message = ERROR_MESSAGE()
                WHERE rec_id = @rec_id
                  AND execution_start_time = @execution_start_time;

                IF @UseTransaction = 1 AND @RollbackOnError = 1
                BEGIN
                    IF @@TRANCOUNT > 0
                        ROLLBACK TRANSACTION;
                    SET @TransactionStarted = 0;
                    BREAK;
                END;
            END CATCH;

            FETCH NEXT FROM recommendation_cursor
            INTO @rec_id, @action_type, @recommendation_source, @schema_name, @table_name, @index_name, @sql;
        END;

        CLOSE recommendation_cursor;
        DEALLOCATE recommendation_cursor;

        IF @TransactionStarted = 1
        BEGIN
            IF @ForceRollback = 1
            BEGIN
                ROLLBACK TRANSACTION;
                SET @TransactionStarted = 0;

                INSERT INTO #ExecutionLog
                (
                    rec_id, action_type, recommendation_source, schema_name, table_name,
                    index_name, executed_sql, execution_start_time, execution_end_time,
                    execution_status, error_message
                )
                VALUES
                (
                    0, 'ROLLBACK', 'TRANSACTION_CONTROL', '', '',
                    NULL, NULL, SYSDATETIME(), SYSDATETIME(),
                    'ROLLED_BACK', 'Transaction was rolled back because @ForceRollback = 1.'
                );
            END
            ELSE IF @HasFailure = 1 AND @RollbackOnError = 1
            BEGIN
                ROLLBACK TRANSACTION;
                SET @TransactionStarted = 0;

                INSERT INTO #ExecutionLog
                (
                    rec_id, action_type, recommendation_source, schema_name, table_name,
                    index_name, executed_sql, execution_start_time, execution_end_time,
                    execution_status, error_message
                )
                VALUES
                (
                    0, 'ROLLBACK', 'TRANSACTION_CONTROL', '', '',
                    NULL, NULL, SYSDATETIME(), SYSDATETIME(),
                    'ROLLED_BACK', 'Transaction was rolled back because an error occurred and @RollbackOnError = 1.'
                );
            END
            ELSE
            BEGIN
                COMMIT TRANSACTION;
                SET @TransactionStarted = 0;

                INSERT INTO #ExecutionLog
                (
                    rec_id, action_type, recommendation_source, schema_name, table_name,
                    index_name, executed_sql, execution_start_time, execution_end_time,
                    execution_status, error_message
                )
                VALUES
                (
                    0, 'COMMIT', 'TRANSACTION_CONTROL', '', '',
                    NULL, NULL, SYSDATETIME(), SYSDATETIME(),
                    'COMMITTED', 'Transaction committed successfully.'
                );
            END
        END
    END;

    SELECT
        rec_id,
        action_type,
        recommendation_source,
        schema_name,
        table_name,
        index_name,
        priority_score,
        reason,
        create_script,
        alter_script,
        drop_script
    FROM #Recommendations
    ORDER BY
        CASE action_type
            WHEN 'CREATE' THEN 1
            WHEN 'ALTER' THEN 2
            WHEN 'DROP' THEN 3
            ELSE 4
        END,
        priority_score DESC,
        schema_name,
        table_name,
        index_name;

    SELECT
        log_id,
        rec_id,
        action_type,
        recommendation_source,
        schema_name,
        table_name,
        index_name,
        executed_sql,
        execution_start_time,
        execution_end_time,
        execution_status,
        error_number,
        error_message
    FROM #ExecutionLog
    ORDER BY log_id;
    */
END;
GO

