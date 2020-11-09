import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/veiwModels/groupview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'base_view.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<GroupViewModel>(
      onModelReady: (model) {
        model.listenToGroups();
      },
      builder: (context, model, child) => Container(
        height: model.state == ViewState.Busy
            ? MediaQuery.of(context).size.height
            : null,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: model.combined.length == 0
            ? Center(
                child: Image(
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                    image: AssetImage(
                      "assets/images/empty.png",
                    )),
              )
            : model.state == ViewState.Busy ?
                  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(KPrimaryColor2),),)
                : ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: model.combined.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                        model.combined[index].name,
                        style: TextStyle(
                            color: KSecondaryColorLightDark,
                            fontFamily: 'PoppinsSemiBold'),
                      ),
                      trailing: model.combined[index].admin != model.user &&
                          !model.combined[index].users.contains(model.user)
                          ? FlatButton(
                              color: KPrimaryColor2,
                              onPressed: () async{
                                // Add the user to the group
                                await model.addUserToGroup(groupIndex: index );
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
                        if (model.combined[index].admin == model.user ||
                            model.combined[index].users.contains(model.user)) {
                              model.navigateToGroupChat(
                                  groupIndex: index,
                                  chatTitle: model.combined[index].name,
                                  imageSrc: model.combined[index].logo,
                              );
                        }

                       // Else if the group is closed or paid open another page

                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          model.combined[index].logo,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.combined[index].description,
                            style: TextStyle(
                                color: KSecondaryColorLightDark,
                                fontFamily: 'PoppinsRegular'),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(25))
                            ),
                            child: Text(
                              model.combined[index].type.toString().toUpperCase(),
                              style: TextStyle(
                                color: KSecondaryColorGrey,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
      ),
    );
  }
}
