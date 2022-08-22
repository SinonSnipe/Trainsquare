using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class OrderDetails
    {
        public int Id { get; set; }
        public LookUp PaymentStatus { get; set; }
        public string TrackingCode { get; set; }
        public string TrackingUrl { get; set; }
        public decimal Total { get; set; }
        public string ChargeId { get; set; }
        public int ModifiedBy { get; set; }
        public int CreatedBy { get; set; }
        public Address ShippingAddress { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public Address BillingAddress { get; set; }
        public string PaymentMethod { get; set; }
        public string PhoneNumber { get; set; }
        public string SessionId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public List<OrderItemDetails> OrderItems { get; set; }
    }
}
