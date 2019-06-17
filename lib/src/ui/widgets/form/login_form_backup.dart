import 'package:closr_prototype/src/core/viewmodels/login_model.dart';
import 'package:closr_prototype/src/ui/shared/ui_helpers.dart';
import 'package:closr_prototype/src/utils/validators.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final LoginModel model;

  LoginForm({this.model});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email;
  String _password;
  String _errorMessage;
  final _formKey = GlobalKey<FormState>();

  // User user = User();

  @override
  void initState() {
    super.initState();
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      var loginSuccess = await widget.model.signIn(_email, _password);
      if (loginSuccess) {
        Navigator.pushNamed(context, '/');
      }
    }
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
          passwordInput(),
          UIHelper.verticalSpaceSmall(),
          showPrimaryButton(),
        ],
      ),
    );
  }

  Widget emailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: "Email",
      ),
      autovalidate: false,
      autocorrect: false,
      autofocus: false,
      // validator: (value) {
      //   if (value.isEmpty) return "Email can't be empty";
      //   if (!Validators.isValidEmail(value)) return "Email is not valid";
      // },
      onSaved: (value) => _email = value,
    );
  }

  Widget passwordInput() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: "Password",
      ),
      obscureText: true,
      autovalidate: false,
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) return "Password can\'t be empty";
        if (!Validators.isValidPassword(value)) return "Password is not valid";
      },
      onSaved: (value) => _password = value,
    );
  }

  Widget showPrimaryButton() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      child: RaisedButton(
        child: Text('Login'),
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Theme.of(context).buttonColor,
        onPressed: _validateAndSubmit,
      ),
    );
  }
}
