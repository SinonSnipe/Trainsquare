using Sabio.Models.Domain;
using System.Collections.Generic;
using System.Dynamic;

namespace Sabio.Services
{
    public interface ILookupsService
    {
        ExpandoObject GetTypes(IEnumerable<string> tableNames);
    }
}