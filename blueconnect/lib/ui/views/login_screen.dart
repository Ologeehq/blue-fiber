import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/veiwModels/signInViewModel.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:blueconnectapp/ui/widgets/input_label.dart';
import 'package:blueconnectapp/ui/widgets/page_description.dart';
import 'package:blueconnectapp/ui/widgets/page_title.dart';
import 'package:blueconnectapp/ui/widgets/round_btn.dart';
import 'package:flutter/material.dart';
import 'base_view.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(builder: (context, model, child) => Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: model.state == ViewState.Busy ? MediaQuery.of(context).size.height : null,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: model.state == ViewState.Busy ?
          Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(KPrimaryColor2),),)

          : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80,),

              PageTitle(title: "Sign in",),

              SizedBox(height: 10,),

              PageDescription(description: "Sign in to continue.",),

              SizedBox(
                height: 50,
              ),

              InputLabel(label: "EMAIL",),

              TextFormField(
                controller: _email,
              ),

              SizedBox(height: 30,),

              InputLabel(label: "PASSWORD",),

              TextFormField(
                obscureText: true,
                controller: _password,
              ),

              SizedBox(height: 30,),

              GestureDetector(
                onTap: (){
                  model.navigateToForgotPassword();
                },
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: KPrimaryColor2,
                      fontFamily: "PoppinsSemiBold"
                  ),
                ),
              ),

              SizedBox(height: 30,),

              RoundButton(btnTitle: "SIGN IN", onTap: () async{
                  await model.login(email: _email.text, password: _password.text);
              },),

              SizedBox(height: 25,),

              GestureDetector(
                onTap: (){
                  model.navigateToRegister();
                },
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  color: KSecondaryColorDarkShade,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                          TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                  color: KPrimaryColor2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              )
                          )
                        ]
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
