import 'package:closr_prototype/src/core/constants/app_constants.dart';
import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:closr_prototype/src/ui/shared/theme.dart';

import 'package:closr_prototype/src/locator.dart';
import 'package:closr_prototype/src/ui/router.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupLocator();
  runApp(ClosrApp());
}

class ClosrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>(
      builder: (context) => locator<AuthenticationService>().user,
      child: MaterialApp(
        title: 'Closr App',
        theme: buildClosrTheme(1),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
