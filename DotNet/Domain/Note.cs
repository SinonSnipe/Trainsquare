using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Note
    {   
      
        public int Id { get; set; }

        public string Notes { get; set; }

        public int WorkshopId { get; set; }

        public WorkShop WorkShops { get; set; }

        public LookUp Tag { get; set; }

        public DateTime DateCreated { get; set; }

        public DateTime DateModified { get; set; }

        public int CreatedBy { get; set; }

        public int ModifiedBy { get; set; }


    }

}

   



