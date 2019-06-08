import 'package:closr_prototype/src/core/enums/view_state.dart';
import 'package:closr_prototype/src/core/viewmodels/home_model.dart';
import 'package:closr_prototype/src/ui/widgets/chat.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
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
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChatScreen(
                        authenticationService: model.user,
                      ),
                    ),
                  ),
          ),
    );
  }
}
