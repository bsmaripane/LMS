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
}
