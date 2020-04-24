import 'package:flutter/material.dart';
import 'package:bakbak/constants.dart';

class ChatScreen extends StatelessWidget {
  static String id = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Hero(
        tag: 'app_name',
        child: Material(
          type: MaterialType.transparency,
          child: Text(
            kAppName,
            style: kAppTitleStyle,
          ),
        ),
      )),
      body: Container(),
    );
  }
}
