import 'package:flutter/material.dart';

import 'package:closr_prototype/bloc_test/ui/backdrop.dart';
import 'package:closr_prototype/bloc_test/ui/screens/menu_page.dart';


import 'package:closr_prototype/bloc_test/utils/pages.dart';
import 'package:closr_prototype/bloc_test/utils/directory.dart';


class ClosrMain extends StatefulWidget {
  final String name;

  ClosrMain({Key key, @required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClosrMainState();
}

class _ClosrMainState extends State<ClosrMain> {
  Pages _currentPage = Pages.home;

  void _onPageTap(Pages page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Backdrop(
          currentPage: Pages.home,
          frontLayer: Directory(page: _currentPage, name: widget.name,),
          backLayer: MenuPage(
            currentPage: _currentPage,
            onPagesTap: _onPageTap,
          ),
          frontTitle: Text("CLOSR"),
          backTitle: Text("MENU"),
      ),
    );
  }
}
