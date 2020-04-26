import 'package:flutter/material.dart';

const String kAppName = 'BakBak';

const Color kPrimaryColor = Color(0xFF212121);
const Color kSecondaryColor = Color(0xFFB1B1B1);

const Color kTitleTextColor = Color(0xFFDADADA);

const TextStyle kWelcomeAppTitleStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    color: Colors.white);
const TextStyle kAppTitleStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    color: Colors.white);
const TextStyle kSignInLabelStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
const TextStyle kCreatorStyle = TextStyle(
  fontSize: 31.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
const TextStyle kSendButtonTextStyle = TextStyle(
  color: kPrimaryColor,
  fontFamily: 'Lato',
  fontWeight: FontWeight.w800,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
  labelStyle: TextStyle(fontSize: 18.0, fontFamily: 'Lato'),
);
