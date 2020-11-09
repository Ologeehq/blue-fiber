import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/veiwModels/feedsview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';

import 'base_view.dart';
import 'package:flutter/material.dart';

class FeedsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<FeedsViewModel>(
      onModelReady: (model) => model.setFeeds(),
      builder: (context, model, child) => RefreshIndicator(
        color: KPrimaryColor2,
        onRefresh: model.setFeeds,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: model.state == ViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(KPrimaryColor2),),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: model.feeds.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(
                          model.feeds[index].title,
                          style: TextStyle(
                            fontFamily: 'PoppinsBold',
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          //  Go to the web view
                          model.navigateToNewsPage(index);
                        },
                        subtitle: Text(model.feeds[index].description ?? ''),
                      )),
        ),
      ),
    );
  }
}
