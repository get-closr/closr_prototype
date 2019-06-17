import 'package:flutter/material.dart';

class MySubtitle extends StatelessWidget {
  const MySubtitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      color: Colors.grey
    ));
  }
}

class MyTitle extends StatelessWidget {
  const MyTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18.0
    ),);
  }
}
