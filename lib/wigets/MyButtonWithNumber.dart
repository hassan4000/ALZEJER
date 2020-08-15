import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:flutter/material.dart';

import 'package:faserholmak/Helper/Content.dart';
import '../constants.dart';

class MyButtonWithNumber extends StatelessWidget {
  String txt;
  Color borderColor;
  Color splashColor;
  double borderWidth;
  TextStyle textStyle;
  VoidCallback press;
  Color buttonColor;
  double raduis;
  int number;


  MyButtonWithNumber({this.txt,
    this.borderColor=kPrimaryColor,
    this.splashColor=Colors.grey,
    this.borderWidth=1.4,
    this.textStyle=NormalTextWhite,
    this.press,
    this.buttonColor=kPrimaryColor,
    this.raduis=raduisButton,
  this.number});

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
      child: Row(
        textDirection: TextDirection.rtl,
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(txt,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style:textStyle
            ),
          ),
          Text(number.toString(),
              textAlign: TextAlign.left,
              textDirection: TextDirection.rtl,
              style:textStyle
          ),
        ],
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
