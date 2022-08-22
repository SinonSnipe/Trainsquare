using Sabio.Data;
using Sabio.Data.Providers;
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

namespace Sabio.Models
{
    public class PrivateBookingService : IPrivateBookingService                
    {   
        IDataProvider _data = null;

        public PrivateBookingService(IDataProvider data)                                       
        {      
            _data = data;
        }

        public PrivateBooking Get(int id, int startingIndex)
        {
            string procName = "[dbo].[PrivateBooking_SelectById]";
            PrivateBooking privateBooking = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }, delegate (IDataReader reader, short set)
            {
                privateBooking = mapPrivateBooking(reader, ref startingIndex);
            }
            );
            return privateBooking;
        }



        public WorkshopRequests GetByUserId(int userId)
        {
            string procName = "[dbo].[WorkshopRequests_SelectBy_UserId]"; 
            WorkshopRequests workshopRequest = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@UserId", userId);
            }, delegate (IDataReader reader, short set)
            {
                workshopRequest = mapWorkshopRequests(reader);
            }
            );  
            return workshopRequest;
        }





        public List<PrivateBooking> GetAll(int startingIndex)
        {
            List<PrivateBooking> list = null;

            string procName = "[dbo].[PrivateBooking_SelectAll]";           
            _data.ExecuteCmd(procName, inputParamMapper: null
            , singleRecordMapper: delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                PrivateBooking privateBooking = mapPrivateBooking(reader, ref startingIndex);         

                if (list == null)
                {
                    list = new List<PrivateBooking>(); 
                }

                list.Add(privateBooking);
            }
            );

            return list; 
        }  




        public int Add(PrivateBookingAddRequest model)
        {
            int id = 0;

            string procName = "[dbo].[PrivateBooking_Insert]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddCommonParams(model, col);
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                col.Add(idOut);

            }, returnParameters: delegate (SqlParameterCollection returnCollection)  
            {
                object oId = returnCollection["@Id"].Value;

                int.TryParse(oId.ToString(), out id); 
            }
            );

            return id;
        }




        public void Update(PrivateBookingUpdateRequest model, int userId)
        {
            string procName = "[dbo].[PrivateBooking_Update]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddCommonParams(model, col);

                col.AddWithValue("@Id", model.Id);
            }, returnParameters: null);
        }




        public void Delete(int id, int startingIndex)
        {
            string procName = "[dbo].[PrivateBooking_Delete]";

            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);

            });
        }




         public Paged<PrivateBooking> Pagination(int pageIndex, int pageSize, int startingIndex)
        {
            Paged<PrivateBooking> pagedResult = null;
            List<PrivateBooking> listResult = null;

            int totalCount = 0;
            string procName = "[dbo].[PrivateBooking_Pagination]";
            _data.ExecuteCmd(procName, delegate (SqlParameterCollection parameterCollection)
            {
                parameterCollection.AddWithValue("@PageIndex", pageIndex);
                parameterCollection.AddWithValue("@PageSize", pageSize);
            }, delegate (IDataReader reader, short set)
            {
                PrivateBooking aPrivateBooking = new PrivateBooking();

                int startingIndex = 0;

                PrivateBooking privateBooking = mapPrivateBooking(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (listResult == null)
                {
                    listResult = new List<PrivateBooking>();
                }
                listResult.Add(privateBooking);
            });
            if (listResult != null)
            {
                pagedResult = new Paged<PrivateBooking>(listResult, pageIndex, pageSize, totalCount);
            };
       
                return pagedResult;
        }




        public Paged<PrivateBooking> Search(int pageIndex, int pageSize, string query, int startingIndex)
        {
            Paged<PrivateBooking> pagedResult = null;
            List<PrivateBooking> listResult = null;
            int totalCount = 0;
            string procName = "[dbo].[PrivateBooking_Search_Pagination]";
            _data.ExecuteCmd(procName, delegate (SqlParameterCollection parameterCollection)
            {
                parameterCollection.AddWithValue("@PageIndex", pageIndex);
                parameterCollection.AddWithValue("@PageSize", pageSize);
                parameterCollection.AddWithValue("@Query", query);
            }, delegate (IDataReader reader, short set)
            {
                PrivateBooking aPrivateBooking = new PrivateBooking();

                int startingIndex = 0;

                PrivateBooking privateBooking = mapPrivateBooking(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (listResult == null)
                {
                    listResult = new List<PrivateBooking>();
                }
                listResult.Add(privateBooking);
            });
            if (listResult != null)
            {
                pagedResult = new Paged<PrivateBooking>(listResult, pageIndex, pageSize, totalCount);
            };

            return pagedResult;
        }

        



        private static PrivateBooking mapPrivateBooking(IDataReader reader, ref int startingIndex)
        {
            PrivateBooking aPrivateBooking = new PrivateBooking();

            aPrivateBooking.Id = reader.GetSafeInt32(startingIndex++);
            aPrivateBooking.Name = reader.GetSafeString(startingIndex++); 
            aPrivateBooking.Email = reader.GetSafeString(startingIndex++);
            aPrivateBooking.NumberOfPeopleAttending = reader.GetSafeInt32(startingIndex++);
            aPrivateBooking.Description = reader.GetSafeString(startingIndex++);
            aPrivateBooking.NumberOfSessions = reader.GetSafeInt32(startingIndex++); 
            aPrivateBooking.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aPrivateBooking.DateModified = reader.GetSafeDateTime(startingIndex++);
            aPrivateBooking.WorkshopId = reader.GetSafeInt32(startingIndex++);
            aPrivateBooking.UserId = reader.GetSafeInt32(startingIndex++);
            aPrivateBooking.WorkshopRequestId = reader.GetSafeInt32(startingIndex++);


            return aPrivateBooking;
        }

        private static WorkshopRequests mapWorkshopRequests(IDataReader reader)
        {
            WorkshopRequests aWorkshopRequests = new WorkshopRequests();
            int startingIndex = 0;

            aWorkshopRequests.Id = reader.GetSafeInt32(startingIndex++);
            aWorkshopRequests.UserId = reader.GetSafeInt32(startingIndex++);
            aWorkshopRequests.HostId = reader.GetSafeInt32(startingIndex++);
            aWorkshopRequests.Topic = reader.GetSafeString(startingIndex++);
            aWorkshopRequests.BriefDescription = reader.GetSafeString(startingIndex++);
            aWorkshopRequests.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aWorkshopRequests.DateModified = reader.GetSafeDateTime(startingIndex++);

            return aWorkshopRequests;
        }




        private static void AddCommonParams(PrivateBookingAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@Email", model.Email);
            col.AddWithValue("@NumberOfPeopleAttending", model.NumberOfPeopleAttending);
            col.AddWithValue("@NumberOfSessions", model.NumberOfSessions);
        }
    }
}
