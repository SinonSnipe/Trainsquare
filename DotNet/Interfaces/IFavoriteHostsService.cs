using Sabio.Models;
using Sabio.Models.Domain;
using System.Collections.Generic;

namespace Sabio.Services.Interfaces
{
    public interface IFavoriteHostsService
    {
        int Add(FavoriteHostAddRequest model, int userId);
        void Delete(int workShopId, int userId);
        List<WorkshopId> GetFavoriteWorkshopIdsByHostId(int userId);
        List<WorkshopId> GetAllWorkshopIds();
        Paged<FavoriteHost> GetAllHostsByUserId(int userId, int pageIndex, int pageSize);
        Paged<HostWithFavoriteCount> Search(int pageIndex, int pageSize, string query);
    }
}