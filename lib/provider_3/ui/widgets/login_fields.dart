import 'package:closr_prototype/provider_3/ui/shared/text_styles.dart';
import 'package:closr_prototype/provider_3/ui/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController controller;
  final String validationMessage;

  const LoginHeader({Key key, this.controller, this.validationMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Login',
          style: headerStyle,
        ),
        UIHelper.verticalSpaceMedium(),
        Text(
          'Enter a number between 1 - 10',
          style: subHeaderStyle,
        ),
        LoginTextField(controller),
        this.validationMessage != null
            ? Text(
                validationMessage,
                style: TextStyle(color: Colors.red),
              )
            : Container()
      ],
    );
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  LoginTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
          decoration: InputDecoration.collapsed(hintText: 'User Id'),
          controller: controller),
    );
  }
}