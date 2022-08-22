using Sabio.Models.Domain;
using System;
using System.Collections.Generic;
using Sabio.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Sabio.Services.Interfaces
{
    public interface IUserMapper
    {
        public BaseUser Map(IDataReader reader, ref int index);
    }
}
