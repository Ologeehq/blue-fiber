
import 'dart:convert';

import 'package:blueconnectapp/core/models/feeds.dart';
import 'package:http/http.dart';

class NewsService {
  static const String _apiKey = '4cc11890aafa421aa1b5f3d0017c2ebe';

  static const String _url = 'http://newsapi.org/v2/top-headlines?country=ng&apiKey=$_apiKey';

  // Fetch the news from the api
  Future getNews() async {
    try{
      Response response = await get(_url);

      var responseData = jsonDecode(response.body);

      List<Feeds> data = [];

      if(response.statusCode == 200){
          data = [...responseData['articles'].map((e){
            return Feeds(
              title: e['title'],
              description: e['description'],
              image: e['urlToImage'],
              publishedAt: DateTime.tryParse(e['publishedAt']).toUtc(),
              url: e['url']
            );
          }).toList()];
      }
      return data;
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }
}