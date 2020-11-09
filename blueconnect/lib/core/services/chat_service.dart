import 'dart:async';

import 'package:blueconnectapp/core/models/chat.dart';
import 'package:blueconnectapp/core/models/chat_block.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {

  final CollectionReference _chatCollection = FirebaseFirestore.instance.collection("chats");

  final StreamController<List<ChatSet>> _chatController = StreamController<List<ChatSet>>.broadcast();

  final StreamController<List<Chat>> _personalChatController = StreamController<List<Chat>>.broadcast();

  FieldValue get timeStamp => FieldValue.serverTimestamp();

  // Get the active chats
  Stream getActiveChats ({ String userId }){
    _chatCollection.where("users",arrayContains: userId).snapshots().listen((activeChatSnapshots) {
      if(activeChatSnapshots.docs.isNotEmpty){
        var activeChats = activeChatSnapshots.docs.map((snapshots) => ChatSet.fromMap(snapshots.data())).toList();
        _chatController.add(activeChats);
      }
    });

    return _chatController.stream;
  }

  // Initiate personal chat
  Future initiatePersonalChat({ String chatId, ChatSet chatSet }) async {
    try{
        // Check if the chat has been created before and if not
        if(!await getChat(chatId: chatId)){
            // Create the chat
           await _chatCollection.doc(chatId).set(chatSet.toJson());
        }
        return true;
    }catch(e){
      return e.message;
    }
  }

  // Get a particular chat
  Future getChat({ String chatId }) async{
    try{
      var chatData = await _chatCollection.doc(chatId).get();
      return chatData.data() != null && chatData.data().length > 0;
    }catch(e){
      return e.message;
    }
  }

  // Load one on one chats
  Stream loadChats ({ String chatId }){
    _chatCollection.doc(chatId)
        .collection("chats")
        .orderBy("timeSent", descending: false)
        .snapshots()
        .listen((personalChatSnapshots) {
      if(personalChatSnapshots.docs.isNotEmpty){
        var chats = personalChatSnapshots.docs.map((snapshot) => Chat.fromMap(snapshot.data())).toList();
        _personalChatController.add(chats);
      }
    });

    return _personalChatController.stream;
  }

  // Send message to friend
  Future messageFriend({ Chat chat, String chatId }) async {
    try{
      await _chatCollection.doc(chatId).collection("chats").add(chat.toJson());
      return true;
    }catch(e){
      return e.message;
    }
  }

}