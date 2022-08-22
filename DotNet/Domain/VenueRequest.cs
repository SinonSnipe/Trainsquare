using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class VenueRequest
    {
        public int VenueId { get; set; }
        public string EventDescription { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Requester { get; set; }
        public DateTime DateModifed { get; set; }
        public DateTime DateCreated { get; set; }
        public int Id { get; set; }

    }
}
