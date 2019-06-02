import 'package:closr_prototype/src/ui/shared/theme.dart';
import 'package:closr_prototype/src/locator.dart';
import 'package:closr_prototype/src/ui/router.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: buildClosrTheme(1),
      initialRoute: '/login',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
