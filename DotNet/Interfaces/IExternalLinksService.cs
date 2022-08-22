using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.ExternalLinks;

namespace Sabio.Services.Interfaces
{
    public interface IExternalLinksService
    {
        void DeleteById(int id);
        int Insert(ExternalLinksAddRequest model);
        Paged<ExternalLinksTable> SelectAll(int pageIndex, int pageSize);
        Paged<ExternalLinksTable> SelectByCreatedBy(int pageIndex, int pageSize, int userId);
        ExternalLinksTable SelectById(int id);
        void Update(ExternalLinksUpdateRequest model);
    }
}