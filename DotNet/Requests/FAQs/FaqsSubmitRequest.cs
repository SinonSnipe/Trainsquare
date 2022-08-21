using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.Faqs
{
    public class FaqsSubmitRequest
    {
        [Required]
        [EmailAddress(ErrorMessage = "Invalid Email Address")]
        public string Email { get; set; }

        [Required]
        [StringLength(50, ErrorMessage = "Please provide your name.")] 
        public string Name { get; set; }

        [Required]
        [StringLength(250, ErrorMessage = "Please provide the reason for contacting us.")]
        public string Question { get; set; }
    }
}
