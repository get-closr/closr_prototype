import 'package:closr_prototype/provider_2/models/user.dart';
import 'package:closr_prototype/provider_2/services/authentication_service.dart';
import 'package:closr_prototype/provider_2/ui/router.dart';
import 'package:closr_prototype/provider_2/utils/locator.dart';
import 'package:closr_prototype/src/ui/theme/theme.dart';
import 'package:closr_prototype/src/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClosrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      builder: (context) => locator<AuthenticationService>().userController,
      child: MaterialApp(
        title: AppConfig.of(context).appTitle,
        theme: buildClosrTheme(1),
        initialRoute: '/login',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
