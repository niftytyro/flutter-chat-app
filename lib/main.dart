import 'package:flutter/material.dart';
import 'package:bakbak/constants.dart';
import 'package:bakbak/screens.dart/sign_in_screen.dart';
import 'package:bakbak/screens.dart/chat_screen.dart';

void main() => runApp(BakBakApp());

class BakBakApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SignInScreen.id,
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
      ),
      title: kAppName,
    );
  }
}
