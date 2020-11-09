import 'package:flutter/foundation.dart';

class ChatSet{
  final String chatId;
  final String user1;
  final String user2;
  final List<String> users;

  ChatSet({ @required this.user1, @required this.user2, @required this.chatId, @required this.users });

  ChatSet.fromMap(Map<String, dynamic> data)
    : chatId  =   data['chatId'],
      user1   =   data['user1'],
      user2   =   data['user2'],
      users   =   [...data['users']];

  Map<String, dynamic> toJson(){
    return {
      'chatId' :  chatId,
      'users'  :  users,
      'user1'  :  user1,
      'user2'  :  user2,
    };
  }
}