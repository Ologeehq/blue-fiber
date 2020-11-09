import 'package:blueconnectapp/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection("users");

  // Create a user
  Future createUser(AppUser user) async {
    try{
      await _usersCollection.doc(user.id).set(user.toJson());
    }catch(e){
      return e.message;
    }
  }

  // Get a particular user
  Future getUser({ String uid }) async {
    try{
      var userData = await _usersCollection.doc(uid).get();
      return AppUser.fromData(userData.data());
    }catch(e){
      return e.message;
    }
  }

  // Update user information
  Future updateUser(AppUser user) async {
    try{
      await _usersCollection.doc(user.id).update(user.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

  // Search for user
  Future searchForUser({ String username }) async {
    try{
      var userData = await _usersCollection.where("fullName", isEqualTo: username).get();
      return AppUser.fromData(userData.docs[0].data());
    }catch(e){
      return e.message;
    }
  }
}