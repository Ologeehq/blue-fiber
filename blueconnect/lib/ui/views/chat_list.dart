import 'package:blueconnectapp/core/veiwModels/notificationview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';

import 'base_view.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationViewModel>(
      onModelReady: (model) {
        model.pullChats();
      },
      builder: (context, model, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: model.chats.length > 0 ?
          ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: model.chats.length,
            itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: KPrimaryColor2,
                    child: Text(model.chats[index].user1 == model.username
                        ? model.chats[index].user2.substring(0,1).toUpperCase()
                        : model.chats[index].user1.substring(0,1).toUpperCase()),
                  ),
                  title: Text(
                    model.chats[index].user1 == model.username
                        ? model.chats[index].user2
                        : model.chats[index].user1,
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      // Go to the chat screen
                      model.navigateToChatScreen(
                          userId: model.chats[index].users[0] == model.userId ? model.chats[index].users[1] : model.chats[index].users[0],
                          username: model.chats[index].user1 == model.username
                              ? model.chats[index].user2
                              : model.chats[index].user1,
                          imageSrc: '',
                      );
                    },
                    icon: Icon(
                      Icons.message,
                      color: KPrimaryColor2,
                    ),
                  ),
                  onTap: () {
                    //  Show the user details

                  },
                ))
        : Center(
          child: Image(
              width: 250,
              height: 250,
              fit: BoxFit.contain,
              image: AssetImage(
                "assets/images/empty.png",
              )),
        ),
      ),
    );
  }
}
