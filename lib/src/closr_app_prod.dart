import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:closr_prototype/src/authentication_bloc/bloc.dart';

import 'package:closr_prototype/src/utils/app_config.dart';
import 'package:closr_prototype/src/utils/user_repository.dart';

import 'package:closr_prototype/src/ui/screens/prod/home_screen.dart';
import 'package:closr_prototype/src/ui/screens/splash_screen.dart';

import 'login/login_screen.dart';


class ClosrApp extends StatefulWidget {
  ClosrApp({Key key}) : super(key: key);

  _ClosrAppState createState() => _ClosrAppState();
}

class _ClosrAppState extends State<ClosrApp> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        title: AppConfig.of(context).appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: _userRepository);
            }
            if (state is Authenticated) {
              return HomeScreen(name: state.displayName);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
