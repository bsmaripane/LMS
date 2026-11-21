-- ===================================================================
-- Create Learner Management System Database
-- ===================================================================

USE master;
GO

SET NOCOUNT ON;
GO

BEGIN TRY

    IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = N'LearnerManagementSystem')
    BEGIN
        CREATE DATABASE [LearnerManagementSystem];

        PRINT 'Database [LearnerManagementSystem] created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Database [LearnerManagementSystem] already exists.';
    END

END TRY
BEGIN CATCH

    PRINT 'Error occurred while creating database.';
    
    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_LINE() AS ErrorLine;

END CATCH;
GO