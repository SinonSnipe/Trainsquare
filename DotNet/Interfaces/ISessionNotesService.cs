using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.SessionNotes;

namespace Sabio.Services
{
    public interface ISessionNotesService
    {
        int Add(SessionNoteAddRequest model, int userId);
        void Delete(int id);
        SessionNote Get(int Id);
        Paged<SessionNote> Paginated(int pageIndex, int pageSize);
        void Update(SessionNoteUpdateRequest model, int userId);
    }
}