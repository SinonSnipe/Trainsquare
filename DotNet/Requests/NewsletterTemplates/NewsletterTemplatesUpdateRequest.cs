using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.NewsletterTemplates
{
  public class NewsletterTemplatesUpdateRequest : NewsletterTemplatesAddRequest, IModelIdentifier
    {
        public int Id { get; set; } 
    }
}
