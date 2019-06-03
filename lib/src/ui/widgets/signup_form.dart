import 'package:closr_prototype/src/core/models/user.dart';
import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:closr_prototype/src/ui/shared/ui_helpers.dart';
import 'package:closr_prototype/src/ui/widgets/password_field.dart';
import 'package:closr_prototype/src/utils/validators.dart';

import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  final LoginModel model;

  const SignupForm({this.model});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController _email;
  // TextEditingController _password;

  final _formKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  bool _formWasEditted = false;

  User user = User();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: "Email",
      ),
      autovalidate: false,
      autocorrect: false,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return "Email can't be empty";
        if (!Validators.isValidEmail(value)) return "Email is not valid";
      },
      onSaved: (String value) => user.email = value,
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
          enabled: user.password != null && user.password.isNotEmpty,
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
    _formWasEditted = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    if (passwordField.value != value) return 'The passwords don\'t match.';
    return null;
  }
}
