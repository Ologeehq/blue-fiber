import 'package:blueconnectapp/core/models/chat.dart';
import 'package:blueconnectapp/core/models/chat_block.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/chat_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class ChatScreenViewModel extends BaseModel{

  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  ChatService _chatService = locator<ChatService>();

  List<Chat> chats = [];

  String get user => _authenticationService.currentUser.id;

  String _friendId = '';

  String _friendName = '';

  String get username => _authenticationService.currentUser.fullName;

  String _chatId = '';

  void navigateBack(){
    _navigationService.goBack();
  }

  void setChatId({ String username, String friend, String friendId }){
    if(username.codeUnitAt(0) > friend.codeUnitAt(0)){
      _chatId = '$username\_$friend';
    }else{
      _chatId = '$friend\_$username';
    }

    // Set the friendID
    _friendId = friendId;

    // Set the friendName
    _friendName = friend;

    notifyListeners();
  }

  Future setUpChat() async {
    await _chatService.initiatePersonalChat(chatId: _chatId, chatSet: ChatSet(
        user1: _friendName,
        user2: username,
        chatId: _chatId,
        users: [user, _friendId]));
  }

  void pullChats(){
    _chatService.loadChats(chatId: _chatId).listen((chatData) {
      List<Chat> updatedChats = chatData;
      if(updatedChats != null  && updatedChats.length > 0){
        chats = updatedChats;
        notifyListeners();
      }
    });
  }

  Future sendMessage({ String message }) async {
    await _chatService.messageFriend(
        chat: Chat(
              message: message,
              sender: user,
              username: username,
              timeSent: _chatService.timeStamp,
              isImage: false
          ),
        chatId: _chatId);
  }


}