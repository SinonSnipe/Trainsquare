using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.VenueRequest
{
    public class UpdateVenueRequest : AddVenueRequest, IModelIdentifier
    {   
        public int Id { get; set; }
    }
}
