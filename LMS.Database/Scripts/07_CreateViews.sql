/******************************************************************************
    File:       07_CreateViews.sql

    Database:   LearnerManagementSystem

    Purpose:
        Create reporting and dashboard views for the Learner Management System

    Improvements:
        - Uses CREATE OR ALTER VIEW
        - Uses schema-qualified objects
        - Removes SELECT *
        - Uses consistent aliases
        - Prevents divide-by-zero errors
        - Improves NULL handling
        - Reporting objects separated from transactional tables

******************************************************************************/

USE LearnerManagementSystem;
GO  


SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET NOCOUNT ON;
GO


/******************************************************************************
    View: Reporting.vwLearnerProfile
******************************************************************************/

CREATE OR ALTER VIEW vwLearnerProfile
AS

SELECT
      L.LearnerId
    , L.AdmissionNumber
    , L.FirstName
    , L.MiddleName
    , L.LastName
    , CONCAT_WS(' ',
          L.FirstName,
          L.MiddleName,
          L.LastName
      ) AS LearnerName
    , G.Gender
    , L.DateOfBirth
    , C.ClassId
    , C.ClassName
    , GR.GradeId
    , GR.GradeName
    , P.ParentId
    , CONCAT_WS(' ',
          P.FirstName,
          P.MiddleName,
          P.LastName
      ) AS ParentName
    , R.Relation
    , P.MobileNumber
    , P.EmailAddress

    , L.IsActive
    , L.CreatedDate

FROM dbo.Learner AS L
	INNER JOIN Lookup.Gender AS G ON G.GenderId = L.GenderId
	INNER JOIN dbo.Parent AS P ON P.ParentId = L.ParentId
	INNER JOIN Lookup.Relation AS R ON R.RelationId = L.RelationId
	INNER JOIN dbo.Class AS C ON C.ClassId = L.ClassId
	INNER JOIN Lookup.Grade AS GR ON GR.GradeId = C.GradeId;

GO

/******************************************************************************
    View: Reporting.vwClassRegister
******************************************************************************/

CREATE OR ALTER VIEW vwClassRegister
AS

SELECT
      C.ClassId
    , C.ClassName
    , G.GradeName
    , L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName
    , L.IsActive

FROM dbo.Class AS C
	INNER JOIN Lookup.Grade AS G ON G.GradeId = C.GradeId
	INNER JOIN dbo.Learner AS L ON L.ClassId = C.ClassId;

GO



/******************************************************************************
    View: Reporting.vwTeacherClasses
******************************************************************************/

CREATE OR ALTER VIEW vwTeacherClasses
AS

SELECT
      T.TeacherId
    , CONCAT_WS(' ',
        T.FirstName,
        T.LastName
      ) AS TeacherName
    , C.ClassName
    , G.GradeName
    , C.AcademicYear

FROM dbo.Teacher AS T
	INNER JOIN dbo.Class AS C ON C.TeacherId = T.TeacherId
	INNER JOIN Lookup.Grade AS G ON G.GradeId = C.GradeId;

GO

/******************************************************************************
    View: Reporting.vwLearnerSubjects
******************************************************************************/

CREATE OR ALTER VIEW vwLearnerSubjects
AS

SELECT
      L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName
    , S.SubjectCode
    , S.SubjectName
    , LS.AcademicYear

FROM dbo.LearnerSubject AS LS
	INNER JOIN dbo.Learner AS L ON L.LearnerId = LS.LearnerId
	INNER JOIN dbo.Subject AS S ON S.SubjectId = LS.SubjectId;

GO

/******************************************************************************
    View: Reporting.vwAssessmentResults
******************************************************************************/

CREATE OR ALTER VIEW vwAssessmentResults
AS

SELECT
      L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName
    , S.SubjectName
    , A.AssessmentName
    , LA.MarkObtained
    , LA.TotalMarks
    , LA.Percentage
    , LA.Remarks

FROM dbo.LearnerAssessment AS LA
	INNER JOIN dbo.Assessment AS A ON A.AssessmentId = LA.AssessmentId
	INNER JOIN dbo.Learner AS L ON L.LearnerId = LA.LearnerId
	INNER JOIN dbo.Subject AS S ON S.SubjectId = A.SubjectId;

GO

/******************************************************************************
    View: Reporting.vwAttendanceSummary
******************************************************************************/

CREATE OR ALTER VIEW vwAttendanceSummary
AS

SELECT
      L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName
    , A.AttendanceDate
    , ATS.Status
    , A.Remarks

FROM dbo.Attendance AS A
	INNER JOIN dbo.Learner AS L ON L.LearnerId = A.LearnerId
	INNER JOIN Lookup.AttendanceStatus AS ATS ON ATS.AttendanceStatusId = A.AttendanceStatusId;
GO



/******************************************************************************
    View: Reporting.vwDisciplineHistory
******************************************************************************/

CREATE OR ALTER VIEW vwDisciplineHistory
AS

SELECT
      L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName
    , D.IncidentDate
    , D.Description
    , D.ActionTaken

FROM dbo.Discipline AS D
	INNER JOIN dbo.Learner AS L ON L.LearnerId = D.LearnerId;
GO

/******************************************************************************
    View: Reporting.vwActiveLearners
******************************************************************************/

CREATE OR ALTER VIEW vwActiveLearners
AS

SELECT
      LearnerId
    , AdmissionNumber
    , LearnerName
    , Gender
    , DateOfBirth
    , ClassName
    , GradeName
    , ParentName
    , MobileNumber
    , EmailAddress

FROM Reporting.vwLearnerProfile
WHERE IsActive = 1;
GO



/******************************************************************************
    View: Reporting.vwParentLearners
******************************************************************************/

CREATE OR ALTER VIEW vwParentLearners
AS

SELECT
      P.ParentId
    , CONCAT_WS(' ',
        P.FirstName,
        P.LastName
      ) AS ParentName
    , L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName

FROM dbo.Parent AS P
	INNER JOIN dbo.Learner AS L ON L.ParentId = P.ParentId;
GO

/******************************************************************************
    View: Reporting.vwDashboardStatistics
******************************************************************************/

CREATE OR ALTER VIEW vwDashboardStatistics
AS

SELECT
	(
		SELECT COUNT(*)
		FROM Administration.Learner
		WHERE IsActive = 1
	) AS ActiveLearners,

	(
		SELECT COUNT(*)
		FROM Administration.Teacher
		WHERE IsActive = 1
	) AS ActiveTeachers,

	(
		SELECT COUNT(*)
		FROM Academic.Class
	) AS TotalClasses,

	(
		SELECT COUNT(*)
		FROM Academic.Subject
	) AS TotalSubjects,

	(
		SELECT COUNT(*)
		FROM Academic.Assessment
	) AS TotalAssessments,

	(
		SELECT COUNT(*)
		FROM Attendance.Attendance
		WHERE AttendanceDate = CAST(GETDATE() AS DATE)
	) AS AttendanceToday,

	(
		SELECT COUNT(*)
		FROM Discipline.Discipline
	) AS TotalDisciplineCases;
GO

/******************************************************************************
    View: Reporting.vwTopPerformingLearners
******************************************************************************/

CREATE OR ALTER VIEW vwTopPerformingLearners
AS

SELECT
      L.LearnerId
    , L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName
    , CAST(
        AVG(LA.Percentage)
        AS DECIMAL(5,2)
      ) AS AveragePercentage

FROM dbo.LearnerAssessment AS LA
	INNER JOIN dbo.Learner AS L ON L.LearnerId = LA.LearnerId

GROUP BY
      L.LearnerId
    , L.AdmissionNumber
    , L.FirstName
    , L.LastName;
GO

/******************************************************************************
    View: Reporting.vwAttendancePercentage
******************************************************************************/

CREATE OR ALTER VIEW vwAttendancePercentage
AS

SELECT
      L.LearnerId
    , L.AdmissionNumber
    , CONCAT_WS(' ',
        L.FirstName,
        L.LastName
      ) AS LearnerName
    , COUNT(*) AS TotalDays
    , SUM
      (
        CASE
            WHEN ATS.Status = 'Present'
            THEN 1
            ELSE 0
        END
      ) AS DaysPresent
    , CAST
      (
        SUM
        (
            CASE
                WHEN ATS.Status = 'Present'
                THEN 1
                ELSE 0
            END
        )
        *100.0 / NULLIF(COUNT(*),0)  AS DECIMAL(5,2)
      ) AS AttendancePercentage

FROM dbo.Attendance AS A
	INNER JOIN dbo.Learner AS L ON L.LearnerId = A.LearnerId
INNER JOIN Lookup.AttendanceStatus AS ATS ON ATS.AttendanceStatusId = A.AttendanceStatusId

GROUP BY
      L.LearnerId
    , L.AdmissionNumber
    , L.FirstName
    , L.LastName;
GO

PRINT 'Reporting views created successfully.';
GO