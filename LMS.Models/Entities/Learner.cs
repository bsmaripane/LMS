namespace LMS.Models.Entities;

public class Learner
{
    public int LearnerId { get; set; }
    public string AdmissionNumber { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string? MiddleName { get; set; }
    public string LastName { get; set; } = string.Empty;
    public int GenderId { get; set; }
    public DateOnly DateOfBirth { get; set; }
    public string IdentificationNumber { get; set; } = string.Empty;
    public int ParentId { get; set; }
    public int RelationId { get; set; }
    public int ClassId { get; set; }
    public string PhysicalAddress { get; set; } = string.Empty;
    public bool IsActive { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime ModifiedDate { get; set; }
}
