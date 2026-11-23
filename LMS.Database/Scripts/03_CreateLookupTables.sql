-- ===================================================================
-- Create Lookup Tables for Learner Management System
-- ===================================================================
USE [LearnerManagementSystem];
GO

SET NOCOUNT ON;
GO

BEGIN TRY
	-- ============================================================
	-- Gender Lookup
	-- ============================================================
	IF OBJECT_ID('Lookup.Gender', 'U') IS NULL
	BEGIN
		CREATE TABLE Lookup.Gender
		(
			GenderId	INT				IDENTITY(1,1)	NOT NULL,
			Gender		VARCHAR(50)		NOT NULL,

			CONSTRAINT PK_Gender PRIMARY KEY (GenderId),
			CONSTRAINT UQ_Gender_Name UNIQUE (Gender)
		);

		PRINT 'Lookup.Gender created successfully.';
	END
	ELSE
		PRINT 'Lookup.Gender already exists.';

	-- ============================================================
	-- Relation Lookup
	-- ============================================================
	IF OBJECT_ID('Lookup.Relation', 'U') IS NULL
	BEGIN
		CREATE TABLE Lookup.Relation
		(
			RelationId	INT			IDENTITY(1,1) NOT NULL,
			Relation	VARCHAR(50) NOT NULL,

			CONSTRAINT PK_Relation PRIMARY KEY (RelationId),
			CONSTRAINT UQ_Relation_Name UNIQUE (Relation)
		);

		PRINT 'Lookup.Relation created successfully.';
	END
	ELSE
		PRINT 'Lookup.Relation already exists.';

	-- ============================================================
	-- Grade Lookup
	-- ============================================================
	IF OBJECT_ID('Lookup.Grade', 'U') IS NULL
	BEGIN
		CREATE TABLE Lookup.Grade
		(
			GradeId		INT			IDENTITY(1,1) NOT NULL,
			GradeName	VARCHAR(50) NOT NULL,

			CONSTRAINT PK_Grade PRIMARY KEY (GradeId),
			CONSTRAINT UQ_Grade_Name UNIQUE (GradeName)
		);

		PRINT 'Lookup.Grade created successfully.';
	END
	ELSE
		PRINT 'Lookup.Grade already exists.';

	-- ============================================================
	-- Title Lookup
	-- ============================================================
	IF OBJECT_ID('Lookup.Title', 'U') IS NULL
	BEGIN
		CREATE TABLE Lookup.Title
		(
			TitleId	INT			IDENTITY(1,1) NOT NULL,
			Title	VARCHAR(50) NOT NULL,

			CONSTRAINT PK_Title PRIMARY KEY (TitleId),
			CONSTRAINT UQ_Title_Name UNIQUE (Title)
		);

		PRINT 'Lookup.Title created successfully.';
	END
	ELSE
		PRINT 'Lookup.Title already exists.';

	-- ============================================================
	-- Attendance Status Lookup
	-- ============================================================
	IF OBJECT_ID('Lookup.AttendanceStatus', 'U') IS NULL
	BEGIN
		CREATE TABLE Lookup.AttendanceStatus
		(
			AttendanceStatusId INT IDENTITY(1,1) NOT NULL,
			Status VARCHAR(50) NOT NULL,

			CONSTRAINT PK_AttendanceStatus PRIMARY KEY (AttendanceStatusId),
			CONSTRAINT UQ_AttendanceStatus_Name UNIQUE (Status)
		);

		PRINT 'Lookup.AttendanceStatus created successfully.';
	END
	ELSE
		PRINT 'Lookup.AttendanceStatus already exists.';

	-- ============================================================
	-- Assessment Type Lookup
	-- ============================================================
	IF OBJECT_ID('Lookup.AssessmentType', 'U') IS NULL
	BEGIN
		CREATE TABLE Lookup.AssessmentType
		(
			AssessmentTypeId	INT			IDENTITY(1,1) NOT NULL,
			AssessmentType		VARCHAR(50) NOT NULL,

			CONSTRAINT PK_AssessmentType PRIMARY KEY (AssessmentTypeId),
			CONSTRAINT UQ_AssessmentType_Name UNIQUE (AssessmentType)
		);

		PRINT 'Lookup.AssessmentType created successfully.';
	END
	ELSE
		PRINT 'Lookup.AssessmentType already exists.';

END TRY
BEGIN CATCH

	PRINT 'Error occurred while creating Lookup tables.';

	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage,
		ERROR_LINE() AS ErrorLine;

END CATCH;
GO