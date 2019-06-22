import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:closr_prototype/src/core/services/firebase_auth_service.dart';
import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:get_it/get_it.dart';

import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt();

Future setupLocator() async {
  locator.registerFactory(() => AuthenticationService());
  locator.registerFactory(() => FirebaseAuthService());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => HomeModel());
}
