
import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {

  double height;
  double  width;


  LogoIcon({this.height=150, this.width=200});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(

          image: DecorationImage(
              image: AssetImage("assets/images/alzeker_logo.png"),
              fit: BoxFit.contain)),
    );
  }
}
