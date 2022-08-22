using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Message
    {
        public int Id { get; set; }
        public string MessageContent { get; set; }
        public string Subject { get; set; }
        public BaseUser Recipient { get; set; }
        public string RecipientEmail { get; set; }
        public BaseUser Sender { get; set; }
        public string SenderEmail { get; set; }
        public DateTime? DateSent { get; set; }
        public DateTime? DateRead { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }

    }
}
