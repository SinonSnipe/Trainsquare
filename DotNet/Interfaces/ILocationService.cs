using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services.Interfaces
{
    public interface ILocationService
    {
        public int Add(LocationAddRequest model, int userId);

        public Location GetById(int Id);

        public Paged<Location> SelectAll(int pageIndex, int pageSize);

        public Paged<Location> CreatedBy(int pageIndex, int pageSize, int creatorId);

        public List<Location> GetByProximity(int radius, double latitude, double longitude);

        public void Update(LocationUpdateRequest model, int userId);

        public void Delete(int Id);

        public Location MapLocation(IDataReader reader, ref int index);
    }
}
