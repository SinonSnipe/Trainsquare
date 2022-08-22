using Microsoft.AspNetCore.Mvc;
using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.VenueRequest;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services 
{
    public class VenueRequestService : IVenueRequestService 
    {                                                       
        IDataProvider _data = null; 
                                                 
        public VenueRequestService(IDataProvider data, IAuthenticationService<int> authService)                                           
        {                                              
            _data = data;  
        }                

        public Paged<VenueRequest> GetByVenueId(int venueId, int pageIndex, int pageSize)  
        {
            string procName = "[dbo].[VenueRequests_SelectByVenueId]"; 
            Paged<VenueRequest> pagedList = null;
             List<VenueRequest> list = null;
            int totalCount = 0;
            
            
            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection) 
            {
                paramCollection.AddWithValue("@VenueId", venueId);
                paramCollection.AddWithValue("@pageIndex", pageIndex);
                paramCollection.AddWithValue("@pageSize", pageSize);    

            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0; 
                VenueRequest venueRequest = MapRequest(reader, ref startingIndex); 

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex);
                }

                if (list == null)
                {
                    list = new List<VenueRequest>();
                }
                list.Add(venueRequest);
            }
            );
            if (list != null)
            {
                pagedList = new Paged<VenueRequest>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        
        public VenueRequest GetByRequester(int userId) 
        {
            string procName = "[dbo].[VenueRequests_SelectByRequester]"; 
            VenueRequest request = null; 

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection) 
            {
                paramCollection.AddWithValue("@Requester", userId); 

            }, delegate (IDataReader reader, short set) 
            {
                int startingIndex = 0; 
                request = MapRequest(reader, ref startingIndex); 
            });
            return request;
        }


        public Paged<VenueRequest> GetAll(int pageIndex, int pageSize)
        {
            Paged<VenueRequest> pagedList = null;
            List<VenueRequest> list = null;
            int totalCount = 0;
            string procName = "[dbo].[VenueRequests_SelectAll]";
           

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@pageIndex", pageIndex);
                param.AddWithValue("@pageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                VenueRequest venueRequest = MapRequest(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex);
                }

                if (list == null)
                {
                    list = new List<VenueRequest>();
                }
                list.Add(venueRequest);
            }
            );
            if (list != null)
            {
                pagedList = new Paged<VenueRequest> (list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }


        public int AddVenueRequest(AddVenueRequest model, int userId)  
        {
            int id = 0; 
            string procName = "[dbo].[VenueRequests_Insert]"; 
            _data.ExecuteNonQuery(procName                
            , inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddCommonParams(model, col);
                col.AddWithValue("@Requester", userId);

                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int); 
                idOut.Direction = ParameterDirection.Output; 
                col.Add(idOut);

            }, returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object oId = returnCollection["@Id"].Value;

                int.TryParse(oId.ToString(), out id);

            });

            return id;
        }


        public void UpdateVenueRequest(UpdateVenueRequest model, int currentUserId)
        {
            string procName = "[dbo].[VenueRequests_Update]";
            _data.ExecuteNonQuery(procName
            , inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddCommonParams(model, col);
                col.AddWithValue("@Id", model.Id);

            }, returnParameters: null);
        }


        public void DeleteVenueRequest (int id)
        {
            string procName = "[dbo].[VenueRequests_Delete]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
           {
               col.AddWithValue("@Id", id);
           }, returnParameters: null);
        }


        private static VenueRequest MapRequest(IDataReader reader, ref int startingIndex) 
        {
            VenueRequest aRequest = new VenueRequest(); 

            aRequest.Id = reader.GetSafeInt32(startingIndex++);
            aRequest.VenueId = reader.GetSafeInt32(startingIndex++);
            aRequest.EventDescription = reader.GetSafeString(startingIndex++);
            aRequest.StartDate = reader.GetSafeDateTime(startingIndex++);
            aRequest.EndDate = reader.GetSafeDateTime(startingIndex++);
            aRequest.Requester = reader.GetSafeInt32(startingIndex++);
            

            return aRequest;
        }


        private static void AddCommonParams(AddVenueRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@EventDescription", model.EventDescription);
            col.AddWithValue("@StartDate", model.StartDate);
            col.AddWithValue("@EndDate", model.EndDate);
            col.AddWithValue("@VenueId", model.VenueId);
        }
    }
}
