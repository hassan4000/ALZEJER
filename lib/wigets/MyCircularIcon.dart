import 'dart:io';

import 'package:faserholmak/constants.dart';
import 'package:flutter/material.dart';

class MyCircularIcon extends StatelessWidget {
  final double w;
  final double h;
  final IconButton icon;



  MyCircularIcon(this.w, this.h,{this.icon});

  @override
  Widget build(BuildContext context) {
    return Container( decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor

    ),child: icon);
  }
}
