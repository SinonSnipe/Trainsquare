using Sabio.Models.Domain;
using Sabio.Models.Requests.NewsletterTemplateKeys;
using System.Collections.Generic;

namespace Sabio.Services
{
    public interface INewsletterTemplateKeysService
    {
        int Add(NewsletterTemplateKeyAddRequest model, int userId);

        void Update(NewsletterTemplateKeyUpdateRequest model, int userId);

        List<NewsletterTemplateKeys> GetByTemplateId(int id);
    }
}