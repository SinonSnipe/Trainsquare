using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests
{
    public class FavoriteHostAddRequest
    {
        [Required]
        [Range(1, 1000)]
        public int WorkshopId { get; set; }
        [Required]
        [Range(1, 1000)]
        public int HostId { get; set; }
    }
}
