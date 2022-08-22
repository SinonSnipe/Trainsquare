using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Cart;
using Sabio.Models.Requests.ShoppingCarts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class CartItemService : ICartItemService
    {
        IDataProvider _data = null;

        public CartItemService(IDataProvider data)
        {
            _data = data;
        }
        public int Add(CartItemAddRequest model)
        {
            int id = 0;

            string procName = "[dbo].[CartItem_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col);

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

        public void AddCartItems(List<CartItemAddRequest> cartItems)
        {

            DataTable myParamValue = null;

            if (cartItems != null)
            {
                myParamValue = MapModelsToTable(cartItems);
            }

            string procName = "[dbo].[CartItems_InsertBatch]";

            _data.ExecuteNonQuery(procName,
              inputParamMapper: delegate (SqlParameterCollection sqlParams)
              {
                  sqlParams.AddWithValue("@newCartItems", myParamValue);
              });

        }
        public void UpdateCartItem(CartItemUpdateRequest cartItem)
        {
            string procName = "[dbo].[CartItem_Update]";

            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", cartItem.Id);
                AddCommonParams(cartItem, paramCollection);

            });

        }
        public void DeleteById(int id)
        {
            string procName = "[dbo].[CartItem_Delete]";

            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);

            });

        }
        public void DeleteByCartId(int cartId)
        {
            string procName = "[dbo].[CartItem_DeleteByCartId]";

            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@cartId", cartId);

            });

        }
        public List<BaseCartItem> GetBaseCartItemsByCartId(int cartId)
        {
            string procName = "[dbo].[CartItem_SelectByCartId]";

            List<BaseCartItem> list = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@CartId", cartId);

            }, delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;

                BaseCartItem item = MapBaseCart(reader, ref startingIndex);

                if (list == null)
                {
                    list = new List<BaseCartItem>();
                }

                list.Add(item);
            });

            return list;
        }
        public List<CartItem> GetCartItemsByCartId(int cartId)
        {
            string procName = "[dbo].[CartItem_SelectByCartIdV2]";

            List<CartItem> list = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@CartId", cartId);

            }, delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;

                CartItem item = MapBaseCart(reader, ref startingIndex);
                MapCartDetails(reader, ref startingIndex, item);

                if (list == null)
                {
                    list = new List<CartItem>();
                }

                list.Add(item);
            });

            return list;
        }

        public List<Product> GetCartItemsByCartIdV3(int cartId)
        {
            string procName = "[dbo].[CartItem_SelectByCartIdV3]";

            List<Product> list = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@CartId", cartId);

            }, delegate (IDataReader reader, short set)
            {

                Product productItem = new Product();

                int startingIndex = 0;

                CartItem cartItem = MapBaseCart(reader, ref startingIndex);
                MapCartDetails(reader, ref startingIndex, cartItem);

                productItem.CartItem = cartItem;
                productItem.AccountId = reader.GetSafeString(startingIndex++);
                productItem.Fee = reader.GetSafeDecimal(startingIndex++);

                if (list == null)
                {
                    list = new List<Product>();
                }

                list.Add(productItem);
            });

            return list;
        }

        private static CartItem MapBaseCart(IDataReader reader, ref int startingIndex)
        {
            CartItem item = new CartItem();

            item.Id = (reader.GetSafeInt32(startingIndex++));
            item.InventoryId = (reader.GetSafeInt32(startingIndex++));
            item.Quantity = (reader.GetSafeInt32(startingIndex++));
            item.CartId = (reader.GetSafeInt32(startingIndex++));

            return item;
        }

        private static void AddCommonParams(CartItemAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@Quantity", model.Quantity);
            col.AddWithValue("@InventoryId", model.InventoryId);
            col.AddWithValue("@CartId", model.CartId);
        }

        private DataTable MapModelsToTable(List<CartItemAddRequest> cartItems)
        {

            DataTable tbl = new DataTable();

            tbl.Columns.Add("CartId", typeof(int));
            tbl.Columns.Add("InventoryId", typeof(int));
            tbl.Columns.Add("Quantity", typeof(int));

            cartItems.ForEach(cartItem =>
            {

                DataRow dataRow = tbl.NewRow();
                int startingIdex = 0;

                dataRow[startingIdex++] = cartItem.CartId;
                dataRow[startingIdex++] = cartItem.InventoryId;
                dataRow[startingIdex++] = cartItem.Quantity;

                tbl.Rows.Add(dataRow);
            }
            );

            return tbl;

        }
        
        private static int MapCartDetails(IDataReader reader, ref int startingIndex, CartItem item)
        {
            item.Name = reader.GetSafeString(startingIndex++);
            item.ImageUrl = reader.GetSafeString(startingIndex++);
            item.Summary = reader.GetSafeString(startingIndex++);
            item.BasePrice = reader.GetSafeDecimal(startingIndex++);
            return startingIndex;
        }

    }
}
