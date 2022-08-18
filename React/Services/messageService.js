import axios from "axios";
import * as helper from './serviceHelpers';

var messageService = {
    endpoint: `${helper.API_HOST_PREFIX}/api/messages/`
};

const getMessageById = (id) => {
  const config = {
    method: "GET",
    url: messageService.endpoint + id,  
    withCredentials: true,
    crossdomain: true,
    headers: { "Content-Type": "application/json" }
  };
  
  return axios(config)
};

const getMessagesAll = (pageIndex, pageSize) => {

  const config = {
      method: "GET",
      url: `${messageService.endpoint}all?pageIndex=${pageIndex}&pageSize=${pageSize}`,
      withCredentials: true,
      crossdomain: true,
      headers: { "Content-Type": "application/json" }
    };

return axios(config);
};

const getMessagesBySenderId = (id, pageIndex, pageSize) => {

  const config = {
      method: "GET",
      url: `${messageService.endpoint}sender/${id}?pageIndex=${pageIndex}&pageSize=${pageSize}`,
      withCredentials: true,
      crossdomain: true,
      headers: { "Content-Type": "application/json" }
    };

return axios(config);
};

const getMessagesByRecipientId = (id, pageIndex, pageSize) => {

  const config = {                       
      method: "GET",
      url: `${messageService.endpoint}recipient/${id}?pageIndex=${pageIndex}&pageSize=${pageSize}`,
      withCredentials: true,
      crossdomain: true,
      headers: { "Content-Type": "application/json" }
    };

return axios(config);
};

const getMessagesByConversation = (activeUserId,selectedUserId, pageIndex, pageSize) => {

  const config = {
      method: "GET",
      url: `${messageService.endpoint}conversation/${activeUserId}&${selectedUserId}?pageIndex=${pageIndex}&pageSize=${pageSize}`,
      withCredentials: true,
      crossdomain: true,
      headers: { "Content-Type": "application/json" }
    };

return axios(config);
};

const getLastMessageInConversation = (id, pageIndex, pageSize) => {

  const config = {
      method: "GET",
      url: `${messageService.endpoint}chatlast/${id}?pageIndex=${pageIndex}&pageSize=${pageSize}`,
      withCredentials: true,
      crossdomain: true,
      headers: { "Content-Type": "application/json" }
    };

return axios(config);
};

const deleteMessage = (id) => {
  const config = {
    method: "DELETE",
    url: messageService.endpoint + id,
    withCredentials: true,
    crossdomain: true,
    headers: { "Content-Type": "application/json" }
  };
  
  return axios(config).then(()=>{
    return id
  });
};

const postMessage = (payload) => {
    const config = {
      method: "POST",
      url: messageService.endpoint,
      data:payload,
      withCredentials: true,
      crossdomain: true,
      headers: { "Content-Type": "application/json" },
    };
  
    return axios(config) 
};

const updateMessage = (payload) => {
    const config = {
      method: "PUT",
      url: messageService.endpoint + payload.id,
      data: payload,
      withCredentials: true,   
      crossdomain: true,
      headers: { "Content-Type": "application/json" }
    };

    return axios(config);
};

  export{getMessageById, getMessagesAll, getMessagesBySenderId, getMessagesByRecipientId, getMessagesByConversation, getLastMessageInConversation, deleteMessage, postMessage, updateMessage}