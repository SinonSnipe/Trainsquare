using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models.Domain;
using Sabio.Models.Requests.OrderItem;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class OrderItemService : IOrderItemService
    {
        IDataProvider _data = null;

        public OrderItemService(IDataProvider data)
        {
            _data = data;
        }

        public void AddOrderItems(List<OrderItemAddRequest> orderItems, int userId)
        {

            DataTable myParamValue = null;

            if (orderItems != null)
            {
                myParamValue = MapModelsToTable(orderItems, userId);
            }

            string procName = "[dbo].[OrderItems_InsertBatch]";

            _data.ExecuteNonQuery(procName,
              inputParamMapper: delegate (SqlParameterCollection sqlParams)
              {
                  sqlParams.AddWithValue("@newOrderItems", myParamValue);
              });

        }

        public List<OrderItem> GetOrderItemsByChargeId(string chargeId)
        {
            string procName = "[dbo].[OrderItems_SelectByChargeId]";

            List<OrderItem> list = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@ChargeId", chargeId);

            }, delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;

                OrderItem item = MapOrderItem(reader, ref startingIndex);

                if (list == null)
                {
                    list = new List<OrderItem>();
                }

                list.Add(item);
            });

            return list;
        }

        private DataTable MapModelsToTable(List<OrderItemAddRequest> orderItems, int userId)
        {

            DataTable tbl = new DataTable();

            tbl.Columns.Add("OrderId", typeof(int));
            tbl.Columns.Add("InventoryId", typeof(int));
            tbl.Columns.Add("Quantity", typeof(int));
            tbl.Columns.Add("UserId", typeof(int));

            orderItems.ForEach(orderItem =>
            {

                DataRow dataRow = tbl.NewRow();
                int startingIdex = 0;

                dataRow[startingIdex++] = orderItem.OrderId;
                dataRow[startingIdex++] = orderItem.InventoryId;
                dataRow[startingIdex++] = orderItem.Quantity;
                dataRow[startingIdex++] = userId;

                tbl.Rows.Add(dataRow);
            }
            );

            return tbl;

        }

        private static OrderItem MapOrderItem(IDataReader reader, ref int startingIndex)
        {
            OrderItem item = new OrderItem();

            item.Id = (reader.GetSafeInt32(startingIndex++));
            item.InventoryId = (reader.GetSafeInt32(startingIndex++));
            item.Quantity = (reader.GetSafeInt32(startingIndex++));
            item.CreatedBy = (reader.GetSafeInt32(startingIndex++));
            item.ModifiedBy = (reader.GetSafeInt32(startingIndex++));

            return item;
        }

    }
}
