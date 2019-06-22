import 'package:closr_prototype/src/ui/shared/color.dart';
import 'package:closr_prototype/src/ui/widgets/buttons/custom_raised_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton(
      {Key key, String text, bool loading = false, VoidCallback onPressed})
      : super(
            key: key,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            height: 44.0,
            color: kClosrPink100,
            textColor: kClosrBrown900,
            borderRadius: 4.0,
            loading: loading,
            onPressed: onPressed);
}
