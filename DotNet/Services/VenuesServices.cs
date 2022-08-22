using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Venues;
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
    public class VenuesServices : IVenuesServices
    {
        IDataProvider _data = null;
        ILocationMapper _locationMapper = null;

        public VenuesServices(IDataProvider data, ILocationMapper mapper)
        {
            _data = data;
            _locationMapper = mapper;
        }

        public int Add(VenuesAddRequest model, int currentUserId)
        {
            int id = 0;
            string procName = "[dbo].[Venues_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    venueParams(model, col);
                    col.AddWithValue("@CreatedBy", currentUserId);
                    col.AddWithValue("@ModifiedBy", currentUserId);

                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;

                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCollection)
                {
                    object oId = returnCollection["@Id"].Value;

                    int.TryParse(oId.ToString(), out id);
                });
            return id;

        }



        public void Delete(int id)
        {
            string procName = "[dbo].[Venues_DeletebyId]";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection paramCol)
                {
                    paramCol.AddWithValue("@Id", id);
                });
               
        }

        public Paged<Venue> Pagination(int pageIndex, int pageSize, int currentUserId)
        {
            Paged<Venue> pagedList = null;
            List<Venue> list = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Venues_Select_ByCreatedBy]", (param) =>
            {
                param.AddWithValue("@User", currentUserId);
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);

            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                Venue venue = MapVenue(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex);
               

                if (list == null)
                {
                    list = new List<Venue>();
                }
                list.Add(venue);
            });
            if (list != null)
            {
                pagedList = new Paged<Venue>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;


        }

        public List<Venue> GetAll()
        {
            List<Venue> list = null;
            string procName = "[dbo].[Venues_SelectAll]";
            _data.ExecuteCmd(procName, inputParamMapper: null
                , singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    int startingIndex = 0;
                    Venue aVenue = MapVenue(reader, ref startingIndex);

                    if (list == null)
                    {
                        list = new List<Venue>();
                    }
                    list.Add(aVenue);
                });
            return list;
        }

        public Venue Get(int id)
        {
            string procName = "[dbo].[Venues_SelectById]";
            Venue venue = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                venue = MapVenue(reader, ref startingIndex);
            });
            return venue;
        }

        public void Update(VenuesUpdateRequest model)
        {
            string procName = "[dbo].[Venues_Update]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", model.Id);
                    venueParams(model, col);

                },
                returnParameters: null);

        }

        public Paged<Venue> GetAll(int pageIndex, int pageSize)
        {
            Paged<Venue> pagedList = null;
            List<Venue> list = null;
            int totalCount = 0;

            string procName = "[dbo].[Venues_SelectAll_Paginated]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@pageIndex", pageIndex);
                param.AddWithValue("@pageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                Venue venue = MapVenue(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex);
                }

                if (list == null)
                {
                    list = new List<Venue>();
                }
                list.Add(venue);
            }
            );
            if (list != null)
            {
                pagedList = new Paged<Venue>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        private  Venue MapVenue(IDataReader reader, ref int startingIndex)
        {
            Venue venue = new Venue();

            

            venue.Id = reader.GetSafeInt32(startingIndex++);
            venue.Name = reader.GetSafeString(startingIndex++);
            venue.Description = reader.GetSafeString(startingIndex++);
            venue.LocationId = reader.GetSafeInt32(startingIndex++);
            venue.Location = _locationMapper.Map(reader, ref startingIndex);
            venue.Url = reader.GetSafeString(startingIndex++);
            venue.CreatedBy = reader.GetSafeInt32(startingIndex++);
            venue.ModifiedBy = reader.GetSafeInt32(startingIndex++);
            venue.DateCreated = reader.GetSafeDateTime(startingIndex++);
            venue.DateModified = reader.GetSafeDateTime(startingIndex++);
            venue.ImageUrl = reader.GetSafeString(startingIndex++);

            return venue;
        }

        private static void venueParams(VenuesAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@Description", model.Description);
            col.AddWithValue("@LocationId", model.LocationId);
            col.AddWithValue("@Url", model.Url);
            col.AddWithValue("@ImageUrl", model.ImageUrl);
            
            
        }
    }
}