/******************************************************************************
    File:
        09_InsertLookupData.sql

    Purpose:
        Insert default lookup/reference data for
        Learner Management System

******************************************************************************/

USE LearnerManagementSystem;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO


BEGIN TRY

BEGIN TRANSACTION;


/******************************************************************************
    Gender
******************************************************************************/

SET IDENTITY_INSERT Lookup.Gender ON;

INSERT INTO Lookup.Gender
(
    GenderId,
    Gender
)
SELECT *
FROM
(
    VALUES
        (0,'Unspecified'),
        (1,'Male'),
        (2,'Female'),
        (3,'Other')
) AS SourceData(GenderId,Gender)

WHERE NOT EXISTS
(
    SELECT 1
    FROM Lookup.Gender G
    WHERE G.GenderId = SourceData.GenderId
);

SET IDENTITY_INSERT Lookup.Gender OFF;



/******************************************************************************
    Relation
******************************************************************************/

SET IDENTITY_INSERT Lookup.Relation ON;

INSERT INTO Lookup.Relation
(
    RelationId,
    Relation
)
SELECT *
FROM
(
    VALUES
        (0,'Other'),
        (1,'Mother'),
        (2,'Father'),
        (3,'Grandmother'),
        (4,'Grandfather'),
        (5,'Brother'),
        (6,'Sister'),
        (7,'Uncle'),
        (8,'Aunt'),
        (9,'Legal Guardian')
)
AS SourceData(RelationId,Relation)

WHERE NOT EXISTS
(
    SELECT 1
    FROM Lookup.Relation R
    WHERE R.RelationId = SourceData.RelationId
);

SET IDENTITY_INSERT Lookup.Relation OFF;



/******************************************************************************
    Grade
******************************************************************************/

SET IDENTITY_INSERT Lookup.Grade ON;

INSERT INTO Lookup.Grade
(
    GradeId,
    GradeName
)
SELECT *
FROM
(
    VALUES
        (0,'Grade 8'),
        (1,'Grade 9'),
        (2,'Grade 10'),
        (3,'Grade 11'),
        (4,'Grade 12')
)
AS SourceData(GradeId,GradeName)

WHERE NOT EXISTS
(
    SELECT 1
    FROM Lookup.Grade G
    WHERE G.GradeId = SourceData.GradeId
);

SET IDENTITY_INSERT Lookup.Grade OFF;



/******************************************************************************
    Title
******************************************************************************/

SET IDENTITY_INSERT Lookup.Title ON;

INSERT INTO Lookup.Title
(
    TitleId,
    Title
)
SELECT *
FROM
(
    VALUES
        (0,'Unspecified'),
        (1,'Mr'),
        (2,'Mrs'),
        (3,'Miss'),
        (4,'Ms'),
        (5,'Dr'),
        (6,'Prof'),
        (7,'Rev'),
        (8,'Sir'),
        (9,'Mx')
)
AS SourceData(TitleId,Title)

WHERE NOT EXISTS
(
    SELECT 1
    FROM Lookup.Title T
    WHERE T.TitleId = SourceData.TitleId
);

SET IDENTITY_INSERT Lookup.Title OFF;



/******************************************************************************
    Attendance Status
******************************************************************************/

SET IDENTITY_INSERT Lookup.AttendanceStatus ON;

INSERT INTO Lookup.AttendanceStatus
(
    AttendanceStatusId,
    Status
)
SELECT *
FROM
(
    VALUES
        (1,'Present'),
        (2,'Absent'),
        (3,'Late'),
        (4,'Excused'),
        (5,'Medical'),
        (6,'Suspended'),
        (7,'School Activity')
)
AS SourceData(AttendanceStatusId,Status)

WHERE NOT EXISTS
(
    SELECT 1
    FROM Lookup.AttendanceStatus A
    WHERE A.AttendanceStatusId =
          SourceData.AttendanceStatusId
);

SET IDENTITY_INSERT Lookup.AttendanceStatus OFF;



/******************************************************************************
    Assessment Type
******************************************************************************/

SET IDENTITY_INSERT Lookup.AssessmentType ON;

INSERT INTO Lookup.AssessmentType
(
    AssessmentTypeId,
    AssessmentType
)
SELECT *
FROM
(
    VALUES
        (1,'Homework'),
        (2,'Assignment'),
        (3,'Quiz'),
        (4,'Practical'),
        (5,'Project'),
        (6,'Test'),
        (7,'Examination'),
        (8,'Oral'),
        (9,'Presentation')
)
AS SourceData(AssessmentTypeId,Type)

WHERE NOT EXISTS
(
    SELECT 1
    FROM Lookup.AssessmentType A
    WHERE A.AssessmentTypeId =
          SourceData.AssessmentTypeId
);

SET IDENTITY_INSERT Lookup.AssessmentType OFF;



COMMIT TRANSACTION;


PRINT 'Lookup data inserted successfully.';


END TRY

BEGIN CATCH


IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;


THROW;


END CATCH;
GO