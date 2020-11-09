import 'package:blueconnectapp/core/veiwModels/forgotpasswordview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';

import 'base_view.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 60,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: KSecondaryColorDarkShade,
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: KPrimaryColor2,
                      fontSize: 24,
                      fontFamily: "PoppinsSemiBold"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We have sent you an sms with a code to the number you provided.",
                  style: TextStyle(
                      color: KSecondaryColorDarkShade,
                      fontFamily: "PoppinsMedium"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    decoration: BoxDecoration(
                      color: KPrimaryColor2,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      child: Text(
                        "VERIFY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: KPrimaryWhite,
                            fontFamily: "PoppinsRegular",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
