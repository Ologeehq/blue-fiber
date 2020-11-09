import 'package:flutter/foundation.dart';

class Channel{
  final String id;
  final String name;
  final String description;
  final String logo;
  final List<String> users;
  final String admin;
  final String channelLink;
  final bool public;
  final bool premium;
  final String channelKey;
  final String price;

  Channel({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.users,
    @required this.admin,
    @required this.public,
    @required this.premium,
    @required this.logo,
    this.channelKey,
    this.channelLink,
    this.price
  });

  Channel.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        description = data['description'],
        users = [...data['users']],
        admin = data['admin'],
        logo  = data['logo'],
        public = data['public'],
        premium = data['premium'],
        channelKey = data['channelKey'],
        channelLink = data['channelLink'],
        price = '${data['price']}';

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'name' : name,
      'logo' : logo,
      'description' : description,
      'users' : users,
      'admin' : admin,
      'public' : public,
      'premium' : premium,
      'channelKey' : channelKey,
      'channelLink' : channelLink,
      'price' : price,
    };
  }
}