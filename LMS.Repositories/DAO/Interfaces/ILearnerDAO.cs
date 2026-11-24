using LMS.Models.Entities;

namespace LMS.Repositories.DAO.Interfaces;

public interface ILearnerDAO
{
    Task<IEnumerable<Learner>> GetAllAsync();
}