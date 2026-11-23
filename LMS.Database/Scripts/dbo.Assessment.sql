USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.Assessment
-- ===================================================================

INSERT INTO dbo.Assessment
(
    AssessmentTypeId,
    SubjectId,
    AssessmentName,
    MaximumMark,
    ReleaseDate,
    DueDate,
    SubmittedDate
)
VALUES
(1,10,'English Assignment',100,'2026-02-01','2026-02-10','2026-02-09'),
(2,11,'Mathematics Test',100,'2026-02-05','2026-02-12','2026-02-12'),
(3,12,'Science Project',100,'2026-03-01','2026-03-20','2026-03-18'),
(4,16,'Accounting Practical',100,'2026-04-01','2026-04-15','2026-04-14'),
(5,18,'Final Mathematics Exam',150,'2026-05-01','2026-05-30','2026-05-30');
GO

