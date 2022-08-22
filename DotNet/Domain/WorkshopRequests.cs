using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class WorkshopRequests
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int HostId { get; set; }
        public string Topic { get; set; }
        public string BriefDescription { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }

    }
}
