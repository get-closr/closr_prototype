import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:closr_prototype/bloc_test/utils/simple_bloc_delegate.dart';
import 'package:closr_prototype/bloc_test/utils/app_config.dart';

import 'package:closr_prototype/app/closr_app_prod.dart';


void main(){
  BlocSupervisor().delegate = SimpleBlocDelegate();

  var configuredApp = AppConfig(
    appTitle: "Closr Prototype Production",
    buildFlavor: "Production",
    child: ClosrApp(),
  );

  return runApp(configuredApp);
}