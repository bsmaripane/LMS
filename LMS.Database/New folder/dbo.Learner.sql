USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.Learner
-- ===================================================================

INSERT INTO dbo.Learner
(
    AdmissionNumber,
    FirstName,
    MiddleName,
    LastName,
    GenderId,
    DateOfBirth,
    IdentificationNumber,
    ParentId,
    RelationId,
    ClassId,
    PhysicalAddress,
    IsActive,
    CreatedDate,
    ModifiedDate
)
VALUES
('ADM0001','Sipho',NULL,'Mokoena',1,'2012-05-15','1205155009087',1,2,6,'12 Main Road',1,SYSDATETIME(),SYSDATETIME()),
('ADM0002','Ayanda',NULL,'Zulu',2,'2011-09-22','1109226009088',2,1,7,'18 Church Street',1,SYSDATETIME(),SYSDATETIME()),
('ADM0003','Lebo','John','Molefe',1,'2010-01-08','1001085009089',3,2,8,'25 School Road',1,SYSDATETIME(),SYSDATETIME()),
('ADM0004','Naledi',NULL,'Khumalo',2,'2009-03-12','0903127009090',4,1,9,'30 Oak Avenue',1,SYSDATETIME(),SYSDATETIME()),
('ADM0005','Brian',NULL,'Smith',1,'2008-11-30','0811305009091',5,2,10,'45 Cedar Street',1,SYSDATETIME(),SYSDATETIME());
GO
