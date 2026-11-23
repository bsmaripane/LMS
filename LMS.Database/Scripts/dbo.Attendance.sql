USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.Attendance
-- ===================================================================

INSERT INTO dbo.Attendance
(
    LearnerId,
    AttendanceDate,
    AttendanceStatusId,
    Remarks
)
VALUES
(3,'2026-07-20',1,'Present'),
(4,'2026-07-20',1,'Present'),
(5,'2026-07-20',2,'Sick Leave'),
(6,'2026-07-20',1,'Present'),
(7,'2026-07-20',3,'Arrived Late');
GO