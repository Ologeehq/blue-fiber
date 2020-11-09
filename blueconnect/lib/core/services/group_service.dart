import 'dart:async';
import 'package:blueconnectapp/core/models/chat.dart';
import 'package:blueconnectapp/core/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupService {

  final CollectionReference _groupCollection = FirebaseFirestore.instance.collection("groups");

  // Create a stream controller that would broadcast our groups
  final StreamController<List<Group>> _groupController = StreamController<List<Group>>.broadcast();

  final StreamController<List<Chat>> _groupChatController = StreamController<List<Chat>>.broadcast();

  FieldValue get timeStamp => FieldValue.serverTimestamp();

  // Create Group
  Future createGroup(Group group) async{
    try{
      await _groupCollection.doc(group.id).set(group.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

  // Update Group
  Future updateGroup(Group group) async {
    try{
      await _groupCollection.doc(group.id).update(group.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

  // Get a group
  Future getGroup({ String groupId}) async {
    try{
      var groupData = await _groupCollection.doc(groupId).get();
      return Group.fromMap(groupData.data());
    }catch(e){
      return e.message;
    }
  }

  //   Delete a group
  Future deleteGroup ({ String groupId }) async {
    try{
      await _groupCollection.doc(groupId).delete();
      return true;
    }catch(e){
      return e.message;
    }
  }

  //   Get all groups [STREAM]
  Stream getGroups(){
      // Request for the snapshots
      _groupCollection.snapshots().listen((groupSnapshots) {
        //Check if it has data
        if(groupSnapshots.docs.isNotEmpty){
          var groups = groupSnapshots.docs.map((snapshot) => Group.fromMap(snapshot.data())).toList();

          _groupController.add(groups);
        }
      });

      // Return the stream underlying our _groupController
      return _groupController.stream;
  }

  // Get the group chats
  Stream getGroupChats({ String groupId }){
    // Request for snapshots
    _groupCollection.doc(groupId).collection("chats").orderBy("timeSent", descending: false).snapshots().listen((groupChatSnapshots) {
      //  Check if the snapshot has data
      if(groupChatSnapshots.docs.isNotEmpty){
        // var chats = groupChatSnapshots.docs.reversed.map((snapshot) => Chat.fromMap(snapshot.data())).toList();
        var chats = groupChatSnapshots.docs.map((snapshot) => Chat.fromMap(snapshot.data())).toList();
        _groupChatController.add(chats);
      }
    });

    return _groupChatController.stream;
  }

  Future addGroupChat({ Chat chat, String groupId }) async {
    try{
      await _groupCollection.doc(groupId).collection("chats").add(chat.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }
}