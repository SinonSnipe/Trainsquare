using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Services.Interfaces;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{

    public class RatingService : IRatingService
    {

        IDataProvider _data = null;

        public RatingService(IDataProvider data)
        {
            _data = data;
        }

        public int AddRating(RatingAddRequest model, int currentUserId)
        {
            int id = 0;

            string procName = "[dbo].[Ratings_Insert]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;

                col.Add(idOut);
                col.AddWithValue("@CreatedBy", currentUserId);
                RatingParameters(model, col);


            }, returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object objId = returnCollection["@Id"].Value;
                int.TryParse(objId.ToString(), out id);
            });
            return id;
        }

        public Paged<RatingsDetails> CreatedByPagination(int pageIndex, int pageSize, int CreatedBy)
        {

            Paged<RatingsDetails> pagedResult = null;

            List<RatingsDetails> list = null;

            int totalCount = 0;

            string procName = "[dbo].[Ratings_Select_ByCreatedBy]";

            _data.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@pageIndex", pageIndex);
                col.AddWithValue("@PageSize", pageSize);
                col.AddWithValue("@CreatedBy", CreatedBy);
            }

            , singleRecordMapper: delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;

                RatingsDetails rating = MapRatings(reader, ref startingIndex);
                rating.Subject = reader.GetSafeString(startingIndex++);
                rating.Text = reader.GetSafeString(startingIndex++);
                rating.Name = reader.GetSafeString(startingIndex++);
                rating.Email = reader.GetSafeString(startingIndex++);
                rating.FirstName = reader.GetSafeString(startingIndex++);
                rating.LastName = reader.GetSafeString(startingIndex++);
                totalCount = reader.GetSafeInt32(startingIndex++);
                if (list == null)
                {
                    list = new List<RatingsDetails>();
                }
                list.Add(rating);
            });

            if (list != null)
            {
                pagedResult = new Paged<RatingsDetails>(list, pageIndex, pageSize, totalCount);
            }
            return pagedResult;

        }    

        public List<RatingsDetails> CreatedByV2(int CreatedBy)
        {

            List<RatingsDetails> list = null;

            string procName = "[dbo].[Ratings_Select_ByCreatedBy_V2]";

            _data.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@CreatedBy", CreatedBy);
            }

            , singleRecordMapper: delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;

                RatingsDetails rating = MapRatings(reader, ref startingIndex);
                rating.Subject = reader.GetSafeString(startingIndex++);
                rating.Text = reader.GetSafeString(startingIndex++);
                rating.Name = reader.GetSafeString(startingIndex++);
                rating.Email = reader.GetSafeString(startingIndex++);
                rating.FirstName = reader.GetSafeString(startingIndex++);
                rating.LastName = reader.GetSafeString(startingIndex++);
                if (list == null)
                {
                    list = new List<RatingsDetails>();
                }
                list.Add(rating);
            });
            return list;

        }

        public Paged<RatingsDetails> SelectByEntityId(int EntityId, int EntityTypeId, int pageIndex, int pageSize)
        {
            Paged<RatingsDetails> pagedList = null;
            List<RatingsDetails> list = null;
            int totalCount = 0;
            string procName = "[dbo].[Ratings_Select_ByEntityId]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@EntityId", EntityId);
                param.AddWithValue("@EntityTypeId", EntityTypeId);
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                RatingsDetails rating = MapRatings(reader, ref startingIndex);
                rating.Subject = reader.GetSafeString(startingIndex++);
                rating.Text = reader.GetSafeString(startingIndex++);
                rating.Name = reader.GetSafeString(startingIndex++);
                rating.Email = reader.GetSafeString(startingIndex++);
                rating.FirstName = reader.GetSafeString(startingIndex++);
                rating.LastName = reader.GetSafeString(startingIndex++);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (list == null)
                {
                    list = new List<RatingsDetails>();
                }

                list.Add(rating);
            });
            if (list != null)
            {
                pagedList = new Paged<RatingsDetails>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Ratings SelectById(int Id)
        {
            string procName = "[dbo].[Ratings_Select_ById]";

            Ratings rating = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", Id);
            },
            delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                rating = MapRatings(reader, ref startingIndex);
            });
            return rating;
        }

        public Paged<Ratings> SelectAllPaginated(int pageIndex, int pageSize)
        {

            Paged<Ratings> pagedResult = null;

            List<Ratings> list = null;

            int totalCount = 0;


            string procName = "[dbo].[Ratings_SelectAll_Paginated]";

            _data.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Index", pageIndex);
                col.AddWithValue("@PageSize", pageSize);
            }

            , singleRecordMapper: delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;

                RatingsDetails rating = MapRatings(reader, ref startingIndex);
  
                totalCount = reader.GetSafeInt32(startingIndex++);

                if (list == null)
                {
                    list = new List<Ratings>();
                }
                list.Add(rating);
            });

            if (list != null)
            {
                pagedResult = new Paged<Ratings>(list, pageIndex, pageSize, totalCount);
            }
            return pagedResult;

        }

        public void Update(RatingUpdateRequest model, int userId, int Id)
        {

            string procName = "[dbo].[Ratings_Update]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                RatingParameters(model, col);
                col.AddWithValue("@CreatedBy", userId);
                col.AddWithValue("@Id", Id);

            }, returnParameters: null);

        }


        private static void RatingParameters(RatingAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@Rating", model.Rating);
            col.AddWithValue("@CommentId", model.CommentId);
            col.AddWithValue("@EntityTypeId", model.EntityTypeId);
            col.AddWithValue("@EntityId", model.EntityId);
            col.AddWithValue("@IsDeleted", model.IsDeleted);
        }

        private RatingsDetails MapRatings(IDataReader reader, ref int startingIndex)

        {

            RatingsDetails RatingService = new RatingsDetails();

            RatingService.Id = reader.GetSafeInt32(startingIndex++);
            RatingService.Rating = (int)reader.GetSafeByte(startingIndex++);
            RatingService.CommentId = reader.GetSafeInt32(startingIndex++);
            RatingService.EntityTypeId = reader.GetSafeInt32(startingIndex++);
            RatingService.EntityId = reader.GetSafeInt32(startingIndex++);
            RatingService.DateCreated = reader.GetSafeDateTime(startingIndex++);
            RatingService.DateModified = reader.GetSafeDateTime(startingIndex++);
            RatingService.CreatedBy = reader.GetSafeInt32(startingIndex++);
            RatingService.IsDeleted = reader.GetSafeBool(startingIndex++);
            return RatingService;
        }


    }
}