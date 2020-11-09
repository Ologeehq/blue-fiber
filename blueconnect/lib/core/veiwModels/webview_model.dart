import 'base_model.dart';

class WebViewModel extends BaseModel{
  bool isLoading = true;

  void finishLoading(){
    isLoading = false;
    notifyListeners();
  }

  void startLoading(){
    isLoading = true;
    notifyListeners();
  }

}