import 'package:closr_prototype/src/core/enums/form_mode.dart';
import 'package:closr_prototype/src/core/enums/view_state.dart';
import 'package:closr_prototype/src/core/services/authentication_service.dart';
import 'package:closr_prototype/src/core/viewmodels/base_model.dart';
import 'package:closr_prototype/src/locator.dart';
import 'package:closr_prototype/src/utils/validators.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  String emailErrorMessage;
  String passwordErrorMessage;

  FormMode _formMode = FormMode.Login;

  FormMode get mode => _formMode;

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
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      emailErrorMessage = "Email is not valid";
      setState(ViewState.Idle);
      return false;
    }

    if (password.isEmpty || !Validators.isValidPassword(password)) {
      passwordErrorMessage = "Password is not valid";
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Busy);

    var user = await _authenticationService.login(email, password);

    if (user == null) {
      print("user does not exist");
      setState(ViewState.Idle);
      return false;
    }
    setState(ViewState.Idle);
    return true;
  }

  Future<bool> signUp(String email, String password) async {
    if (email.isEmpty || !Validators.isValidEmail(email)) {
      emailErrorMessage = "Email is not valid";
      setState(ViewState.Idle);
      return false;
    }

    if (password.isEmpty || !Validators.isValidPassword(password)) {
      passwordErrorMessage = "Password is not valid";
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Busy);
    var user = await _authenticationService.signup(email, password);
    if (user == null) {
      print("User not created ");
      setState(ViewState.Idle);
      return false;
    }
    setState(ViewState.Idle);
    return true;
  }

  Future<bool> signInWithGoogle() async {
    setState(ViewState.Busy);
    var user = await _authenticationService.signInWithGoogle();
    if (user == null) {
      print("user does not exist");
      setState(ViewState.Idle);
      return false;
    }
    setState(ViewState.Idle);
    return true;
  }
}
