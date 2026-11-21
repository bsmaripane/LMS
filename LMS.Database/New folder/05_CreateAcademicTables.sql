 -- ===================================================================
-- Create Academic Tables for Learner Management System
-- ===================================================================

USE [LearnerManagementSystem];
GO

SET NOCOUNT ON;
GO

BEGIN TRY

	-- ============================================================
	-- Learner Subject Registration
	-- ============================================================

	IF OBJECT_ID('dbo.LearnerSubject','U') IS NULL
	BEGIN

	CREATE TABLE LearnerSubject
	(
		LearnerSubjectId	INT			IDENTITY(1,1) NOT NULL,
		LearnerId			INT			NOT NULL,
		SubjectId			INT			NOT NULL,
		AcademicYear		SMALLINT	NOT NULL,

		CONSTRAINT PK_LearnerSubject PRIMARY KEY(LearnerSubjectId),

		CONSTRAINT FK_LearnerSubject_Learner FOREIGN KEY(LearnerId) REFERENCES Learner(LearnerId),
		CONSTRAINT FK_LearnerSubject_Subject FOREIGN KEY(SubjectId) REFERENCES Subject(SubjectId),

		CONSTRAINT CK_LearnerSubject_Year CHECK(AcademicYear BETWEEN 2000 AND 2100),

		CONSTRAINT UQ_LearnerSubject UNIQUE(LearnerId, SubjectId, AcademicYear)
	);

	PRINT 'dbo.LearnerSubject created.';
	END;

	-- ============================================================
	-- Assessment
	-- ============================================================

	IF OBJECT_ID('dbo.Assessment','U') IS NULL
	BEGIN

	CREATE TABLE Assessment
	(
		AssessmentId		INT				IDENTITY(1,1)	NOT NULL,
		AssessmentTypeId	INT				NOT NULL,
		SubjectId			INT				NOT NULL,
		AssessmentName		VARCHAR(100)	NOT NULL,
		MaximumMark			DECIMAL(6,2)	NOT NULL,
		ReleaseDate			DATE			NOT NULL		DEFAULT CAST(GETDATE() AS DATE),
		DueDate				DATE			NOT NULL		DEFAULT DATEADD(DAY,5,CAST(GETDATE() AS DATE)),
		SubmittedDate		DATE			NULL,

		CONSTRAINT PK_Assessment PRIMARY KEY(AssessmentId),

		CONSTRAINT FK_Assessment_Type FOREIGN KEY(AssessmentTypeId) REFERENCES Lookup.AssessmentType(AssessmentTypeId),
		CONSTRAINT FK_Assessment_Subject FOREIGN KEY(SubjectId) REFERENCES Subject(SubjectId),

		CONSTRAINT CK_Assessment_Marks CHECK(MaximumMark > 0)
	);


	PRINT 'dbo.Assessment created.';
	END;

	-- ============================================================
	-- Learner Assessment Results
	-- ============================================================

	IF OBJECT_ID('dbo.LearnerAssessment','U') IS NULL
	BEGIN


	CREATE TABLE LearnerAssessment
	(
		LearnerAssessmentId		INT				IDENTITY(1,1)	NOT NULL,
		AssessmentId			INT				NOT NULL,
		LearnerId				INT				NOT NULL,
		MarkObtained			DECIMAL(6,2)	NOT NULL		DEFAULT 0,
		TotalMarks				DECIMAL(6,2)	NOT NULL,
		Percentage AS
		(
			CASE
				WHEN TotalMarks = 0 THEN 0
				ELSE (MarkObtained / TotalMarks) * 100
			END
		) PERSISTED,
		Remarks					VARCHAR(255)	NULL,

		CONSTRAINT PK_LearnerAssessment PRIMARY KEY(LearnerAssessmentId),

		CONSTRAINT FK_LearnerAssessment_Assessment FOREIGN KEY(AssessmentId) REFERENCES Assessment(AssessmentId),
		CONSTRAINT FK_LearnerAssessment_Learner FOREIGN KEY(LearnerId) REFERENCES Learner(LearnerId),

		CONSTRAINT CK_LearnerAssessment_Marks CHECK(MarkObtained <= TotalMarks),

		CONSTRAINT UQ_LearnerAssessment UNIQUE(AssessmentId,LearnerId)
	);

	PRINT 'dbo.LearnerAssessment created.';
	END;

	-- ============================================================
	-- Attendance
	-- ============================================================

	IF OBJECT_ID('dbo.Attendance','U') IS NULL
	BEGIN

	CREATE TABLE Attendance
	(
		AttendanceId		INT				IDENTITY(1,1)	NOT NULL,
		LearnerId			INT				NOT NULL,
		AttendanceDate		DATE			NOT NULL		DEFAULT CAST(GETDATE() AS DATE),
		AttendanceStatusId	INT				NOT NULL,
		Remarks				VARCHAR(255)	NULL,

		CONSTRAINT PK_Attendance PRIMARY KEY(AttendanceId),

		CONSTRAINT FK_Attendance_Learner FOREIGN KEY(LearnerId) REFERENCES Learner(LearnerId),
		CONSTRAINT FK_Attendance_Status FOREIGN KEY(AttendanceStatusId) REFERENCES Lookup.AttendanceStatus(AttendanceStatusId),

		CONSTRAINT UQ_Attendance UNIQUE(LearnerId,AttendanceDate)
	);

	PRINT 'dbo.Attendance created.';
	END;

	-- ============================================================
	-- Discipline
	-- ============================================================

	IF OBJECT_ID('dbo.Discipline','U') IS NULL
	BEGIN

	CREATE TABLE Discipline
	(
		DisciplineId	INT				IDENTITY(1,1)	NOT NULL,
		LearnerId		INT				NOT NULL,
		IncidentDate	DATE			NOT NULL		DEFAULT CAST(GETDATE() AS DATE),
		Description		VARCHAR(500)	NOT NULL,
		ActionTaken		VARCHAR(255)	NOT NULL,

		CONSTRAINT PK_Discipline PRIMARY KEY(DisciplineId),

		CONSTRAINT FK_Discipline_Learner FOREIGN KEY(LearnerId) REFERENCES Learner(LearnerId)
	);
	PRINT 'dbo.Discipline created.'
	END;

END TRY
BEGIN CATCH

	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage,
		ERROR_LINE() AS ErrorLine;

END CATCH;
GO