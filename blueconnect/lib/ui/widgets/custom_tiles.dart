import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String label;
  final Function onTap;

  const CustomTile({ Key key, this.label, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: Container(
        padding:
        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: KPrimaryColor2),
        child: Icon(
          Icons.group_add,
          color: KPrimaryWhite,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'PoppinsRegular',
          fontSize: 18,
        ),
      ),
    );
  }
}
