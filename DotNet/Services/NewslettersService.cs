using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Newsletters;
using Sabio.Services;
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
    public class NewslettersService : INewslettersService

    {
        IDataProvider _data = null;
        IUserMapper _userMapper = null;
        public NewslettersService(IDataProvider data, IUserMapper userMapper)
        {
            _data = data;
            _userMapper = userMapper;
        }


        public Newsletters Get(int id)
        {
            string procName = "[dbo].[Newsletters_Select_ById]";
            Newsletters newsletter = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);

            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                newsletter = MapNewsletters(reader, ref startingIndex);

            });
            return newsletter;

        }

        public Paged<Newsletters> Pagination(int pageIndex, int pageSize)
        {

            Paged<Newsletters> pagedList = null;
            List<Newsletters> list = null;
            int totalCount = 0;

            _data.ExecuteCmd(
                "[dbo].[Newsletters_SelectAll]",
                (param) =>

                {
                    param.AddWithValue("@PageIndex", pageIndex);
                    param.AddWithValue("@PageSize", pageSize);
                },
                (reader, recordSetIndex) =>
                {
                    int startingIndex = 0;
                    Newsletters aNewsletter = MapNewsletters(reader, ref startingIndex);
                    totalCount = reader.GetSafeInt32(startingIndex++);

                    if (totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(startingIndex++);
                    }

                    if (list == null)
                    {
                        list = new List<Newsletters>();
                    }
                    list.Add(aNewsletter);
                }
                );
            if (list != null)
            {
                pagedList = new Paged<Newsletters>(list, pageIndex, pageSize, totalCount);
            }

            return pagedList;
        }

        public int Add(NewslettersAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[Newsletters_Insert]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
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
        public void Update(NewslettersUpdateRequest model, int userId)
        {
            string procName = "[dbo].[Newsletters_Update]";

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddParams(model, col, userId);
                col.AddWithValue("@Id", model.Id);
            },
                returnParameters: null);
        }

        public void Delete(int id)
        {
            string procName = "[dbo].[Newsletters_Delete]";

            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);

            });

        }
        private Newsletters MapNewsletters(IDataReader reader, ref int startingIndex)
        {
            Newsletters aNewsletter = new Newsletters();


            aNewsletter.Id = reader.GetSafeInt32(startingIndex++);
            aNewsletter.TemplateId = reader.GetSafeInt32(startingIndex++);
            aNewsletter.Name = reader.GetSafeString(startingIndex++);
            aNewsletter.CoverPhoto = reader.GetSafeString(startingIndex++);
            aNewsletter.DateToPublish = reader.GetSafeDateTime(startingIndex++);
            aNewsletter.DateToExpire = reader.GetSafeDateTime(startingIndex++);
            aNewsletter.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aNewsletter.DateModified = reader.GetSafeDateTime(startingIndex++);
            aNewsletter.CreatedBy = _userMapper.Map(reader, ref startingIndex);

            return aNewsletter;
        }

        private static void AddParams(NewslettersAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@TemplateId", model.TemplateId);
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@CoverPhoto", model.CoverPhoto);
            col.AddWithValue("@DateToPublish", model.DateToPublish);
            col.AddWithValue("@DateToExpire", model.DateToExpire);
            col.AddWithValue("@CreatedBy", userId);
        }

    }
}




