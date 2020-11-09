import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class PageDescription extends StatelessWidget {
  final String description;

  const PageDescription({Key key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
          color: KSecondaryColorDarkShade,
          fontFamily: "PoppinsMedium"
      ),
    );
  }
}
