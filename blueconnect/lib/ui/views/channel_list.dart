import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/veiwModels/channelview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'base_view.dart';
import 'package:flutter/material.dart';

class ChannelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ChannelViewModel>(
      onModelReady: (model) {
        model.listenToChannels();
      },
      builder: (context, model, child) => Container(
        height: model.state == ViewState.Busy
            ? MediaQuery.of(context).size.height
            : null,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: model.channels.length == 0
            ? Center(
          child: Image(
              width: 250,
              height: 250,
              fit: BoxFit.contain,
              image: AssetImage(
                "assets/images/empty.png",
              )),
        )
            :  model.state == ViewState.Busy ?
        Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(KPrimaryColor2),),)
            : ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: model.channels.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                model.channels[index].name,
                style: TextStyle(
                    color: KSecondaryColorLightDark,
                    fontFamily: 'PoppinsSemiBold'),
              ),
              trailing: model.channels[index].admin != model.user &&
                  !model.channels[index].users.contains(model.user)
                  ? FlatButton(
                color: KPrimaryColor2,
                onPressed: () async{
                  // Add the user to the channel
                  await model.addUserToChannel(channelIndex: index);
                },
                child: Text(
                  "JOIN",
                  style: TextStyle(
                    color: KPrimaryWhite,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              )
                  : null,
              onTap: () {
                //  Go to the chat screen
                if (model.channels[index].admin == model.user ||
                    model.channels[index].users.contains(model.user)) {
                      model.navigateToChannelChat(
                          channelIndex: index,
                          chatTitle: model.channels[index].name,
                          imageSrc: model.channels[index].logo);
                }
              },
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  model.channels[index].logo,
                ),
              ),
              subtitle: Text(
                model.channels[index].description,
                style: TextStyle(
                    color: KSecondaryColorLightDark,
                    fontFamily: 'PoppinsRegular'),
              ),
            )),
      ),
    );
  }
}
