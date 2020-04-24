import 'package:flutter/material.dart';
import 'package:bakbak/screens.dart/sign_in_screen.dart';
import 'package:bakbak/screens.dart/chat_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = '/welcome';

  bool signedIn = false;

  @override
  Widget build(BuildContext context) {
    if (signedIn == false) {
      return SignInScreen();
    } else {
      return ChatScreen();
    }
  }
}
