import 'dart:async';
import 'package:blueconnectapp/core/models/chat.dart';
import 'package:blueconnectapp/core/models/community.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CommunityService {

  final CollectionReference _communityCollection = FirebaseFirestore.instance.collection("communities");

  // Create a stream controller that would broadcast our community
  final StreamController<List<Community>> _communityController = StreamController<List<Community>>.broadcast();

  final StreamController<List<Chat>> _communityChats = StreamController<List<Chat>>.broadcast();

  FieldValue get timeStamp => FieldValue.serverTimestamp();

  // Create community
  Future createCommunity(Community community) async{
    try{
      await _communityCollection.doc(community.id).set(community.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

  // Update community
  Future updateCommunity(Community community) async {
    try{
      await _communityCollection.doc(community.id).update(community.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

  // Get a community
  Future getCommunity({ String communityId}) async {
    try{
      var communityData = await _communityCollection.doc(communityId).get();
      return Community.fromMap(communityData.data());
    }catch(e){
      return e.message;
    }
  }

  //   Delete a community
  Future deleteCommunity ({ String communityId }) async {
    try{
      await _communityCollection.doc(communityId).delete();
      return true;
    }catch(e){
      return e.message;
    }
  }

  //   Get all communities [STREAM]
  Stream getCommunities(){
      // Request for the snapshots
      _communityCollection.snapshots().listen((communitySnapshots) {
        // Check if it has data
        if(communitySnapshots.docs.isNotEmpty){
          var community = communitySnapshots.docs.map((snapshot) => Community.fromMap(snapshot.data())).toList();
          _communityController.add(community);
        }
      });

      // Return the stream underlying our _communityController
      return _communityController.stream;
  }
  
  Stream getCommunityChats({ String communityId }){
    // Request for the snapshots
    _communityCollection
        .doc(communityId)
        .collection("chats")
        .orderBy("timeSent", descending: false)
        .snapshots()
        .listen((communityChatSnapshots) {
      // Check if it has data
      if(communityChatSnapshots.docs.isNotEmpty){
        var chats = communityChatSnapshots.docs.map((snapshot) => Chat.fromMap(snapshot.data())).toList();
        _communityChats.add(chats);
      }
    });

    // Return the stream underlying our _communityChat
    return _communityChats.stream;
  }

  Future addCommunityChat({ Chat chat, String communityId }) async {
    try{
      await _communityCollection.doc(communityId).collection("chats").add(chat.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }
}