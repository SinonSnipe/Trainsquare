using Sabio.Models.Domain;
using Sabio.Models.Requests.OrderItem;
using System.Collections.Generic;

namespace Sabio.Services
{
    public interface IOrderItemService
    {
        void AddOrderItems(List<OrderItemAddRequest> orderItems, int userId);
        List<OrderItem> GetOrderItemsByChargeId(string chargeId);
 
    }
}
