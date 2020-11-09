import 'package:blueconnectapp/core/veiwModels/chatscreenview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';

import 'base_view.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String imageSrc;
  final String userId;

  const ChatScreen({
    Key key,
    @required this.username,
    @required this.imageSrc,
    @required this.userId
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatScreenViewModel>(
        onModelReady: (model){
            model.setChatId(username: model.username, friend: widget.username, friendId: widget.userId);
            model.setUpChat();
            model.pullChats();
        },
        onModelDisposed: (model){
          _message.dispose();
        },
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: KPrimaryColor2,
            leading: FlatButton(
              shape: CircleBorder(),
              padding: EdgeInsets.only(left: 2.0),
              onPressed: () {
                model.navigateBack();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: KPrimaryWhite,
                    size: 24.0,
                  ),
                  CircleAvatar(
                    radius: 15,
                    child: Text(
                      widget.username.substring(0,1).toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'PoppinsBold',
                      ),
                    ),
                  )
                ],
              ),
            ),
            title: InkWell(
              highlightColor: KSecondaryColorGrey.withOpacity(0.03),
              // splashColor: KSecondaryColorGrey,
              onTap: () {
                // Show the user details
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Text(
                  widget.username,
                  style: TextStyle(
                      color: KPrimaryWhite,
                      fontFamily: 'PoppinsRegular'
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: PopupMenuButton(
                    child: Icon(
                      Icons.more_vert,
                      color: KPrimaryWhite,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.person, color: KSecondaryColorDarkGrey,),
                              SizedBox(width: 10,),
                              Text("View user"),
                            ],
                          ),
                          onTap: () {
                            // view user details
                          },
                        ),
                      ),
                    ]),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Flexible(
                    child: Container(
                      child: ListView.separated(
                          shrinkWrap: false,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemCount: model.chats.length,
                          itemBuilder: (context, index) => Container(
                            alignment: model.chats[index].sender != model.user
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: KPrimaryColor2.withOpacity(.7),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: .5,
                                      spreadRadius: 1.0,
                                      color: Color(0x22000000),
                                      offset: Offset(1, 1))
                                ],
                                borderRadius: model.chats[index].sender != model.user
                                    ? BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )
                                    : BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(model.chats[index].sender != model.user
                                      ? model.chats[index].username
                                      : 'You',
                                    style: TextStyle(
                                      color: KPrimaryWhite,
                                      fontFamily: 'PoppinsRegular'
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    model.chats[index].message,
                                    textAlign: model.chats[index].sender != model.user
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    style: TextStyle(
                                        color: KPrimaryWhite,
                                        fontSize: 16,
                                        fontFamily: 'PoppinsRegular'),
                                  ),
                                  Divider(),
                                  // Text(
                                  //   '${model.chats[index].timeSent.hour}:${model.chats[index].timeSent.minute} ',
                                  //   textAlign: model.chats[index].sender != model.user
                                  //       ? TextAlign.left
                                  //       : TextAlign.right,
                                  //   style: TextStyle(
                                  //       color: KPrimaryWhite, fontSize: 10),
                                  // ),
                                ],
                              ),
                            ),
                          )),
                    )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color: KPrimaryWhite),
                          child: Row(
                            children: [
                              IconButton(
                                splashRadius: 5,
                                padding: EdgeInsets.all(0.0),
                                disabledColor: KSecondaryColorGrey,
                                icon: Icon(Icons.attach_file),
                                onPressed: () {
                                  // Open file for selecting images
                                },
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: _message,
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.send,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0.0),
                                    hintText: "Write a message",
                                    hintStyle: TextStyle(
                                        color: KSecondaryColorDarkShade,
                                        fontSize: 16,
                                        fontFamily: 'PoppinsRegular'),
                                    counterText: '',
                                  ),
                                  maxLength: 100,
                                  keyboardType: TextInputType.multiline,
                                  keyboardAppearance: Brightness.dark,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: KPrimaryColor2,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(1.0,
                                            1.0), // shadow direction: bottom right
                                      )
                                    ]),
                                child: IconButton(
                                  splashRadius: 5,
                                  icon: Icon(Icons.send),
                                  color: KPrimaryWhite,
                                  onPressed: () {
                                    //  Send message
                                    if(_message.text.isNotEmpty){
                                      model.sendMessage(message: _message.text);
                                      _message.clear();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),);
  }
}
