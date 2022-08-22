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
    public class CartService : ICartService
    {
        IDataProvider _data = null;

        public CartService(IDataProvider data)
        {
            _data = data;
        }
        public BaseCart GetBaseCartByUserId(int id)
        {
            string procName = "[dbo].[Cart_SelectByUserId]";

            BaseCart cart = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@UserId", id);

            }, delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;

                cart = new BaseCart();

                cart.Id = (reader.GetSafeInt32(startingIndex++));
                cart.CustomerId = (reader.GetSafeInt32(startingIndex++));
            }
            );

            return cart;
        }
        public int Add(int userId)
        {
            int id = 0;

            string procName = "[dbo].[Cart_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@CustomerId", userId);

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
       
    }
}
