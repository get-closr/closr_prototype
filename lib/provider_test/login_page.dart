import 'package:closr_prototype/src/ui/shared/color.dart';
import 'package:closr_prototype/src/utils/password.dart';
import 'package:closr_prototype/src/utils/validators.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './user_repository_provider.dart';

enum FormMode { LOGIN, REGISTER }

class User {
  String id = '';
  String email = '';
  String password = '';
}

class LoginPage extends StatefulWidget {
  final UserRepository userRepo;

  const LoginPage({Key key, this.userRepo}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // bool _isLoading;
  // bool _isIos;
  // bool _autoValidate = false;
  // bool _formEditted = false;

  FormMode _formMode = FormMode.LOGIN;
  User user = User();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: AccentColorOverride(
        child: SafeArea(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        loginButton(),
                        googleLoginButton(),
                        _switchButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
      onSaved: (String value) => user.email = value,
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
            onSaved: (value) => user.password = value)
        : passwordSignup();
  }

  Widget loginButton() {
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: _formMode == FormMode.LOGIN
            ? Text('Login')
            : Text('Create Account'),
        onPressed: () async {
          if (_validateAndSave()) {
            print(user.email);
            print(user.password);
            await widget.userRepo
                .signIn(user.email, user.password)
                .catchError((onError) {
              final snackbar = SnackBar(
                content: Text(onError.toString().substring(15)),
              );
              _scaffoldKey.currentState..showSnackBar(snackbar);
            });
          }
        });
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _signInGoogle() async {
    await widget.userRepo.signInWithGoogle().catchError((onError) {
      final snackbar = SnackBar(
        content: Text(onError.toString()),
      );
      _scaffoldKey.currentState..showSnackBar(snackbar);
    });
  }

  Widget googleLoginButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: kClosrBrown900),
      label: Text(
        'Sign in with Google',
        style: TextStyle(
          color: kClosrBrown900,
        ),
      ),
      color: Theme.of(context).buttonColor,
      onPressed: _signInGoogle,
    );
  }

  Widget _switchButton() {
    return FlatButton(
      child: _formMode == FormMode.LOGIN
          ? Text('Create an account')
          : Text('Have an account? Sign in'),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    setState(() {
      _formMode = FormMode.REGISTER;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(accentColor: color),
    );
  }
}
