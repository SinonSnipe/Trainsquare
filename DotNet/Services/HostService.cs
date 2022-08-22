using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.WorkShopRequest;
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
    public class HostService : IHostService
    {
        IDataProvider _data = null;
        public HostService(IDataProvider data)
        {
            _data = data;
        }

        public List<HostWorkShop> GetWorkshops(int HostId)
        {
            List<HostWorkShop> list = null;
            _data.ExecuteCmd(
                "Host_SelectWorkshop_ById",
                (param) =>
                {
                    param.AddWithValue("@HostId", HostId);
                },
                (reader, recordSetIndex) =>
                {
                    int startingIndex = 0;
                    HostWorkShop workshop = MapWorkShop(reader, ref startingIndex);

                    if (list == null)
                    {
                        list = new List<HostWorkShop>();
                    }

                    list.Add(workshop);
                });

            return list;
        }

        public Paged<HostSession> GetSessions(int HostId, int pageIndex, int pageSize)
        {
            Paged<HostSession> pagedList = null;
            List<HostSession> list = null;
            int totalCount = 0;

            _data.ExecuteCmd(
                "Sessions_Select_ByHostId",
                (param) =>
                {
                    param.AddWithValue("@HostId", HostId);
                    param.AddWithValue("@PageIndex", pageIndex);
                    param.AddWithValue("@PageSize", pageSize);
                },
                (reader, recordSetIndex) =>
                {
                    int startingIndex = 0;
                    HostSession session = MapSession(reader, ref startingIndex);
                    totalCount = reader.GetSafeInt32(startingIndex++);

                    if (totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(startingIndex++);
                    }

                    if (list == null)
                    {
                        list = new List<HostSession>();
                    }

                    list.Add(session);
                });
            if (list != null)
            {
                pagedList = new Paged<HostSession>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public HostProfile GetProfile(int HostId)
        {
            HostProfile profile = null;
            string procName = "[dbo].[Host_Select_ById]";
            _data.ExecuteCmd(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
             {
                 col.AddWithValue("@HostId", HostId);
             }
            , singleRecordMapper: delegate (IDataReader reader, short set)
              {
                  int ind = 0;
                  profile = MapProfile(reader, ref ind);
              });
            return profile;
        }

        public List<HostWorkshopRequests> GetWorkshopRequests(int HostId)
        {
            List<HostWorkshopRequests> list = null;
            _data.ExecuteCmd(
                "DBO.WorkshopRequest_SelectBy_HostId",
                (param) =>
                {
                    param.AddWithValue("@HostId", HostId);
                },
                (reader, recordSetIndex) =>
                {
                    int startingIndex = 0;
                    HostWorkshopRequests request = MapWorkShopRequests(reader, ref startingIndex);

                    if (list == null)
                    {
                        list = new List<HostWorkshopRequests>();
                    }

                    list.Add(request);
                });
            
            return list;
        }

        public static HostSession MapSession(IDataReader reader, ref int startingIndex)
        {
            HostSession s = new HostSession();

            s.Id = reader.GetSafeInt32(startingIndex++);
            s.ImageUrl = reader.GetSafeString(startingIndex++);
            s.Name = reader.GetSafeString(startingIndex++);
            s.Date = reader.GetSafeDateTime(startingIndex++);
            s.TotalSlots = reader.GetSafeInt32(startingIndex++);
            s.OpenSlots = reader.GetSafeInt32(startingIndex++);
            s.StartTime = reader.GetSafeTimeSpan(startingIndex++);
            s.EndTime = reader.GetSafeTimeSpan(startingIndex++);
            return s;
        }

        public static HostWorkShop MapWorkShop(IDataReader reader, ref int startingIndex)
        {
            HostWorkShop ws = new HostWorkShop();

            ws.Id = reader.GetSafeInt32(startingIndex++);
            ws.Name = reader.GetSafeString(startingIndex++);
            ws.Summary = reader.GetSafeString(startingIndex++);
            ws.ShortDescription = reader.GetSafeString(startingIndex++);
            ws.VenueId = reader.GetSafeInt32(startingIndex++);
            ws.HostId = reader.GetSafeInt32(startingIndex++);
            ws.DateCreated = reader.GetSafeDateTime(startingIndex++);
            ws.DateModified = reader.GetSafeDateTime(startingIndex++);
            ws.StatusId = reader.GetSafeInt32(startingIndex++);
            ws.DateStart = reader.GetSafeDateTime(startingIndex++);
            ws.DateEnd = reader.GetSafeDateTime(startingIndex++);
            ws.ImageUrl = reader.GetSafeString(startingIndex++);
            return ws;
        }
        public static HostProfile MapProfile(IDataReader reader, ref int ind)
        {
            HostProfile hp = new HostProfile();

            hp.HostId = reader.GetSafeInt32(ind++);
            hp.UserId = reader.GetSafeInt32(ind++);
            hp.FirstName = reader.GetSafeString(ind++);
            hp.MiddleI = reader.GetSafeString(ind++);
            hp.LastName = reader.GetSafeString(ind++);
            hp.AvatarUrl = reader.GetSafeString(ind++);
            hp.DateCreated = reader.GetSafeDateTime(ind++);
            hp.Email = reader.GetSafeString(ind++);
            return hp;
        }
        public static HostWorkshopRequests MapWorkShopRequests(IDataReader reader, ref int ind)
        {
            HostWorkshopRequests hwr = new HostWorkshopRequests();

            hwr.Id = reader.GetSafeInt32(ind++);
            hwr.UserId = reader.GetSafeInt32(ind++);
            hwr.HostId = reader.GetSafeInt32(ind++);
            hwr.Topic = reader.GetSafeString(ind++);
            hwr.BriefDescription = reader.GetSafeString(ind++);
            hwr.DateCreated = reader.GetSafeDateTime(ind++);
            hwr.DateModified = reader.GetSafeDateTime(ind++);
            hwr.AvatarUrl = reader.GetSafeString(ind++);
            hwr.FirstName = reader.GetSafeString(ind++);
            hwr.LastName = reader.GetSafeString(ind++);
            return hwr;
        }
    }
}
