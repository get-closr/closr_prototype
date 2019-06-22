import 'package:closr_prototype/src/core/services/auth_service.dart';
import 'package:closr_prototype/src/ui/views/home_view.dart';
import 'package:closr_prototype/src/ui/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (_, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          return user == null ? LoginView() : HomeView();
        } else {
          return Scaffold(
            body: Center(
              child: SpinKitChasingDots(),
            ),
          );
        }
      },
    );
  }
}
