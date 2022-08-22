using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models.Domain;
using Sabio.Models.Requests.NewsletterContent;
using Sabio.Services.Interfaces;

namespace Sabio.Services
{
    public class NewsletterContentService : INewsletterContentService
    {
        IDataProvider _data = null;
        IUserMapper _userMapper = null;

        public NewsletterContentService(IDataProvider data, IUserMapper userMapper)
        {
            _data = data;
            _userMapper = userMapper;

         }
        public int Add(NewsletterContentAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[NewsletterContent_Insert]";
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
        public void Update(NewsletterContentUpdateRequest model, int userId)
        {
            string procName = "[dbo].[NewsletterContent_Update]";

            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddParams(model, col, userId);
                    col.AddWithValue("@Id", model.Id);

                },
                returnParameters: null);
        }
        public NewsletterContent Get(int id)
        {


            string procName = "[dbo].[NewsletterContent_Select_ById]";

            NewsletterContent newsletterContent = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {


                paramCollection.AddWithValue("@Id", id);

            }, delegate (IDataReader reader, short set)
            {



                int startingIndex = 0;
                newsletterContent = MapNewsletterContent(reader, ref startingIndex);

            });
            return newsletterContent;

        }
        private NewsletterContent MapNewsletterContent(IDataReader reader, ref int startingIndex)
        {
            NewsletterContent aNewsletterContent = new NewsletterContent();


            aNewsletterContent.Id = reader.GetSafeInt32(startingIndex++);
            aNewsletterContent.TemplateKeyId = reader.GetSafeInt32(startingIndex++);
            aNewsletterContent.NewsletterId = reader.GetSafeInt32(startingIndex++);
            aNewsletterContent.Value = reader.GetSafeString(startingIndex++);
            aNewsletterContent.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aNewsletterContent.DateModified = reader.GetSafeDateTime(startingIndex++);
            aNewsletterContent.CreatedBy = _userMapper.Map(reader, ref startingIndex);

            return aNewsletterContent;
        }

        private static void AddParams(NewsletterContentAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@TemplateKeyId", model.TemplateKeyId);
            col.AddWithValue("@NewsletterId", model.NewsletterId);
            col.AddWithValue("@Value", model.Value);
            col.AddWithValue("@CreatedBy", userId);
        }

    }
}
