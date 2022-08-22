using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class InventoryService : IInventoryService
    {
        IDataProvider _data = null;
        IUserMapper _userMapper = null;



        public InventoryService(IDataProvider data, IUserMapper mapper)
        {
            _data = data;
            _userMapper = mapper;

        }

        public int Add(InventoryAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[Inventory_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col, userId);

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

        public Inventory Get(int id)
        {
            string procName = "[dbo].[Inventory_Select_ById]";

            Inventory inventory = null;

            _data.ExecuteCmd(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
             {
                 col.AddWithValue("@Id", id);
             }, singleRecordMapper: delegate (IDataReader reader, short set)
             {
                 int startingIndex = 0;
                 inventory = MapInventory(reader, ref startingIndex);

             }
            );

            return inventory;
        }

        public Paged<Inventory> GetPaginate(int pageIndex, int pageSize)
        {
            Paged<Inventory> pagedResult = null;
            List<Inventory> result = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Inventory_SelectAll]",

            inputParamMapper: delegate (SqlParameterCollection parameterCollection)
            {
                parameterCollection.AddWithValue("@pageIndex", pageIndex);
                parameterCollection.AddWithValue("@pageSize", pageSize);
            },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {

                    int startingIndex = 0;
                    Inventory inventory = MapInventory(reader, ref startingIndex);

                    if (totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(startingIndex++);
                    }
                    if (result == null)
                    {
                        result = new List<Inventory>();
                    }
                    result.Add(inventory);

                });
            if (result != null)
            {
                pagedResult = new Paged<Inventory>(result, pageIndex, pageSize, totalCount);
            }

            return pagedResult;
        }

        public Paged<InventoryDetails> GetPaginateV2(int pageIndex, int pageSize)
        {
            Paged<InventoryDetails> pagedResult = null;
            List<InventoryDetails> result = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Inventory_SelectAllV2]",

            inputParamMapper: delegate (SqlParameterCollection parameterCollection)
            {
                parameterCollection.AddWithValue("@pageIndex", pageIndex);
                parameterCollection.AddWithValue("@pageSize", pageSize);
            },
            singleRecordMapper: delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;
                InventoryDetails inventory = MapInventoryV2(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (result == null)
                {
                    result = new List<InventoryDetails>();
                }
                result.Add(inventory);

            });
            if (result != null)
            {
                pagedResult = new Paged<InventoryDetails>(result, pageIndex, pageSize, totalCount);
            }

            return pagedResult;
        }

        public Paged<InventoryDetails> GetPaginateV2Search(int pageIndex, int pageSize, string query)
        {
            Paged<InventoryDetails> pagedResult = null;
            List<InventoryDetails> result = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Inventory_SelectAllV2_ByQuery]",

            inputParamMapper: delegate (SqlParameterCollection parameterCollection)
            {
                parameterCollection.AddWithValue("@pageIndex", pageIndex);
                parameterCollection.AddWithValue("@pageSize", pageSize);
                parameterCollection.AddWithValue("@Query", query);

            },
            singleRecordMapper: delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;
                InventoryDetails inventory = MapInventoryV2(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (result == null)
                {
                    result = new List<InventoryDetails>();
                }
                result.Add(inventory);

            });
            if (result != null)
            {
                pagedResult = new Paged<InventoryDetails>(result, pageIndex, pageSize, totalCount);
            }

            return pagedResult;
        }

        public void Delete(int id)
        {
            string procName = "[dbo].[Inventory_Delete_ById]";
            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            });
        }

        public void Update(InventoryUpdateRequest model, int userId)
        {
            string procName = "[dbo].[Inventory_Update]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col, userId);
                    col.AddWithValue("@Id", model.Id);
                });
        }

        private Inventory MapInventory(IDataReader reader, ref int startingIndex)
        {
            Inventory inventory = new Inventory();

            inventory.Id = reader.GetSafeInt32(startingIndex++);
            inventory.WorkshopId = new WorkShop();
            inventory.WorkshopId.Id = reader.GetSafeInt32(startingIndex++);
            inventory.WorkShopName = reader.GetSafeString(startingIndex++);
            inventory.Summary = reader.GetSafeString(startingIndex++);
            inventory.ImageUrl = reader.GetSafeString(startingIndex++);
            inventory.CreatedBy = _userMapper.Map(reader, ref startingIndex);
            inventory.ModifiedBy = _userMapper.Map(reader, ref startingIndex);
            inventory.Quantity = reader.GetSafeInt32(startingIndex++);
            inventory.BasePrice = reader.GetSafeDecimal(startingIndex++);
            inventory.DateCreated = reader.GetSafeDateTime(startingIndex++);
            inventory.DateModified = reader.GetSafeDateTime(startingIndex++);

            return inventory;
        }


        private static void AddCommonParams(InventoryAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@WorkShopId", model.WorkShopId);
            col.AddWithValue("@Quantity", model.Quantity);
            col.AddWithValue("@BasePrice", model.BasePrice);
            col.AddWithValue("@User", userId);
        }

        private InventoryDetails MapInventoryV2(IDataReader reader, ref int startingIndex)
        {
            InventoryDetails inventory = new InventoryDetails();

            inventory.Id = reader.GetSafeInt32(startingIndex++);
            inventory.Workshop = MapWorkshop(reader, ref startingIndex);
            inventory.Quantity = reader.GetSafeInt32(startingIndex++);
            inventory.BasePrice = reader.GetSafeDecimal(startingIndex++);
            inventory.DateCreated = reader.GetSafeDateTime(startingIndex++);
            inventory.DateModified = reader.GetSafeDateTime(startingIndex++);
            inventory.CreatedBy = reader.GetSafeInt32(startingIndex++);
            inventory.ModifiedBy = reader.GetSafeInt32(startingIndex++);

            return inventory;
        }

        private WorkShop MapWorkshop(IDataReader reader, ref int startingIndex)
        {
            WorkShop workShop = new WorkShop();

            workShop.Id = reader.GetSafeInt32(startingIndex++);
            workShop.Name = reader.GetSafeString(startingIndex++);
            workShop.Summary = reader.GetSafeString(startingIndex++);
            workShop.ShortDescription = reader.GetSafeString(startingIndex++);
            workShop.VenueId = reader.GetSafeInt32(startingIndex++);

            BaseUser host = new BaseUser()
            {
                Id = reader.GetSafeInt32(startingIndex++),
                FirstName = reader.GetSafeString(startingIndex++),
                LastName = reader.GetSafeString(startingIndex++),
                AvatarUrl = reader.GetSafeString(startingIndex++),
            };
            workShop.Host = host;

            workShop.WorkShopType = reader.GetSafeString(startingIndex++);
            workShop.WorkShopStatus = reader.GetSafeString(startingIndex++);
            workShop.ImageUrl = reader.GetSafeString(startingIndex++);
            workShop.ExternalSiteUrl = reader.GetSafeString(startingIndex++);
            workShop.LanguageId = reader.GetSafeInt32(startingIndex++);
            workShop.IsFree = reader.GetSafeBool(startingIndex++);
            workShop.NumberOfSessions = reader.GetSafeInt32(startingIndex++);
            workShop.DateStart = reader.GetDateTime(startingIndex++);
            workShop.DateEnd = reader.GetDateTime(startingIndex++);
            workShop.DateCreated = reader.GetDateTime(startingIndex++);
            workShop.DateModified = reader.GetDateTime(startingIndex++);

            return workShop;
        }
    }
}
