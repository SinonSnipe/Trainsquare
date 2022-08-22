using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class BaseCartItem
    {
        public int Id { get; set; }
        public int InventoryId { get; set; }
        public int Quantity { get; set; }
        public int CartId { get; set; }
    }
}
