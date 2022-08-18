import React, { useState, useEffect, useRef } from 'react';
import { HubConnectionBuilder } from '@microsoft/signalr';
import { getLastMessageInConversation } from '../../services/messageService';
import * as moment from 'moment';
import PropTypes from 'prop-types';
import ChatUsers from './ChatUsers';
import ChatArea from './ChatArea';
import { Row, Col } from 'react-bootstrap';
import { onGlobalError } from '../../services/serviceHelpers';
import debug from 'sabio-debug';  

const _logger = debug.extend('ChatApp');
// ChatApp
const ChatApp = (props) => {
    const currentUser = props.currentUser;          
    const [connection, setConnection] = useState(null);
    const [user, setUser] = useState([]);
    const [userMessages, setUserMessages] = useState([]);
    const [selectedUser, setSelectedUser] = useState();
    const latestChat = useRef(null);
    const latestUsers = useRef(null);
    const latestSelectedUser = useRef(null)
    latestChat.current = userMessages;
    latestUsers.current = user; 
    latestSelectedUser.current = selectedUser;

    useEffect(() => {
        const connect = new HubConnectionBuilder()
          .withUrl('https://trainsquare.azurewebsites.net/chathub')
          .withAutomaticReconnect()
          .build();
    
        setConnection(connect);
      }, []);
      
      useEffect(() => {
        if (connection) {
          connection
            .start()
            .then(()=> {
                _logger("Connection Successful")
              connection.on("ReceiveMessage", (message) => {
                        const updatedSelectedUser = latestSelectedUser.current
                        _logger("SignalR Message Incoming", updatedSelectedUser, message)
                        if(updatedSelectedUser.id === message.sender.id){
                        const updatedChat = [...latestChat.current];
                        updatedChat.push(message);
                        setUserMessages(updatedChat);

                        const mappedMessage = mappingUsers(message);
                        const updatedUsers = ([...latestUsers.current]).filter((m) => m.id !== mappedMessage.id);
                        updatedUsers.unshift(mappedMessage)
                        setUser(updatedUsers);}
                        
                        else{
                            const mappedMessage = mappingUsers(message);
                            const updatedUsers = ([...latestUsers.current]).filter((m) => m.id !== mappedMessage.id);
                            updatedUsers.unshift(mappedMessage)
                            setUser(updatedUsers);}
   
              });
            })
            .catch((error) => _logger(error));
        }

      }, [connection]);

    const onSendMessage = async (message) => {
        let email = selectedUser.email
        if (connection) await connection.send('SendPrivateMessage',email, message);
        _logger("sendingmessage",connection, email, message)

        const updatedChat = [...latestChat.current];
        updatedChat.push(message); 
        setUserMessages(updatedChat);

        const mappedMessage = mappingUsers(message);
        const updatedUsers = ([...latestUsers.current]).filter((m) => m.id !== mappedMessage.id);
        updatedUsers.unshift(mappedMessage)
        setUser(updatedUsers);
    };

    useEffect(() => {          
        _logger('useEffect firing');  
        getLastMessageInConversation(currentUser.id, 0, 10).then(onGetLastMessageInConversationSuccess).catch(onGlobalError);
    }, [currentUser]);   
    

    const onGetLastMessageInConversationSuccess = (response) => {       
        _logger('onGetLastMessageInConversationSuccess', response);                                           
        const arrayOfMessages = response.data.item.pagedItems;          
        const mappedUsers = arrayOfMessages.map(mappingUsers);
        setUser(mappedUsers);
    };

    const mappingUsers = (m) =>{
        let user = {};
            if(m.sender.id !== currentUser.id){
                
                user.messageId = m.id
                user.id = m.sender.id;
                user.firstName = m.sender.firstName? m.sender.firstName : "Trainsquare User";    
                user.lastName = m.sender.lastName;
                user.avatar = m.sender.avatarUrl;
                user.email = m.senderEmail;                 
                user.lastMessage = m.messageContent;
                user.lastMessageOn = moment(m.dateSent).format("MMM Do YY")            
            }
            else
            {
                user.messageId = m.id
                user.id = m.recipient.id;
                user.firstName = m.recipient.firstName? m.recipient.firstName : "Trainsquare User";    
                user.lastName = m.recipient.lastName;
                user.avatar = m.recipient.avatarUrl;
                user.email = m.recipientEmail;                  
                user.lastMessage = m.messageContent;
                user.lastMessageOn = moment(m.dateSent).format("MMM Do YY")
            }
            return user;
    }

    const onUserChange = (user) => {            
        _logger('User Selected', user);  
        setSelectedUser(user);
        
    };

    const onSetUserMessages = (messagesArray) => {
        setUserMessages(messagesArray)
    };


    return (        
        <>


            <Row>
                <Col xxl={6} xl={{ span: 6, order: 1 }}>    
                    <ChatUsers activeUser = {currentUser} onUserSelect = {onUserChange} users = {user} />
                </Col>                                                                        

                <Col xxl={6} xl={{ span: 6, order: 2 }}>        
                    <ChatArea user={selectedUser} activeUser={currentUser} selectedUserMessages = {userMessages} settingUserMessages = {onSetUserMessages}  sendMessage = {onSendMessage}/>
                </Col> 
            </Row>

        </>
    );
};

ChatApp.propTypes = {
    currentUser: PropTypes.shape({
        email: PropTypes.string.isRequired,
        id: PropTypes.number.isRequired,
        isLoggedIn: PropTypes.bool.isRequired,
        profilePic: PropTypes.string.isRequired,
        roles: PropTypes.arrayOf(PropTypes.string),
    }),  
};

export default ChatApp;;                                                                   
