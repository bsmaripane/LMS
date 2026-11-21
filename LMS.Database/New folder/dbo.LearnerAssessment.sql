USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.LearnerAssessment
-- ===================================================================

INSERT INTO dbo.LearnerAssessment
(
    AssessmentId,
    LearnerId,
    MarkObtained,
    TotalMarks,
    Remarks
)
VALUES
(2,3,82,100,'Very Good'),
(3,3,76,100,'Good'),
(4,4,91,100,'Excellent'),
(5,6,68,100,'Satisfactory'),
(6,7,132,150,'Excellent');
GO