import 'package:closr_prototype/src/core/enums/form_mode.dart';
import 'package:closr_prototype/src/core/enums/view_state.dart';
import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:closr_prototype/src/ui/shared/color.dart';
import 'package:closr_prototype/src/ui/widgets/form/login_form.dart';
import 'package:closr_prototype/src/ui/widgets/form/signup_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          preferredSize: Size.fromHeight(0),
        ),
        body: Padding(
          padding: EdgeInsets.all(50),
          child: Center(
            child: model.state == ViewState.Busy
                ? SpinKitDualRing(color: kClosrPink100)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                            child: Image.asset(
                          'assets/images/Closr_logo.png',
                        )),
                      ),
                      model.mode == FormMode.Login
                          ? LoginFormTest(
                              email: _email,
                              password: _passw,
                              emailValidationMessage: model.emailErrorMessage,
                              passwordValidationMessage:
                                  model.passwordErrorMessage)
                          : SignUpForm(
                              email: _email,
                              password: _passw,
                            ),
                      showPrimaryButton(context, model),
                      googleLoginButton(context, model),
                      switchButton(model),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget showPrimaryButton(context, model) {
    return RaisedButton(
      child:
          model.mode == FormMode.Login ? Text('Login') : Text('Create Account'),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Theme.of(context).buttonColor,
      onPressed: () async {
        if (model.mode == FormMode.Login) {
          var loginSuccess = await model.signIn(_email.text, _passw.text);
          if (loginSuccess) {
            Navigator.pushNamed(context, '/');
          }
        } else {
          var signupSuccess = await model.signIn(_email.text, _passw.text);
          if (signupSuccess) {
            Navigator.pushNamed(context, '/verify');
          }
        }
      },
    );
  }

  Widget googleLoginButton(context, model) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      label: Text(
        'Sign in with Google',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      elevation: 2.0,
      color: Colors.redAccent,
      onPressed: () async {
        var loginSuccess = await model.signInWithGoogle();
        if (loginSuccess) {
          Navigator.pushNamed(context, '/');
        }
      },
    );
  }

  switchButton(model) {
    return FlatButton(
        child: model.mode == FormMode.Login
            ? Text('Create an account')
            : Text('Have an account? Sign in'),
        onPressed: () async {
          model.switchMode(model.mode);
        });
  }
}
