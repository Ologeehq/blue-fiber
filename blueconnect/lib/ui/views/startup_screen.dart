import 'package:blueconnectapp/core/veiwModels/startupview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'base_view.dart';

class StartUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(builder: (context, model, child) => Scaffold(
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
                  model.navigateToGetStarted();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  decoration: BoxDecoration(
                    color: KPrimaryColor2,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(
                          color: KPrimaryWhite,
                          fontFamily: "PoppinsRegular",
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 25,
              ),

              GestureDetector(
                onTap: (){
                  model.navigateToSignIn();
                },
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              color: KSecondaryColorDarkShade,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      TextSpan(
                          text: "Sign in",
                          style: TextStyle(
                              color: KPrimaryColor2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      )
                    ]
                )
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
