import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  AuthenticationService get user => _authenticationService;

  Future<FirebaseUser> getUser() async {
    return _authenticationService.getUser();
  }

  Future<void> signOut() async {
    return Future.wait([
      _authenticationService.signOut(),
    ]);
  }

}
