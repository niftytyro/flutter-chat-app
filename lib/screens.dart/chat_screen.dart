import 'package:flutter/material.dart';
import 'package:bakbak/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
FirebaseUser _loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String message;
  TextEditingController _controller;

  Future<FirebaseUser> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _loggedInUser = user;
      }
    } catch (e) {
      print('error:');
      print(e);
    }
  }

  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((val) {
      setState(() {});
    });
    getMessagesStream();
  }

  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kAppName,
          style: kAppTitleStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: kPrimaryColor, width: 2.0),
                  bottom: BorderSide(color: kPrimaryColor, width: 2.0),
                  left: BorderSide(color: kPrimaryColor, width: 2.0),
                  right: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                borderRadius: BorderRadius.circular(35.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              padding: EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        if (value.length > 0) {
                          message = value;
                        }
                      },
                      decoration: kMessageTextFieldDecoration,
                      maxLines: 5,
                      minLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if ((message != null) || (message.length > 0)) {
                        _firestore.collection('messages').add({
                          'message': message,
                          'sender': _loggedInUser.displayName,
                          'sender_email': _loggedInUser.email,
                          'time': DateTime.now().toIso8601String().toString(),
                        });
                        setState(() {
                          _controller.clear();
                        });
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key key,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: kPrimaryColor,
          );
        }
        var messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var each in messages) {
          final messageText = each.data['message'];
          final messageSender = each.data['sender'];
          final messageSenderEmail = each.data['sender_email'];

          final _currentUser = _loggedInUser.email;

          final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: _currentUser == messageSenderEmail);
          messageBubbles.add(messageBubble);
        }
        return Expanded(
            child: ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
          children: messageBubbles,
        ));
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key key,
      @required this.text,
      @required this.sender,
      @required this.isMe});

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(fontSize: 8.0, color: Colors.grey[700]),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 3.0,
            color: isMe ? kSecondaryColor : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                    color: isMe ? Colors.white : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
