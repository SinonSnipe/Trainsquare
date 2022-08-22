using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Notes;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Sabio.Models.Domain.Note;

namespace Sabio.Services
{
    public class NotesService : INotesService
    {
        IDataProvider _data = null;
        ILookUp _lookMapper = null;

        public NotesService(IDataProvider data, ILookUp lookMapper)
        {
            _data = data;
            _lookMapper = lookMapper;
        }

        public Note Get(int Id)
        {
            string procName = "[dbo].[Notes_Select_ById]";
            Note note = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {

                paramCollection.AddWithValue("@Id", Id);

            }, delegate (IDataReader reader, short set)
            {
                int startIndex = 0;
                note = MapNote(reader, ref startIndex);
            }
            );
            return note;
        }

        public Paged<Note> Paginated(int pageIndex, int pageSize)
        {
            Paged<Note> pagedList = null;
            List<Note> noteList = null;
            int totalCount = 0; 

            string procName = "[dbo].[Notes_SelectAll]";

            _data.ExecuteCmd(procName
             , inputParamMapper: delegate (SqlParameterCollection col)
             {
                 col.AddWithValue("@PageIndex", pageIndex);
                 col.AddWithValue("@PageSize", pageSize);
             },
             singleRecordMapper: delegate (IDataReader reader, short set)
             {
                 int startIndex = 0;
                 Note aNote = MapNote(reader, ref startIndex);

                 if (totalCount == 0)
                 {
                     totalCount = reader.GetSafeInt32(startIndex);
                 }
                 if (noteList == null)
                 {
                     noteList = new List<Note>();
                 }

                 noteList.Add(aNote);
             } );
            if (noteList != null)
            {
                pagedList = new Paged<Note>(noteList, pageIndex, pageSize, totalCount);
            }

            return pagedList;
        }

        public Paged<Note> GetCurrent(int createdBy, int pageIndex, int pageSize) 
        {
            Paged<Note> pagedList = null;
            List<Note> noteList = null;
            int totalCount = 0;

            string procName = "[dbo].[Notes_Select_ByCreatedBy]";

            _data.ExecuteCmd(procName
             , inputParamMapper: delegate (SqlParameterCollection col)
             {
                 col.AddWithValue("@CreatedBy", createdBy);
                 col.AddWithValue("@PageIndex", pageIndex);
                 col.AddWithValue("@PageSize", pageSize);
             },
              delegate (IDataReader reader, short set)
             {
                 int startIndex = 0;
                 Note aNote = MapNote(reader, ref startIndex);
                 if(totalCount == 0)
                 {
                     totalCount = reader.GetSafeInt32(startIndex);
                 }
                 if (noteList == null)
                 {
                     noteList = new List<Note>();
                 }

                 noteList.Add(aNote);
             });
            if (noteList != null)
            {
                pagedList = new Paged<Note>(noteList, pageIndex, pageSize, totalCount);
            }

            return pagedList;

        }

        public int Add(NoteAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[Notes_Insert]"; 
            _data.ExecuteNonQuery(procName,
            inputParamMapper: delegate (SqlParameterCollection col)
            {
                commonParams(model, col, userId);
                col.AddWithValue("@CreatedBy", userId);
                col.AddWithValue("@DateCreated", model.DateCreated);


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

        public void Update(NoteUpdateRequest model, int userId) 
        {
            string procName = "[dbo].[Notes_Update]";
            _data.ExecuteNonQuery(procName,
            inputParamMapper: delegate (SqlParameterCollection col)
            {

                commonParams(model, col, userId);
                col.AddWithValue("Id", model.Id);
                col.AddWithValue("@DateModified", model.DateModified);
                col.AddWithValue("@ModifiedBy", userId);

            },
            returnParameters: null);
        }

        public void Delete(int id)
        {
            string procName = "[dbo].[Notes_Delete_ById]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", id);

                }, returnParameters: null);
        }



        private Note MapNote(IDataReader reader, ref int startIndex)
        {
            Note aNote = new Note();
            aNote.WorkShops = new WorkShop();
            aNote.Tag = new LookUp();

            aNote.Id = reader.GetSafeInt32(startIndex++);
            aNote.Notes = reader.GetSafeString(startIndex++);
            aNote.WorkshopId = reader.GetSafeInt32(startIndex++);
            aNote.WorkShops.ImageUrl = reader.GetSafeString(startIndex++);
            aNote.WorkShops.Name = reader.GetSafeString(startIndex++);
            aNote.Tag = _lookMapper.MapLookup(reader, ref startIndex);
            aNote.DateCreated = reader.GetSafeDateTime(startIndex++);
            aNote.DateModified = reader.GetSafeDateTime(startIndex++);
            aNote.CreatedBy = reader.GetSafeInt32(startIndex++);
            aNote.ModifiedBy = reader.GetSafeInt32(startIndex++);
            return aNote;
        }

        private void commonParams(NoteAddRequest model, SqlParameterCollection col, int userId)
        {
            col.AddWithValue("@Notes", model.Notes);
            col.AddWithValue("@WorkShopId", model.WorkShopId);
            col.AddWithValue("@TagsTypeId", model.TagsTypeId);
            //col.AddWithValue("@ModifiedBy", userId);


        }

      
    }
}
