using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class ExternalLinksTable
    {
        public int Id { get; set; }
        public UserBasic UserBasic { get; set; }
        public UrlType UrlType { get; set; }
        public string Url { get; set; }
        public int EntityId { get; set; }
        public EntityBusinessType EntityBusinessType { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
    }
}
