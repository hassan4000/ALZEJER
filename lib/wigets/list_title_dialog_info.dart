import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/constants.dart';
import 'package:flutter/material.dart';

class ListTitleDialogInfo extends StatelessWidget {
  String number;
  String text;
  String image;
  Icon icon;

  ListTitleDialogInfo({this.number, this.text, this.image,this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      shape: getOutLineBorder(radius: 4, color: Colors.transparent, width: 1),
      child: ListTile(
       leading: icon==null?Image.asset("assets/images/$image",fit: BoxFit.contain,color: kPrimaryColor,height: 30,width: 30,):icon,
        subtitle: Text("$text",style: getTextSyle(16, kPrimaryColor),),
        title: Text("$number",style: getTextSyle(16, kPrimaryColor,fontWeight: FontWeight.w600),),

      ),
    );
  }
}
