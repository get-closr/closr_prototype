import 'package:closr_prototype/src/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class LoginFormTest extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final String emailValidationMessage;
  final String passwordValidationMessage;

  LoginFormTest(
      {@required this.email,
      @required this.password,
      this.emailValidationMessage,
      this.passwordValidationMessage});

  @override
  Widget build(BuildContext context) {
    return LoginTextField(
        email, password, emailValidationMessage, passwordValidationMessage);
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final String emailValidationMessage;
  final String passwordValidationMessage;

  LoginTextField(this.email, this.password, this.emailValidationMessage,
      this.passwordValidationMessage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: "Email",
          ),
          autovalidate: false,
          autocorrect: false,
          autofocus: false,
          controller: email,
          onSaved: (value) => email.text = value,
        ),
        this.emailValidationMessage != null
        ? Text(emailValidationMessage, style: TextStyle(color: Colors.red))
        : Container(),
        TextFormField(
          controller: password,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: "Password",
          ),
          obscureText: true,
          autovalidate: false,
          autocorrect: false,
          onSaved: (value) => password.text = value,
        ),
        this.passwordValidationMessage != null
        ? Text(passwordValidationMessage, style: TextStyle(color: Colors.red))
        : Container(),
        UIHelper.verticalSpaceMedium(),
      ],
    );
  }
}
