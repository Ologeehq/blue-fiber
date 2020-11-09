import 'package:blueconnectapp/core/veiwModels/settingsview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:blueconnectapp/ui/widgets/input_label.dart';
import 'package:blueconnectapp/ui/widgets/page_description.dart';
import 'package:blueconnectapp/ui/widgets/page_title.dart';
import 'package:blueconnectapp/ui/widgets/round_btn.dart';
import 'package:flutter/material.dart';
import '../../core/enum/view_state.dart';
import 'base_view.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor2,
          title: Text(
            "Settings",
            style: TextStyle(fontFamily: 'PoppinsRegular'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: model.state == ViewState.Busy
                ? MediaQuery.of(context).size.height
                : null,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(KPrimaryColor2),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PageTitle(
                        title: "Settings",
                      ),
                      PageDescription(
                        description: "Update your account password here.",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InputLabel(
                        label: "PASSWORD",
                      ),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InputLabel(
                        label: "CONFIRM PASSWORD",
                      ),
                      TextFormField(
                        controller: _cpassword,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      RoundButton(
                        btnTitle: "UPDATE PASSWORD",
                        onTap: () async {
                          if (_password.text == _cpassword.text) {
                            print('match');
                            await model.changePassword(_cpassword.text.trim());
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
