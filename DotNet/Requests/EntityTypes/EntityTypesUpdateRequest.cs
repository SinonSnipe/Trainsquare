using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.EntityTypes
{
    public class EntityTypesUpdateRequest : EntityTypesAddRequest , IModelIdentifier
    {
        public int Id { get; set; }
    }
}
