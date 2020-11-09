import 'package:flutter/foundation.dart';

class AppUser{
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String quote;

  AppUser({
    @required this.id,
    @required this.fullName,
    @required this.email,
    @required this.phone,
    this.quote
  });

  // Name constructor for serializing the data from firebase
  AppUser.fromData(Map<String, dynamic> data)
        :id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        phone = data['phone'],
        quote = data['quote'];

   // Transform data to json
   Map<String, dynamic>  toJson(){
     return {
       "id": id,
       "fullName" : fullName,
       "email" : email,
       "phone" : phone,
       "quote" : quote ?? '',
     };
   }

}