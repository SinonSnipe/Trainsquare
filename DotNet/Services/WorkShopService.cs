using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Workshop;
using Sabio.Models.Requests.WorkshopSignUps;
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
    public class WorkShopService : IWorkShopService
    {
        IDataProvider _data = null;
        IUserMapper _userMapper = null;
        IEmailService _emailService = null;

        public WorkShopService(IDataProvider data, IUserMapper mapper, ILookUp lookMapper, IEmailService emailServ)
        {
            _data = data;
            _userMapper = mapper;
            _emailService = emailServ;
        }

        public void RegisterAdd(WorkshopRegistrationRequset model, int UserId)
        {        
            string procName = "[dbo].[WorkshopRegistration_Insert]";

            _data.ExecuteNonQuery(
                procName,
                inputParamMapper: delegate (SqlParameterCollection parameterCollection)
                {
                    parameterCollection.AddWithValue("@WorkshopId", model.WorkshopId);
                    parameterCollection.AddWithValue("@UserId", UserId);
                    parameterCollection.AddWithValue("@StatusId", model.StatusId);
                },
                returnParameters: null
            );

            WorkshopRegistrationEmail data = GetEmailInfo(model.WorkshopId, UserId);

            _emailService.SendWorkshopRegistrationConfirmation(data);         
        }

        private WorkshopRegistrationEmail GetEmailInfo(int id, int UserId)
        {
            string procName = "[dbo].[WorkShopRegistrationEmail_SelectAllByWorkshopId]";

            WorkshopRegistrationEmail emailInfo = null;

            _data.ExecuteCmd(
                procName, 
                delegate (SqlParameterCollection parameterCollection)
                {
                    parameterCollection.AddWithValue("@WorkshopId", id);
                    parameterCollection.AddWithValue("@UserId", UserId);

                }, delegate (IDataReader reader, short set)
                {
                    int startingIndex = 0;
                    emailInfo = new WorkshopRegistrationEmail();

                    emailInfo.WorkshopId = reader.GetSafeInt32(startingIndex++);
                    emailInfo.WorkshopName = reader.GetSafeString(startingIndex++);
                    emailInfo.WorkshopImage = reader.GetSafeString(startingIndex++);
                    emailInfo.DateStart = reader.GetSafeDateTime(startingIndex++);
                    emailInfo.DateEnd = reader.GetSafeDateTime(startingIndex++);
                    emailInfo.UserEmail = reader.GetSafeString(startingIndex++);
                    emailInfo.UserRegistrationStatusId = reader.GetSafeInt32(startingIndex++);
                    emailInfo.UserRegistrationStatus = reader.GetSafeString(startingIndex++);
                    emailInfo.VenueName = reader.GetSafeString(startingIndex++);
                    emailInfo.VenueUrl = reader.GetSafeString(startingIndex++);
                    emailInfo.LineOne = reader.GetSafeString(startingIndex++);
                    emailInfo.LineTwo = reader.GetSafeString(startingIndex++);
                    emailInfo.City = reader.GetSafeString(startingIndex++);
                    emailInfo.State = reader.GetSafeInt32(startingIndex++);
                    emailInfo.HostFName = reader.GetSafeString(startingIndex++);
                    emailInfo.HostLName = reader.GetSafeString(startingIndex++);
                });
            return emailInfo;
        }

        public void RegisterUpdate(WorkshopRegistrationRequset model, int UserId)
        {
            string procName = "[dbo].[WorkshopRegistration_Update]";

            _data.ExecuteNonQuery(
                procName,
                inputParamMapper: delegate (SqlParameterCollection parameterCollection)
                {
                    parameterCollection.AddWithValue("@WorkshopId", model.WorkshopId);
                    parameterCollection.AddWithValue("@UserId", UserId);
                    parameterCollection.AddWithValue("@StatusId", model.StatusId);
                },
                returnParameters: null
            );

            WorkshopRegistrationEmail data = GetEmailInfo(model.WorkshopId, UserId);

            _emailService.SendWorkshopRemovalConfirmation(data);
        }

        public List<WorkshopRegistration> GetAllWorkshopsByUserId(int UserId)
        {
            string procName = "[dbo].[WorkshopRegistration_SelectAllWorkshopsByUserId]";

            List<WorkshopRegistration> list = null;

            _data.ExecuteCmd(
                procName,
                inputParamMapper: delegate (SqlParameterCollection parameterCollection)
                {
                    parameterCollection.AddWithValue("@UserId", UserId);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    int startingIndex = 0;

                    WorkshopRegistration wkSpRg = new WorkshopRegistration();

                    wkSpRg.WorkshopId = reader.GetSafeInt32(startingIndex++);                    
                    wkSpRg.RegistrationStatus = reader.GetSafeString(startingIndex++);                                  

                    if (list == null)
                    {
                        list = new List<WorkshopRegistration>();
                    }

                    list.Add(wkSpRg);
                }
            );

            return list;
        }

        public void Update(WorkShopUpdateRequest model, int userId, int id)
        {
            string procName = "dbo.WorkShop_Update";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                workShopCommonParams(model, col, userId);
                col.AddWithValue("@Id", id);


            }, returnParameters: null);
        }

        public int Add(WorkShopAddRequest model, int userId)
        {
            int id = 0;

            string procName = "dbo.WorkShop_Insert";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                workShopCommonParams(model, col, userId);

                SqlParameter idOut = new SqlParameter("@Id", System.Data.SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;

                col.Add(idOut);
            }, returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object oId = returnCollection["@Id"].Value;

                int.TryParse(oId.ToString(), out id);
            });

            return id;
        }

        public WorkShop Get(int id)
        {
            string procName = "dbo.WorkShop_Select_ById";

            WorkShop workShop = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);

            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                workShop = mapWorkShop(reader, ref startingIndex);
            });

            return workShop;
        }

        public void Delete(int id)
        {
            string procName = "dbo.WorkShop_Delete";

            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", id);
            });
        }

        public Paged<WorkShop> GetAll(int pageIndex, int pageSize)
        {
            Paged<WorkShop> pagedList = null;
            List<WorkShop> list = null;
            int totalCount = 0;

            string procName = "dbo.WorkShop_SelectAll";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@pageIndex", pageIndex);
                param.AddWithValue("@pageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                WorkShop workShop = mapWorkShop(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex++);

                if (list == null)
                {
                    list = new List<WorkShop>();
                }
                list.Add(workShop);
            }
            );
            if (list != null)
            {
                pagedList = new Paged<WorkShop>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Paged<WorkShop> Search(int pageIndex, int pageSize, string query)
        {
            Paged<WorkShop> pagedList = null;
            List<WorkShop> list = null;
            int totalCount = 0;

            string procName = "[dbo].[Workshop_Select ByQuery]";

            _data.ExecuteCmd(procName, (inputParamMapper) =>
            {
                inputParamMapper.AddWithValue("@PageIndex", pageIndex);
                inputParamMapper.AddWithValue("@PageSize", pageSize);
                inputParamMapper.AddWithValue("@Query", query);
            },
                (reader, recordSetIndex) =>
                {
                    int startidx = 0;

                    WorkShop surveys = mapWorkShop(reader, ref startidx);
                    totalCount = reader.GetSafeInt32(startidx++);

                    if (list == null)
                    {
                        list = new List<WorkShop>();
                    }
                    list.Add(surveys);
                }
                );
            if (list != null)
            {
                pagedList = new Paged<WorkShop>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public List<WorkShop> GetFive()
        {

            List<WorkShop> list = null;

            string procName = "[dbo].[WorkShop_SelectRandom5]";

            _data.ExecuteCmd(procName, inputParamMapper: null,
            singleRecordMapper: delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                WorkShop workShop = mapWorkShop(reader, ref startingIndex);

                if (list == null)
                {
                    list = new List<WorkShop>();
                }
                list.Add(workShop);
            }
            );

            return list;
        }

        public List<WorkshopVenues> GetByGeo(int radius, double latitude, double longitude)
        {
            List<WorkshopVenues> list = null;

            _data.ExecuteCmd("[dbo].[Workshop_SelectAll_GeoSearch]", (param) =>
            {
                param.AddWithValue("@Distance", radius);
                param.AddWithValue("@Latitude", latitude);
                param.AddWithValue("@Longitude", longitude);
            },

            singleRecordMapper: delegate (IDataReader reader, short set)
            {
                int ind = 0;
                WorkshopVenues location = new WorkshopVenues();
                location.Workshop = new WorkShop();
                location.LocationId = reader.GetSafeInt32(ind++);
                location.LocationType = reader.GetSafeString(ind++);
                location.LineOne = reader.GetSafeString(ind++);
                location.LineTwo = reader.GetSafeString(ind++);
                location.City = reader.GetSafeString(ind++);
                location.Zip = reader.GetSafeString(ind++);
                location.State = reader.GetSafeString(ind++);
                location.Latitude = reader.GetSafeDouble(ind++);
                location.Longitude = reader.GetSafeDouble(ind++);
                location.Workshop = mapWorkShop(reader, ref ind);
                location.VenueId = reader.GetSafeInt32(ind++);
                location.VenueName = reader.GetSafeString(ind++);
                location.VenueImageUrl = reader.GetSafeString(ind++);
                location.Range = reader.GetSafeDouble(ind++);

                if (list == null)
                {
                    list = new List<WorkshopVenues>();
                }

                list.Add(location);
            });

            return list;
        }

        private WorkShop mapWorkShop(IDataReader reader, ref int startingIndex)
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

        private static void workShopCommonParams(WorkShopAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@Summary", model.Summary);
            col.AddWithValue("@ShortDescription", model.ShortDescription);
            col.AddWithValue("@VenueId", model.VenueId);
            col.AddWithValue("@HostId", userId);
            col.AddWithValue("@WorkShopTypeId", model.WorkShopTypeId);
            col.AddWithValue("@WorkShopStatusId", model.WorkShopStatusId);
            col.AddWithValue("@ImageUrl", model.ImageUrl);
            col.AddWithValue("@ExternalSiteUrl", model.ExternalSiteUrl);
            col.AddWithValue("@LanguageId", model.LanguageId);
            col.AddWithValue("@IsFree", model.IsFree);
            col.AddWithValue("@NumberOfSessions", model.NumberOfSessions);
            col.AddWithValue("@DateStart", model.DateStart);
            col.AddWithValue("@DateEnd", model.DateEnd);
        }
    }
}