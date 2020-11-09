import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class VerificationViewModel extends BaseModel{
  NavigationService _navigationService = locator<NavigationService>();

  Future verifySMS({ String field1, String field2, String field3, String field4 }) async {
    _navigationService.navigatorKey.currentState.pushReplacementNamed(Routes.HOME_SCREEN);
  }
}