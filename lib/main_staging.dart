import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:closr_prototype/bloc_test/utils/simple_bloc_delegate.dart';
import 'package:closr_prototype/bloc_test/utils/app_config.dart';

import 'package:closr_prototype/app/closr_app_staging.dart';


void main(){
  BlocSupervisor().delegate = SimpleBlocDelegate();

  var configuredApp = AppConfig(
    appTitle: "Closr Prototype Staging",
    buildFlavor: "Staging",
    child: ClosrApp(),
  );

  return runApp(configuredApp);
}