using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Sabio.Models.Requests
{
    public class LoginRequest
    {
        [Required]
        [StringLength(100, MinimumLength = 2)]
        public string Email { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2)]
        public string Password { get; set; }
    }
}
