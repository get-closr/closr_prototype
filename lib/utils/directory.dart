import 'package:flutter/material.dart';
import 'package:closr_prototype/utils/pages.dart';
import 'package:closr_prototype/ui/screens/home_screen.dart';

import 'package:closr_prototype/ui/screens/no_content.dart';


class Directory extends StatelessWidget {
  final Pages page;
  final String name;

  Directory({this.page, this.name});

  @override
  Widget build(BuildContext context) {
    print(page);
    switch (page) {
      case Pages.home:
        return HomeScreen(name: this.name,);
        break;
      default:
        return NoContent();
    }
  }
}
