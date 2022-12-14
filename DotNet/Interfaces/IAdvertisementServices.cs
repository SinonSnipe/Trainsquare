using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;

namespace Sabio.Services
{
    public interface IAdvertisementServices
    {
        int Add(AdvertisementAddRequest model, int currentUserId);
        Paged<Advertisements> CreatedByPagination(int index, int pageSize, int CreatedBy);
        void Delete(int id);
        Advertisements Get(int id);
        Paged<Advertisements> Pagination(int index, int pageSize);
        void Update(AdvertisementUpdateRequest model, int userId, int adId);
    }
}