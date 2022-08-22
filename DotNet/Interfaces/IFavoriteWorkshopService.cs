using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services.Interfaces
{
    public interface IFavoriteWorkshopService
    {
        public int Add(FavoriteWorkshopAddRequest model, int userId);
        public Paged<WorkShop> GetAllByUserId(int userId, int pageIndex, int pageSize);
        public Paged<WorkshopWithFavoriteCount> GetAllFavoriteWorkshops(int pageIndex, int pageSize);
        public Paged<WorkshopWithFavoriteCount> Search(int pageIndex, int pageSize, string query);
        public List<WorkshopId> GetFavoriteWorkshopIds(int userId);
        public void Delete(int workShopId, int userId);
    }
}
