import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/models/channel.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/channel_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class ChannelViewModel extends BaseModel{

  List<Channel> channels = [];

  ChannelService _channelService = locator<ChannelService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  String get user => _authenticationService.currentUser.id;

  void listenToChannels(){
    setState(ViewState.Busy);

    _channelService.getChannels().listen((channelData) {
      List<Channel> updatedChannels = channelData;
      if(updatedChannels != null  && updatedChannels.length > 0){
        channels = updatedChannels;
        notifyListeners();
      }
    });

    setState(ViewState.Idle);
  }

  void navigateToChannelChat({ String chatTitle, String imageSrc, int channelIndex }){
    _navigationService.navigateTo( Routes.CHANNEL_SCREEN, arguments: [chatTitle, imageSrc, channelIndex] );
  }

  Future addUserToChannel({ int channelIndex }) async{
    setState(ViewState.Busy);
    // Add the user to the group
    channels[channelIndex].users.add(_authenticationService.currentUser.id);
    // Check if the channel is a private group or a paid group!
    await _channelService.updateChannel(channels[channelIndex]);

    var chatTitle = channels[channelIndex].name;
    var imageSrc = channels[channelIndex].logo;

    setState(ViewState.Idle);

    _navigationService.navigateTo(
        Routes.CHANNEL_SCREEN,
        arguments: [chatTitle, imageSrc, channelIndex]
    );
  }
}