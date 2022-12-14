using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class HostWithFavoriteCount : FavoriteHost
    {
        [Required]
        [Range(1, 1000)]
        public int TotalFavorited { get; set; }
    }
}
