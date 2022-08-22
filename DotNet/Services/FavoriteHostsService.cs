using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
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
    public class FavoriteHostsService : IFavoriteHostsService
    {
        IDataProvider _data = null;
        IUserMapper _userMapper = null;

        public FavoriteHostsService(IDataProvider data, IUserMapper userMapper)
        {
            _data = data;
            _userMapper = userMapper;
        }

        public int Add(FavoriteHostAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[FavoriteHosts_Insert]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddCommonParams(model, col, userId);

                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;

                col.Add(idOut);

            }, returnParameters: delegate (SqlParameterCollection returnCol)
            {
                object oId = returnCol["id"].Value;
                int.TryParse(oId.ToString(), out id);
            });

            return id;
        }

        public List<WorkshopId> GetFavoriteWorkshopIdsByHostId(int userId)
        {
            List<WorkshopId> list = null;
            int totalCount = 0;

            string procName = "[dbo].[FavoriteHosts_SelectWorkShopIds_ByHostId]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("UserId", userId);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                WorkshopId workshopId = MapWorkshopIds(reader, startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (list == null)
                {
                    list = new List<WorkshopId>();
                }
                list.Add(workshopId);

            });
            if (list != null)
            {
                return list;
            }
            return null;

        }

        public List<WorkshopId> GetAllWorkshopIds()
        {

            List<WorkshopId> list = null;

            string procName = "[dbo].[FavoriteHosts_SelectAllWorkShopIds]";

            _data.ExecuteCmd(procName, inputParamMapper: null,
            singleRecordMapper: delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                WorkshopId workShop = MapWorkshopIds(reader, startingIndex);

                if (list == null)
                {
                    list = new List<WorkshopId>();
                }
                list.Add(workShop);
            });
            return list;
        }

        public Paged<FavoriteHost> GetAllHostsByUserId(int userId, int pageIndex, int pageSize)
        {
            Paged<FavoriteHost> pagedList = null;
            List<FavoriteHost> list = null;
            int totalCount = 0;

            string procName = "[dbo].[FavoriteHosts_Select_ByUserId]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@UserId", userId);
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                FavoriteHost host = MapHosts(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (list == null)
                {
                    list = new List<FavoriteHost>();
                }
                list.Add(host);
            });
            if (list != null)
            {
                pagedList = new Paged<FavoriteHost>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Paged<HostWithFavoriteCount> Search(int pageIndex, int pageSize, string query)
        {
            Paged<HostWithFavoriteCount> pagedList = null;
            List<HostWithFavoriteCount> list = null;
            int totalCount = 0;

            string procName = "[dbo].[FavoriteHosts_Select_ByQuery]";

            _data.ExecuteCmd(procName, (inputParamMapper) =>
            {
                inputParamMapper.AddWithValue("@PageIndex", pageIndex);
                inputParamMapper.AddWithValue("@PageSize", pageSize);
                inputParamMapper.AddWithValue("@Query", query);
            },
                (reader, recordSetIndex) =>
                {
                    int startingIndex = 0;

                    HostWithFavoriteCount surveys = MapFavoriteCountHost(reader, ref startingIndex);

                    if (totalCount == 0)
                    {
                        reader.GetSafeInt32(startingIndex++);
                    }

                    if (list == null)
                    {
                        list = new List<HostWithFavoriteCount>();
                    }
                    list.Add(surveys);
                }
                );
            if (list != null)
            {
                pagedList = new Paged<HostWithFavoriteCount>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }



        public void Delete(int workShopId, int userId)
        {
            string procName = "[dbo].[FavoriteHosts_Delete_ById]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection collection)
            {
                collection.AddWithValue("@WorkshopId", workShopId);
                collection.AddWithValue("@UserId", userId);
            }, returnParameters: null);
        }

        private static WorkshopId MapWorkshopIds(IDataReader reader, int startingIndex)
        {
            WorkshopId workshopId = new WorkshopId();

            workshopId.Id = reader.GetSafeInt32(startingIndex++);
            return workshopId;
        }

        private static FavoriteHost MapHosts(IDataReader reader, ref int startingIndex)
        {
            FavoriteHost host = new FavoriteHost();

            host.WorkshopId = reader.GetSafeInt32(startingIndex++);
            host.HostId = reader.GetSafeInt32(startingIndex++);
            host.FirstName = reader.GetSafeString(startingIndex++);
            host.LastName = reader.GetSafeString(startingIndex++);
            return host;
        }

        private HostWithFavoriteCount MapFavoriteCountHost(IDataReader reader, ref int startingIndex)
        {
            HostWithFavoriteCount host = new HostWithFavoriteCount();

            host.WorkshopId = reader.GetSafeInt32(startingIndex++);
            host.TotalFavorited = reader.GetSafeInt32(startingIndex++);
            host.HostId = reader.GetSafeInt32(startingIndex++);
            host.FirstName = reader.GetSafeString(startingIndex++);
            host.LastName = reader.GetSafeString(startingIndex++);
            return host;
        }

        private static void AddCommonParams(FavoriteHostAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@HostId", userId);
            col.AddWithValue("@WorkshopId", model.WorkshopId);
        }
    }
}
