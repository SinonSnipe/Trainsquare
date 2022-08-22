using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.NewsletterTemplates;

namespace Sabio.Services
{
    public interface INewsletterTemplatesService
    {
        int Add(NewsletterTemplatesAddRequest model, int userId);
        void Update(NewsletterTemplatesUpdateRequest model, int currentUserId);
        NewsletterTemplates Get(int id);
        void Delete(int id);

        Paged<NewsletterTemplates> GetAllPaginated(int pageIndex, int pageSize);
        Paged<NewsletterTemplates> SearchPaginated(int pageIndex, int pageSize, string query);
    }
}