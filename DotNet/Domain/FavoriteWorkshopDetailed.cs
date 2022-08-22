using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class FavoriteWorkshopDetailed : FavoriteWorkshopBase
    {
        public string Name { get; set; }
        public string Summary { get; set; }
        public string ShortDescription { get; set; }
        public int VenueId { get; set; }
        public int HostId { get; set; }
        public int WorkShopTypeId { get; set; }
        public int WorkShopStatusId { get; set; }
        public string ImageUrl { get; set; }
        public string ExternalSiteUrl { get; set; }
        public int LanguageId { get; set; }
        public bool IsFree { get; set; }
        public int NumberOfSessions { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public DateTime DateStart { get; set; }
        public DateTime DateEnd { get; set; }

    }
}
