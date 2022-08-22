using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sabio.Data;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Data.Providers;
using Sabio.Services.Interfaces;
using Sabio.Models.Requests.ExternalLinks;

namespace Sabio.Services
{
    public class ExternalLinksService : IExternalLinksService
    {
        IDataProvider _data = null;
        public ExternalLinksService(IDataProvider data)
        {
            _data = data;
        }

        public int Insert(ExternalLinksAddRequest model)
        {
            int id = 0;
            string procName = "[dbo].[ExternalLinks_Insert]";

            _data.ExecuteNonQuery(
                procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col);

                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;

                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCollection)
                {
                    object old = returnCollection["@Id"].Value;
                    Int32.TryParse(old.ToString(), out id);
                }
            );

            return id;
        }

        public void Update(ExternalLinksUpdateRequest model)
        {
            string procName = "[dbo].[ExternalLinks_Update]";

            _data.ExecuteNonQuery(
                procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col);
                    col.AddWithValue("@Id", model.Id);
                },
                returnParameters: null
            );
        }

        public void DeleteById(int id)
        {
            string procName = "[dbo].[ExternalLinks_Delete_ById]";

            _data.ExecuteNonQuery(
                procName,
                delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
            );
        }

        public ExternalLinksTable SelectById(int id)
        {
            string procName = "[dbo].[ExternalLinks_Select_ById]";
            ExternalLinksTable externalLink = null;

            _data.ExecuteCmd(
                procName,
                delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                },
                delegate (IDataReader reader, short set)
                {
                    int startingindex = 0;
                    externalLink = MapSingleExternalLink(reader, ref startingindex);
                }
            );

            return externalLink;
        }

        public Paged<ExternalLinksTable> SelectAll(int pageIndex, int pageSize)
        {
            List<ExternalLinksTable> list = null;
            Paged<ExternalLinksTable> pagedList = null;
            string procName = "[dbo].[ExternalLinks_SelectAll]";
            int totalCount = 0;

            _data.ExecuteCmd(
                procName,
                delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@PageIndex", pageIndex);
                    col.AddWithValue("@PageSize", pageSize);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    int startingIndex = 0;
                    ExternalLinksTable externalLinks = MapSingleExternalLink(reader, ref startingIndex);

                    if (totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(startingIndex++);
                    }
                    if (list == null)
                    {
                        list = new List<ExternalLinksTable>();
                    }

                    list.Add(externalLinks);
                }
            );

            if (list != null)

            {
                pagedList = new Paged<ExternalLinksTable>(list, pageIndex, pageSize, totalCount);
            }

            return pagedList;
        }

        public Paged<ExternalLinksTable> SelectByCreatedBy(int pageIndex, int pageSize, int userId)
        {
            List<ExternalLinksTable> resultList = null;
            Paged<ExternalLinksTable> pagedResultList = null;
            string procName = "[dbo].[ExternalLinks_Select_ByCreatedBy]";
            int totalCount = 0;

            _data.ExecuteCmd(
                procName,
                delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@PageIndex", pageIndex);
                    col.AddWithValue("@PageSize", pageSize);
                    col.AddWithValue("@UserId", userId);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    int startingIndex = 0;
                    ExternalLinksTable externalLinks = MapSingleExternalLink(reader, ref startingIndex);

                    if (totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(startingIndex++);
                    }
                    if (resultList == null)
                    {
                        resultList = new List<ExternalLinksTable>();
                    }

                    resultList.Add(externalLinks);
                }
            );

            if (resultList != null)

            {
                pagedResultList = new Paged<ExternalLinksTable>(resultList, pageIndex, pageSize, totalCount);
            }

            return pagedResultList;
        }

        private static ExternalLinksTable MapSingleExternalLink(IDataReader reader, ref int startingIndex)
        {
            ExternalLinksTable externalLinks = new ExternalLinksTable();
            externalLinks.UserBasic = new UserBasic();
            externalLinks.UrlType = new UrlType();
            externalLinks.EntityBusinessType = new EntityBusinessType();

            externalLinks.Id = reader.GetSafeInt32(startingIndex++);
            externalLinks.UserBasic.Id = reader.GetSafeInt32(startingIndex++);
            externalLinks.UrlType = reader.GetSafeEnum<UrlType>(startingIndex++);
            externalLinks.Url = reader.GetSafeString(startingIndex++);
            externalLinks.EntityId = reader.GetSafeInt32(startingIndex++);
            externalLinks.EntityBusinessType = reader.GetSafeEnum<EntityBusinessType>(startingIndex++);
            externalLinks.DateCreated = reader.GetSafeDateTime(startingIndex++);
            externalLinks.DateModified = reader.GetSafeDateTime(startingIndex++);

            return externalLinks;
        }

        private static void AddCommonParams(ExternalLinksAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@UserId", model.UserId);
            col.AddWithValue("@UrlTypeId", model.UrlTypeId);
            col.AddWithValue("@Url", model.Url);
            col.AddWithValue("@EntityId", model.EntityId);
            col.AddWithValue("@EntityTypeId", model.EntityTypeId);
        }
    }
}
