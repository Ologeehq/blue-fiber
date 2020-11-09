import 'package:flutter/foundation.dart';

class Feeds{
  final String title;
  final String description;
  final String image;
  final String url;
  final DateTime publishedAt;

  Feeds({
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.url,
    @required this.publishedAt
  });

}