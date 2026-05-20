

CREATE   PROCEDURE [dbo].[usp_StandardizeConstraintAndIndexNames]
    @PreviewOnly BIT = 1,
    @RunId UNIQUEIDENTIFIER = NULL
AS
BEGIN
print 'TODO FIX THIS'
/*
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @RunId IS NULL
        SET @RunId = NEWID();

    DECLARE @Candidates TABLE
    (
        row_id INT IDENTITY(1,1) PRIMARY KEY,
        object_type NVARCHAR(50) NOT NULL,
        schema_name SYSNAME NOT NULL,
        table_name SYSNAME NULL,
        current_name SYSNAME NOT NULL,
        proposed_name SYSNAME NOT NULL,
        rename_command NVARCHAR(MAX) NULL,
        validation_status NVARCHAR(50) NULL,
        validation_message NVARCHAR(4000) NULL
    );

    DECLARE @Log TABLE
    (
        log_id INT IDENTITY(1,1) PRIMARY KEY,
        run_id UNIQUEIDENTIFIER NOT NULL,
        log_datetime DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
        object_type NVARCHAR(50) NOT NULL,
        schema_name SYSNAME NOT NULL,
        table_name SYSNAME NULL,
        current_name SYSNAME NOT NULL,
        proposed_name SYSNAME NOT NULL,
        rename_command NVARCHAR(MAX) NULL,
        execution_status NVARCHAR(50) NOT NULL,
        error_number INT NULL,
        error_message NVARCHAR(4000) NULL
    );

    ;WITH pk_uq_cols AS
    (
        SELECT
            kc.object_id AS constraint_object_id,
            STRING_AGG(c.name, '_') WITHIN GROUP (ORDER BY ic.key_ordinal) AS column_list
        FROM sys.key_constraints AS kc
        INNER JOIN sys.index_columns AS ic
            ON kc.parent_object_id = ic.object_id
           AND kc.unique_index_id = ic.index_id
        INNER JOIN sys.columns AS c
            ON ic.object_id = c.object_id
           AND ic.column_id = c.column_id
        GROUP BY kc.object_id
    ),
    fk_names AS
    (
        SELECT
            fk.object_id,
            OBJECT_SCHEMA_NAME(fk.parent_object_id) AS schema_name,
            OBJECT_NAME(fk.parent_object_id) AS table_name,
            fk.name AS current_name,
            LEFT(
                'FK_' + OBJECT_NAME(fk.parent_object_id) + '_' + OBJECT_NAME(fk.referenced_object_id),
                128
            ) AS proposed_name
        FROM sys.foreign_keys AS fk
    ),
    ck_names AS
    (
        SELECT
            cc.object_id,
            OBJECT_SCHEMA_NAME(cc.parent_object_id) AS schema_name,
            OBJECT_NAME(cc.parent_object_id) AS table_name,
            cc.name AS current_name,
            LEFT(
                'CK_' + OBJECT_NAME(cc.parent_object_id) + '_' + CAST(cc.object_id AS VARCHAR(20)),
                128
            ) AS proposed_name
        FROM sys.check_constraints AS cc
    ),
    df_names AS
    (
        SELECT
            dc.object_id,
            OBJECT_SCHEMA_NAME(dc.parent_object_id) AS schema_name,
            OBJECT_NAME(dc.parent_object_id) AS table_name,
            dc.name AS current_name,
            LEFT(
                'DF_' + OBJECT_NAME(dc.parent_object_id) + '_' + col.name,
                128
            ) AS proposed_name
        FROM sys.default_constraints AS dc
        INNER JOIN sys.columns AS col
            ON dc.parent_object_id = col.object_id
           AND dc.parent_column_id = col.column_id
    ),
    key_names AS
    (
        SELECT
            kc.object_id,
            OBJECT_SCHEMA_NAME(kc.parent_object_id) AS schema_name,
            OBJECT_NAME(kc.parent_object_id) AS table_name,
            kc.name AS current_name,
            LEFT(
                CASE
                    WHEN kc.type = 'PK' THEN
                        'PK_' + OBJECT_NAME(kc.parent_object_id)
                    WHEN kc.type = 'UQ' THEN
                        'UQ_' + OBJECT_NAME(kc.parent_object_id) + '_' + ISNULL(puc.column_list, 'COL')
                END,
                128
            ) AS proposed_name,
            kc.type_desc AS object_type
        FROM sys.key_constraints AS kc
        LEFT JOIN pk_uq_cols AS puc
            ON kc.object_id = puc.constraint_object_id
    ),
    ix_names AS
    (
        SELECT
            i.object_id,
            i.index_id,
            s.name AS schema_name,
            t.name AS table_name,
            i.name AS current_name,
            LEFT(
                'IDX_' + t.name + '_' +
                ISNULL(
                    STRING_AGG(c.name, '_') WITHIN GROUP (ORDER BY ic.key_ordinal),
                    'COL'
                ),
                128
            ) AS proposed_name
        FROM sys.indexes AS i
        INNER JOIN sys.tables AS t
            ON i.object_id = t.object_id
        INNER JOIN sys.schemas AS s
            ON t.schema_id = s.schema_id
        LEFT JOIN sys.index_columns AS ic
            ON i.object_id = ic.object_id
           AND i.index_id = ic.index_id
           AND ic.is_included_column = 0
        LEFT JOIN sys.columns AS c
            ON ic.object_id = c.object_id
           AND ic.column_id = c.column_id
        WHERE i.index_id > 0
          AND i.is_primary_key = 0
          AND i.is_unique_constraint = 0
          AND i.name IS NOT NULL
          AND i.type IN (1, 2)
        GROUP BY
            i.object_id,
            i.index_id,
            s.name,
            t.name,
            i.name
    )
    INSERT INTO @Candidates
    (
        object_type,
        schema_name,
        table_name,
        current_name,
        proposed_name,
        rename_command,
        validation_status,
        validation_message
    )
    SELECT
        key_names.object_type,
        key_names.schema_name,
        key_names.table_name,
        key_names.current_name,
        key_names.proposed_name,
        CASE
            WHEN key_names.current_name <> key_names.proposed_name
            THEN 'EXEC sp_rename '''
                 + QUOTENAME(key_names.schema_name) + '.'
                 + QUOTENAME(key_names.current_name)
                 + ''', '''
                 + key_names.proposed_name
                 + ''', ''OBJECT'';'
        END,
        CASE
            WHEN key_names.current_name = key_names.proposed_name THEN 'SKIPPED'
            ELSE 'READY'
        END,
        CASE
            WHEN key_names.current_name = key_names.proposed_name THEN 'Name already matches standard'
            ELSE NULL
        END
    FROM key_names

    UNION ALL

    SELECT
        'FOREIGN_KEY',
        fk_names.schema_name,
        fk_names.table_name,
        fk_names.current_name,
        fk_names.proposed_name,
        CASE
            WHEN fk_names.current_name <> fk_names.proposed_name
            THEN 'EXEC sp_rename '''
                 + QUOTENAME(fk_names.schema_name) + '.'
                 + QUOTENAME(fk_names.current_name)
                 + ''', '''
                 + fk_names.proposed_name
                 + ''', ''OBJECT'';'
        END,
        CASE
            WHEN fk_names.current_name = fk_names.proposed_name THEN 'SKIPPED'
            ELSE 'READY'
        END,
        CASE
            WHEN fk_names.current_name = fk_names.proposed_name THEN 'Name already matches standard'
            ELSE NULL
        END
    FROM fk_names

    UNION ALL

    SELECT
        'CHECK_CONSTRAINT',
        ck_names.schema_name,
        ck_names.table_name,
        ck_names.current_name,
        ck_names.proposed_name,
        CASE
            WHEN ck_names.current_name <> ck_names.proposed_name
            THEN 'EXEC sp_rename '''
                 + QUOTENAME(ck_names.schema_name) + '.'
                 + QUOTENAME(ck_names.current_name)
                 + ''', '''
                 + ck_names.proposed_name
                 + ''', ''OBJECT'';'
        END,
        CASE
            WHEN ck_names.current_name = ck_names.proposed_name THEN 'SKIPPED'
            ELSE 'READY'
        END,
        CASE
            WHEN ck_names.current_name = ck_names.proposed_name THEN 'Name already matches standard'
            ELSE NULL
        END
    FROM ck_names

    UNION ALL

    SELECT
        'DEFAULT_CONSTRAINT',
        df_names.schema_name,
        df_names.table_name,
        df_names.current_name,
        df_names.proposed_name,
        CASE
            WHEN df_names.current_name <> df_names.proposed_name
            THEN 'EXEC sp_rename '''
                 + QUOTENAME(df_names.schema_name) + '.'
                 + QUOTENAME(df_names.current_name)
                 + ''', '''
                 + df_names.proposed_name
                 + ''', ''OBJECT'';'
        END,
        CASE
            WHEN df_names.current_name = df_names.proposed_name THEN 'SKIPPED'
            ELSE 'READY'
        END,
        CASE
            WHEN df_names.current_name = df_names.proposed_name THEN 'Name already matches standard'
            ELSE NULL
        END
    FROM df_names

    UNION ALL

    SELECT
        'INDEX',
        ix_names.schema_name,
        ix_names.table_name,
        ix_names.current_name,
        ix_names.proposed_name,
        CASE
            WHEN ix_names.current_name <> ix_names.proposed_name
            THEN 'EXEC sp_rename '''
                 + QUOTENAME(ix_names.schema_name) + '.'
                 + QUOTENAME(ix_names.table_name) + '.'
                 + QUOTENAME(ix_names.current_name)
                 + ''', '''
                 + ix_names.proposed_name
                 + ''', ''INDEX'';'
        END,
        CASE
            WHEN ix_names.current_name = ix_names.proposed_name THEN 'SKIPPED'
            ELSE 'READY'
        END,
        CASE
            WHEN ix_names.current_name = ix_names.proposed_name THEN 'Name already matches standard'
            ELSE NULL
        END
    FROM ix_names;

    UPDATE c
    SET
        validation_status = 'DUPLICATE_PROPOSED_NAME',
        validation_message = 'Duplicate proposed name detected in candidate set'
    FROM @Candidates AS c
    INNER JOIN
    (
        SELECT
            schema_name,
            proposed_name
        FROM @Candidates
        WHERE rename_command IS NOT NULL
        GROUP BY
            schema_name,
            proposed_name
        HAVING COUNT(*) > 1
    ) AS d
        ON c.schema_name = d.schema_name
       AND c.proposed_name = d.proposed_name
    WHERE c.rename_command IS NOT NULL;

    INSERT INTO @Log
    (
        run_id,
        object_type,
        schema_name,
        table_name,
        current_name,
        proposed_name,
        rename_command,
        execution_status,
        error_number,
        error_message
    )
    SELECT
        @RunId,
        object_type,
        schema_name,
        table_name,
        current_name,
        proposed_name,
        rename_command,
        CASE WHEN @PreviewOnly = 1 THEN 'PREVIEW' ELSE validation_status END,
        NULL,
        validation_message
    FROM @Candidates;

    IF @PreviewOnly = 1
    BEGIN
        SELECT
            log_id,
            run_id,
            log_datetime,
            object_type,
            schema_name,
            table_name,
            current_name,
            proposed_name,
            rename_command,
            execution_status,
            error_number,
            error_message
        FROM @Log
        ORDER BY schema_name, table_name, object_type, current_name;

        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM @Candidates
        WHERE validation_status NOT IN ('READY', 'SKIPPED')
    )
    BEGIN
        SELECT
            log_id,
            run_id,
            log_datetime,
            object_type,
            schema_name,
            table_name,
            current_name,
            proposed_name,
            rename_command,
            execution_status,
            error_number,
            error_message
        FROM @Log
        ORDER BY schema_name, table_name, object_type, current_name;

        RAISERROR('Validation failed. Review result set before executing changes.', 16, 1);
        RETURN;
    END;

    DECLARE
        @row_id INT,
        @object_type NVARCHAR(50),
        @schema_name SYSNAME,
        @table_name SYSNAME,
        @current_name SYSNAME,
        @proposed_name SYSNAME,
        @rename_command NVARCHAR(MAX);

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE rename_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT
            row_id,
            object_type,
            schema_name,
            table_name,
            current_name,
            proposed_name,
            rename_command
        FROM @Candidates
        WHERE validation_status = 'READY'
        ORDER BY schema_name, table_name, object_type, current_name;

        OPEN rename_cursor;

        FETCH NEXT FROM rename_cursor
        INTO @row_id, @object_type, @schema_name, @table_name, @current_name, @proposed_name, @rename_command;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                EXEC sp_executesql @rename_command;

                INSERT INTO @Log
                (
                    run_id,
                    object_type,
                    schema_name,
                    table_name,
                    current_name,
                    proposed_name,
                    rename_command,
                    execution_status,
                    error_number,
                    error_message
                )
                VALUES
                (
                    @RunId,
                    @object_type,
                    @schema_name,
                    @table_name,
                    @current_name,
                    @proposed_name,
                    @rename_command,
                    'SUCCESS',
                    NULL,
                    NULL
                );
            END TRY
            BEGIN CATCH
                INSERT INTO @Log
                (
                    run_id,
                    object_type,
                    schema_name,
                    table_name,
                    current_name,
                    proposed_name,
                    rename_command,
                    execution_status,
                    error_number,
                    error_message
                )
                VALUES
                (
                    @RunId,
                    @object_type,
                    @schema_name,
                    @table_name,
                    @current_name,
                    @proposed_name,
                    @rename_command,
                    'FAILED',
                    ERROR_NUMBER(),
                    ERROR_MESSAGE()
                );

                THROW;
            END CATCH;

            FETCH NEXT FROM rename_cursor
            INTO @row_id, @object_type, @schema_name, @table_name, @current_name, @proposed_name, @rename_command;
        END;

        CLOSE rename_cursor;
        DEALLOCATE rename_cursor;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF CURSOR_STATUS('local', 'rename_cursor') >= -1
        BEGIN
            CLOSE rename_cursor;
            DEALLOCATE rename_cursor;
        END;

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT
            log_id,
            run_id,
            log_datetime,
            object_type,
            schema_name,
            table_name,
            current_name,
            proposed_name,
            rename_command,
            execution_status,
            error_number,
            error_message
        FROM @Log
        ORDER BY log_id;

        THROW;
    END CATCH;

    SELECT
        log_id,
        run_id,
        log_datetime,
        object_type,
        schema_name,
        table_name,
        current_name,
        proposed_name,
        rename_command,
        execution_status,
        error_number,
        error_message
    FROM @Log
    ORDER BY log_id;
*/
END;
GO

