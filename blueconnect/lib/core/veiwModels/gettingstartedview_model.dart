import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class GettingStartedViewModel extends BaseModel{
  NavigationService _navigationService = locator<NavigationService>();

  void navigateToLogin(){
    _navigationService.navigatorKey.currentState.pushReplacementNamed(Routes.LOGIN_SCREEN);
  }

  void navigateToSignIn(){
    _navigationService.navigatorKey.currentState.pushReplacementNamed(Routes.REGISTER_SCREEN);
  }
}