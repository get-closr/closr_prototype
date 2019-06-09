import 'package:closr_prototype/src/ui/views/home_view.dart';
import 'package:closr_prototype/src/ui/views/login_view.dart';
import 'package:closr_prototype/src/ui/widgets/bottom_nav/bottom_navbar.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        // return MaterialPageRoute(builder: (_) => HomeView());
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}"),),
          ),
        );
    }
  }
}