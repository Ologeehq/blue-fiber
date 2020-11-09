import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/veiwModels/signUpViewModel.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:blueconnectapp/ui/widgets/input_label.dart';
import 'package:blueconnectapp/ui/widgets/page_description.dart';
import 'package:blueconnectapp/ui/widgets/page_title.dart';
import 'package:blueconnectapp/ui/widgets/round_btn.dart';
import 'package:flutter/material.dart';
import 'base_view.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      onModelReady: (model) {
        /**/
      },
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: model.state == ViewState.Busy ? MediaQuery.of(context).size.height : null,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: model.state == ViewState.Busy ?
            Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(KPrimaryColor2),),)
            : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                ),

                PageTitle(title: "Sign Up",),

                SizedBox(
                  height: 10,
                ),

                PageDescription(description: "Enter your information below to sign up",),

                SizedBox(
                  height: 50,
                ),

                InputLabel(
                  label: "EMAIL",
                ),

                TextFormField(
                  controller: _email,
                ),

                SizedBox(
                  height: 30,
                ),

                InputLabel(
                  label: "USERNAME",
                ),
                TextFormField(
                  controller: _username,
                ),
                SizedBox(
                  height: 30,
                ),
                InputLabel(
                  label: "PHONE",
                ),
                TextFormField(
                  controller: _phone,
                ),
                SizedBox(
                  height: 30,
                ),
                InputLabel(
                  label: "PASSWORD",
                ),
                TextFormField(
                  obscureText: true,
                  controller: _password,
                ),
                SizedBox(
                  height: 30,
                ),
                RoundButton(
                  onTap: () async{
                    await model.signUp(
                        email: _email.text,
                        password: _password.text,
                        fullName: _username.text,
                        phone: _phone.text
                    );
                  },
                  btnTitle: "SIGN UP",
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    //  Add a function in the view model to navigate to the login
                    model.navigateToLogin();
                  },
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                                color: KSecondaryColorDarkShade,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                                color: KPrimaryColor2,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
