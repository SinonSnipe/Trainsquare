using Sabio.Data.Providers;
using Sabio.Models.Requests.NewsletterTemplateKeys;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Sabio.Models.Domain;
using Sabio.Data;
using Sabio.Models;
using Sabio.Services.Interfaces;


namespace Sabio.Services
{
    public class NewsletterTemplateKeysService : INewsletterTemplateKeysService
    {
        IDataProvider _data = null;
        ILookUp _lookMapper = null;

        public NewsletterTemplateKeysService(IDataProvider data, ILookUp lookMapper)
        {
            _data = data;
            _lookMapper = lookMapper;
        }

        public int Add(NewsletterTemplateKeyAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[NewsletterTemplateKeys_Insert]";

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

        public void Update (NewsletterTemplateKeyUpdateRequest model, int userId)
        {
            string procName = "[dbo].[NewsletterTemplateKeys_Update]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddParams(model, col, userId);
                    col.AddWithValue("@Id", model.Id);
                },
                returnParameters: null);
        }
        
        public List<NewsletterTemplateKeys> GetByTemplateId(int id)
        {
            string procName = "[dbo].[NewsletterTemplateKeys_Select_ByTemplateId]";

            List<NewsletterTemplateKeys> list = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@TemplateId", id);

            }, delegate (IDataReader reader, short set)


            {
                int startingIndex = 0;
                NewsletterTemplateKeys anewsletterTemplateKey = MapNewsletterTemplateKeys(reader, ref startingIndex);
                
                if (list == null)
                {
                    list = new List<NewsletterTemplateKeys>();
                }
                list.Add(anewsletterTemplateKey);
            });

            return list;
        }
        
        private NewsletterTemplateKeys MapNewsletterTemplateKeys(IDataReader reader, ref int startingIndex)
        {
            NewsletterTemplateKeys aNewsTempKey = new NewsletterTemplateKeys();

            aNewsTempKey.Id = reader.GetSafeInt32(startingIndex++);
            aNewsTempKey.KeyTypeId = _lookMapper.MapLookup(reader, ref startingIndex);
            aNewsTempKey.TemplateId = reader.GetSafeInt32(startingIndex++);
            aNewsTempKey.KeyName = reader.GetSafeString(startingIndex++);

            return aNewsTempKey;
        }
        private static void AddParams(NewsletterTemplateKeyAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@KeyTypeId", model.KeyTypeId);
            col.AddWithValue("@TemplateId", model.TemplateId);
            col.AddWithValue("@KeyName", model.KeyName);

        }

    }


}
