import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:closr_prototype/src/ui/shared/theme.dart';
import 'package:closr_prototype/src/locator.dart';
import 'package:closr_prototype/src/ui/router.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(ClosrApp());
}

class ClosrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>(
      builder: (context) => locator<AuthenticationService>().userController,
      child: MaterialApp(
        title: 'Closr App',
        theme: buildClosrTheme(1),
        initialRoute: '/login',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
