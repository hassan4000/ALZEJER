import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CardTimeDreams extends StatelessWidget {
  String price;
  String name;
  String textAboveLine;
  String textUnderLine;
  bool showDolar;
  String textUnderLineHint;
  VoidCallback press;
  bool line;


  CardTimeDreams({this.price, this.name, this.showDolar=true,this.textAboveLine, this.textUnderLineHint=timeToStart,this.textUnderLine,this.press,this.line=true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 8,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(

            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(children: <Widget>[
                  Text('$people $textAboveLine',style: getTextSyle(16, kPrimaryColor),textDirection: TextDirection.rtl,),
                  line?
                  Divider(thickness: 2,height: 2,)
                      :SizedBox(height:2,),
                  line?
                  Text('$textUnderLineHint $textUnderLine',style: getTextSyle(16, kPrimaryColor),textDirection: TextDirection.rtl,)
                  :Container(),
                ],),
              ),
              SizedBox(width: 12,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 1,
                    color: kPrimaryColor
                  )
                ),
                child: Column(
                  children: <Widget>[
                    Text("$name",style: getTextSyle(14, kPrimaryColor),textDirection: TextDirection.rtl,),
                   /* Container(
                      width: 100,height: 100,
                      child:
                      ClipOval(child:Container(color: Colors.black,)),
                    ),*/
                    SizedBox(height: 2,),
                   showDolar? Text("$price \$",style: getTextSyle(14, kPrimaryColor,fontWeight: FontWeight.w600),
                      textDirection: TextDirection.rtl,):
                   Text("$price",style: getTextSyle(14, kPrimaryColor,fontWeight: FontWeight.w600),
                     textDirection: TextDirection.rtl,),
                  ],
                ),
              ),

             /* Flexible(flex: ,2),*/
            ],
          ),
        ),
      ),
    );
  }
}
