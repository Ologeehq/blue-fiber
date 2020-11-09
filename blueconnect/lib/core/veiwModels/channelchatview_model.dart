import 'package:blueconnectapp/core/models/chat.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/channel_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/core/veiwModels/channelview_model.dart';

import '../../locator.dart';
import 'base_model.dart';

class ChannelChatViewModel extends BaseModel{

  NavigationService _navigationService = locator<NavigationService>();
  ChannelViewModel _channelViewModel = locator<ChannelViewModel>();
  ChannelService _channelService = locator<ChannelService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  int channelIndex;

  List<Chat> chats = [];

  String get user => _authenticationService.currentUser.id;

  String get username =>  _authenticationService.currentUser.fullName;

  bool get isAdmin => _authenticationService.currentUser.id == _channelViewModel.channels[channelIndex].admin;

  // Navigate back
  void navigateBack(){
    chats.clear();
    _navigationService.goBack();
  }

  // Set the group index
  void setChannelIndex(int index){
    channelIndex = index;
    notifyListeners();
  }

  // Send message
  Future sendMessage({String message}) async {
      var channelId = _channelViewModel.channels[channelIndex].id;
      await _channelService.addChannelChat(chat: Chat(
          message: message,
          username: username,
          sender: _authenticationService.currentUser.id,
          timeSent: _channelService.timeStamp,
          isImage: false
      ),
          channelId: channelId
      );
  }

  // Pull all channel message
  void pullChannelChats(){
      var channelId = _channelViewModel.channels[channelIndex].id;
      _channelService.getChannelChats(channelId: channelId).listen((channelChatData) {
        List<Chat> updatedChats = channelChatData;
        if(updatedChats != null  && updatedChats.length > 0){
          // chats = [...updatedChats.reversed];
          chats = updatedChats;
          notifyListeners();
        }
      });
  }
}