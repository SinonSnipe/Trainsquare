using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Notes;
using Sabio.Models.Requests.SessionNotes;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Sabio.Models.Domain.SessionNote;

namespace Sabio.Services
{
    public class SessionNotesService : ISessionNotesService
    {
        IDataProvider _data = null;
        ILookUp _lookMapper = null;

        public SessionNotesService(IDataProvider data, ILookUp lookMapper)
        {
            _data = data;
            _lookMapper = lookMapper;
        }

        public SessionNote Get(int Id)
        {
            string procName = "[dbo].[SessionNotes_Select_ById]";
            SessionNote sessionNote = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {

                paramCollection.AddWithValue("@Id", Id);

            }, delegate (IDataReader reader, short set)
            {
                int startIndex = 0;
                sessionNote = MapSessionNote(reader, ref startIndex);
            }
            );
            return sessionNote;
        }

        public Paged<SessionNote> Paginated(int pageIndex, int pageSize)
        {
            Paged<SessionNote> pagedList = null;
            List<SessionNote> noteList = null;
            int totalCount = 0;

            string procName = "[dbo].[SessionNotes_SelectAll]";

            _data.ExecuteCmd(procName
             , inputParamMapper: delegate (SqlParameterCollection col)
             {
                 col.AddWithValue("@PageIndex", pageIndex);
                 col.AddWithValue("@PageSize", pageSize);
             },
             singleRecordMapper: delegate (IDataReader reader, short set)
             {
                 int startIndex = 0;
                 SessionNote aNote = MapSessionNote(reader, ref startIndex);

                 if (totalCount == 0)
                 {
                     totalCount = reader.GetSafeInt32(startIndex);
                 }
                 if (noteList == null)
                 {
                     noteList = new List<SessionNote>();
                 }

                 noteList.Add(aNote);
             });
            if (noteList != null)
            {
                pagedList = new Paged<SessionNote>(noteList, pageIndex, pageSize, totalCount);
            }

            return pagedList;
        }

        public void Delete(int id)
        {
            string procName = "[dbo].[SessionNotes_Delete_ById]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", id);

                }, returnParameters: null);
        }

        public int Add(SessionNoteAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[SessionNotes_Insert]";
            _data.ExecuteNonQuery(procName,
            inputParamMapper: delegate (SqlParameterCollection col)
            {
                commonParams(model, col, userId);


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

        public void Update(SessionNoteUpdateRequest model, int userId)
        {
            string procName = "[dbo].[SessionNotes_Update]";
            _data.ExecuteNonQuery(procName,
            inputParamMapper: delegate (SqlParameterCollection col)
            {

                commonParams(model, col, userId);
                col.AddWithValue("Id", model.Id);

            },
            returnParameters: null);
        }

        private SessionNote MapSessionNote(IDataReader reader, ref int startIndex)
        {
            SessionNote aSessionNote = new SessionNote();
            aSessionNote.Tag = new LookUp();

            aSessionNote.Id = reader.GetSafeInt32(startIndex++);
            aSessionNote.WorkshopName = reader.GetSafeString(startIndex++);
            aSessionNote.Tag = _lookMapper.MapLookup(reader, ref startIndex);
            aSessionNote.Notes = reader.GetSafeString(startIndex++);
            aSessionNote.SessionDate = reader.GetSafeDateTime(startIndex++);

            return aSessionNote;
        }

        private void commonParams(SessionNoteAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@WorkshopName", model.WorkshopName);
            col.AddWithValue("@TagsTypeId", model.TagsTypeId);
            col.AddWithValue("@Notes", model.Notes);
            col.AddWithValue("@SessionDate", model.SessionDate);
        }

    }
}
