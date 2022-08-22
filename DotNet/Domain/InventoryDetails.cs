using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class InventoryDetails
    {
        public int Id { get; set; }
        public WorkShop Workshop { get; set; }
        public int Quantity { get; set; }
        public decimal BasePrice { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public int CreatedBy { get; set; }
        public int ModifiedBy { get; set; }

    }
}
