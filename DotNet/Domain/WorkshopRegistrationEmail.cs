using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class WorkshopRegistrationEmail
    {
		public int WorkshopId { get; set; }
		public string WorkshopName { get; set; }
		public string WorkshopImage { get; set; }
		public DateTime DateStart { get; set; }
		public DateTime DateEnd { get; set; }
		public string UserEmail { get; set; }
		public int UserRegistrationStatusId { get; set; }
		public string UserRegistrationStatus { get; set; }
		public string VenueName { get; set; }
		public string VenueUrl { get; set; }
		public string LineOne { get; set; }
		public string LineTwo { get; set; }
		public string City { get; set; }
		public int State { get; set; }
		public string HostFName { get; set; }
		public string HostLName { get; set; }
	}
}
