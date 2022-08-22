using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class FavoriteHost
    {
        public int WorkshopId { get; set; }
        public int HostId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

    }
}
