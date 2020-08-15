import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:flutter/material.dart';

class ApplicationInfoPage extends StatelessWidget {

  final String hint;
  final  String text;


  ApplicationInfoPage({this.hint, this.text});

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
             Flexible(child: Text(text,
               textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: getTextSyle(16, Colors.black),)),
             Expanded(flex:3,child: Text(hint,textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.black)),
             ),


           ],
         ),
         SizedBox(height: 10,)
       ],
      ),
    );
  }
}
