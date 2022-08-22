
using Sabio.Models.Domain;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public interface ISmsService
    {
        void TestSendSms(string code);
       
        int Add(int userId, string code);

        string GenerateRandomNumber();

        TwoFactorAuthentication GetById(int userId);

        void Delete(int userId);

    }
}