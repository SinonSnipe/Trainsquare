using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.SessionNotes
{
    public class SessionNoteUpdateRequest : SessionNoteAddRequest, IModelIdentifier

    {
        public int Id { get; set; }
    }
}
