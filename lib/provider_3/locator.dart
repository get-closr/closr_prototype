import 'package:closr_prototype/provider_3/core/services/authentication_service.dart';
import 'package:closr_prototype/provider_3/core/viewmodels/home_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api.dart';
import 'core/viewmodels/comments_model.dart';
import 'core/viewmodels/login_model.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerLazySingleton(()=>AuthenticationService());
  locator.registerLazySingleton(()=>Api());

  locator.registerLazySingleton(()=> LoginModel());
  locator.registerFactory(()=> HomeModel());
  locator.registerFactory(()=> CommentsModel());
}