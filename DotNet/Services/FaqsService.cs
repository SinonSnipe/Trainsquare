using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Faqs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class FaqsService : IFaqsService
    {
        IDataProvider _data = null;

        public FaqsService(IDataProvider data)
        {
            _data = data;
        }
        public int Add(FaqsAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[Faqs_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    addCommonParams(model, col, userId);

                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;

                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCol)
                {
                    object oId = returnCol["@Id"].Value;
                    int.TryParse(oId.ToString(), out id);
                });
            return id;
        }

        public Paged<Faqs> GetAll(int pageIndex, int pageSize)
        {
            Paged<Faqs> pagedList = null;
            List<Faqs> list = null;
            int totalCount = 0;

            string procName = "[dbo].[Faqs_SelectAll]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@pageIndex", pageIndex);
                param.AddWithValue("@pageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                Faqs faq = MapFaqs(reader, ref startingIndex);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }

                if (list == null)
                {
                    list = new List<Faqs>();
                }

                list.Add(faq);
            });
            if (list != null)
            {
                pagedList = new Paged<Faqs>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Paged<Faqs> GetByCreatedBy( int pageIndex, int pageSize, int currentUserId)
        {
            Paged<Faqs> pagedList = null;
            List<Faqs> list = null;
            int totalCount = 0;

            string procName = "[dbo].[Faqs_Select_ByCreatedBy]";

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@CreatedBy", currentUserId);
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);
                
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                Faqs faq = MapFaqs(reader, ref startingIndex);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (list == null)
                {
                    list = new List<Faqs>();
                }

                list.Add(faq);
            }
            );
            if (list != null)
            {
                pagedList = new Paged<Faqs>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Faqs Get(int Id)
        {
            string procName = "[dbo].[Faqs_Select_ById]";

            Faqs faq = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", Id);
            },
            delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                faq = MapFaqs(reader, ref startingIndex);
            });
            return faq;
        }

        public void Update(FaqsUpdateRequest model, int Id)
        {
            string procName = "[dbo].[Faqs_Update]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    addCommonParams(model, col, Id);
                    col.AddWithValue("@Id", model.Id);
                },
                returnParameters: null);
        }

        public Faqs Delete(int Id)
        {
            string procName = "[dbo].[Faqs_Delete_ById]";

            Faqs faq = null;

            _data.ExecuteCmd(procName,
                inputParamMapper: delegate (SqlParameterCollection deleteCol)
                {
                    deleteCol.AddWithValue("@Id", Id);
                },
                delegate (IDataReader reader, short set)
                {
                    int startingIndex = 0;
                    faq = MapFaqs(reader, ref startingIndex);
                });
            return faq;
        }

        private static Faqs MapFaqs(IDataReader reader, ref int startingIndex)
        {
            Faqs faqs = new Faqs();

            faqs.Id = reader.GetSafeInt32(startingIndex++);
            faqs.Question = reader.GetSafeString(startingIndex++);
            faqs.Answer = reader.GetSafeString(startingIndex++);
            faqs.CategoryId = reader.GetSafeInt32(startingIndex++);
            faqs.SortOrder = reader.GetSafeInt32(startingIndex++);
            faqs.DateCreated = reader.GetSafeDateTime(startingIndex++);
            faqs.DateModified = reader.GetSafeDateTime(startingIndex++);
            faqs.CreatedBy = reader.GetSafeInt32(startingIndex++);
            faqs.ModifiedBy = reader.GetSafeInt32(startingIndex++);
            return faqs;
        }

        private static void addCommonParams(FaqsAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@Question", model.Question);
            col.AddWithValue("@Answer", model.Answer);
            col.AddWithValue("@CategoryId", model.CategoryId);
            col.AddWithValue("@SortOrder", model.SortOrder);
            col.AddWithValue("@CreatedBy", userId);
            col.AddWithValue("@ModifiedBy", userId);
        }

    }
}
