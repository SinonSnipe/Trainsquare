using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class FavoriteWorkshopBase
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int WorkShopId { get; set; }

    }
}
