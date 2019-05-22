import 'package:closr_prototype/provider_3/core/enum/formmode.dart';
import 'package:closr_prototype/provider_3/core/enum/viewstate.dart';
import 'package:closr_prototype/provider_3/core/viewmodels/login_model.dart';
import 'package:closr_prototype/provider_3/ui/shared/app_colors.dart';
import 'package:closr_prototype/provider_3/utils/password.dart';
// import 'package:closr_prototype/provider_3/ui/widgets/login_header.dart';
import 'package:closr_prototype/provider_3/utils/validators.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FormMode _formMode = FormMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(50.0),
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
                  emailInput(),
                  passwordInput(),
                  model.state == ViewState.Busy
                      ? CircularProgressIndicator()
                      : loginButton(model)
                      // FlatButton(
                      //     color: Colors.white,
                      //     child: Text(
                      //       'Login',
                      //       style: TextStyle(color: Colors.black),
                      //     ),
                      //     onPressed: () async {
                            // var loginSuccess =
                            //     await model.login(_controller.text);
                            // if (loginSuccess) {
                            //   Navigator.pushNamed(context, '/');
                            // }
                          // },
                        // )
                ],
              ),
            ),
          ),
    );
  }

   bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget loginButton(model) {
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: _formMode == FormMode.LOGIN
            ? Text('Login')
            : Text('Create Account'),
        onPressed: () async {
          var loginSuccess = await model.signIn(_emailController.text, _passwordController.text);
          if (loginSuccess) {
            Navigator.pushNamed(context, '/');
          }
          // if (_validateAndSave()) {
          //   print(user.email);
          //   print(user.password);
          //   await widget.userRepo
          //       .signIn(user.email, user.password)
          //       .catchError((onError) {
          //     final snackbar = SnackBar(
          //       content: Text(onError.toString().substring(15)),
          //     );
          //     _scaffoldKey.currentState..showSnackBar(snackbar);
          //   });
          // }
        });
  }

  Widget emailInput() {
    return TextFormField(
      controller: _emailController,
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
      // onSaved: (String value) => user.email = value,
    );
  }

  Widget passwordInput() {
    return _formMode == FormMode.LOGIN
        ? TextFormField(
            controller: _passwordController,
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
            // onSaved: (value) => user.password = value
            )
        : passwordSignup();
  }

  Widget passwordSignup() {
    return Column(
      children: <Widget>[
        PasswordField(
          fieldKey: _passwordFieldKey,
          helperText: 'No more than 8 characters',
          labelText: 'Password *',
          onFieldSubmitted: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Confirm Password",
            icon: Icon(Icons.lock_outline),
          ),
          maxLength: 8,
          obscureText: true,
        ),
      ],
    );
  }
}
