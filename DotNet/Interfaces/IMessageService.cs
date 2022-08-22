using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Messages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services.Interfaces
{
    public interface IMessageService
    {
        Message Get(int id);
        Paged<Message> GetAll(int pageIndex, int pageSize);
        Paged<Message> GetBySender(int senderId, int pageIndex, int pageSize);
        Paged<Message> GetByRecipient(int recipientId, int pageIndex, int pageSize);
        Paged<Message> GetConversation(int activeUserId, int selectedUserId, int pageIndex, int pageSize);
        Paged<Message> GetLastConversationMessage(int activeUserId, int pageIndex, int pageSize);
        void Delete(int id);
        int Create(MessageAddRequest model);
        void Update(MessageUpdateRequest model);
    }

}
