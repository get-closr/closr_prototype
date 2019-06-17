import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:closr_prototype/src/ui/shared/color.dart';
import 'package:closr_prototype/src/ui/shared/theme.dart';
import 'package:closr_prototype/src/ui/shared/ui_helpers.dart';
import 'package:closr_prototype/src/utils/bottom_sheet_fix.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat/message_bubble.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatTrigger extends StatefulWidget {
  final AuthenticationService _authenticationService;

  ChatTrigger({Key key, @required AuthenticationService authenticationService})
      : assert(authenticationService != null),
        _authenticationService = authenticationService;
  @override
  _ChatTriggerState createState() => _ChatTriggerState();
}

class _ChatTriggerState extends State<ChatTrigger> {
  final messageTextController = TextEditingController();

  String messageText;

  AuthenticationService get _authenticationService =>
      widget._authenticationService;

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

  _showModalBottomSheet(context) {
    showModalBottomSheetApp(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          children: messageBubbles,
                        ),
                      );
                    }
                  },
                ),
                UIHelper.verticalSpaceSmall(),
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
                          _firestore.collection('messages').add({
                            'message': messageText,
                            'sender': loggedInUser.email
                          });
                        },
                        child: Text(
                          'Send',
                          style: kSendButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showModalBottomSheet(context);
      },
      elevation: 5,
      backgroundColor: kClosrPink100,
      child: Icon(
        Icons.chat_bubble_outline,
        color: kClosrBrown900,
      ),
    );
  }
}
