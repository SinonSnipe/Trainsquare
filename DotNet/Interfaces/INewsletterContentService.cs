using Sabio.Models.Domain;
using Sabio.Models.Requests.NewsletterContent;

namespace Sabio.Services
{
    public interface INewsletterContentService
    {
        int Add(NewsletterContentAddRequest model, int userId);
        void Update(NewsletterContentUpdateRequest model, int userId);
        NewsletterContent Get(int id);
    }
}