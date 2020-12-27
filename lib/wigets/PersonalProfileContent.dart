import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:flutter/material.dart';

class PersonalProfileContent extends StatelessWidget {

  final String hint;
  final  String text;


  PersonalProfileContent({this.hint, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(




      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
       children: <Widget>[
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           mainAxisSize: MainAxisSize.max,
           children: <Widget>[
             Expanded(flex:2,child: Text(text,
               textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: getTextSyle(16, Colors.black),)),
             Flexible(flex: 2,child: Text(hint,style: getTextSyle(14, Colors.black))),


           ],
         ),
         SizedBox(height: 10,)
       ],
      ),
    );
  }
}
