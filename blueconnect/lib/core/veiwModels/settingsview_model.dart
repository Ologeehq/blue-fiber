import '../../locator.dart';
import '../enum/view_state.dart';
import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import 'base_model.dart';

class SettingsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future changePassword(String newPassword) async {
    setState(ViewState.Busy);

    var result = await _authenticationService.changePassword(newPassword);

    setState(ViewState.Idle);
    if (result is bool) {
      _dialogService.showDialog(
          title: 'Success',
          description: 'password updated successfully',
          buttonTitle: 'Ok');
    } else {
      _dialogService.showDialog(
          title: 'Error',
          description: 'Unable to update new password',
          buttonTitle: 'Go back');
    }
  }
}
