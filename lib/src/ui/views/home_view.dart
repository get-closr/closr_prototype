import 'package:closr_prototype/src/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sliver App Bar"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                semanticLabel: 'Sign Out',
              ),
              onPressed: () {
                //signOut
                Navigator.pushNamed(context, '/login');
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Put Chat App here"),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
