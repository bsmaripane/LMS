USE LearnerManagementSystem
GO

-- ===================================================================
-- dbo.Parent
-- ===================================================================

INSERT INTO dbo.Parent
(
    TitleId,
    FirstName,
    LastName,
    EmailAddress,
    MobileNumber,
    CreatedDate
)
VALUES
(1,'John','Smith','john.smith@email.com','0825551001',SYSDATETIME()),
(2,'Mary','Jones','mary.jones@email.com','0825551002',SYSDATETIME()),
(1,'Peter','Williams','peter.williams@email.com','0825551003',SYSDATETIME()),
(2,'Susan','Brown','susan.brown@email.com','0825551004',SYSDATETIME()),
(1,'David','Mokoena','david.mokoena@email.com','0825551005',SYSDATETIME());
GO