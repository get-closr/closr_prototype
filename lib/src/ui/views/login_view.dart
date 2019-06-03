import 'package:closr_prototype/src/core/enums/form_mode.dart';
import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:closr_prototype/src/locator.dart';
import 'package:closr_prototype/src/ui/widgets/login_form.dart';
import 'package:closr_prototype/src/ui/widgets/signup_form.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      builder: (context) => locator<LoginModel>(),
      child: Consumer<LoginModel>(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                automaticallyImplyLeading: false,
              ),
              body: Form(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Flexible(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            height: 300,
                            child: Image.asset(
                              'assets/images/Closr_logo.png',
                            ),
                          ),
                        ),
                      ),
                      model.mode == FormMode.Login
                          ? LoginForm(model: model)
                          : SignupForm(model: model),
                      googleLoginButton(context, model),
                      switchButton(model),
                    ],
                  ),
                ),
              ),
            ),
      ),
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
      // color: Theme.of(context).buttonColor,
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
