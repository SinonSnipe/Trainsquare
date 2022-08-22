using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class BaseShoppingCart
    {
        public int Id { get; set; }
        public int InventoryId { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime DateModified { get; set; }
        
    }
}
