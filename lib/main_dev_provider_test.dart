import 'package:flutter/material.dart';
import 'package:closr_prototype/bloc_test/utils/app_config.dart';
import 'package:closr_prototype/app/closr_app_dev.dart';




void main() {
  var configuredApp = AppConfig(
    appTitle: "Closr Prototype Dev",
    buildFlavor: "Development",
    child: ClosrApp(),
  );
  return runApp(configuredApp);
}
