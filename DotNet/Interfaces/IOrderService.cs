using Sabio.Models.Domain;
using Sabio.Models.Requests.Order;
using System.Collections.Generic;

namespace Sabio.Services
{
    public interface IOrderService
    {
        int Add(OrderAddRequest orderAddRequest, int userId);
        void Update(OrderUpdateRequest model, int userId);
        Order GetByChargeId(string chargeId);
        List<Order> GetAllByUserId(int userId);
        OrderDetails GetByIdV2(int id);
    }
}
