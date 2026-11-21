USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.Subject
-- ===================================================================

INSERT INTO dbo.Subject
(
    SubjectCode,
    SubjectName,
    GradeId
)
VALUES
('ENG8','English',0),
('MAT8','Mathematics',0),
('SCI9','Natural Science',1),
('ENG9','English',1),
('MAT10','Mathematics',2),
('PHY10','Physical Science',2),
('ACC11','Accounting',3),
('BUS11','Business Studies',3),
('MAT12','Mathematics',4),
('LIF12','Life Orientation',4);
GO

