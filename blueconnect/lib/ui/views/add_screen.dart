import 'package:blueconnectapp/core/enum/pricing_type.dart';
import 'package:blueconnectapp/core/enum/view_state.dart';
import 'package:blueconnectapp/core/enum/visibility.dart';
import 'package:blueconnectapp/core/veiwModels/addview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'package:blueconnectapp/ui/widgets/input_label.dart';
import 'package:blueconnectapp/ui/widgets/round_btn.dart';

import 'base_view.dart';

import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  final String category;

  const AddScreen({ Key key, this.category }) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _logo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddViewModel>(
      onModelReady: (model){

      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor2,
          leading: IconButton(
            onPressed: () {
              model.navigateBack();
            },
            icon: Icon(
              Icons.arrow_back,
            ),
            color: KPrimaryWhite,
          ),
          title: Text(
            "Create ${widget.category}",
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              color: KPrimaryWhite,
              fontSize: 18,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: model.state == ViewState.Busy ? MediaQuery.of(context).size.height : null,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:model.state == ViewState.Busy ?
                Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(KPrimaryColor2),),)
            : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputLabel(
                  label: "NAME",
                ),
                TextFormField(
                  style: TextStyle(
                      color: KSecondaryColorDarkShade,
                      fontFamily: 'PoppinsRegular',
                      fontSize: 16),
                  controller: _name,
                  decoration: InputDecoration(
                    hintText: 'Enter ${widget.category} name.',
                    hintStyle: TextStyle(
                      color: KSecondaryColorDarkGrey,
                      fontFamily: 'PoppinsRegular',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InputLabel(
                  label: "DESCRIPTION",
                ),
                TextFormField(
                  style: TextStyle(
                      color: KSecondaryColorDarkShade,
                      fontFamily: 'PoppinsRegular',
                      fontSize: 16),
                  controller: _description,
                  decoration: InputDecoration(
                    hintText: 'Enter ${widget.category} description.',
                    hintStyle: TextStyle(
                      color: KSecondaryColorDarkGrey,
                      fontFamily: 'PoppinsRegular',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InputLabel(
                  label: "LOGO",
                ),
                TextFormField(
                  style: TextStyle(
                      color: KSecondaryColorDarkShade,
                      fontFamily: 'PoppinsRegular',
                      fontSize: 16),
                  controller: _logo,
                  decoration: InputDecoration(
                    hintText: 'Select ${widget.category} logo.',
                    hintStyle: TextStyle(
                      color: KSecondaryColorDarkGrey,
                      fontFamily: 'PoppinsRegular',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                widget.category != 'Community'? InputLabel(
                  label: "VISIBILITY",
                ): Container(),
                widget.category != 'Community'? Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Public",
                            style: TextStyle(
                                color: KSecondaryColorLightDark,
                                fontFamily: 'PoppinsRegular'
                            ),
                          ),
                          leading: Radio(
                            activeColor: KPrimaryColor2,
                            value: Privacy.Public,
                            groupValue: model.character,
                            onChanged: (value) {
                              model.setPrivacy(value);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Private",
                            style: TextStyle(
                                color: KSecondaryColorLightDark,
                                fontFamily: 'PoppinsRegular'
                            ),
                          ),
                          leading: Radio(
                            activeColor: KPrimaryColor2,
                            value: Privacy.Private,
                            groupValue: model.character,
                            onChanged: (value) {
                              model.setPrivacy(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ): Container(),
                SizedBox(
                  height: 30,
                ),
                widget.category != 'Community'? InputLabel(
                  label: "PREMIUM",
                ): Container(),
                widget.category != 'Community'? Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Paid",
                            style: TextStyle(
                                color: KSecondaryColorLightDark,
                                fontFamily: 'PoppinsRegular'),
                          ),
                          leading: Radio(
                            activeColor: KPrimaryColor2,
                            value: Pricing.Premium,
                            groupValue: model.pricing,
                            onChanged: (value) {
                              model.setPricing(value);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Free",
                            style: TextStyle(
                                color: KSecondaryColorLightDark,
                                fontFamily: 'PoppinsRegular'),
                          ),
                          leading: Radio(
                            activeColor: KPrimaryColor2,
                            value: Pricing.Free,
                            groupValue: model.pricing,
                            onChanged: (value) {
                              model.setPricing(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ): Container(),

                SizedBox(
                  height: 50,
                ),

                RoundButton(
                  btnTitle: "CREATE ${widget.category.toUpperCase()}",
                  onTap: () async{
                    switch(widget.category){
                        case 'Group':
                            await model.addGroup(name: _name.text, description: _description.text, logo: _logo.text);
                            break;
                        case 'Channel':
                            await model.addChannel(name: _name.text, description: _description.text, logo: _logo.text);
                            break;
                        case 'Community':
                            await model.addCommunity(name: _name.text, description: _description.text, logo: _logo.text);
                            break;
                        default:
                            break;
                    }
                    // Pop the context and go back to the home screen.
                    model.navigateBack();
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
