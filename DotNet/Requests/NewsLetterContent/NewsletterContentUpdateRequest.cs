using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.NewsletterContent
{
    public class NewsletterContentUpdateRequest : NewsletterContentAddRequest, IModelIdentifier
    {
        public int Id { get; set; }
    }
}
