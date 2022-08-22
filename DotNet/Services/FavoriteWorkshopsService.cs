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
    public class FavoriteWorkshopsService : IFavoriteWorkshopService
    {
        IDataProvider _data = null;
        IUserMapper _userMapper = null;

        public FavoriteWorkshopsService(IDataProvider data, IUserMapper mapper, ILookUp lookMapper)
        {
            _data = data;
            _userMapper = mapper;
        }

        public int Add(FavoriteWorkshopAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[FavoriteWorkshops_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col, userId);

                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;

                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCol)
                {
                    object oId = returnCol["@Id"].Value;
                    int.TryParse(oId.ToString(), out id);
                });
            return id;

        }

        public Paged<WorkShop> GetAllByUserId(int userId, int pageIndex, int pageSize)
        {
            Paged<WorkShop> pagedList = null;
            List<WorkShop> list = null;
            int totalCount = 0;

            string procName = "[dbo].[FavoriteWorkshops_Select_ByUserId]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@UserId", userId);
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                WorkShop workShop = MapWorkShop(reader, ref startingIndex);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (list == null)
                {
                    list = new List<WorkShop>();
                }
                list.Add(workShop);
            });
            if(list != null)
            {
                pagedList = new Paged<WorkShop>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Paged<WorkshopWithFavoriteCount> GetAllFavoriteWorkshops(int pageIndex, int pageSize)
        {
            Paged<WorkshopWithFavoriteCount > pagedList = null;
            List <WorkshopWithFavoriteCount> list = null;
            int totalCount = 0;

            string procName = "[dbo].[FavoriteWorkshops_SelectAll]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                WorkshopWithFavoriteCount workshop = MapFavoriteCountWorkshop(reader, ref startingIndex);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (list == null)
                {
                    list = new List<WorkshopWithFavoriteCount>();
                }
                list.Add(workshop);
            });
            if(list != null)
            {
                pagedList = new Paged<WorkshopWithFavoriteCount>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Paged<WorkshopWithFavoriteCount> Search(int pageIndex, int pageSize, string query)
        {
            Paged<WorkshopWithFavoriteCount> pagedList = null;
            List<WorkshopWithFavoriteCount> list = null;
            int totalCount = 0;

            string procName = "[dbo].[FavoriteWorkshops_Select_ByQuery]";

            _data.ExecuteCmd(procName, (inputParamMapper) =>
            {
                inputParamMapper.AddWithValue("@PageIndex", pageIndex);
                inputParamMapper.AddWithValue("@PageSize", pageSize);
                inputParamMapper.AddWithValue("@Query", query);
            },
                (reader, recordSetIndex) =>
                {
                    int startingIndex = 0;

                    WorkshopWithFavoriteCount surveys = MapFavoriteCountWorkshop(reader, ref startingIndex);

                    if (totalCount == 0)
                    {
                        reader.GetSafeInt32(startingIndex++);
                    }

                    if (list == null)
                    {
                        list = new List<WorkshopWithFavoriteCount>();
                    }
                    list.Add(surveys);
                }
                );
            if (list != null)
            {
                pagedList = new Paged<WorkshopWithFavoriteCount>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public List<WorkshopId> GetFavoriteWorkshopIds(int userId)
        {
            List<WorkshopId> list = null;
            int totalCount = 0;

            string procName = "[dbo].[FavoriteWorkshops_SelectWorkShopIds_ByUserId]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("UserId", userId);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                WorkshopId workshopId = MapWorkshopIds(reader, startingIndex);

                if(totalCount == 0)
                {
                    totalCount=reader.GetSafeInt32(startingIndex++);
                }
                if(list == null)
                {
                    list = new List<WorkshopId>();
                }
                list.Add(workshopId);
            });
            if(list != null)
            {
                return list;
            }
            return null;
        }

        public void Delete(int workShopId, int userId)
        {
            string procName = "[dbo].[FavoriteWorkshops_Delete_ById]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                collection.AddWithValue("@WorkShopId", workShopId);
                collection.AddWithValue("@UserId", userId);
            }, returnParameters: null);
        }

    

        private WorkShop MapWorkShop(IDataReader reader, ref int startingIndex)
        {
            WorkShop workShop = new WorkShop();

            workShop.Id = reader.GetSafeInt32(startingIndex++);
            workShop.Name = reader.GetSafeString(startingIndex++);
            workShop.Summary = reader.GetSafeString(startingIndex++);
            workShop.ShortDescription = reader.GetSafeString(startingIndex++);
            workShop.VenueId = reader.GetSafeInt32(startingIndex++);
            workShop.Host = _userMapper.Map(reader, ref startingIndex);
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

        private WorkshopWithFavoriteCount MapFavoriteCountWorkshop(IDataReader reader, ref int startingIndex)
        {
            WorkshopWithFavoriteCount workShop = new WorkshopWithFavoriteCount();

            workShop.Id = reader.GetSafeInt32(startingIndex++);
            workShop.TotalFavorited = reader.GetSafeInt32(startingIndex++);
            workShop.Name = reader.GetSafeString(startingIndex++);
            workShop.Summary = reader.GetSafeString(startingIndex++);
            workShop.ShortDescription = reader.GetSafeString(startingIndex++);
            workShop.VenueId = reader.GetSafeInt32(startingIndex++);
            workShop.Host = _userMapper.Map(reader, ref startingIndex);
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

        private WorkshopId MapWorkshopIds(IDataReader reader, int startingIndex)
        {
            WorkshopId workshopId = new WorkshopId();

            workshopId.Id = reader.GetSafeInt32(startingIndex++);

            return workshopId;
        }

        private static void AddCommonParams(FavoriteWorkshopAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@UserId", userId);
            col.AddWithValue("@WorkShopId", model.WorkShopId);
        }
    }
}
