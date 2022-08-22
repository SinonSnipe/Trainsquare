using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class VenueLocation : BaseLocationMapper, IModelIdentifier
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string LocationType { get; set; }
        public string LineTwo { get; set; }
        public string State { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Url { get; set; }
        public int CreatedBy { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public string ImageUrl { get; set; }
    }
}



//public class LocationUpdateRequest : LocationAddRequest, IModelIdentifier

