import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/models/user.dart';
import 'package:blueconnectapp/core/services/authentication_service.dart';
import 'package:blueconnectapp/core/services/dialog_service.dart';
import 'package:blueconnectapp/core/services/user_service.dart';
import 'package:blueconnectapp/locator.dart';

import '../constants/route_paths.dart';
import '../services/navigator_service.dart';
import 'base_model.dart';

class ProfileViewModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  UserService _userService = locator<UserService>();
  DialogService _dialogService = locator<DialogService>();

  String get fullName => _authenticationService.currentUser.fullName;

  String get email => _authenticationService.currentUser.email;

  String get phone => _authenticationService.currentUser.phone;

  String get id => _authenticationService.currentUser.id;

  // Just if it's not yet set
  String get quote => _authenticationService.currentUser.quote;

  Future updateProfile(
      {String fullName, String email, String phone, String quote}) async {
    setState(ViewState.Busy);

    var result = await _userService.updateUser(AppUser(
        id: _authenticationService.currentUser.id,
        fullName: fullName,
        email: email,
        phone: phone,
        quote: quote));

    setState(ViewState.Idle);

    if (result is bool) {
      _dialogService.showDialog(
          title: "Success",
          buttonTitle: "Ok",
          description: "Profile updated successfully.");
    } else {
      _dialogService.showDialog(
          title: "Error",
          buttonTitle: "Ok",
          description: "Profile update failed. Try again later");
    }
  }

  void navigateToSettings() {
    _navigationService.navigateTo(Routes.SETTINGS_SCREEN);
  }

  Future signOut() async {
    setState(ViewState.Busy);
    await _authenticationService.signOut();
    setState(ViewState.Idle);
    _navigationService.navigateToAndRemoveAll(Routes.LOGIN_SCREEN);
  }
}
