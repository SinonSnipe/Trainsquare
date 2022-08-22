using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services.Interfaces
{
    public interface IInventoryService
    {
        int Add(InventoryAddRequest model, int Id);

        void Delete(int id);

        Inventory Get(int id);

        Paged<Inventory> GetPaginate(int pageIndex, int pageSize);

        void Update(InventoryUpdateRequest model, int Id);

        Paged<InventoryDetails> GetPaginateV2(int pageIndex, int pageSize);
        Paged<InventoryDetails> GetPaginateV2Search(int pageIndex, int pageSize, string query);

    }
}
