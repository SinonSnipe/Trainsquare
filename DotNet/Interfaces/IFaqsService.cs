using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Faqs;

namespace Sabio.Services
{
    public interface IFaqsService
    {
        int Add(FaqsAddRequest model, int userId);
        Faqs Delete(int Id);
        Faqs Get(int Id);
        Paged<Faqs> GetAll(int pageIndex, int pageSize);
        Paged<Faqs> GetByCreatedBy(int currentUserId, int pageIndex, int pageSize);
        void Update(FaqsUpdateRequest model, int Id);
    }
}