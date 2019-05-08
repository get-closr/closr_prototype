import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.appTitle,
    @required this.buildFlavor,
    @required this.child
    });

  final Widget child;
  final String appTitle;
  final String buildFlavor;

  static AppConfig of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppConfig)as AppConfig);
  }

  @override
  bool updateShouldNotify( AppConfig oldWidget) => false;
}