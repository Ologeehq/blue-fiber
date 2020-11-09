import 'package:blueconnectapp/core/models/chat.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/community_service.dart';
import 'package:blueconnectapp/core/services/group_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/core/veiwModels/groupview_model.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class ConversationViewModel extends BaseModel{

  NavigationService _navigationService = locator<NavigationService>();
  GroupViewModel _groupViewModel = locator<GroupViewModel>();
  CommunityService _communityService = locator<CommunityService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  GroupService _groupService = locator<GroupService>();

  int groupIndex;

  List<Chat> chats = [];

  String get user => _authenticationService.currentUser.id;

  String get username => _authenticationService.currentUser.fullName;

  // Navigate back
  void navigateBack(){
    chats.clear();
    _navigationService.goBack();
  }

  // Set the group index
  void setGroupIndex(int index){
    groupIndex = index;
    notifyListeners();
  }

  // Send message
  Future sendMessage({String message}) async {
    if(_groupViewModel.combined[groupIndex].type == 'community'){
      var communityId = _groupViewModel.combined[groupIndex].id;
      await _communityService.addCommunityChat(chat: Chat(
          message: message,
          username: username,
          sender: _authenticationService.currentUser.id,
          timeSent: _communityService.timeStamp,
          isImage: false
      ),
          communityId: communityId
      );
    }else{
      var groupId = _groupViewModel.combined[groupIndex].id;
      await _groupService.addGroupChat(chat: Chat(
        message: message,
        username: username,
        sender: _authenticationService.currentUser.id,
        timeSent: _groupService.timeStamp,
        isImage: false,
      ),
          groupId: groupId
      );
    }
  }

  void pullChats(){
      // Check if it's a community or a group
      if(_groupViewModel.combined[groupIndex].type == 'community'){
        var communityId = _groupViewModel.combined[groupIndex].id;
        _communityService.getCommunityChats(communityId: communityId).listen((communityChatData) {
          List<Chat> updatedChats = communityChatData;
          if(updatedChats != null  && updatedChats.length > 0){
            chats = updatedChats;
            notifyListeners();
          }
        });
      }else{
        var groupId = _groupViewModel.combined[groupIndex].id;
        _groupService.getGroupChats(groupId: groupId).listen((groupChatData) {
            List<Chat> updatedChats = groupChatData;
            if(updatedChats != null && updatedChats.length > 0 ){
              chats = updatedChats;
              notifyListeners();
            }
        });
      }
  }

}