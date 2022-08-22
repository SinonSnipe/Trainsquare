using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Advertisements
    {

        public int Id { get; set; }
        public int WorkShopId { get; set; }
        public int OwnerId { get; set; }
        public string Title { get; set; }
        public string AdMainImage { get; set; }
        public string Details { get; set; }
        public DateTime DateStart { get; set; } 
        public DateTime DateEnd { get; set; } 
        public List<File> File { get; set; } 


    }
}
