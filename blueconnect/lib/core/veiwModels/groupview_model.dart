import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/models/community.dart';
import 'package:blueconnectapp/core/models/group.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/community_service.dart';
import 'package:blueconnectapp/core/services/group_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class GroupViewModel extends BaseModel{

  List<Group> _groups = [];
  List<Community> _communities = [];

  List<dynamic> get combined {
    return [_communities,_groups].expand((element) => element).toList();
  }

  GroupService _groupService = locator<GroupService>();
  CommunityService _communityService = locator<CommunityService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  String get user => _authenticationService.currentUser.id;

  void listenToGroups(){
    setState(ViewState.Busy);

    // Listen on the group service
    _groupService.getGroups().listen((groupData) {
      List<Group> updatedGroups = groupData;
      if(updatedGroups != null  && updatedGroups.length > 0){
        _groups = updatedGroups;
        notifyListeners();
      }
    });

    // Listen on the community Service
    _communityService.getCommunities().listen((communityData) {
      List<Community> updatedGroups = communityData;
      if(updatedGroups != null  && updatedGroups.length > 0){
        _communities = updatedGroups;
        notifyListeners();
      }
    });

    setState(ViewState.Idle);
  }

  void navigateToGroupChat({ String chatTitle, String imageSrc, int groupIndex }){
    _navigationService.navigateTo(
        Routes.CHAT_SCREEN,
        arguments: [chatTitle, imageSrc, groupIndex]
    );
  }

  Future addUserToGroup({ int groupIndex }) async{
    setState(ViewState.Busy);
    // Add the user to the group
    combined[groupIndex].users.add(_authenticationService.currentUser.id);
    // Check if the group is a private group or a paid group!
    if(combined[groupIndex].type == 'community'){
        await _communityService.updateCommunity(combined[groupIndex]);
    }else{
        await _groupService.updateGroup(combined[groupIndex]);
    }
    var chatTitle = combined[groupIndex].name;
    var imageSrc = combined[groupIndex].logo;

    setState(ViewState.Idle);

    _navigationService.navigateTo(
        Routes.CHAT_SCREEN,
        arguments: [chatTitle, imageSrc, groupIndex]
    );
  }

}