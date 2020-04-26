import 'package:flutter/material.dart';
import 'package:bakbak/constants.dart';
import 'package:bakbak/screens.dart/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInScreen extends StatefulWidget {
  static String id = '/sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'app_name',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
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
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showSpinner = true;
                    });
                    _handleSignIn().then((FirebaseUser user) {
                      print(user);
                      if (user != null) {
                        Navigator.pushNamedAndRemoveUntil(context,
                            ChatScreen.id, (Route<dynamic> route) => false);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }).catchError((e) {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                    });
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
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    return user;
  }
}
