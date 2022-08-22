using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Product
    {
        public CartItem CartItem { get; set; }
        public string AccountId { get; set; }
        public decimal Fee { get; set; }
    }
}
