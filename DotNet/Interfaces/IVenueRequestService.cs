using Sabio.Models.Domain;
using Sabio.Models.Requests.VenueRequest;
using System.Collections.Generic;
using Sabio.Models;
namespace Sabio.Services
{
    public interface IVenueRequestService
    {
        int AddVenueRequest(AddVenueRequest model, int userId);
        public Paged<VenueRequest> GetAll(int pageIndex, int pageSize);
        public Paged<VenueRequest> GetByVenueId(int id, int pageIndex, int pageSize);
        public VenueRequest GetByRequester(int userId);
        public void UpdateVenueRequest(UpdateVenueRequest model, int currentUserId);
        public void DeleteVenueRequest(int id);
    }
}
