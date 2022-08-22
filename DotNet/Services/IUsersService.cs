using Sabio.Models;
using Sabio.Models.Domain;

namespace Sabio.Services
{
    public interface IUsersService
    {
        Paged<User> Paginate(int pageIndex, int pageSize);
    }
}