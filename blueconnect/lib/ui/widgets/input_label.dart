import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  final String label;

  const InputLabel({ Key key, this.label }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$label",
      style: TextStyle(
          color: KPrimaryColor2,
          fontFamily: "PoppinsBold"
      ),
    );
  }
}
