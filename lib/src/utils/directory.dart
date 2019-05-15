import 'package:closr_prototype/src/ui/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:closr_prototype/src/utils/pages.dart';
import 'package:closr_prototype/src/ui/screens/home_screen.dart';

import 'package:closr_prototype/src/ui/screens/no_content.dart';


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
      case Pages.chat:
        return ChatScreen();
      default:
        return NoContent();
    }
  }
}
