import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:closr_prototype/utils/simple_bloc_delegate.dart';

import 'package:closr_prototype/utils/app_config.dart';
import 'package:closr_prototype/closr_app_dev.dart';

void main(){
  BlocSupervisor().delegate = SimpleBlocDelegate();

  var configuredApp = AppConfig(
    appTitle: "Closr Prototype Dev",
    buildFlavor: "Development",
    child: ClosrApp(),
  );

  return runApp(configuredApp);
}