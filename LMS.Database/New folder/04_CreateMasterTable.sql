-- ===================================================================
-- Create Master Tables for Learner Management System
-- ===================================================================

USE [LearnerManagementSystem];
GO

SET NOCOUNT ON;
GO

BEGIN TRY
	-- ============================================================
	-- Parent Table
	-- ============================================================

	IF OBJECT_ID('dbo.Parent','U') IS NULL
	BEGIN

	CREATE TABLE Parent
	(
		ParentId		INT				IDENTITY(1,1) NOT NULL,
		TitleId			INT				NOT NULL,
		FirstName		VARCHAR(50)		NOT NULL,
		LastName		VARCHAR(50)		NOT NULL,
		EmailAddress	VARCHAR(100)	NOT NULL,
		MobileNumber	VARCHAR(15)		NOT NULL,
		CreatedDate		DATETIME2		NOT NULL 
			
		CONSTRAINT DF_Parent_CreatedDate DEFAULT SYSDATETIME(),
		CONSTRAINT PK_Parent PRIMARY KEY(ParentId),
		CONSTRAINT FK_Parent_Title FOREIGN KEY(TitleId)	REFERENCES Lookup.Title(TitleId),
		CONSTRAINT UQ_Parent_Email UNIQUE(EmailAddress)
	);

	PRINT 'dbo.Parent created.';
	END;
	-- ============================================================
	-- Teacher Table
	-- ============================================================

	IF OBJECT_ID('dbo.Teacher','U') IS NULL
	BEGIN

	CREATE TABLE Teacher
	(
		TeacherId		INT				IDENTITY(1,1)	NOT NULL,
		TitleId			INT				NOT NULL,
		FirstName		VARCHAR(50)		NOT NULL,
		LastName		VARCHAR(50)		NOT NULL,
		EmailAddress	VARCHAR(100)	NOT NULL,
		MobileNumber	VARCHAR(15)		NOT NULL,
		IsActive		BIT				NOT NULL		DEFAULT 1,
		HireDate		DATE			NOT NULL		DEFAULT CAST(GETDATE() AS DATE),

		CONSTRAINT PK_Teacher PRIMARY KEY(TeacherId),
		CONSTRAINT FK_Teacher_Title FOREIGN KEY(TitleId) REFERENCES Lookup.Title(TitleId),
		CONSTRAINT UQ_Teacher_Email	UNIQUE(EmailAddress)
	);

	PRINT 'dbo.Teacher created.';
	END;
	-- ============================================================
	-- Class Table
	-- ============================================================

	IF OBJECT_ID('dbo.Class','U') IS NULL
	BEGIN

	CREATE TABLE Class
	(
		ClassId			INT				IDENTITY(1,1)	NOT NULL,
		GradeId			INT				NOT NULL,
		TeacherId		INT				NOT NULL,
		ClassName		VARCHAR(50)		NOT NULL,
		AcademicYear	SMALLINT		NOT NULL,

		CONSTRAINT PK_Class PRIMARY KEY(ClassId),
		CONSTRAINT FK_Class_Grade FOREIGN KEY(GradeId) REFERENCES Lookup.Grade(GradeId),
		CONSTRAINT FK_Class_Teacher FOREIGN KEY(TeacherId) REFERENCES Teacher(TeacherId),
		CONSTRAINT CK_Class_AcademicYear CHECK(AcademicYear BETWEEN 2000 AND 2100)
	);

	PRINT 'dbo.Class created.';
	END;

	-- ============================================================
	-- Subject Table
	-- ============================================================

	IF OBJECT_ID('dbo.Subject','U') IS NULL
	BEGIN

	CREATE TABLE Subject
	(
		SubjectId		INT				IDENTITY(1,1)	NOT NULL,
		SubjectCode		VARCHAR(10)		NOT NULL,
		SubjectName		VARCHAR(100)	NOT NULL,
		GradeId			INT				NOT NULL,

		CONSTRAINT PK_Subject PRIMARY KEY(SubjectId),

		CONSTRAINT FK_Subject_Grade FOREIGN KEY(GradeId) REFERENCES Lookup.Grade(GradeId),

		CONSTRAINT UQ_Subject_Code UNIQUE(SubjectCode)
	);

	PRINT 'dbo.Subject created.';
	END;

	-- ============================================================
	-- Learner Table
	-- ============================================================

	IF OBJECT_ID('dbo.Learner','U') IS NULL
	BEGIN

	CREATE TABLE Learner
	(
		LearnerId				INT				IDENTITY(1,1)	NOT NULL,
		AdmissionNumber			VARCHAR(20)		NOT NULL,
		FirstName				VARCHAR(50)		NOT NULL,
		MiddleName				VARCHAR(50)		NULL,
		LastName				VARCHAR(50)		NOT NULL,
		GenderId				INT				NOT NULL,
		DateOfBirth				DATE			NOT NULL,
		IdentificationNumber	VARCHAR(13)		NULL,
		ParentId				INT				NOT NULL,
		RelationId				INT				NOT NULL,
		ClassId					INT				NOT NULL,
		PhysicalAddress			VARCHAR(255)	NULL,
		IsActive				BIT				NOT NULL		DEFAULT 1,
		CreatedDate				DATETIME2		NOT NULL		DEFAULT SYSDATETIME(),
		ModifiedDate			DATETIME2		NOT NULL		DEFAULT SYSDATETIME(),

		CONSTRAINT PK_Learner PRIMARY KEY(LearnerId),

		CONSTRAINT UQ_Learner_AdmissionNumber UNIQUE(AdmissionNumber),

		CONSTRAINT FK_Learner_Gender FOREIGN KEY(GenderId) REFERENCES Lookup.Gender(GenderId),
		CONSTRAINT FK_Learner_Parent FOREIGN KEY(ParentId) REFERENCES Parent(ParentId),
		CONSTRAINT FK_Learner_Relation FOREIGN KEY(RelationId) REFERENCES Lookup.Relation(RelationId),
		CONSTRAINT FK_Learner_Class FOREIGN KEY(ClassId) REFERENCES Class(ClassId)
	);

	PRINT 'dbo.Learner created.';
	END;

END TRY
BEGIN CATCH

SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_MESSAGE() AS ErrorMessage,
    ERROR_LINE() AS ErrorLine;

END CATCH;

GO