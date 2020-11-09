import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/models/chat_block.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/chat_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class ChatViewModel extends BaseModel{
  NavigationService _navigationService = locator<NavigationService>();
  ChatService _chatService = locator<ChatService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  List<ChatSet> chats = [];

  String get username => _authenticationService.currentUser.fullName;

  String get userId => _authenticationService.currentUser.id;

  void navigateBack(){
    _navigationService.goBack();
  }

  void pullChats(){
    setState(ViewState.Busy);

    _chatService.getActiveChats(userId: _authenticationService.currentUser.id).listen((chatData) {
      List<ChatSet> updatedChats = chatData;
      if(updatedChats != null  && updatedChats.length > 0){
        chats = updatedChats;
        notifyListeners();
      }
    });

    setState(ViewState.Idle);
  }

  void navigateToChatScreen({ String username, String imageSrc, String userId }){
    _navigationService.navigateTo(Routes.PERSONAL_CHAT_SCREEN, arguments: [username, imageSrc, userId]);
  }
}