import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:flutter/material.dart';

import 'package:faserholmak/Helper/Content.dart';
import '../constants.dart';

class MyButton extends StatelessWidget {
  String txt;
  Color borderColor;
  Color splashColor;
  double borderWidth;
  TextStyle textStyle;
  VoidCallback press;
  Color buttonColor;
  double raduis;



  MyButton({this.txt,
    this.borderColor=kPrimaryColor,
    this.splashColor=Colors.grey,
    this.borderWidth=1.4,
    this.textStyle=NormalTextWhite,
    this.press,
    this.buttonColor=kPrimaryColor,
    this.raduis=raduisButton});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
              style: BorderStyle.solid)),
      splashColor: splashColor,
      color: buttonColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(txt,
            textAlign: TextAlign.center,
            style:textStyle
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
