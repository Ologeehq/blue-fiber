import 'dart:async';

import 'package:blueconnectapp/core/dataModels/alerts/alert_request.dart';
import 'package:blueconnectapp/core/dataModels/alerts/alert_response.dart';

class DialogService {
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  // Registers the callback function. Typically to show the dialog
  void registerDialogListener(Function(AlertRequest) showDialogListener){
    _showDialogListener = showDialogListener;
  }

  // Calls the dialog listener and returns a Future that will wait for dialogComplete
  Future<AlertResponse> showDialog({ String title, String description, String buttonTitle = 'ok' }){
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(title: title, description: description, buttonTitle: buttonTitle));
    return _dialogCompleter.future;
  }

  // Completes the dialogCompleter to resume Future execution call
  void dialogComplete(AlertResponse response){
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}