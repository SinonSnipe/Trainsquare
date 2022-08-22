using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Venues;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class VenueLocationService : IVenueLocationService
    {
        IDataProvider _data = null;


        public VenueLocationService(IDataProvider data)
        {
            _data = data;
        }


        public int Add(VenueLocationAddRequest model, int currentUserId)
        {
            int id = 0;
            string procName = "[dbo].[Venues_Insert_V2]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    VenueLocationParams(model, col);
                    col.AddWithValue("@CreatedBy", currentUserId);

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


        public VenueLocation Get(int id)
        {
            string procName = "[dbo].[Venues_SelectById_V2]";
            VenueLocation VenueLocation = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                VenueLocation = MapVenueLocation(reader, ref startingIndex);
            });
            return VenueLocation;
        }


        public Paged<VenueLocation> GetAll(int pageIndex, int pageSize)
        {
            Paged<VenueLocation> pagedList = null;
            List<VenueLocation> list = null;
            int totalCount = 0;

            string procName = "[dbo].[Venues_SelectAll_Paginated_V2]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@pageIndex", pageIndex);
                param.AddWithValue("@pageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int index = 0;
                VenueLocation venue = MapVenueLocation(reader, ref index);
                totalCount = reader.GetSafeInt32(index);

                if (list == null)
                {
                    list = new List<VenueLocation>();
                }
                list.Add(venue);
             });
            if (list != null)
            {
                pagedList = new Paged<VenueLocation>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }


        public Paged<VenueLocation> CreatedBy(int pageIndex, int pageSize, int currentUserId)
        {
            Paged<VenueLocation> pagedList = null;
            List<VenueLocation> list = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Venues_Select_ByCreatedBy_V2]", (param) =>
            {
                param.AddWithValue("@User", currentUserId);
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);

            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                VenueLocation venue = MapVenueLocation(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex);


                if (list == null)
                {
                    list = new List<VenueLocation>();
                }
                list.Add(venue);
            });
            if (list != null)
            {
                pagedList = new Paged<VenueLocation>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }


        public void Update(VenueLocationUpdateRequest model, int currentUserId)
        {
            string procName = "[dbo].[Venues_Update_V2]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", model.Id);
                    col.AddWithValue("@ModifiedBy", currentUserId);
                    VenueLocationParams(model, col);

                },
                returnParameters: null);
        }


        public void Delete(int id)
        {
            string procName = "[dbo].[Venues_DeletebyId_V2]";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection paramCol)
                {
                    paramCol.AddWithValue("@Id", id);
                });

        }



        private VenueLocation MapVenueLocation(IDataReader reader, ref int index)
        {
            VenueLocation venue = new VenueLocation();

            venue.Id = reader.GetSafeInt32(index++);
            venue.Name = reader.GetSafeString(index++);
            venue.Description = reader.GetSafeString(index++);
            venue.LocationType = reader.GetSafeString(index++);
            venue.LineOne = reader.GetSafeString(index++);
            venue.LineTwo = reader.GetSafeString(index++);
            venue.City = reader.GetSafeString(index++);
            venue.Zip = reader.GetSafeString(index++);
            venue.State = reader.GetSafeString(index++);
            venue.Latitude = reader.GetSafeDouble(index++);
            venue.Longitude = reader.GetSafeDouble(index++);
            venue.Url = reader.GetSafeString(index++);
            venue.CreatedBy = reader.GetSafeInt32(index++);
            venue.ModifiedBy = reader.GetSafeInt32(index++);
            venue.DateCreated = reader.GetSafeDateTime(index++);
            venue.DateModified = reader.GetSafeDateTime(index++);
            venue.ImageUrl = reader.GetSafeString(index++);

            return venue;
        }



        private static void VenueLocationParams(VenueLocationAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@Description", model.Description);
            col.AddWithValue("@Url", model.Url);
            col.AddWithValue("@ImageUrl", model.ImageUrl);
            col.AddWithValue("@LocationType", model.LocationType);
            col.AddWithValue("@LineOne", model.LineOne);
            col.AddWithValue("@LineTwo", model.LineTwo);
            col.AddWithValue("@City", model.City);
            col.AddWithValue("@Zip", model.Zip);
            col.AddWithValue("@State", model.State);
            col.AddWithValue("@Latitude", model.Latitude);
            col.AddWithValue("@Longitude", model.Longitude);
        }

    }
}
