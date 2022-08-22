using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.NewsletterTemplates;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class NewsletterTemplatesService : INewsletterTemplatesService
    {
        IDataProvider _data = null;

        public NewsletterTemplatesService(IDataProvider data)
        {
            _data = data;
        }
        public int Add(NewsletterTemplatesAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[NewsletterTemplates_Insert]";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col) 
                {
                    AddParams(model, col, userId);

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
        public void Update(NewsletterTemplatesUpdateRequest model, int userId)
        {
            string procName = "[dbo].[NewsletterTemplates_Update]";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddParams(model, col, userId);
                    col.AddWithValue("@Id", model.Id);

                },
                returnParameters: null);
        }
        public NewsletterTemplates Get(int id)
        {


            string procName = "[dbo].[NewsletterTemplates_Select_ById]";

            NewsletterTemplates newsletterTemplates = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {


                paramCollection.AddWithValue("@Id", id);

            }, delegate (IDataReader reader, short set)
            {



                int startingIndex = 0;
                newsletterTemplates = MapNewsletterTemplates(reader, ref startingIndex);

            });
            return newsletterTemplates; 

        }

        public void Delete(int id)
        {

            string procName = "[dbo].[NewsletterTemplates_Delete_ById]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col) 
            {

                col.AddWithValue("@Id", id);

            },
     returnParameters: null);
        }


        public Paged<NewsletterTemplates> GetAllPaginated(int pageIndex, int pageSize)
        {
            Paged<NewsletterTemplates> pagedlist = null;
            List<NewsletterTemplates> list = null;
            int totalCount = 0;

            _data.ExecuteCmd(
                "[dbo].[NewsletterTemplates_SelectAll]",
                (param) =>
                {
                    param.AddWithValue("@pageIndex", pageIndex);
                    param.AddWithValue("@pageSize", pageSize);
                },
                 (reader, recordSetIndex) =>
                 {
                     int startingIndex = 0;
                     NewsletterTemplates aNewsletterTemplates = MapNewsletterTemplates(reader, ref startingIndex);
                     totalCount = reader.GetSafeInt32(startingIndex++);
                     
                     if (list == null)
                     {
                         list = new List<NewsletterTemplates>();
                     }
                     list.Add(aNewsletterTemplates);
                 }
                 );
            if (list != null)
            {
                pagedlist = new Paged<NewsletterTemplates>(list, pageIndex, pageSize, totalCount);
            }

            return pagedlist;

        }

        public Paged<NewsletterTemplates> SearchPaginated(int pageIndex, int pageSize, string query) 
        {
            Paged<NewsletterTemplates> pagedlist = null;
            List<NewsletterTemplates> list = null;
            int totalCount = 0;

            _data.ExecuteCmd(
                "[dbo].[NewsletterTemplates_Search_Paginated]",
                (param) =>
                {
                    param.AddWithValue("@pageIndex", pageIndex);
                    param.AddWithValue("@pageSize", pageSize);
                    param.AddWithValue("@Query", query);
                },
                (reader, recordSetIndex) =>
                {
                    int startingIndex = 0;
                    NewsletterTemplates newsletterTemplates = MapNewsletterTemplates(reader, ref startingIndex);
                    totalCount = reader.GetSafeInt32(startingIndex);

                    if (list == null)
                    {
                        list = new List<NewsletterTemplates>();
                    }
                    list.Add(newsletterTemplates);
                }
                );
            if (list != null)
            {
                pagedlist = new Paged<NewsletterTemplates>(list, pageIndex, pageSize, totalCount);
            }
            return pagedlist;
        }



        private static NewsletterTemplates MapNewsletterTemplates(IDataReader reader, ref int startingIndex)
        {
            NewsletterTemplates aNewsletterTemplates = new NewsletterTemplates();


            aNewsletterTemplates.Id = reader.GetSafeInt32(startingIndex++);
            aNewsletterTemplates.Name = reader.GetSafeString(startingIndex++);
            aNewsletterTemplates.Description = reader.GetSafeString(startingIndex++);
            aNewsletterTemplates.PrimaryImage = reader.GetSafeString(startingIndex++);
            aNewsletterTemplates.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aNewsletterTemplates.DateModified = reader.GetSafeDateTime(startingIndex++);
            aNewsletterTemplates.CreatedBy = reader.GetSafeInt32(startingIndex++);

            return aNewsletterTemplates;
        }

        private static void AddParams(NewsletterTemplatesAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@Description", model.Description);
            col.AddWithValue("@PrimaryImage", model.PrimaryImage);
            col.AddWithValue("@CreatedBy", userId);
           

        }
    }

}
