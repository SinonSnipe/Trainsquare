using Sabio.Models.Domain;
using Sabio.Models.Requests.Cart;

namespace Sabio.Services
{
    public interface ICartService
    {
        int Add(int userId);
        BaseCart GetBaseCartByUserId(int id);

    }
}

