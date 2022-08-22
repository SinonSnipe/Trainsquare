using Sabio.Models;
using Sabio.Models.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services.Interfaces
{
    public interface IBlogService
    {
        Blog Get(int id);
        Paged<Blog> GetAllPagination(int pageIndex, int pageSize);
        Paged<Blog> PaginateType(int pageIndex, int pageSize, string query, int BlogsTypeId);     
    }
}
