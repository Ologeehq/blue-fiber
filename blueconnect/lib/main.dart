import 'package:blueconnectapp/core/managers/dialog_manager.dart';
import 'package:blueconnectapp/core/services/navigator_service.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'locator.dart';
import './ui/router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();  //  Set up the locator
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(
                  child: widget,
                )
              ),
            ),
            navigatorKey: locator<NavigationService>().navigatorKey,
            color: KPrimaryColor2,
            title: 'Blue Connect',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.blue,
              scaffoldBackgroundColor: KPrimaryWhite,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/',
            onGenerateRoute: XRouter.generateRoute,
    );
  }
}
