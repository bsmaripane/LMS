-- ============================================================
-- Create Learner Management System Application Schemas
-- ============================================================

USE LearnerManagementSystem;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRY

    IF SCHEMA_ID('Lookup') IS NULL
    BEGIN
        EXEC('CREATE SCHEMA Lookup AUTHORIZATION dbo;');
        PRINT 'Created schema: Lookup';
    END;

    IF SCHEMA_ID('Audit') IS NULL
    BEGIN
        EXEC('CREATE SCHEMA Audit AUTHORIZATION dbo;');
        PRINT 'Created schema: Audit';
    END;

    IF SCHEMA_ID('Security') IS NULL
    BEGIN
        EXEC('CREATE SCHEMA Security AUTHORIZATION dbo;');
        PRINT 'Created schema: Security';
    END;

END TRY
BEGIN CATCH

    THROW;

END CATCH;
GO