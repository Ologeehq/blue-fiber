import 'package:blueconnectapp/ui/views/add_screen.dart';
import 'package:blueconnectapp/ui/views/channel_screen.dart';
import 'package:blueconnectapp/ui/views/chat_screen.dart';
import 'package:blueconnectapp/ui/views/conversation_screen.dart';
import 'package:blueconnectapp/ui/views/create_screen.dart';
import 'package:blueconnectapp/ui/views/forgotpassword_screen.dart';
import 'package:blueconnectapp/ui/views/gettingstarted_screen.dart';
import 'package:blueconnectapp/ui/views/home_screen.dart';
import 'package:blueconnectapp/ui/views/login_screen.dart';
import 'package:blueconnectapp/ui/views/profile_screen.dart';
import 'package:blueconnectapp/ui/views/settings_screen.dart';
import 'package:blueconnectapp/ui/views/signup_screen.dart';
import 'package:blueconnectapp/ui/views/startup_screen.dart';
import 'package:blueconnectapp/ui/views/verification_screen.dart';
import 'package:blueconnectapp/ui/views/web_screen.dart';
import 'package:flutter/material.dart';
import 'package:blueconnectapp/core/constants/route_paths.dart';
// Set up router for the project

class XRouter {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.INDEX_SCREEN :
        return MaterialPageRoute(builder: (_) => StartUpScreen());

      case Routes.START_UP_SCREEN:
        return MaterialPageRoute(builder: (_) => GettingStartedScreen());

      case Routes.LOGIN_SCREEN:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case Routes.REGISTER_SCREEN:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case Routes.FORGOT_PASSWORD_SCREEN:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());

      case Routes.VERIFICATION_SCREEN:
        return MaterialPageRoute(builder: (_) => VerificationScreen());

      case Routes.HOME_SCREEN:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case Routes.CREATE_SCREEN:
        return MaterialPageRoute(builder: (_) => CreateScreen());

      case Routes.ADD_GROUP_SCREEN:
        var arguments = settings.arguments;
        return MaterialPageRoute(builder: (_) => AddScreen(category: arguments,));

      case Routes.PROFILE_SCREEN:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case Routes.SETTINGS_SCREEN:
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case Routes.WEB_SCREEN:
        String arguments = settings.arguments;
        return MaterialPageRoute(builder: (_) => WebScreen(url: arguments,));

      case Routes.CHAT_SCREEN:
          List<dynamic> arguments = settings.arguments;
          return MaterialPageRoute(builder: (_) => ConversationScreen(
            chatTitle: arguments[0], imageSrc: arguments[1], groupIndex: arguments[2],));

      case Routes.CHANNEL_SCREEN:
          List<dynamic> arguments = settings.arguments;
          return MaterialPageRoute(builder: (_)=> ChannelScreen(
            chatTitle: arguments[0],
            imageSrc: arguments[1],
            channelIndex: arguments[2],
          ));

      case Routes.PERSONAL_CHAT_SCREEN:
          List<dynamic> arguments = settings.arguments;
          return MaterialPageRoute(builder: (_) => ChatScreen(username: arguments[0], imageSrc: arguments[1], userId: arguments[2],));

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text("No route defined for ${settings.name}"),
          ),
        ));
    }
  }
}