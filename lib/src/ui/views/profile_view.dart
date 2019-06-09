import 'package:closr_prototype/src/ui/shared/typography.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Icon(Icons.contacts),
          title: Text('You'),
        ),
        body: Container(
          color: Color(0xffe9ecef),
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              ListTile(
                onTap: () {},
                leading: Icon(Icons.edit),
                title: myTitle(text: "My Event"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.group),
                title: myTitle(text: "My Community"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: myTitle(text: "My Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
