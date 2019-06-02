import 'package:closr_prototype/bloc_test/utils/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:closr_prototype/bloc_test/utils/pages.dart';

import 'package:closr_prototype/bloc_test/ui/screens/account_screen.dart';
import 'package:closr_prototype/bloc_test/ui/screens/chat_screen.dart';
import 'package:closr_prototype/bloc_test/ui/screens/home_screen.dart';
import 'package:closr_prototype/bloc_test/ui/screens/no_content.dart';

class Directory extends StatelessWidget {
  final Pages page;
  final String name;
  final UserRepository _userRepository = UserRepository();

  Directory({this.page, this.name});

  @override
  Widget build(BuildContext context) {
    print(page);
    switch (page) {
      case Pages.home:
        return HomeScreen(
          name: this.name,
        );
        break;
      case Pages.account:
        return AccountScreen();
      case Pages.chat:
        return ChatScreen(userRepository: _userRepository ,);
      default:
        return NoContent();
    }
  }
}
