using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class HostProfile
    {
        public int HostId { get; set; }
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string MiddleI { get; set; }
        public string LastName { get; set; }
        public string AvatarUrl { get; set; }
        public DateTime DateCreated { get; set; }
        public string Email { get; set; } 

    }
}
