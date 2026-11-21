USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.Teacher
-- ===================================================================

INSERT INTO dbo.Teacher
(
    TitleId,
    FirstName,
    LastName,
    EmailAddress,
    MobileNumber,
    IsActive,
    HireDate
)
VALUES
(1,'James','Taylor','j.taylor@school.co.za','0835552001',1,'2022-01-10'),
(2,'Sarah','Johnson','s.johnson@school.co.za','0835552002',1,'2021-07-15'),
(1,'Michael','Naidoo','m.naidoo@school.co.za','0835552003',1,'2020-05-20'),
(2,'Lerato','Nkosi','l.nkosi@school.co.za','0835552004',1,'2023-01-05'),
(1,'Thabo','Maseko','t.maseko@school.co.za','0835552005',1,'2019-08-01');
GO