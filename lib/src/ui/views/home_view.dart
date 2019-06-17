import 'package:closr_prototype/src/core/constants/app_constants.dart';
import 'package:closr_prototype/src/core/enums/view_state.dart';
import 'package:closr_prototype/src/core/viewmodels/home_model.dart';
import 'package:closr_prototype/src/ui/shared/color.dart';
import 'package:closr_prototype/src/ui/shared/ui_helpers.dart';
// import 'package:closr_prototype/src/ui/widgets/chat/chat.dart';
import 'package:closr_prototype/src/ui/widgets/chat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'base_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Alignment childAlignment = Alignment.center;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      print('keyboard $visible');
      setState(() {
        childAlignment = visible ? Alignment.topCenter : Alignment.center;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, model, child) => Scaffold(
        // resizeToAvoidBottomPadding: true,
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
                      context, RoutePaths.Login, (_) => false);
                }),
          ],
        ),
        body: model.state == ViewState.Busy
            ? Center(
                child: SpinKitChasingDots(
                color: kClosrPink100,
              ))
            : AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 400),
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(20),
                alignment: childAlignment,
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: Text(
                        'Welcome!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Container(
                      height: MediaQuery.of(context).size.height - 320,
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.width - 70),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/images/Closr_logo.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(canvasColor: Colors.transparent),
                      child: ChatTrigger(authenticationService: model.user,),
                    ),
                    UIHelper.verticalSpaceMedium(),
                  ],
                  // child: Stack(children: <Widget>[
                  //   ChatScreen(
                  //     authenticationService: model.user,
                  //   ),
                  // ]),
                ),
              ),
      ),
    );
  }
}
