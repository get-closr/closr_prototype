import 'package:flutter/material.dart';
import 'main.dart';
import 'resources/app_config.dart';

void main(){
  var configuredApp = AppConfig(
    appTitle: "Closr Prototype Dev",
    buildFlavor: "Developement",
    child: MyApp(),
  );

  return runApp(configuredApp);
}