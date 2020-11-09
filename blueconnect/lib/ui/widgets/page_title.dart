import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;

  const PageTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: KPrimaryColor2,
          fontSize: 24,
          fontFamily: "PoppinsSemiBold"),
    );
  }
}
