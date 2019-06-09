import 'package:closr_prototype/src/ui/shared/color.dart';
import 'package:flutter/material.dart';

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
