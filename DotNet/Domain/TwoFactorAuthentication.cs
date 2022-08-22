using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class TwoFactorAuthentication : TwoFactorAuthenticationCodes
    {
        public int Id { get; set; }
        public BaseUser User { get; set; }
        public string PhoneNumber { get; set; }
        public LookUp Status { get; set; }
        public bool IsTwoFactorEnabled { get; set; }
        public LookUp TwoFactorType { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
    }
}
