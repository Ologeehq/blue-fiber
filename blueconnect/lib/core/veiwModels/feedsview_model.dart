import 'package:blueconnectapp/core/constants/route_paths.dart';
import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/models/feeds.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:blueconnectapp/core/services/news_service.dart';
import 'package:blueconnectapp/locator.dart';

import 'base_model.dart';

class FeedsViewModel extends BaseModel{
  // Add the navigator service
  NavigationService _navigationService = locator<NavigationService>();
  NewsService _newsService = locator<NewsService>();

  List<Feeds> feeds;

  Future setFeeds() async{
    //Set the state to busy
    setState(ViewState.Busy);

    feeds = await _newsService.getNews();

    notifyListeners();
    // Set the state back to idle
    setState(ViewState.Idle);
  }

  void navigateToNewsPage(int id){
    _navigationService.navigatorKey.currentState.pushNamed(Routes.WEB_SCREEN, arguments: feeds[id].url);
  }


}