import 'package:closr_prototype/src/core/services/auth_service.dart';
import 'package:flutter/widgets.dart';

class SignInManager {
  final AuthService auth;
  final ValueNotifier<bool> isLoading;

  SignInManager({@required this.auth, @required this.isLoading});

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<User> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }

  Future<void> signInWithGoogle() async {
    return await _signIn(auth.signInWithGoogle);
  }

}
