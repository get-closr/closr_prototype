import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/user_repository.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => LoginModel());
}
