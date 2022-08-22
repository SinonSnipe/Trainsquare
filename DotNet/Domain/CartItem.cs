using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class CartItem : BaseCartItem
    {
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public string Summary { get; set; }
        public decimal BasePrice { get; set; }
        
    }
}
