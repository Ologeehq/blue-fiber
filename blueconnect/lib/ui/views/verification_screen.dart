import 'package:blueconnectapp/core/veiwModels/verificationview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';

import 'base_view.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController _field1 = TextEditingController();
  TextEditingController _field2 = TextEditingController();
  TextEditingController _field3 = TextEditingController();
  TextEditingController _field4 = TextEditingController();

  @override
  void dispose() {
    _field1.dispose();
    _field2.dispose();
    _field3.dispose();
    _field4.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<VerificationViewModel>(builder:  (context, model, child) => Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80,),

              Text(
                "Verification",
                style: TextStyle(
                    color: KPrimaryColor2,
                    fontSize: 24,
                    fontFamily: "PoppinsSemiBold"
                ),
              ),

              SizedBox(height: 10,),

              Text(
                "We have sent you an sms with a code to the number you provided.",
                style: TextStyle(
                    color: KSecondaryColorDarkShade,
                    fontFamily: "PoppinsMedium"
                ),
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: _field1,
                    ),
                  ),

                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: _field2,
                    ),
                  ),

                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: _field3,
                    ),
                  ),

                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: _field4,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 80,),

              GestureDetector(
                onTap: () async{
                  model.verifySMS(field1: _field1.text, field2: _field2.text, field3: _field3.text, field4: _field4.text);
                },
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
                          fontWeight: FontWeight.w500
                      ),
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
