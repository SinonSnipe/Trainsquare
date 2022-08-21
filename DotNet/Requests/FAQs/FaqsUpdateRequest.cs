using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.Faqs
{
    public class FaqsUpdateRequest : FaqsAddRequest, IModelIdentifier
    {
        public int Id { get; set; }
    }
}
