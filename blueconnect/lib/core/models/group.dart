import 'package:flutter/foundation.dart';

class Group{
  final String id;
  final String name;
  final String description;
  final String logo;
  final List<String> users;
  final String admin;
  final String groupLink;
  final bool public;
  final bool premium;
  final String groupKey;
  final String price;
  final String type;

  Group({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.users,
    @required this.admin,
    @required this.public,
    @required this.premium,
    @required this.logo,
    this.type = 'group',
    this.groupKey,
    this.groupLink,
    this.price
  });

  Group.fromMap(Map<String, dynamic> data)
    : id = data['id'],
      name = data['name'],
      description = data['description'],
      users = [...data['users']],
      admin = data['admin'],
      logo  = data['logo'],
      public = data['public'],
      premium = data['premium'],
      groupKey = data['groupKey'],
      groupLink = data['groupLink'],
      type = data["type"],
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
      'type' : 'group',
      'groupKey' : groupKey,
      'groupLink' : groupLink,
      'price' : price,
    };
  }
}