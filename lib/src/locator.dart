import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:get_it/get_it.dart';

import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => HomeModel());
}
