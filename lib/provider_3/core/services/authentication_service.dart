import 'dart:async';

import 'package:closr_prototype/provider_3/core/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();

  StreamController<FirebaseUser> userController = StreamController<FirebaseUser>();



  Future<bool> signIn(String email, String password) async {
    var fetchedUser = await _api.signInWithCredentials(email, password);

    var hasUser = fetchedUser != null;

    if (hasUser) {
      userController.add(fetchedUser);
    }
    return hasUser;

  }

  // Future<bool> login(int userId) async {
  //   var fetchedUser = await _api.getUserProfile(userId);

  //   var hasUser = fetchedUser != null;

  //   if (hasUser) {
  //     userController.add(fetchedUser);
  //   }

  //   return hasUser;
  // }
}
