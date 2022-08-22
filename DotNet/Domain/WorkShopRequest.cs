using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain.WorkShopRequest
{
    public class WorkShopRequest : WorkShopRequestBase
    {
      
       
        public string Email { get; set; }   
        
        public string Topic { get; set; }
        
        public string ShortDescription { get; set; }

        public DateTime DateCreated { get; set; }

        public DateTime DateModified { get; set; }

        



    }
}
