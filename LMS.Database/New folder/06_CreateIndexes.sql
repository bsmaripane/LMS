/******************************************************************************
    Purpose:
        Create performance indexes for Learner Management System

    Notes:
        - Primary keys automatically create clustered indexes.
        - Unique constraints automatically create unique indexes.
        - Additional indexes target foreign keys and common searches.
******************************************************************************/

USE [LearnerManagementSystem];
GO

SET NOCOUNT ON;
GO

BEGIN TRY

	/******************************************************************************
		Parent
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Parent_Name' AND object_id = OBJECT_ID('Parent'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Parent_Name
		ON Parent
		(
			LastName,
			FirstName
		);

	END;

	/******************************************************************************
		Teacher
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Teacher_Name' AND object_id=OBJECT_ID('Teacher'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Teacher_Name
		ON Teacher
		(
			LastName,
			FirstName
		);

	END;

	/******************************************************************************
		Learner
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Learner_Name' AND object_id=OBJECT_ID('Learner'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Learner_Name
		ON Learner
		(
			LastName,
			FirstName
		);

	END;

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Learner_Class' AND object_id=OBJECT_ID('Learner'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Learner_Class
		ON Learner
		(
			ClassId
		);

	END;

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Learner_Parent' AND object_id=OBJECT_ID('Learner'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Learner_Parent
		ON Learner
		(
			ParentId
		);

	END;

	/******************************************************************************
		Subject
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Subject_Grade' AND object_id=OBJECT_ID('Subject'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Subject_Grade
		ON Subject
		(
			GradeId
		);

	END;

	/******************************************************************************
		Class
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Class_Teacher' AND object_id=OBJECT_ID('Academic.Class'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Class_Teacher
		ON Class
		(
			TeacherId
		);

	END;

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Class_Grade' AND object_id=OBJECT_ID('Class'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Class_Grade
		ON Class
		(
			GradeId
		);

	END;

	/******************************************************************************
		LearnerSubject
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_LearnerSubject_Search' AND object_id=OBJECT_ID('LearnerSubject'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_LearnerSubject_Search
		ON LearnerSubject
		(
			LearnerId,
			AcademicYear
		)
		INCLUDE
		(
			SubjectId
		);

	END;



	/******************************************************************************
		Assessment
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Assessment_Subject_Date' AND object_id=OBJECT_ID('Assessment'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Assessment_Subject_Date
		ON Assessment
		(
			SubjectId,
			DueDate
		);

	END;



	/******************************************************************************
		LearnerAssessment
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_LearnerAssessment_Learner' AND object_id=OBJECT_ID('.LearnerAssessment'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_LearnerAssessment_Learner
		ON LearnerAssessment
		(
			LearnerId
		)
		INCLUDE
		(
			AssessmentId,
			Percentage
		);

	END;

	/******************************************************************************
		Attendance
	******************************************************************************/

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Attendance_Learner_Date' AND object_id=OBJECT_ID('Attendance'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Attendance_Learner_Date
		ON Attendance
		(
			LearnerId,
			AttendanceDate
		);

	END;

	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Attendance_Status' AND object_id=OBJECT_ID('Attendance'))
	BEGIN

		CREATE NONCLUSTERED INDEX IX_Attendance_Status
		ON Attendance
		(
			AttendanceStatusId
		);

	END;

	/******************************************************************************
		Discipline
	******************************************************************************/

	IF NOT EXISTS
	(
		SELECT 1
		FROM sys.indexes
		WHERE name='IX_Discipline_Learner_Date'
		AND object_id=OBJECT_ID('Discipline' )
	)
	BEGIN

	CREATE NONCLUSTERED INDEX IX_Discipline_Learner_Date
	ON Discipline
	(
		LearnerId,
		IncidentDate
	);

	END;

	PRINT 'All LMS indexes created successfully.';

END TRY
BEGIN CATCH

	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage,
		ERROR_LINE() AS ErrorLine;

END CATCH;
GO