using LMS.Models.Entities;

namespace LMS.Tests.Models.Entities;

[TestFixture]
public class LearnerTests
{
    [Test]
    public void NewLearner_ShouldHaveDefaultValues()
    {
        // Arrange
        var learner = new Learner();

        // Assert
        Assert.Multiple(() =>
        {
            Assert.That(learner.LearnerId, Is.EqualTo(0));
            Assert.That(learner.AdmissionNumber, Is.EqualTo(string.Empty));
            Assert.That(learner.FirstName, Is.EqualTo(string.Empty));
            Assert.That(learner.MiddleName, Is.Null);
            Assert.That(learner.LastName, Is.EqualTo(string.Empty));
        });
    }

    [Test]
    public void LearnerProperties_ShouldStoreAssignedValues()
    {
        // Arrange
        var learner = new Learner
        {
            LearnerId = 1,
            AdmissionNumber = "ADM001",
            FirstName = "John",
            MiddleName = "David",
            LastName = "Smith",
            GenderId = 1,
            DateOfBirth = new DateOnly(2010, 5, 15),
            IdentificationNumber = "1005150000000",
            ParentId = 1,
            RelationId = 1,
            ClassId = 1,
            PhysicalAddress = "Pretoria",
            IsActive = true
        };

        // Assert
        Assert.That(learner.LearnerId, Is.EqualTo(1));
        Assert.That(learner.AdmissionNumber, Is.EqualTo("ADM001"));
        Assert.That(learner.FirstName, Is.EqualTo("John"));
        Assert.That(learner.MiddleName, Is.EqualTo("David"));
        Assert.That(learner.LastName, Is.EqualTo("Smith"));
        Assert.That(learner.GenderId, Is.EqualTo(1));
        Assert.That(learner.DateOfBirth, Is.EqualTo(new DateOnly(2010, 5, 15)));
        Assert.That(learner.IdentificationNumber, Is.EqualTo("1005150000000"));
        Assert.That(learner.ParentId, Is.EqualTo(1));
        Assert.That(learner.RelationId, Is.EqualTo(1));
        Assert.That(learner.ClassId, Is.EqualTo(1));
        Assert.That(learner.PhysicalAddress, Is.EqualTo("Pretoria"));
        Assert.That(learner.IsActive, Is.True);
    }
}
