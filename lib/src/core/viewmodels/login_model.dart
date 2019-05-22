import 'package:closr_prototype/src/core/services/user_repository.dart';
import 'package:closr_prototype/src/locator.dart';
import 'package:flutter/foundation.dart';

enum ViewState { Idle, Busy }

enum FormMode { Login, Signup }

class LoginModel extends ChangeNotifier {
  final UserRepository _userRepository = locator<UserRepository>();

  ViewState _state = ViewState.Idle;

  FormMode _formMode = FormMode.Login;

  ViewState get state => _state;

  FormMode get mode => _formMode;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setMode(FormMode formMode) {
    _formMode = formMode;
    notifyListeners();
  }

  Future<void> switchMode(FormMode formMode) async {
    if (formMode == FormMode.Login) {
      setMode(FormMode.Signup);
    } else {
      setMode(FormMode.Login);
    }
  }

  Future<bool> signIn(String email, String password) async {
    setState(ViewState.Busy);
    var user = await _userRepository.signInWithCredentials(email, password);
    if (user == null){
      print("user does not exist");
      setState(ViewState.Idle);
      return false;
    }
    setState(ViewState.Idle);
    return true;
  }

  Future<bool> signInWithGoogle() async {
    setState(ViewState.Busy);
    var user = await _userRepository.signInWithGoogle();
    if (user == null){
      print("user does not exist");
      setState(ViewState.Idle);
      return false;
    }
    setState(ViewState.Idle);
    return true;
  }
}
