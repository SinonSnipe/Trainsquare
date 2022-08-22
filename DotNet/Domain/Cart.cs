using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Cart : BaseCart
    {
        public string AccountId { get; set; }
        public decimal Fee { get; set; }
        public List<CartItem> Items { get; set; }
        public decimal Total { get; set; }

    }
}
