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
    public interface IPrivateBookingService
    {
        PrivateBooking Get(int id, int startingIndex);
        WorkshopRequests GetByUserId(int userId);
        List<PrivateBooking> GetAll(int startingIndex); 
        int Add(PrivateBookingAddRequest model);
        void Update(PrivateBookingUpdateRequest model, int userId);
        void Delete(int id, int startingIndex);
        Paged<PrivateBooking> Pagination(int pageIndex, int pageSize, int startingIndex);
        Paged<PrivateBooking> Search(int pageIndex, int pageSize, string query, int startingIndex);
    }
}
