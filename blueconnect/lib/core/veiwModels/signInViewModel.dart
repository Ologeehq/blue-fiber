import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/dialog_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class SignInViewModel extends BaseModel{
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  void navigateToRegister(){
    _navigationService.navigatorKey.currentState.pushReplacementNamed(Routes.REGISTER_SCREEN);
  }

  void navigateToForgotPassword() {
    _navigationService.navigateTo(Routes.FORGOT_PASSWORD_SCREEN);
  }

  Future login ({ String email, String password }) async {
    setState(ViewState.Busy);

    var result = await _authenticationService.loginWithEmail(email: email, password: password);

    setState(ViewState.Idle);

    if(result is bool){
      _navigationService.navigatorKey.currentState.pushReplacementNamed(Routes.HOME_SCREEN);
    }else{
      _dialogService.showDialog(
          title: 'Error',
          description: result,
          buttonTitle: 'Ok'
      );
    }

  }
}