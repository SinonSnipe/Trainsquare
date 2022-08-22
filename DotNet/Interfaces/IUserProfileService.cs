using Sabio.Models.Domain;
using Sabio.Models.Requests;

namespace Sabio.Services.Interfaces;

public interface IUserProfileService
{
    UserProfile GetProfileByUserId(int id);
    UserProfile GetProfileById(int Id);
    public void Update(UserProfileUpdateRequest model);
}
