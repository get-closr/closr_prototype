import 'package:closr_prototype/src/provider_test/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './src/provider_test/user_repository_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return UserInfoPage(user: user.user);
          }
        },
      ),
    );
  }
}

class Splash extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }

}

class UserInfoPage extends StatelessWidget {
  final FirebaseUser user;

  const UserInfoPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            RaisedButton(
              child: Text("Sign Out"),
              onPressed: () => Provider.of<UserRepository>(context).signOut(),
            )
          ],
        ),
      ),
    );
  }
}
