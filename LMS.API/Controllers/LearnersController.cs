using LMS.Models.Entities;
using LMS.Repositories.DAO.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace LMS.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class LearnersController : ControllerBase
{
    private readonly ILearnerDAO _learnerDAO;

    public LearnersController(ILearnerDAO learnerDAO)
    {
        _learnerDAO = learnerDAO;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Learner>>> GetAll()
    {
        var learners = await _learnerDAO.GetAllAsync();

        return Ok(learners);
    }
}
