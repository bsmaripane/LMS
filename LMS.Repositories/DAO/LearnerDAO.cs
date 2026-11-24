
using Dapper;
using LMS.Models.Entities;
using LMS.Repositories.DAO.Interfaces;
using Microsoft.Data.SqlClient;

namespace LMS.Repositories.DAO;

public class LearnerDAO : ILearnerDAO
{
    private readonly string _connectionString;

    public LearnerDAO(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<Learner>> GetAllAsync()
    {
        const string GetAllSql = """
            SELECT *
            FROM dbo.Learner
            ORDER BY LearnerId;
            """;

        await using var connection = new SqlConnection(_connectionString);

        await connection.OpenAsync();

        return await connection.QueryAsync<Learner>(GetAllSql);
    }
}
