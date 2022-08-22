using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Notes;
using System.Collections.Generic;

namespace Sabio.Services
{
    public interface INotesService
    {

        int Add(NoteAddRequest model, int userId);
        Note Get(int Id);
        Paged<Note> Paginated(int pageIndex, int pageSize);
        Paged<Note> GetCurrent(int createdBy, int pageIndex, int pageSize);
        void Update(NoteUpdateRequest model, int userId);
        void Delete(int Id);
    }
}