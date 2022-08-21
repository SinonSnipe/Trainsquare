using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.Newsletters
{
  
    
        public class NewslettersUpdateRequest : NewslettersAddRequest, IModelIdentifier
        {
            public int Id { get; set; }
        }
    
}
