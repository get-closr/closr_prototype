import 'package:closr_prototype/src/core/models/user.dart';
import 'package:closr_prototype/src/ui/shared/ui_helpers.dart';
import 'package:closr_prototype/src/utils/validators.dart';
import 'package:flutter/material.dart';

class LoginFields extends StatefulWidget {
  @override
  _LoginFieldsState createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  TextEditingController _email;
  TextEditingController _password;

  final _formKey = GlobalKey<FormState>();

  User user = User();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        emailInput(),
        UIHelper.verticalSpaceSmall(),
        passwordInput(),
        UIHelper.verticalSpaceMedium(),
      ],
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
    return TextFormField(
        controller: _password,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Password",
        ),
        obscureText: true,
        autovalidate: false,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty) return "Password can\'t be empty";
          if (!Validators.isValidPassword(value))
            return "Password is not valid";
        },
        onSaved: (value) => user.password = value);
  }
}
