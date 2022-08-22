using Sabio.Models;
using Sabio.Models.Domain.WorkShopRequest;
using Sabio.Models.Requests.WorkShopRequest;


namespace Sabio.Services
{
    public interface IWorkShopRequest
    {

        Paged<WorkShopRequest> SearchPaginate(int pageIndex, int pageSize, string q);

        Paged<WorkShopRequest> GetByCreatedBy(int currentRequest, int pageIndex, int pageSize);

        WorkShopRequest Get(int id);

        Paged<WorkShopRequest> Pagination(int pageIndex, int pageSize);

        int Add(WorkShopAddRequest model);


        public void Delete(int Id);

        
    }
}
