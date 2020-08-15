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
             Expanded(flex:1,child: Text(text,
               textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: getTextSyle(16, Colors.black),)),
             Expanded(flex:1,child: Text(hint,textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.black)),
             ),


           ],
         ),
         SizedBox(height: 10,)
       ],
      ),
    );
  }
}
