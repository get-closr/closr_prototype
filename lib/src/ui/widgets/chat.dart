import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:closr_prototype/src/ui/shared/color.dart';
import 'package:closr_prototype/src/ui/shared/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  final AuthenticationService _authenticationService;

  ChatScreen({Key key, @required AuthenticationService authenticationService})
      : assert(authenticationService != null),
        _authenticationService = authenticationService;

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  String messageText;


  AuthenticationService get _authenticationService => widget._authenticationService;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _authenticationService.getUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('messages').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              } else {
                final messages = snapshot.data.documents;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages) {
                  final messageText = message.data['message'];
                  final messageSender = message.data['sender'];

                  final currentUser = loggedInUser.email;

                  final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isMe: currentUser == messageSender,
                  );
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                );
              }
            },
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('messages').add(
                        {'message': messageText, 'sender': loggedInUser.email});
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
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageBubble({Key key, this.sender, this.text, this.isMe})
      : super(key: key);

  get bubbleRadius => isMe
      ? BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )
      : BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        );

  @override
  Widget build(BuildContext context) {
    var material2 = Material(
      borderRadius: bubbleRadius,
      elevation: 2.0,
      color: isMe ? kClosrPink400 : kClosrSurfaceWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Text(
          '$text',
          style: TextStyle(
              fontSize: 15.0, color: isMe ? Colors.white : Colors.black54),
        ),
      ),
    );
    var material = material2;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          material,
        ],
      ),
    );
  }
}
