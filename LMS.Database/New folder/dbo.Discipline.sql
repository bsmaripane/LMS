USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.Discipline
-- ===================================================================

INSERT INTO dbo.Discipline
(
    LearnerId,
    IncidentDate,
    Description,
    ActionTaken
)
VALUES
(3,'2026-03-10','Late for class','Verbal Warning'),
(4,'2026-03-18','Uniform violation','Parent Contacted'),
(5,'2026-04-05','Disruptive behaviour','Detention'),
(6,'2026-05-01','Homework not submitted','Written Warning'),
(7,'2026-06-12','Fighting during break','Suspended for 2 days');
GO
