using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class WorkshopVenues
    {
        public WorkShop Workshop { get; set; }
        public int VenueId { get; set; }
        public string VenueName { get; set; }
        public string VenueImageUrl { get; set; }
        public double Range { get; set; }
        public int LocationId { get; set; }
        public string LocationType { get; set; }
        public string LineOne { get; set; }
        public string LineTwo { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string State { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
    }
}
