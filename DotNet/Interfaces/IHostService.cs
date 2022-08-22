using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.WorkShopRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services.Interfaces
{
    public interface IHostService
    {
        List<HostWorkShop> GetWorkshops(int hostId);
        Paged<HostSession> GetSessions(int pageIndex, int pageSize, int pageSize1);
        HostProfile GetProfile(int hostId);
        List<HostWorkshopRequests> GetWorkshopRequests(int hostId);
    }
}
