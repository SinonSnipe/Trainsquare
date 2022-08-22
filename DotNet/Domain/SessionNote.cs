using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class SessionNote
    {
        public int Id { get; set; }

        public string WorkshopName { get; set; }

        public LookUp Tag { get; set; }

        public string Notes { get; set; }

        public DateTime SessionDate { get; set; }

    }
}
