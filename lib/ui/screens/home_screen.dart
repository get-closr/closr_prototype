import 'package:flutter/material.dart';
//TODO sharedpreferences to remember whether use has completed setup

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Welcome $name!'),
            Text('Setup Your Jewellery'),
            Text('Complete Your Profile'),
            Text('Invite Your Partner'),
            Text('Relinquish Control'),
            Text('Start Playing')
          ],
        ),
      ),
    );
  }
}
