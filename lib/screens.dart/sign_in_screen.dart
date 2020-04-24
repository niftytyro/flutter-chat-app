import 'package:flutter/material.dart';
import 'package:bakbak/constants.dart';
import 'package:bakbak/screens.dart/chat_screen.dart';

class SignInScreen extends StatefulWidget {
  static String id = '/sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Hero(
                      tag: 'app_name',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(kAppName, style: kWelcomeAppTitleStyle),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
                        Text(
                          'by',
                          style: TextStyle(
                              color: kTitleTextColor,
                              fontSize: 18.0,
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10.0),
                        Text('Udasi', style: kCreatorStyle),
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ChatScreen.id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF555555),
                    borderRadius: BorderRadius.circular(3.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(offset: Offset(1, 1), blurRadius: 2),
                      BoxShadow(
                          color: Color(0xFF666666),
                          offset: Offset(-1, -1),
                          blurRadius: 2)
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 2.0, 2.0, 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Sign In with',
                        style: kSignInLabelStyle,
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Image(
                        image: AssetImage('assets/images/google_logo.png'),
                        width: 50.0,
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
