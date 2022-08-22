using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class AdvertisementServices : IAdvertisementServices
    {

        
        IDataProvider _data = null;
      
        public AdvertisementServices(IDataProvider data)
        {
            _data = data;
            
        }

        #region Advertisements_Insert

        public int Add(AdvertisementAddRequest model, int currentUserId )
        {

            int id = 0; 

            string procName = "dbo.Advertisements_InsertV2";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                AdvertisementParams(model, col, currentUserId);
               

                SqlParameter idOut = new SqlParameter("AdId", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;

                col.Add(idOut);
            }, returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object oId = returnCollection["AdId"].Value;
                int.TryParse(oId.ToString(), out id);
            });
            return id;

        }


        #endregion

        #region Advertisement_SelectById
        public Advertisements Get(int id)
        {
            int startingIndex = 0;
            string procName = "[dbo].[Advertisements_SelectById]";

            Advertisements advertisementServices = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {

                paramCollection.AddWithValue("@Id", id);


            }, delegate (IDataReader reader, short set)
            {

                advertisementServices = MapAdvertisements(reader, ref startingIndex);

            }

            );
            return advertisementServices;

        }

        #endregion

        #region Advertisement_SelectAll_Paginated

        public Paged<Advertisements> Pagination(int index, int pageSize)
        {
            
            Paged<Advertisements> pagedResult = null;

            List<Advertisements> list = null;

            int totalCount = 0;

            string procName = "[dbo].[Advertisements_SelectAll_Paginated]"; 

            _data.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Index", index);
                col.AddWithValue("@PageSize", pageSize);
            }

            , singleRecordMapper: delegate (IDataReader reader, short set)
            {
           
                int startingIndex = 0;

                Advertisements anAd = MapAdvertisements(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex++);

                if (list == null)
                {
                    list = new List<Advertisements>();
                }
                list.Add(anAd);
            });

            if (list != null)
            {
                pagedResult = new Paged<Advertisements>(list, index, pageSize, totalCount);
            }
            return pagedResult;

        }

        #endregion

        #region Advertisement_CreatedByPaginated
        public Paged<Advertisements> CreatedByPagination(int index, int pageSize, int CreatedBy)
        {

            Paged<Advertisements> pagedResult = null;

            List<Advertisements> list = null;

            int totalCount = 0;

            string procName = "[dbo].[Advertisements_SelectByCreatedBy_Paginated]";

            _data.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Index", index);
                col.AddWithValue("@PageSize", pageSize);
                col.AddWithValue("@CreatedBy", CreatedBy);
            }

            , singleRecordMapper: delegate (IDataReader reader, short set)
            {

            int startingIndex = 0;

                Advertisements anAd = MapAdvertisements(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex++);
                if (list == null)
                {
                    list = new List<Advertisements>();
                }
                list.Add(anAd);
            });

            if (list != null)
            {
                pagedResult = new Paged<Advertisements>(list, index, pageSize, totalCount);
            }
            return pagedResult;

        }



        #endregion

        #region Advertisement_Update
        public void Update(AdvertisementUpdateRequest model, int userId, int adId)
        { 

            string procName = "[dbo].[Advertisements_Update]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
               

                AdvertisementParams(model, col, userId);
                col.AddWithValue("@Id", adId);

            }, returnParameters: null);

        }

        #endregion

        #region Advertisement_Delete
        public void Delete(int id)
        {
            string procName = "[dbo].[Advertisements_Delete]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {

                col.AddWithValue("@Id", id);


            }, returnParameters: null);

        }

        #endregion


        #region -- Mapping Method --
        private Advertisements MapAdvertisements(IDataReader reader, ref int startingIndex)
        {

            Advertisements AdvertisementServices = new Advertisements();

            AdvertisementServices.Id = reader.GetSafeInt32(startingIndex++);
            AdvertisementServices.WorkShopId = reader.GetSafeInt32(startingIndex++);
            AdvertisementServices.OwnerId = reader.GetSafeInt32(startingIndex++);
            AdvertisementServices.Title = reader.GetSafeString(startingIndex++);
            AdvertisementServices.AdMainImage = reader.GetSafeString(startingIndex++);
            AdvertisementServices.Details = reader.GetSafeString(startingIndex++);
            AdvertisementServices.DateStart = reader.GetSafeDateTime(startingIndex++);
            AdvertisementServices.DateEnd = reader.GetSafeDateTime(startingIndex++);
            AdvertisementServices.File = reader.DeserializeObject<List<File>>(startingIndex++);
            return AdvertisementServices;


        }

        #endregion

        #region
        private static void AdvertisementParams(AdvertisementAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@WorkShopId", model.WorkShopId);
            col.AddWithValue("@OwnerId ",userId);
            col.AddWithValue("@Title", model.Title);
            col.AddWithValue("@AdMainImage", model.AdMainImage);
            col.AddWithValue("@Details", model.Details);
            col.AddWithValue("@CreatedBy", userId);
            col.AddWithValue("@DateStart", model.DateStart);
            col.AddWithValue("@DateEnd", model.DateEnd);
            
        }
        #endregion

    }
}
