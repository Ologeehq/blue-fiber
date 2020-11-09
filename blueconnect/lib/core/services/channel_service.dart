import 'dart:async';
import 'package:blueconnectapp/core/models/channel.dart';
import 'package:blueconnectapp/core/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChannelService {

  final CollectionReference _channelCollection = FirebaseFirestore.instance.collection("channels");

  // Create a stream controller that would broadcast our channel
  final StreamController<List<Channel>> _channelController = StreamController<List<Channel>>.broadcast();

  final StreamController<List<Chat>> _channelChatController = StreamController<List<Chat>>.broadcast();

  FieldValue get timeStamp => FieldValue.serverTimestamp();

  // Create Channel
  Future createChannel(Channel channel) async{
    try{
      await _channelCollection.doc(channel.id).set(channel.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

  // Update Channel
  Future updateChannel(Channel channel) async {
    try{
      await _channelCollection.doc(channel.id).update(channel.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

  // Get a Channel
  Future getChannel({ String channelId}) async {
    try{
      var channelData = await _channelCollection.doc(channelId).get();
      return Channel.fromMap(channelData.data());
    }catch(e){
      return e.message;
    }
  }

  //   Delete a channel
  Future deleteChannel ({ String channelId }) async {
    try{
      await _channelCollection.doc(channelId).delete();
      return true;
    }catch(e){
      return e.message;
    }
  }

  //   Get all groups [STREAM]
  Stream getChannels(){
    // Request for the snapshots
    _channelCollection.snapshots().listen((chanelSnapshots) {
      //Check if it has data
      if(chanelSnapshots.docs.isNotEmpty){
        var channels = chanelSnapshots.docs.map((snapshot) => Channel.fromMap(snapshot.data())).toList();
        _channelController.add(channels);
      }
    });

    // Return the stream underlying our _groupController
    return _channelController.stream;
  }

  // Get the channel chats
  Stream getChannelChats({ String channelId }){
    // Request for snapshots
    _channelCollection.doc(channelId)
        .collection("chats").orderBy("timeSent", descending: false)
        .snapshots()
        .listen((groupChatSnapshots) {
      //  Check if the snapshot has data
      if(groupChatSnapshots.docs.isNotEmpty){
        // var chats = groupChatSnapshots.docs.reversed.map((snapshot) => Chat.fromMap(snapshot.data())).toList();
        var chats = groupChatSnapshots
            .docs
            .map((snapshot) => Chat.fromMap(snapshot.data())).toList();
        _channelChatController.add(chats);
      }
    });

    return _channelChatController.stream;
  }

  Future addChannelChat({ Chat chat, String channelId }) async {
    try{
      await _channelCollection.doc(channelId).collection("chats").add(chat.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }
}