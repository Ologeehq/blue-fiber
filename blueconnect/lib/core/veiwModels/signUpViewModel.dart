import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/dialog_service.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel{

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({ @required String email, @required String password, @required String fullName, @required String phone }) async {
    setState(ViewState.Busy);

    var result = await _authenticationService.signUpWithEmail( email: email, password: password, fullName: fullName, phone: phone );

    setState(ViewState.Idle);

    if(result is bool){
    //  Navigate to the home view route
      _navigationService.navigatorKey.currentState.pushReplacementNamed(Routes.HOME_SCREEN);
    }else{
        _dialogService.showDialog(
          title: 'Error',
          description: result,
          buttonTitle: 'Ok'
        );
    }
  }

  void navigateToLogin(){
    _navigationService.navigatorKey.currentState.pushReplacementNamed(Routes.LOGIN_SCREEN);
  }

}