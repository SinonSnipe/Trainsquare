using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Models.Requests.Users;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public interface IUserService
    {
        int Create(UserAddRequest userModel);
        int GetUserIdByEmail(string email);
        void InsertToken(string token, int userId, int tokenType);
        Task<bool> LogInAsync(string email, string password);
        Task<bool> LogInTest(string email, string password, int id, string[] roles = null);
        int ResetPassword(UserResetPasswordRequest model, int userId);
        void ConfirmNewUserToken(string token);
        int ConfirmResetPasswordToken(string token);
        Paged<UserBase> GetAll(int pageIndex, int pageSize);
        UserChangePassword GetById(int Id);
        bool ChangePasswordTaxi(UserPasswordChangeRequest model, int userId);
        bool ChangePasswordForLoggedIn(string email, string password);
    }
}
