using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Venues;
using System.Collections.Generic;

namespace Sabio.Services
{
    public interface IVenueLocationService
    {
        int Add(VenueLocationAddRequest model, int currentUserId);

        VenueLocation Get(int id);


        Paged<VenueLocation> GetAll(int pageIndex, int pageSize);

        Paged<VenueLocation> CreatedBy(int pageIndex, int pageSize, int currentUserId);


        void Update(VenueLocationUpdateRequest model, int currentUserId);


        void Delete(int id);
    }
}