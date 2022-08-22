using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Order;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class OrderService : IOrderService
    {
        IDataProvider _data = null;

        public OrderService(IDataProvider data)
        {
            _data = data;
        }
        public Order GetByChargeId(string chargeId)
        {
            string procName = "[dbo].[Order_Select_ByChargeId]";

            Order order = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@ChargeId", chargeId);

            }, delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;
                order = MapSingleOrder(reader, ref startingIndex);
            }
            );

            return order;
        }

        public List<Order> GetAllByUserId(int userId)
        {
            string procName = "[dbo].[Order_Select_ByUserId]";

            List<Order> orders = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@UserId", userId);

            }, delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;
                Order order = MapSingleOrder(reader, ref startingIndex);

                if(orders == null)
                {
                    orders = new List<Order>();
                }
                orders.Add(order);
            }
            );

            return orders;
        }

        public OrderDetails GetByIdV2(int id)
        {
            string procName = "[dbo].[Order_Select_ByIdV3]";

            OrderDetails order = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);

            }, delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;
                order = MapSingleOrderDetails(reader, ref startingIndex);
            }
            );

            return order;
        }

        public int Add(OrderAddRequest orderAddRequest, int userId)
        {
            int id = 0;

            string procName = "[dbo].[Order_Insert]";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(orderAddRequest, userId, col);

                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;

                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection col)
                {
                    object oId = col["@Id"].Value;
                    int.TryParse(oId.ToString(), out id);

                });

            return id;
        }

        public void Update(OrderUpdateRequest model, int userId)
        {

            string procName = "[dbo].[Order_Update]";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", model.Id);
                    AddCommonParams(model, userId, col);
                });

        }

        private static void AddCommonParams(OrderAddRequest orderAddRequest, int userId, SqlParameterCollection col)
        {
            col.AddWithValue("@PaymentStatusId", orderAddRequest.PaymentStatusId);
            col.AddWithValue("@TrackingCode", orderAddRequest.TrackingCode == null ? (object)DBNull.Value : orderAddRequest.TrackingCode);
            col.AddWithValue("@TrackingUrl", orderAddRequest.TrackingUrl == null ? (object)DBNull.Value : orderAddRequest.TrackingUrl);
            col.AddWithValue("@Total", orderAddRequest.Total);
            col.AddWithValue("@ShippingAddressId", orderAddRequest.ShippingAddressId == 0 ? (object)DBNull.Value : orderAddRequest.ShippingAddressId);
            col.AddWithValue("@ChargeId", orderAddRequest.ChargeId);
            col.AddWithValue("@BillingAddressId", orderAddRequest.BillingAddressId == 0 ? (object)DBNull.Value : orderAddRequest.BillingAddressId);
            col.AddWithValue("@PaymentMethod", orderAddRequest.PaymentMethod == null ? (object)DBNull.Value : orderAddRequest.PaymentMethod);
            col.AddWithValue("@PhoneNumber", orderAddRequest.PhoneNumber == null ? (object)DBNull.Value : orderAddRequest.PhoneNumber);
            col.AddWithValue("@SessionId", orderAddRequest.SessionId == null ? (object)DBNull.Value : orderAddRequest.SessionId);
            col.AddWithValue("@UserId", userId);
        }
        private static Order MapSingleOrder(IDataReader reader, ref int startingIndex)
        {
            Order order = new Order();
            order.Id = reader.GetSafeInt32(startingIndex++);
            order.PaymentStatusId = reader.GetSafeInt32(startingIndex++);
            order.TrackingCode = reader.GetSafeString(startingIndex++);
            order.TrackingUrl = reader.GetSafeString(startingIndex++);
            order.Total = reader.GetSafeDecimal(startingIndex++);
            order.ShippingAddressId = reader.GetSafeInt32(startingIndex++);
            order.ChargeId = reader.GetSafeString(startingIndex++);
            order.CreatedBy = reader.GetSafeInt32(startingIndex++);
            order.ModifiedBy = reader.GetSafeInt32(startingIndex++);
            return order;
        }

        private static OrderDetails MapSingleOrderDetails(IDataReader reader, ref int startingIndex)
        {
            OrderDetails order = new OrderDetails();

            order.Id = reader.GetSafeInt32(startingIndex++);

            LookUp paymentStatus = new LookUp()
            {
                Id = reader.GetSafeInt32(startingIndex++),
                Name = reader.GetSafeString(startingIndex++),
            };
            order.PaymentStatus = paymentStatus;

            order.TrackingCode = reader.GetSafeString(startingIndex++);
            order.TrackingUrl = reader.GetSafeString(startingIndex++);
            order.Total = reader.GetSafeDecimal(startingIndex++);
            order.ChargeId = reader.GetSafeString(startingIndex++);
            order.CreatedBy = reader.GetSafeInt32(startingIndex++);
            order.ModifiedBy = reader.GetSafeInt32(startingIndex++);

            Address shippingAddress = new Address()
            {
                Line1 = reader.GetSafeString(startingIndex++),
                Line2 = reader.GetSafeString(startingIndex++),
                City = reader.GetSafeString(startingIndex++),
                Country = reader.GetSafeString(startingIndex++),
                PostalCode = reader.GetSafeString(startingIndex++),
                State = reader.GetSafeString(startingIndex++),
            };
            order.ShippingAddress = shippingAddress;

            order.DateCreated = reader.GetSafeDateTime(startingIndex++);
            order.DateModified = reader.GetSafeDateTime(startingIndex++);

            Address billingAddress = new Address()
            {
                Line1 = reader.GetSafeString(startingIndex++),
                Line2 = reader.GetSafeString(startingIndex++),
                City = reader.GetSafeString(startingIndex++),
                Country = reader.GetSafeString(startingIndex++),
                PostalCode = reader.GetSafeString(startingIndex++),
                State = reader.GetSafeString(startingIndex++),
            };
            order.BillingAddress = billingAddress;

            order.PaymentMethod = reader.GetSafeString(startingIndex++);
            order.PhoneNumber = reader.GetSafeString(startingIndex++);
            order.SessionId = reader.GetSafeString(startingIndex++);
            order.FirstName = reader.GetSafeString(startingIndex++);
            order.LastName = reader.GetSafeString(startingIndex++);

            order.OrderItems = reader.DeserializeObject<List<OrderItemDetails>>(startingIndex++);

            return order;
        }
    }
}
