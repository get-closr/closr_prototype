import 'package:closr_prototype/src/core/viewmodels/home_model.dart';
import 'package:closr_prototype/src/ui/widgets/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      builder: (context) => locator<HomeModel>(),
      child: Consumer<HomeModel>(
          builder: (context, model, child) => Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  brightness: Brightness.light,
                  title: Text("Home"),
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          semanticLabel: 'Sign Out',
                        ),
                        onPressed: () async {
                          model.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (_) => false);
                        }),
                  ],
                ),
                body: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      FloatingActionButton(
                        child: Icon(Icons.add_circle),
                        backgroundColor: Theme.of(context).buttonColor,
                        onPressed: () {},
                      ),
                      ChatScreen(
                        userRepository: model.user,
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
