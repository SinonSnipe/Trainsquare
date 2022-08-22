using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class PrivateBooking
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public int NumberOfPeopleAttending { get; set; }
        public int NumberOfSessions { get; set; }
        public string Description { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public int WorkshopId { get; set; }
        public int UserId { get; set; }
        public int WorkshopRequestId { get; set; }
    }
}
