using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Ratings  
    {
     
        public int Id { get; set; }

        public int Rating { get; set; }

        public int CommentId { get; set; }

        public int EntityTypeId { get; set; }

        public int EntityId { get; set;}    

        public DateTime DateCreated { get; set; }

        public DateTime DateModified { get; set; } 

        public int CreatedBy { get; set; }

        public bool IsDeleted { get; set; }


    }
}
