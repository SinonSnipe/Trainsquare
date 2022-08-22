using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Blogs;

namespace Sabio.Services
{
    public interface IBlogsServices
    {

        public void Update(BlogUpdateRequest model, int currentUserId);

        public Paged<Blog> PaginateAuthor(int pageIndex, int pageSize, int authorId);

        public Paged<Blog> PaginateAuthorQuery(int pageIndex, int pageSize, string query, int authorId);

        public Paged<Blog> PaginateType(int pageIndex, int pageSize, int blogTypeId);

        int Add(BlogAddRequest model, int currentUserId);


    }
}