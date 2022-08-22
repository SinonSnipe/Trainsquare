using Sabio.Data;
using Sabio.Models.Domain;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class LocationMapperService : ILocationMapper
    {
        public BaseLocationMapper Map(IDataReader reader, ref int index)
        {

            BaseLocationMapper location = new BaseLocationMapper();
            location.LineOne = reader.GetSafeString(index++);
            location.City = reader.GetSafeString(index++);
            location.Zip = reader.GetSafeString(index++);

            return location;
        }
    }
}
