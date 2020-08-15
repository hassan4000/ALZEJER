import 'package:flutter/material.dart';

class ColoredTabBarV2 extends Container{


  final Icon icon;
  final String text;
  ColoredTabBarV2({this.icon, this.text});


  @override
  Widget build(BuildContext context) => Tab(icon: icon, text: text);

}
