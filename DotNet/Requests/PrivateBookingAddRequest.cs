using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests
{
    public class PrivateBookingAddRequest
    {
        [Required]
        [StringLength(10000, MinimumLength = 1)]
        public string Name { get; set; }

        [Required]
        [StringLength(10000, MinimumLength = 1)]
        public string Email { get; set; }

        [Required]
        [Range(1, int.MaxValue)]
        public int NumberOfPeopleAttending { get; set; } 

        [Required]
        [Range(1, int.MaxValue)]
        public int NumberOfSessions { get; set; } 

    }
}
