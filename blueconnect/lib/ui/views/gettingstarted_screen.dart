import 'package:blueconnectapp/core/veiwModels/gettingstartedview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';

import 'base_view.dart';
import 'package:flutter/material.dart';

class GettingStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<GettingStartedViewModel>(builder: (context, model, chile ) => Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                child: Icon(
                  Icons.chat,
                  color: KPrimaryColor2,
                  size: 100,
                ),
              ),

              Text(
                "Blue Connect",
                style: TextStyle(
                    // color: Color(0xFF33BB80),
                    color: KPrimaryColor2,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: "PoppinsRegular"
                ),
              ),

              SizedBox(
                height: 100,
              ),

              Text(
                "Simple Secure",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "PoppinsMedium"
                ),
              ),

              Text(
                "Reliable Messaging",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "PoppinsMedium"
                ),
              ),

              SizedBox(
                height: 80,
              ),

              GestureDetector(
                onTap: (){
                  model.navigateToLogin();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  decoration: BoxDecoration(
                    color: KPrimaryColor2,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          color: KPrimaryWhite,
                          fontFamily: "PoppinsRegular",
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  model.navigateToSignIn();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: KSecondaryColorDarkGrey
                      )
                  ),
                  child: Container(
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          color: KSecondaryColorDarkGrey,
                          fontFamily: "PoppinsRegular",
                          fontWeight: FontWeight.w800
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
