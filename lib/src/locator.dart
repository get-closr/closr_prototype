import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/user_repository.dart';
import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => LoginModel());
  locator.registerLazySingleton(() => HomeModel());
}
