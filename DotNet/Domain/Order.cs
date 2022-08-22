using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Order
    {
        public int Id { get; set; }
        public int PaymentStatusId { get; set; }
        public string TrackingCode { get; set; }
        public string TrackingUrl { get; set; }
        public decimal Total { get; set; }
        public int ShippingAddressId { get; set; }
        public string ChargeId { get; set; }
        public int ModifiedBy { get; set; }
        public int CreatedBy { get; set; }
    }
}
