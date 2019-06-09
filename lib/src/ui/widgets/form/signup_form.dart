import 'package:closr_prototype/src/ui/shared/ui_helpers.dart';
import 'package:closr_prototype/src/ui/widgets/form/password_field.dart';



import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  const SignUpForm({@required this.email, @required this.password});

  @override
  Widget build(BuildContext context) {
    return SignUpTextField(email, password);
  }
}

class SignUpTextField extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  SignUpTextField(this.email, this.password);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          emailInput(),
          UIHelper.verticalSpaceSmall(),
          PasswordField(
            fieldKey: _passwordFieldKey,
            helperText: 'No more than 8 characters',
            labelText: 'Password *',
            onFieldSubmitted: (value) {},
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Confirm Password",
              prefixIcon: Icon(Icons.lock_outline),
            ),
            maxLength: 8,
            obscureText: true,
          ),
          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }

  Widget emailInput() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: "Email",
      ),
      autovalidate: false,
      autocorrect: false,
      autofocus: false,
      onSaved: (String value) => email.text = value,
    );
  }

  Widget passwordInput() {
    return Column(
      children: <Widget>[
        PasswordField(
          helperText: 'No more than 8 characters',
          labelText: 'Password *',
          onFieldSubmitted: (value) {},
        ),
        TextFormField(
          enabled: password.text != null && password.text.isNotEmpty,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            icon: Icon(Icons.lock_outline),
          ),
          maxLength: 8,
          obscureText: true,
          validator: _validatePassword,
        ),
      ],
    );
  }

  String _validatePassword(String value) {
    // _formWasEditted = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    if (passwordField.value != value) return 'The passwords don\'t match.';
    return null;
  }
}
