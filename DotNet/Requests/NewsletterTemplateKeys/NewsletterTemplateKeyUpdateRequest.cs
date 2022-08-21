using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.NewsletterTemplateKeys
{
    public class NewsletterTemplateKeyUpdateRequest: NewsletterTemplateKeyAddRequest, IModelIdentifier
    {
        public int Id { get; set; }
    }
}
