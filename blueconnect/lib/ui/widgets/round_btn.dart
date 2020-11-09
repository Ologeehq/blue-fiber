import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String btnTitle;
  final Function onTap;

  const RoundButton({ Key key, this.btnTitle, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        decoration: BoxDecoration(
          color: KPrimaryColor2,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          child: Text(
            btnTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: KPrimaryWhite,
                fontFamily: "PoppinsRegular",
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
