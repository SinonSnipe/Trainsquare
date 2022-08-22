using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain.WorkShopRequest;
using Sabio.Models.Requests.WorkShopRequest;

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
namespace Sabio.Services
{
    public class WorkShopRequestService : IWorkShopRequest
    {
        IDataProvider _data = null;
        public WorkShopRequestService(IDataProvider data)
        {
            _data = data;
        }
        public Paged<WorkShopRequest> Pagination(int pageIndex, int pageSize)
        {
            Paged<WorkShopRequest> pagedList = null;
            List<WorkShopRequest> list = null;
            int totalCount = 0;

            string procName = "dbo.WorkShopRequestForm_Pagination_V2";


            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@PageIndex", pageIndex);
                paramCollection.AddWithValue("@PageSize", pageSize);
            }, delegate (IDataReader reader, short set)
            {

                WorkShopRequest aRequest = MapRequest(reader);


                if (list == null)
                {
                    list = new List<WorkShopRequest>();
                }
                list.Add(aRequest);
            }
                );


            if (list != null)
            {
                pagedList = new Paged<WorkShopRequest>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public WorkShopRequest Get(int id)
        {
           
            string procName = "dbo.WorkshopRequestForm_SelectBy_CurrentId_V2";

            WorkShopRequest request = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@InstructorId", id);
            }, delegate (IDataReader reader, short set)
            {

                request = MapRequest(reader);
            }
            );
            return request;

        }

     
        public Paged<WorkShopRequest> GetByCreatedBy(int pageIndex, int pageSize, int currentRequest)
        {
            Paged<WorkShopRequest> pagedList = null;
            List<WorkShopRequest> list = null;
            int totalCount = 0;

     
            _data.ExecuteCmd(
                "[dbo].[WorkShopRequestForm_Select_CreatedBy]",
                (param) =>

                {
                    param.AddWithValue("@Request", currentRequest);
                    param.AddWithValue("@PageIndex", pageIndex);
                    param.AddWithValue("@PageSize", pageSize);
                },
                (reader, recordSetIndex) =>
                {

                    
                        WorkShopRequest aRequest = MapRequest(reader);

                        

                            if (list == null)
                            {
                                list = new List<WorkShopRequest>();
                            }

                            list.Add(aRequest);
                        }
                
                        );
                    if (list != null)
                    {
                        pagedList = new Paged<WorkShopRequest>(list, pageIndex, pageSize, totalCount);
                    }
                    return pagedList;
                }

        public Paged<WorkShopRequest> SearchPaginate(int pageIndex, int pageSize, string q)
            {
                Paged<WorkShopRequest> pagedList = null;
                List<WorkShopRequest> list = null;
                int totalCount = 0;

                _data.ExecuteCmd(
                    "[dbo].[WorkShopRequestForm_Select_BySearch]",
                    (param) =>

                    {
                        param.AddWithValue("@PageIndex", pageIndex);
                        param.AddWithValue("@PageSize", pageSize);
                        param.AddWithValue("@Query", q);
                    },
                    (reader, recordSetIndex) =>
                    {
                        WorkShopRequest aRequest = MapRequest(reader);

                        if (list == null)
                        {
                            list = new List<WorkShopRequest>();
                        }

                        list.Add(aRequest);
                    }
                    );
                if (list != null)
                {
                    pagedList = new Paged<WorkShopRequest>(list, pageIndex, pageSize, totalCount);
                }
                return pagedList;
            }


        public int Add(WorkShopAddRequest model)
        {

            int instructorId = 0;

            string procName = "dbo.WorkShopRequestForm_Insert";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col);
                    SqlParameter idOut = new SqlParameter("@InstructorId", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;
                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCollection)
                {
                    object oId = returnCollection["@InstructorId"].Value;
                    int.TryParse(oId.ToString(), out instructorId);
                    Console.WriteLine(" ");
                });
            return instructorId;
        }



        public void Delete(int Id)
        {
            string procName = "dbo.WorkShopRequestForm_Delete";

            _data.ExecuteNonQuery(procName,
                  inputParamMapper: delegate (SqlParameterCollection col)
                  {
                      col.AddWithValue("@InstructorId", Id);
                  },
                 returnParameters: null);
        }
        private static WorkShopRequest MapRequest(IDataReader reader)
        {
            WorkShopRequest aRequest = new WorkShopRequest();
            int startingIndex = 0;

                aRequest.InstructorId = reader.GetInt32(startingIndex++);
                aRequest.Name = reader.GetSafeString(startingIndex++);
                aRequest.Email = reader.GetSafeString(startingIndex++);
                aRequest.Topic = reader.GetSafeString(startingIndex++);
                aRequest.ShortDescription = reader.GetSafeString(startingIndex++);
                aRequest.DateCreated = reader.GetSafeDateTime(startingIndex++);
                aRequest.DateModified = reader.GetSafeDateTime(startingIndex++);



                return aRequest;
            }

        private static void AddCommonParams(WorkShopAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@Email", model.Email);
            col.AddWithValue("@Topic", model.Topic);
            col.AddWithValue("@ShortDescription", model.ShortDescription);


        }


    }
}