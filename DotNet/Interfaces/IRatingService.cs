using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using System.Collections.Generic;

namespace Sabio.Services.Interfaces
{
    public interface IRatingService
    {
        int AddRating(RatingAddRequest model, int currentUserId);
        Paged<RatingsDetails> CreatedByPagination(int pageIndex, int pageSize, int CreatedBy);
        List<RatingsDetails> CreatedByV2(int CreatedBy);
        Paged<Ratings> SelectAllPaginated(int Index, int pageSize);
        Paged<RatingsDetails> SelectByEntityId(int EntityId, int EntityTypeId, int pageIndex, int pageSize);
        Ratings SelectById(int Id);
        void Update(RatingUpdateRequest model, int userId, int Id);
    }
}