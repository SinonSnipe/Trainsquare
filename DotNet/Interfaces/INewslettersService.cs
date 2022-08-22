using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Newsletters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    
    
        public interface INewslettersService
        {
            Newsletters Get(int id);
            Paged<Newsletters> Pagination(int pageIndex, int pageSize);
            int Add(NewslettersAddRequest model, int userId);
            void Update(NewslettersUpdateRequest model, int currentUserId);
            void Delete(int id);


        }
    
}
