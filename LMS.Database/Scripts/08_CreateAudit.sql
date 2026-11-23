/******************************************************************************
    File:           08_CreateAudit.sql

    Database:       LearnerManagementSystem

    Purpose:
        Create the lightweight auditing framework for the
        Learner Management System.

    Features
    --------
    • Lightweight audit tables
    • Minimal performance impact
    • No XML storage
    • No JSON storage
    • No column-by-column auditing
    • Deployment-safe (idempotent)
    • Supports future audit triggers
******************************************************************************/

USE LearnerManagementSystem;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET NOCOUNT ON;
GO

SET XACT_ABORT ON;
GO

/******************************************************************************
    Create Audit Schema
******************************************************************************/

IF SCHEMA_ID('Audit') IS NULL
BEGIN
    EXEC ('CREATE SCHEMA Audit AUTHORIZATION dbo;');
    PRINT 'Audit schema created.';
END
ELSE
BEGIN
    PRINT 'Audit schema already exists.';
END;
GO

/******************************************************************************
    Audit.AuditLog
******************************************************************************/

IF OBJECT_ID('Audit.AuditLog','U') IS NULL
BEGIN

    CREATE TABLE Audit.AuditLog
    (
        AuditId BIGINT IDENTITY(1,1)
            CONSTRAINT PK_AuditLog
            PRIMARY KEY CLUSTERED,

        TableName SYSNAME NOT NULL,

        RecordId INT NOT NULL,

        OperationType CHAR(1) NOT NULL
            CONSTRAINT CK_AuditLog_Operation
            CHECK (OperationType IN ('I','U','D')),

        ChangedBy NVARCHAR(128) NOT NULL
            CONSTRAINT DF_AuditLog_ChangedBy
            DEFAULT (SUSER_SNAME()),

        ChangedDate DATETIME2(3) NOT NULL
            CONSTRAINT DF_AuditLog_ChangedDate
            DEFAULT (SYSUTCDATETIME()),

        HostName NVARCHAR(128) NULL
            CONSTRAINT DF_AuditLog_HostName
            DEFAULT (HOST_NAME()),

        ApplicationName NVARCHAR(128) NULL
            CONSTRAINT DF_AuditLog_App
            DEFAULT (APP_NAME()),

        SessionId INT NOT NULL
            CONSTRAINT DF_AuditLog_Session
            DEFAULT (@@SPID),

        AffectedRows SMALLINT NOT NULL
            CONSTRAINT DF_AuditLog_Rows
            DEFAULT (1)
    );

    PRINT 'Audit.AuditLog created.';

END
ELSE
BEGIN
    PRINT 'Audit.AuditLog already exists.';
END;
GO

/******************************************************************************
    Audit.LoginAudit
******************************************************************************/

IF OBJECT_ID('Audit.LoginAudit','U') IS NULL
BEGIN

    CREATE TABLE Audit.LoginAudit
    (
        LoginAuditId BIGINT IDENTITY(1,1)
            CONSTRAINT PK_LoginAudit
            PRIMARY KEY CLUSTERED,

        UserName NVARCHAR(128) NOT NULL,

        LoginDate DATETIME2(3) NOT NULL
            CONSTRAINT DF_LoginAudit_LoginDate
            DEFAULT (SYSUTCDATETIME()),

        LogoutDate DATETIME2(3) NULL,

        HostName NVARCHAR(128) NULL,

        ApplicationName NVARCHAR(128) NULL,

        SessionId INT NOT NULL
            CONSTRAINT DF_LoginAudit_Session
            DEFAULT (@@SPID)
    );

    PRINT 'Audit.LoginAudit created.';

END
ELSE
BEGIN
    PRINT 'Audit.LoginAudit already exists.';
END;
GO

/******************************************************************************
    Audit.ViewAudit
******************************************************************************/

IF OBJECT_ID('Audit.ViewAudit','U') IS NULL
BEGIN

    CREATE TABLE Audit.ViewAudit
    (
        ViewAuditId BIGINT IDENTITY(1,1)
            CONSTRAINT PK_ViewAudit
            PRIMARY KEY CLUSTERED,

        UserName NVARCHAR(128) NOT NULL,

        ViewName SYSNAME NOT NULL,

        ViewedDate DATETIME2(3) NOT NULL
            CONSTRAINT DF_ViewAudit_Date
            DEFAULT (SYSUTCDATETIME()),

        HostName NVARCHAR(128) NULL,

        ApplicationName NVARCHAR(128) NULL
    );

    PRINT 'Audit.ViewAudit created.';

END
ELSE
BEGIN
    PRINT 'Audit.ViewAudit already exists.';
END;
GO

/******************************************************************************
    Audit.ErrorLog
******************************************************************************/

IF OBJECT_ID('Audit.ErrorLog','U') IS NULL
BEGIN

    CREATE TABLE Audit.ErrorLog
    (
        ErrorId BIGINT IDENTITY(1,1)
            CONSTRAINT PK_ErrorLog
            PRIMARY KEY CLUSTERED,

        ErrorNumber INT NULL,

        ErrorSeverity INT NULL,

        ErrorState INT NULL,

        ErrorProcedure NVARCHAR(128) NULL,

        ErrorLine INT NULL,

        ErrorMessage NVARCHAR(4000) NULL,

        ErrorDate DATETIME2(3) NOT NULL
            CONSTRAINT DF_ErrorLog_Date
            DEFAULT (SYSUTCDATETIME()),

        UserName NVARCHAR(128) NOT NULL
            CONSTRAINT DF_ErrorLog_User
            DEFAULT (SUSER_SNAME())
    );

    PRINT 'Audit.ErrorLog created.';

END
ELSE
BEGIN
    PRINT 'Audit.ErrorLog already exists.';
END;
GO

/******************************************************************************
    Indexes
******************************************************************************/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID('Audit.AuditLog')
      AND name = 'IX_AuditLog_Table_Record'
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_AuditLog_Table_Record
        ON Audit.AuditLog
        (
            TableName,
            RecordId
        );

END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID('Audit.AuditLog')
      AND name = 'IX_AuditLog_Table_Date'
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_AuditLog_Table_Date
        ON Audit.AuditLog
        (
            TableName,
            ChangedDate DESC
        );

END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID('Audit.LoginAudit')
      AND name = 'IX_LoginAudit_User'
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_LoginAudit_User
        ON Audit.LoginAudit
        (
            UserName,
            LoginDate DESC
        );

END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID('Audit.ViewAudit')
      AND name = 'IX_ViewAudit_View'
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_ViewAudit_View
        ON Audit.ViewAudit
        (
            ViewName,
            ViewedDate DESC
        );

END;
GO

/******************************************************************************
    Verification
******************************************************************************/

PRINT '';
PRINT '==============================================';
PRINT 'Audit framework installed successfully.';
PRINT '==============================================';

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id
WHERE s.name = 'Audit'
ORDER BY t.name;
GO